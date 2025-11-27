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

    // Calcular el total de preguntas y el porcentaje
    const totalPreguntas = respuestas.length;
    const puntajeMaximo = totalPreguntas * 10; // Asumiendo 10 puntos por pregunta
    const calificacion = puntajeMaximo > 0 ? Math.round((puntaje / puntajeMaximo) * 100) : 0;

    // Contar respuestas correctas
    let correctas = 0;
    for (const resp of respuestas) {
      const pregunta = await Pregunta.findByPk(resp.idPregunta);
      if (!pregunta) continue;

      if (pregunta.tipo === 'opcion_multiple' && resp.idOpcionSeleccionada) {
        const opcion = await Opcion.findByPk(resp.idOpcionSeleccionada);
        if (opcion) {
          // Verificación robusta del valor booleano
          const esCorrecta = opcion.esCorrecta === 1 || opcion.esCorrecta === true ||
            String(opcion.esCorrecta) === '1' || String(opcion.esCorrecta) === 'true';
          if (esCorrecta) correctas++;
        }
      }
    }

    console.log(`[SUBMIT DEBUG] Puntaje final: ${puntaje}/${puntajeMaximo}`);
    console.log(`[SUBMIT DEBUG] Calificación: ${calificacion}%`);
    console.log(`[SUBMIT DEBUG] Correctas: ${correctas}/${totalPreguntas}`);

    const resultado = {
      puntaje,
      calificacion,
      correctas,
      total: totalPreguntas,
      feedback
    };

    res.json({
      status: 'success',
      message: 'Evaluación enviada',
      data: { resultado }
    });
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

// Nuevo endpoint para que docentes/admins vean resultados de estudiantes
exports.getEstudiantesResults = async (req, res) => {
  try {
    const { id } = req.params; // ID de la evaluación
    const evaluacion = await Evaluacion.findByPk(id, {
      include: [{
        model: Pregunta,
        as: 'preguntas'
      }]
    });

    if (!evaluacion) {
      return res.status(404).json({ status: 'error', message: 'Evaluación no encontrada' });
    }

    // Verificar que el usuario sea docente del curso o admin
    const curso = await Curso.findByPk(evaluacion.idCurso);
    const isDocente = curso.idDocente === req.usuario.idUsuario;
    const isAdmin = req.usuario.rol === 'admin';

    if (!isDocente && !isAdmin) {
      return res.status(403).json({ status: 'error', message: 'No autorizado' });
    }

    // Obtener todas las respuestas de estudiantes para esta evaluación
    const { Usuario } = require('../models');
    const respuestas = await RespuestaEstudiante.findAll({
      include: [
        {
          model: Usuario,
          as: 'usuario',
          attributes: ['idUsuario', 'nombre', 'correo']
        },
        {
          model: Pregunta,
          as: 'pregunta',
          where: { idEvaluacion: id },
          include: [{
            model: Opcion,
            as: 'opciones'
          }]
        }
      ]
    });

    // Agrupar respuestas por estudiante
    const estudiantesMap = {};

    for (const resp of respuestas) {
      const userId = resp.idUsuario;

      if (!estudiantesMap[userId]) {
        estudiantesMap[userId] = {
          usuario: resp.usuario,
          respuestas: [],
          correctas: 0,
          total: 0
        };
      }

      estudiantesMap[userId].respuestas.push(resp);
      estudiantesMap[userId].total++;

      if (resp.correcta) {
        estudiantesMap[userId].correctas++;
      }
    }

    // Convertir a array y calcular calificaciones
    const estudiantes = Object.values(estudiantesMap).map(est => {
      const calificacion = est.total > 0 ? Math.round((est.correctas / est.total) * 100) : 0;
      return {
        usuario: est.usuario,
        correctas: est.correctas,
        total: est.total,
        calificacion,
        aprobado: calificacion >= 70
      };
    });

    res.json({
      status: 'success',
      message: 'Resultados obtenidos',
      data: {
        evaluacion: {
          id: evaluacion.idEvaluacion,
          titulo: evaluacion.titulo,
          totalPreguntas: evaluacion.preguntas.length
        },
        estudiantes
      }
    });
  } catch (error) {
    console.error('[GET ESTUDIANTES RESULTS] Error:', error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};
