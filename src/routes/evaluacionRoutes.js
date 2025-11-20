const express = require('express');
const router = express.Router();
const evaluacionController = require('../controllers/evaluacionController');
const { authenticateToken } = require('../middleware/auth');
const { body } = require('express-validator');

// Crear evaluación
router.post(
  '/create',
  authenticateToken,
  body('titulo').trim().notEmpty(),
  body('idCurso').isNumeric(),
  body('preguntas').isArray({ min: 1 }),
  evaluacionController.createEvaluacion
);

// Enviar respuestas
router.post(
  '/:id/submit',
  authenticateToken,
  body('respuestas').isArray({ min: 1 }),
  evaluacionController.submitEvaluacion
);

// Obtener resultados
router.get(
  '/:id/results',
  authenticateToken,
  evaluacionController.getResults
);

module.exports = router;
