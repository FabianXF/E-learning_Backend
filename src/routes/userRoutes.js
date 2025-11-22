const express = require('express');
const router = express.Router();
const { body } = require('express-validator');
const { getProfile, updateProfile } = require('../controllers/userController');
const { authenticateToken } = require('../middleware/auth');

// Validaciones para actualizar perfil
const validarActualizarPerfil = [
    body('nombre')
        .optional()
        .trim()
        .isLength({ min: 2, max: 100 })
        .withMessage('El nombre debe tener entre 2 y 100 caracteres'),
    body('avatar')
        .optional({ checkFalsy: true })  // Permite valores vacíos
        .trim()
        .isURL()
        .withMessage('El avatar debe ser una URL válida'),
    body('password')
        .optional()
        .isLength({ min: 6 })
        .withMessage('La contraseña debe tener al menos 6 caracteres')
];

// GET /api/users/profile - Obtener perfil del usuario autenticado
router.get('/profile', authenticateToken, getProfile);

// PUT /api/users/profile - Actualizar perfil del usuario autenticado
router.put('/profile', authenticateToken, validarActualizarPerfil, updateProfile);

module.exports = router;
