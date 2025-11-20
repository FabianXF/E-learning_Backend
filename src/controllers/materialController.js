const { Material, Modulo, Curso, Inscripcion } = require('../models');
const { validationResult } = require('express-validator');

exports.uploadMaterial = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ status: 'error', message: 'Validación fallida', errors: errors.array() });
  }

  try {
    const { titulo, tipo, idModulo } = req.body;
    const modulo = await Modulo.findByPk(idModulo);
    if (!modulo) {
      return res.status(404).json({ status: 'error', message: 'Módulo no encontrado' });
    }

    const curso = await modulo.getCurso();
    // Fix: Use req.usuario instead of req.user
    if (curso.idDocente !== req.usuario.idUsuario || req.usuario.rol !== 'docente') {
      return res.status(403).json({ status: 'error', message: 'No autorizado para subir materiales en este curso' });
    }

    const url = `/uploads/${req.file.filename}`;
    const duracionMinutos = tipo === 'video' ? 0 : null; // Puedes calcular duracion si es video
    const material = await Material.create({ titulo, tipo, url, duracionMinutos, idModulo });

    res.status(201).json({ status: 'success', message: 'Material subido exitosamente', data: { material } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.getMaterial = async (req, res) => {
  try {
    const material = await Material.findByPk(req.params.id);
    if (!material) {
      return res.status(404).json({ status: 'error', message: 'Material no encontrado' });
    }

    const modulo = await material.getModulo();
    const curso = await modulo.getCurso();
    // Fix: Use req.usuario instead of req.user
    const isDocente = curso.idDocente === req.usuario.idUsuario;
    const isInscrito = await Inscripcion.findOne({ where: { idUsuario: req.usuario.idUsuario, idCurso: curso.idCurso } });

    if (!isDocente && !isInscrito) {
      return res.status(403).json({ status: 'error', message: 'No autorizado para acceder a este material' });
    }

    // Para stream o download, aquí devuelvo URL
    res.json({ status: 'success', message: 'Material obtenido', data: { material } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};