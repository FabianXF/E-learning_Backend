const express = require('express');
const router = express.Router();
const { body } = require('express-validator');
const { register, login } = require('../controllers/authController');

// Validaciones para registro (basado solo en correo)
const validarRegistro = [
  // Aceptar emailAddress o correo
  body('emailAddress')
    .optional()
    .trim()
    .isEmail()
    .withMessage('El correo debe tener un formato válido')
    .normalizeEmail(),
  body('correo')
    .optional()
    .trim()
    .isEmail()
    .withMessage('El correo debe tener un formato válido')
    .normalizeEmail(),
  // Validar que al menos uno de los dos esté presente
  body().custom((value) => {
    if (!value.emailAddress && !value.correo) {
      throw new Error('El correo electrónico es requerido');
    }
    return true;
  }),
  // Aceptar password o contrasena
  body('password')
    .optional()
    .notEmpty()
    .withMessage('La contraseña es requerida')
    .isLength({ min: 6 })
    .withMessage('La contraseña debe tener al menos 6 caracteres'),
  body('contrasena')
    .optional()
    .notEmpty()
    .withMessage('La contraseña es requerida')
    .isLength({ min: 6 })
    .withMessage('La contraseña debe tener al menos 6 caracteres'),
  // Validar que al menos uno de los dos esté presente
  body().custom((value) => {
    if (!value.password && !value.contrasena) {
      throw new Error('La contraseña es requerida');
    }
    return true;
  }),
  body('nombre')
    .optional()
    .trim()
    .isLength({ min: 2, max: 100 })
    .withMessage('El nombre debe tener entre 2 y 100 caracteres'),
  body('rol')
    .optional()
    .isIn(['estudiante', 'docente', 'admin'])
    .withMessage('El rol debe ser: estudiante, docente o admin')
];

// Validaciones para login (solo correo)
const validarLogin = [
  body('correo')
    .optional()
    .trim()
    .isEmail()
    .withMessage('El correo debe tener un formato válido')
    .normalizeEmail(),
  body('emailAddress')
    .optional()
    .trim()
    .isEmail()
    .withMessage('El correo debe tener un formato válido')
    .normalizeEmail(),
  // Validar que al menos uno de los identificadores esté presente
  body().custom((value) => {
    if (!value.correo && !value.emailAddress) {
      throw new Error('El correo electrónico es requerido');
    }
    return true;
  }),
  // Aceptar password o contrasena
  body('password')
    .optional()
    .notEmpty()
    .withMessage('La contraseña es requerida'),
  body('contrasena')
    .optional()
    .notEmpty()
    .withMessage('La contraseña es requerida'),
  // Validar que al menos uno de los dos esté presente
  body().custom((value) => {
    if (!value.password && !value.contrasena) {
      throw new Error('La contraseña es requerida');
    }
    return true;
  })
];

// POST /api/auth/register - Registrar nuevo usuario
router.post('/register', validarRegistro, register);

// POST /api/auth/login - Iniciar sesión
router.post('/login', validarLogin, login);

module.exports = router;

