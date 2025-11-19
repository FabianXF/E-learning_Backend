const express = require('express');
const router = express.Router();
const progresoController = require('../controllers/progresoController');
const authMiddleware = require('../middleware/auth');

router.get('/:idCurso', authMiddleware, progresoController.getProgreso);

router.put('/:idCurso/material/:idMaterial', authMiddleware, progresoController.updateProgreso);

module.exports = router;