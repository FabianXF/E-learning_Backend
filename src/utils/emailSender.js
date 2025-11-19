const nodemailer = require('nodemailer');
require('dotenv').config();

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
});

exports.sendReporte = async (to, filePath) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject: 'Reporte de Curso',
    text: 'Adjunto el reporte generado.',
    attachments: [{ path: filePath }]
  };

  await transporter.sendMail(mailOptions);
};