const { Evaluacion, Pregunta, Opcion, RespuestaEstudiante, Curso } = require('../models');
const { validationResult } = require('express-validator');

exports.createEvaluacion = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ status: 'error', message: 'Validación fallida', errors: errors.array() });
  }

  try {
    const { titulo, descripcion, fechaInicio, fechaFin, idCurso, preguntas } = req.body;
    const curso = await Curso.findByPk(idCurso);
    if (!curso || curso.idDocente !== req.user.idUsuario) {
      return res.status(403).json({ status: 'error', message: 'No autorizado para crear evaluaciones en este curso' });
    }

    const evaluacion = await Evaluacion.create({ titulo, descripcion, fechaInicio, fechaFin, idCurso });

    for (const preg of preguntas) {
      const pregunta = await Pregunta.create({ textoPregunta: preg.textoPregunta, tipo: preg.tipo, puntos: preg.puntos, idEvaluacion: evaluacion.idEvaluacion });
      if (preg.tipo === 'opcion_multiple' && preg.opciones) {
        for (const opc of preg.opciones) {
          await Opcion.create({ texto: opc.texto, esCorrecta: opc.esCorrecta, idPregunta: pregunta.idPregunta });
        }
      }
    }

    res.status(201).json({ status: 'success', message: 'Evaluación creada', data: { evaluacion } });
  } catch (error) {
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
      const pregunta = await Pregunta.findByPk(resp.idPregunta);
      if (!pregunta || pregunta.idEvaluacion !== evaluacion.idEvaluacion) {
        continue;
      }

      let correcta = false;
      if (pregunta.tipo === 'opcion_multiple') {
        const opcion = await Opcion.findByPk(resp.idOpcionSeleccionada);
        if (opcion && opcion.esCorrecta) {
          correcta = true;
          puntaje += pregunta.puntos;
        }
      } else if (pregunta.tipo === 'verdadero_falso') {
        // Asume respuestaTexto es 'verdadero' o 'falso', compara con correcta
        // Para simplicidad, asume lógica aquí
        correcta = true; // Implementar verificación
        if (correcta) puntaje += pregunta.puntos;
      } else if (pregunta.tipo === 'abierta') {
        feedback += 'Respuesta abierta pendiente de revisión. ';
      }

      await RespuestaEstudiante.create({
        idPregunta: resp.idPregunta,
        idUsuario: req.user.idUsuario,
        respuestaTexto: resp.respuestaTexto,
        idOpcionSeleccionada: resp.idOpcionSeleccionada,
        correcta
      });
    }

    res.json({ status: 'success', message: 'Evaluación enviada', data: { puntaje, feedback } });
  } catch (error) {
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
    const isDocente = curso.idDocente === req.user.idUsuario;
    const respuestas = await RespuestaEstudiante.findAll({ where: { idUsuario: req.user.idUsuario } }); // O todas si docente

    if (!isDocente) {
      // Solo propias
    }

    res.json({ status: 'success', message: 'Resultados obtenidos', data: { respuestas } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};