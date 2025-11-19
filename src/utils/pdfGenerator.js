const PDFDocument = require('pdfkit');
const fs = require('fs');
const path = require('path');

exports.generateCertificado = (user, curso, codigo) => {
  const doc = new PDFDocument();
  const filePath = path.join(__dirname, '../../certificates', `${user.nombre.replace(/\s/g, '_')}-${curso.titulo.replace(/\s/g, '_')}.pdf`);
  doc.pipe(fs.createWriteStream(filePath));

  doc.fontSize(25).text('Certificado de Finalización', { align: 'center' });
  doc.fontSize(18).text(`Emitido a: ${user.nombre}`);
  doc.text(`Por completar el curso: ${curso.titulo}`);
  doc.text(`Fecha de emisión: ${new Date().toLocaleDateString()}`);
  doc.text(`Código de verificación: ${codigo}`);
  doc.end();

  return filePath;
};

exports.generateReporte = (data, idCurso) => {
  const doc = new PDFDocument();
  const filePath = path.join(__dirname, '../../reports', `reporte-${idCurso}.pdf`);
  doc.pipe(fs.createWriteStream(filePath));

  doc.fontSize(20).text('Reporte de Curso');
  doc.text(`Inscripciones: ${data.inscripciones}`);
  doc.text(`Promedio de progreso: ${data.promedioProgreso}%`);
  // Agrega más stats o gráficos si usas chart.js para embed
  doc.end();

  return filePath;
};