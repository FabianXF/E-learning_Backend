const { Curso, Inscripcion, RespuestaEstudiante, ProgresoMaterial } = require('../models');
const pdfGenerator = require('../utils/pdfGenerator');
const emailSender = require('../utils/emailSender');
const path = require('path');

exports.getReporte = async (req, res) => {
  try {
    const curso = await Curso.findByPk(req.params.idCurso);
    if (!curso || (curso.idDocente !== req.user.idUsuario && req.user.rol !== 'admin')) {
      return res.status(403).json({ status: 'error', message: 'No autorizado para generar reportes de este curso' });
    }

    // Stats ejemplo
    const inscripciones = await Inscripcion.count({ where: { idCurso: curso.idCurso } });
    const promedioProgreso = await Inscripcion.average('progresoPorcentaje', { where: { idCurso: curso.idCurso } });
    const data = { inscripciones, promedioProgreso: Math.round(promedioProgreso || 0) };

    const filePath = path.join(__dirname, '../../reports', `reporte-${curso.idCurso}.pdf`);
    pdfGenerator.generateReporte(data, filePath);

    if (req.query.email === 'true') {
      await emailSender.sendReporte(req.user.correo, filePath);
    }

    res.json({ status: 'success', message: 'Reporte generado', data: { url: `/reports/reporte-${curso.idCurso}.pdf` } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};