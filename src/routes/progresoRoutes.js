const express = require('express');
const router = express.Router();
const progresoController = require('../controllers/progresoController');
const { authenticateToken } = require('../middleware/auth');

router.get(
  '/:idCurso',
  authenticateToken,
  progresoController.getProgreso
);

router.put(
  '/:idCurso/material/:idMaterial',
  authenticateToken,
  progresoController.updateProgreso
);

module.exports = router;
