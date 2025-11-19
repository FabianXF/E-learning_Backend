const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');
const authMiddleware = require('../middleware/auth');

router.get('/usuarios', authMiddleware, adminController.getUsuarios);
router.put('/usuarios/:id', authMiddleware, adminController.updateUsuario);
router.delete('/usuarios/:id', authMiddleware, adminController.deleteUsuario);
router.get('/monitor', authMiddleware, adminController.getMonitor);

module.exports = router;