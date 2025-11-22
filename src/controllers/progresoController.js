const { ProgresoMaterial, Material, Inscripcion, Modulo } = require('../models');
const { validationResult } = require('express-validator');

exports.getProgreso = async (req, res) => {
  try {
    const inscripcion = await Inscripcion.findOne({ where: { idUsuario: req.usuario.idUsuario, idCurso: req.params.idCurso } });
    if (!inscripcion) {
      return res.status(403).json({ status: 'error', message: 'No inscrito en este curso' });
    }

    // Obtener todos los módulos del curso
    const modulos = await Modulo.findAll({ where: { idCurso: req.params.idCurso } });
    const idsModulos = modulos.map(m => m.idModulo);

    // Contar total de materiales del curso
    const totalMateriales = await Material.count({ where: { idModulo: idsModulos } });

    // Obtener todos los materiales del curso
    const materialesDelCurso = await Material.findAll({
      where: { idModulo: idsModulos },
      attributes: ['idMaterial']
    });
    const idsMaterialesDelCurso = materialesDelCurso.map(m => m.idMaterial);

    // Obtener progreso del usuario para estos materiales
    const progresosCompletados = await ProgresoMaterial.findAll({
      where: {
        idUsuario: req.usuario.idUsuario,
        idMaterial: idsMaterialesDelCurso,
        completado: true
      },
      attributes: ['idMaterial']
    });

    const completados = progresosCompletados.length;
    const porcentaje = totalMateriales > 0 ? Math.round((completados / totalMateriales) * 100) : 0;

    // Array de IDs de materiales completados
    const materialesVistos = progresosCompletados.map(p => p.idMaterial);

    // Gráfico simple (data para frontend, e.g., Chart.js)
    const grafico = { completados, pendientes: totalMateriales - completados };

    await inscripcion.update({ progresoPorcentaje: porcentaje });

    res.json({
      status: 'success',
      message: 'Progreso obtenido',
      data: {
        porcentaje,
        porcentajeCompletado: porcentaje,
        grafico,
        materialesVistos
      }
    });
  } catch (error) {
    console.error('[GET PROGRESO] Error:', error);
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
    const inscripcion = await Inscripcion.findOne({ where: { idUsuario: req.usuario.idUsuario, idCurso: curso.idCurso } });
    if (!inscripcion) {
      return res.status(403).json({ status: 'error', message: 'No inscrito en este curso' });
    }

    const [progreso, created] = await ProgresoMaterial.upsert({
      idUsuario: req.usuario.idUsuario,
      idMaterial: material.idMaterial,
      completado: true,
      fechaCompletado: new Date()
    });

    res.json({ status: 'success', message: 'Progreso actualizado', data: { progreso } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

// Desmarcar material como completado
exports.deleteProgreso = async (req, res) => {
  try {
    const { idCurso, idMaterial } = req.params;
    const idUsuario = req.usuario.idUsuario;

    const material = await Material.findByPk(idMaterial);
    if (!material) {
      return res.status(404).json({ status: 'error', message: 'Material no encontrado' });
    }

    const modulo = await material.getModulo();
    const curso = await modulo.getCurso();
    const inscripcion = await Inscripcion.findOne({ where: { idUsuario, idCurso: curso.idCurso } });

    if (!inscripcion) {
      return res.status(403).json({ status: 'error', message: 'No inscrito en este curso' });
    }

    const deleted = await ProgresoMaterial.destroy({
      where: { idUsuario, idMaterial }
    });

    if (deleted === 0) {
      return res.status(404).json({ status: 'error', message: 'Material no estaba marcado como completado' });
    }

    res.json({ status: 'success', message: 'Material desmarcado como completado' });
  } catch (error) {
    console.error('[DELETE PROGRESO] Error:', error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};