const express = require('express');
const router = express.Router();
const foroController = require('../controllers/foroController');
const authMiddleware = require('../middleware/auth');
const { body } = require('express-validator');

router.post('/', authMiddleware, [
  body('tema').trim().notEmpty(),
  body('idCurso').isNumeric()
], foroController.createForo);

router.get('/:id', authMiddleware, foroController.getForo);

router.post('/:id/mensajes', authMiddleware, [
  body('contenido').trim().notEmpty()
], foroController.createMensaje);

router.delete('/mensajes/:id', authMiddleware, foroController.deleteMensaje);

module.exports = router;