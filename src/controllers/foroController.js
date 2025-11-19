const { Foro, Mensaje, Curso } = require('../models');
const { validationResult } = require('express-validator');

exports.createForo = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ status: 'error', message: 'Validación fallida', errors: errors.array() });
  }

  try {
    const { tema, idCurso } = req.body;
    const curso = await Curso.findByPk(idCurso);
    if (!curso || curso.idDocente !== req.user.idUsuario) {
      return res.status(403).json({ status: 'error', message: 'No autorizado para crear foros en este curso' });
    }

    const foro = await Foro.create({ tema, idCurso });

    res.status(201).json({ status: 'success', message: 'Foro creado', data: { foro } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.getForo = async (req, res) => {
  try {
    const foro = await Foro.findByPk(req.params.id, { include: Mensaje });
    if (!foro) {
      return res.status(404).json({ status: 'error', message: 'Foro no encontrado' });
    }

    const curso = await foro.getCurso();
    const isInscrito = await Inscripcion.findOne({ where: { idUsuario: req.user.idUsuario, idCurso: curso.idCurso } });
    const isDocente = curso.idDocente === req.user.idUsuario;

    if (!isInscrito && !isDocente) {
      return res.status(403).json({ status: 'error', message: 'No autorizado para ver este foro' });
    }

    res.json({ status: 'success', message: 'Foro obtenido', data: { foro } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.createMensaje = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ status: 'error', message: 'Validación fallida', errors: errors.array() });
  }

  try {
    const { contenido } = req.body;
    const foro = await Foro.findByPk(req.params.id);
    if (!foro) {
      return res.status(404).json({ status: 'error', message: 'Foro no encontrado' });
    }

    const curso = await foro.getCurso();
    const isInscrito = await Inscripcion.findOne({ where: { idUsuario: req.user.idUsuario, idCurso: curso.idCurso } });
    const isDocente = curso.idDocente === req.user.idUsuario;

    if (!isInscrito && !isDocente) {
      return res.status(403).json({ status: 'error', message: 'No autorizado para publicar en este foro' });
    }

    const mensaje = await Mensaje.create({ contenido, idForo: foro.idForo, idUsuario: req.user.idUsuario });

    res.status(201).json({ status: 'success', message: 'Mensaje publicado', data: { mensaje } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.deleteMensaje = async (req, res) => {
  try {
    const mensaje = await Mensaje.findByPk(req.params.id);
    if (!mensaje) {
      return res.status(404).json({ status: 'error', message: 'Mensaje no encontrado' });
    }

    const foro = await mensaje.getForo();
    const curso = await foro.getCurso();
    if (curso.idDocente !== req.user.idUsuario) {
      return res.status(403).json({ status: 'error', message: 'No autorizado para moderar este mensaje' });
    }

    await mensaje.destroy();

    res.json({ status: 'success', message: 'Mensaje eliminado' });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};