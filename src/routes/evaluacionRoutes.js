const express = require('express');
const router = express.Router();
const evaluacionController = require('../controllers/evaluacionController');
const authMiddleware = require('../middleware/auth');
const { body } = require('express-validator');

router.post('/create', authMiddleware, [
  body('titulo').trim().notEmpty(),
  body('idCurso').isNumeric(),
  body('preguntas').isArray({ min: 1 })
], evaluacionController.createEvaluacion);

router.post('/:id/submit', authMiddleware, [
  body('respuestas').isArray({ min: 1 })
], evaluacionController.submitEvaluacion);

router.get('/:id/results', authMiddleware, evaluacionController.getResults);

module.exports = router;