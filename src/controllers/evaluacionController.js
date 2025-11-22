const { Evaluacion, Pregunta, Opcion, RespuestaEstudiante, Curso } = require('../models');
const { validationResult } = require('express-validator');
const { sequelize } = require('../config/db');

exports.createEvaluacion = async (req, res) => {
  const t = await sequelize.transaction();

  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      await t.rollback();
      return res.status(400).json({ status: 'error', message: 'Validación fallida', errors: errors.array() });
    }

    console.log('Creating evaluation with body:', JSON.stringify(req.body, null, 2));
    const { titulo, descripcion, fechaInicio, fechaFin, idCurso, preguntas } = req.body;

    const curso = await Curso.findByPk(idCurso);
    if (!curso) {
      await t.rollback();
      return res.status(404).json({ status: 'error', message: 'Curso no encontrado' });
    }

    if (curso.idDocente !== req.usuario.idUsuario) {
      await t.rollback();
      return res.status(403).json({ status: 'error', message: 'No autorizado para crear evaluaciones en este curso' });
    }

    if (new Date(fechaFin) < new Date(fechaInicio)) {
      await t.rollback();
      return res.status(400).json({ status: 'error', message: 'La fecha de fin debe ser posterior o igual a la fecha de inicio' });
    }

    const evaluacion = await Evaluacion.create({
      titulo,
      descripcion,
      fechaInicio,
      fechaFin,
      idCurso
    }, { transaction: t });

    if (preguntas && preguntas.length > 0) {
      for (const preg of preguntas) {
        const textoPregunta = preg.pregunta || preg.textoPregunta;
        const tipo = preg.tipo || 'opcion_multiple';
        const puntos = preg.puntos || 10;

        const pregunta = await Pregunta.create({
          textoPregunta,
          tipo,
          puntos,
          idEvaluacion: evaluacion.idEvaluacion
        }, { transaction: t });

        if (tipo === 'opcion_multiple' && preg.opciones) {
          if (Array.isArray(preg.opciones) && typeof preg.opciones[0] === 'string') {
            for (let i = 0; i < preg.opciones.length; i++) {
              await Opcion.create({
                texto: preg.opciones[i],
                esCorrecta: i === preg.respuestaCorrecta,
                idPregunta: pregunta.idPregunta
              }, { transaction: t });
            }
          }
          else if (Array.isArray(preg.opciones) && typeof preg.opciones[0] === 'object') {
            for (const opc of preg.opciones) {
              await Opcion.create({
                texto: opc.texto,
                esCorrecta: opc.esCorrecta,
                idPregunta: pregunta.idPregunta
              }, { transaction: t });
            }
          }
        }
      }
    }

    await t.commit();
    res.status(201).json({ status: 'success', message: 'Evaluación creada', data: { evaluacion } });

  } catch (error) {
    await t.rollback();
    console.error('Error creating evaluation:', error);
    if (error.name === 'SequelizeValidationError') {
      return res.status(400).json({ status: 'error', message: error.errors.map(e => e.message).join(', ') });
    }
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.submitEvaluacion = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ status: 'error', message: 'Validación fallida', errors: errors.array() });
  }

  try {
    const { respuestas } = req.body;
    console.log('[SUBMIT DEBUG] Respuestas recibidas:', JSON.stringify(respuestas, null, 2));

    const evaluacion = await Evaluacion.findByPk(req.params.id);
    if (!evaluacion) {
      return res.status(404).json({ status: 'error', message: 'Evaluación no encontrada' });
    }

    const now = new Date();
    if (now < new Date(evaluacion.fechaInicio) || now > new Date(evaluacion.fechaFin)) {
      return res.status(403).json({ status: 'error', message: 'Fuera del período de la evaluación' });
    }

    let puntaje = 0;
    let feedback = '';

    for (const resp of respuestas) {
      console.log(`[SUBMIT DEBUG] Procesando respuesta para pregunta ID: ${resp.idPregunta}`);

      const pregunta = await Pregunta.findByPk(resp.idPregunta);
      if (!pregunta || pregunta.idEvaluacion !== evaluacion.idEvaluacion) {
        console.log(`[SUBMIT DEBUG] Pregunta no encontrada o no pertenece a la evaluación`);
        continue;
      }

      let correcta = false;
      if (pregunta.tipo === 'opcion_multiple') {
        console.log(`[SUBMIT DEBUG] Buscando opción ID: ${resp.idOpcionSeleccionada}`);
        const opcion = await Opcion.findByPk(resp.idOpcionSeleccionada);

        if (opcion) {
          const valorRaw = opcion.esCorrecta;
          console.log(`[SUBMIT DEBUG] Opción encontrada: "${opcion.texto}", esCorrecta (Raw): ${valorRaw} (${typeof valorRaw})`);

          // Verificación robusta
          let esCorrectaBD = false;
          if (valorRaw === true) esCorrectaBD = true;
          else if (valorRaw === 1) esCorrectaBD = true;
          else if (String(valorRaw) === 'true') esCorrectaBD = true;
          else if (String(valorRaw) === '1') esCorrectaBD = true;

          if (esCorrectaBD) {
            correcta = true;
            puntaje += pregunta.puntos;
            console.log(`[SUBMIT DEBUG] ¡Respuesta CORRECTA! Puntaje actual: ${puntaje}`);
          } else {
            console.log(`[SUBMIT DEBUG] Respuesta INCORRECTA`);
          }
        } else {
          console.log(`[SUBMIT DEBUG] Opción NO encontrada en BD`);
        }
      } else if (pregunta.tipo === 'verdadero_falso') {
        correcta = true;
        if (correcta) puntaje += pregunta.puntos;
      } else if (pregunta.tipo === 'abierta') {
        feedback += 'Respuesta abierta pendiente de revisión. ';
      }

      await RespuestaEstudiante.create({
        idPregunta: resp.idPregunta,
        idUsuario: req.usuario.idUsuario,
        respuestaTexto: resp.respuestaTexto,
        idOpcionSeleccionada: resp.idOpcionSeleccionada,
        correcta
      });
    }

    console.log(`[SUBMIT DEBUG] Puntaje final calculado: ${puntaje}`);
    res.json({ status: 'success', message: 'Evaluación enviada', data: { puntaje, feedback } });
  } catch (error) {
    console.error('[SUBMIT ERROR]', error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.getResults = async (req, res) => {
  try {
    const evaluacion = await Evaluacion.findByPk(req.params.id);
    if (!evaluacion) {
      return res.status(404).json({ status: 'error', message: 'Evaluación no encontrada' });
    }

    const curso = await evaluacion.getCurso();
    const isDocente = curso.idDocente === req.usuario.idUsuario;
    const respuestas = await RespuestaEstudiante.findAll({ where: { idUsuario: req.usuario.idUsuario } });

    res.json({ status: 'success', message: 'Resultados obtenidos', data: { respuestas } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.getEvaluacionesByCurso = async (req, res) => {
  try {
    const { idCurso } = req.params;
    const curso = await Curso.findByPk(idCurso);
    if (!curso) {
      return res.status(404).json({ status: 'error', message: 'Curso no encontrado' });
    }
    const evaluaciones = await Evaluacion.findAll({
      where: { idCurso },
      include: [{
        model: Pregunta,
        as: 'preguntas',
        include: [{ model: Opcion, as: 'opciones' }]
      }],
      order: [['fechaInicio', 'DESC']]
    });
    res.json({ status: 'success', message: 'Evaluaciones obtenidas', data: evaluaciones });
  } catch (error) {
    console.error('[GET EVALUACIONES BY CURSO] Error:', error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.getEvaluacion = async (req, res) => {
  try {
    const evaluacion = await Evaluacion.findByPk(req.params.id, {
      include: [{
        model: Pregunta,
        as: 'preguntas',
        include: [{ model: Opcion, as: 'opciones' }]
      }]
    });
    if (!evaluacion) {
      return res.status(404).json({ status: 'error', message: 'Evaluación no encontrada' });
    }
    res.json({ status: 'success', message: 'Evaluación obtenida', data: evaluacion });
  } catch (error) {
    console.error('[GET EVALUACION] Error:', error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};
