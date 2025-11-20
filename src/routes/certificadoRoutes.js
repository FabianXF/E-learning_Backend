const express = require('express');
const router = express.Router();
const certificadoController = require('../controllers/certificadoController');
const { authenticateToken } = require('../middleware/auth');

router.get('/:idCurso', authenticateToken, certificadoController.getCertificado);

module.exports = router;
