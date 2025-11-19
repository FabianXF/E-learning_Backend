const { Certificado, Curso, Inscripcion } = require('../models');
const pdfGenerator = require('../utils/pdfGenerator');
const path = require('path');
const { v4: uuidv4 } = require('uuid');

exports.getCertificado = async (req, res) => {
  try {
    const inscripcion = await Inscripcion.findOne({ where: { idUsuario: req.user.idUsuario, idCurso: req.params.idCurso } });
    if (!inscripcion || inscripcion.progresoPorcentaje < 100) {
      return res.status(403).json({ status: 'error', message: 'Curso no completado' });
    }

    const curso = await Curso.findByPk(req.params.idCurso);
    const codigo = uuidv4().slice(0, 10).toUpperCase();

    const [certificado, created] = await Certificado.upsert({
      idUsuario: req.user.idUsuario,
      idCurso: curso.idCurso,
      codigoVerificacion: codigo,
      urlPDF: '' // Temporal
    });

    const filePath = pdfGenerator.generateCertificado(req.user, curso, codigo);
    await certificado.update({ urlPDF: filePath });

    res.json({ status: 'success', message: 'Certificado generado', data: { url: filePath } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};