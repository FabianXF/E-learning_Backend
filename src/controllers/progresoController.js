const { ProgresoMaterial, Material, Inscripcion, Modulo } = require('../models');
const { validationResult } = require('express-validator');

exports.getProgreso = async (req, res) => {
  try {
    const inscripcion = await Inscripcion.findOne({ where: { idUsuario: req.user.idUsuario, idCurso: req.params.idCurso } });
    if (!inscripcion) {
      return res.status(403).json({ status: 'error', message: 'No inscrito en este curso' });
    }

    const modulos = await Modulo.findAll({ where: { idCurso: req.params.idCurso } });
    const totalMateriales = await Material.count({ where: { idModulo: modulos.map(m => m.idModulo) } });
    const completados = await ProgresoMaterial.count({ where: { idUsuario: req.user.idUsuario, completado: true } });

    const porcentaje = totalMateriales > 0 ? Math.round((completados / totalMateriales) * 100) : 0;

    // Gráfico simple (data para frontend, e.g., Chart.js)
    const grafico = { completados, pendientes: totalMateriales - completados };

    await inscripcion.update({ progresoPorcentaje: porcentaje });

    res.json({ status: 'success', message: 'Progreso obtenido', data: { porcentaje, grafico } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.updateProgreso = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ status: 'error', message: 'Validación fallida', errors: errors.array() });
  }

  try {
    const material = await Material.findByPk(req.params.idMaterial);
    if (!material) {
      return res.status(404).json({ status: 'error', message: 'Material no encontrado' });
    }

    const modulo = await material.getModulo();
    const curso = await modulo.getCurso();
    const inscripcion = await Inscripcion.findOne({ where: { idUsuario: req.user.idUsuario, idCurso: curso.idCurso } });
    if (!inscripcion) {
      return res.status(403).json({ status: 'error', message: 'No inscrito en este curso' });
    }

    const [progreso, created] = await ProgresoMaterial.upsert({
      idUsuario: req.user.idUsuario,
      idMaterial: material.idMaterial,
      completado: true,
      fechaCompletado: new Date()
    });

    res.json({ status: 'success', message: 'Progreso actualizado', data: { progreso } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};