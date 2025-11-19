const express = require('express');
const router = express.Router();
const certificadoController = require('../controllers/certificadoController');
const authMiddleware = require('../middleware/auth');

router.get('/:idCurso', authMiddleware, certificadoController.getCertificado);

module.exports = router;