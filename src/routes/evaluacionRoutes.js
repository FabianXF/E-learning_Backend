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

// Obtener evaluaciones de un curso (debe ir ANTES de /:id/results)
router.get(
  '/curso/:idCurso',
  authenticateToken,
  evaluacionController.getEvaluacionesByCurso
);

// Obtener una evaluación individual (debe ir ANTES de /:id/results)
router.get(
  '/:id',
  authenticateToken,
  evaluacionController.getEvaluacion
);

// Obtener resultados
router.get(
  '/:id/results',
  authenticateToken,
  evaluacionController.getResults
);

module.exports = router;
