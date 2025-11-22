const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    console.log('[MULTER] Guardando archivo en uploads/');
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    const filename = Date.now() + path.extname(file.originalname);
    console.log('[MULTER] Nombre de archivo:', filename);
    cb(null, filename);
  }
});

const fileFilter = (req, file, cb) => {
  console.log('[MULTER] Verificando tipo de archivo:', file.mimetype);
  const allowedTypes = [
    'image/jpeg',
    'image/png',
    'image/jpg',
    'video/mp4',
    'application/pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document', // .docx
    'application/vnd.ms-powerpoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation' // .pptx
  ];

  if (allowedTypes.includes(file.mimetype)) {
    console.log('[MULTER] ✅ Tipo de archivo permitido');
    cb(null, true);
  } else {
    console.log('[MULTER] ❌ Tipo de archivo no permitido:', file.mimetype);
    cb(new Error(`Tipo de archivo no permitido: ${file.mimetype}. Solo se permiten: jpg, png, mp4, pdf, doc, docx, ppt, pptx`), false);
  }
};

const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 10 * 1024 * 1024 } // 10MB max
});

// Agregar logging al middleware
const uploadWithLogging = upload.single('file');

module.exports = (req, res, next) => {
  console.log('[MULTER] ===== Procesando upload =====');
  console.log('[MULTER] Content-Type:', req.headers['content-type']);
  console.log('[MULTER] Body antes de multer:', Object.keys(req.body));

  uploadWithLogging(req, res, (err) => {
    if (err) {
      console.error('[MULTER] ❌ Error:', err.message);
      return res.status(400).json({
        status: 'error',
        message: err.message
      });
    }

    console.log('[MULTER] Archivo procesado:', req.file ? 'SÍ' : 'NO');
    if (req.file) {
      console.log('[MULTER] Detalles del archivo:', {
        fieldname: req.file.fieldname,
        originalname: req.file.originalname,
        mimetype: req.file.mimetype,
        size: req.file.size,
        filename: req.file.filename
      });
    }
    console.log('[MULTER] Body después de multer:', req.body);

    next();
  });
};