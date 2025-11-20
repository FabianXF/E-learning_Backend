const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');
const { authenticateToken } = require('../middleware/auth');

router.get('/usuarios', authenticateToken, adminController.getUsuarios);
router.put('/usuarios/:id', authenticateToken, adminController.updateUsuario);
router.delete('/usuarios/:id', authenticateToken, adminController.deleteUsuario);
router.get('/monitor', authenticateToken, adminController.getMonitor);

module.exports = router;
