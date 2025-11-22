const { Certificado, Curso, Inscripcion } = require('../models');
const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');
const pdfGenerator = require('../utils/pdfGenerator');

exports.getCertificado = async (req, res) => {
  try {
    const inscripcion = await Inscripcion.findOne({ where: { idUsuario: req.usuario.idUsuario, idCurso: req.params.idCurso } });
    if (!inscripcion || inscripcion.progresoPorcentaje < 100) {
      return res.status(403).json({ status: 'error', message: 'Curso no completado' });
    }

    const curso = await Curso.findByPk(req.params.idCurso);
    const codigo = uuidv4().slice(0, 10).toUpperCase();

    const [certificado, created] = await Certificado.upsert({
      idUsuario: req.usuario.idUsuario,
      idCurso: curso.idCurso,
      codigoVerificacion: codigo,
      urlPDF: '' // Temporal
    });

    const filePath = pdfGenerator.generateCertificado(req.usuario, curso, codigo);
    await certificado.update({ urlPDF: filePath });

    // Esperar un momento para asegurar que el archivo se escriba completamente
    setTimeout(() => {
      if (fs.existsSync(filePath)) {
        res.download(filePath, `Certificado-${curso.titulo}.pdf`, (err) => {
          if (err) {
            console.error('[CERTIFICADO] Error al descargar:', err);
            if (!res.headersSent) {
              res.status(500).json({ status: 'error', message: 'Error al descargar el certificado' });
            }
          }
        });
      } else {
        console.error('[CERTIFICADO] Archivo no encontrado:', filePath);
        res.status(500).json({ status: 'error', message: 'Error al generar el archivo del certificado' });
      }
    }, 1000); // Pequeño delay para asegurar escritura

  } catch (error) {
    console.error('[CERTIFICADO] Error:', error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};