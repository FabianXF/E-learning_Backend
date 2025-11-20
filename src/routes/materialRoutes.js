const express = require('express');
const router = express.Router();
const materialController = require('../controllers/materialController');
const { authenticateToken } = require('../middleware/auth');
const upload = require('../middleware/upload');
const { body } = require('express-validator');

router.post(
  '/upload',
  authenticateToken,
  upload.single('file'),
  body('titulo').trim().notEmpty().withMessage('Título requerido'),
  body('tipo').isIn(['pdf', 'video', 'doc', 'image']).withMessage('Tipo inválido'),
  body('idModulo').isNumeric().withMessage('ID de módulo inválido'),
  materialController.uploadMaterial
);

router.get('/:id', authenticateToken, materialController.getMaterial);

module.exports = router;
