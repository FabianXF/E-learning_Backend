const jwt = require('jsonwebtoken');
const { Usuario } = require('../models');

// Middleware para verificar token JWT
const authenticateToken = async (req, res, next) => {
  try {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Bearer TOKEN

    if (!token) {
      return res.status(401).json({
        status: 'error',
        message: 'Token de acceso requerido'
      });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    // Buscar usuario y adjuntarlo a la request
    const usuario = await Usuario.findByPk(decoded.idUsuario, {
      attributes: { exclude: ['contrasena'] }
    });

    if (!usuario) {
      return res.status(401).json({
        status: 'error',
        message: 'Usuario no encontrado'
      });
    }

    req.usuario = usuario;
    next();
  } catch (error) {
    if (error.name === 'JsonWebTokenError') {
      return res.status(401).json({
        status: 'error',
        message: 'Token inválido'
      });
    }
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({
        status: 'error',
        message: 'Token expirado'
      });
    }
    return res.status(500).json({
      status: 'error',
      message: 'Error al verificar token',
      error: error.message
    });
  }
};

// Middleware para verificar rol específico
const requireRole = (...roles) => {
  return (req, res, next) => {
    if (!req.usuario) {
      return res.status(401).json({
        status: 'error',
        message: 'No autenticado'
      });
    }

    if (!roles.includes(req.usuario.rol)) {
      return res.status(403).json({
        status: 'error',
        message: 'No tienes permisos para realizar esta acción'
      });
    }

    next();
  };
};

module.exports = {
  authenticateToken,
  requireRole
};



