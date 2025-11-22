const express = require('express');
const router = express.Router();
const foroController = require('../controllers/foroController');
const { authenticateToken } = require('../middleware/auth');
const { body } = require('express-validator');

// Crear foro
router.post(
  '/',
  authenticateToken,
  body('tema').trim().notEmpty().withMessage('El tema es obligatorio'),
  body('idCurso').isInt().withMessage('idCurso debe ser un número entero'),
  foroController.createForo
);

// Obtener foros de un curso
router.get('/curso/:idCurso', authenticateToken, foroController.getForosByCurso);

// Obtener mis foros (todos los cursos)
router.get('/mis-foros', authenticateToken, foroController.getMisForos);

// Obtener foro
router.get('/:id', authenticateToken, foroController.getForo);

// Publicar mensaje
router.post(
  '/:id/mensajes',
  authenticateToken,
  body('contenido').trim().notEmpty().withMessage('El contenido es obligatorio'),
  foroController.createMensaje
);

// Eliminar mensaje
router.delete(
  '/mensajes/:id',
  authenticateToken,
  foroController.deleteMensaje
);

module.exports = router;
