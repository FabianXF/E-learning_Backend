const jwt = require('jsonwebtoken');
const { Usuario } = require('../models');

// Middleware para verificar token JWT
const authenticateToken = async (req, res, next) => {
  try {
    const authHeader = req.headers['authorization'];

    // DEBUG: Log del header de autorización
    console.log('[AUTH DEBUG] ===== Nueva petición =====');
    console.log('[AUTH DEBUG] Ruta:', req.method, req.path);
    console.log('[AUTH DEBUG] Authorization header:', authHeader ? `${authHeader.substring(0, 30)}...` : 'NO PRESENTE');

    const token = authHeader && authHeader.split(' ')[1]; // Bearer TOKEN

    if (!token) {
      console.log('[AUTH DEBUG] ❌ Token no encontrado en header');
      return res.status(401).json({
        status: 'error',
        message: 'Token de acceso requerido'
      });
    }

    console.log('[AUTH DEBUG] Token extraído:', token.substring(0, 20) + '...');

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    console.log('[AUTH DEBUG] Token decodificado exitosamente');
    console.log('[AUTH DEBUG] Payload:', { idUsuario: decoded.idUsuario, rol: decoded.rol, correo: decoded.correo });

    // Buscar usuario y adjuntarlo a la request
    const usuario = await Usuario.findByPk(decoded.idUsuario, {
      attributes: { exclude: ['contrasena'] }
    });

    if (!usuario) {
      console.log('[AUTH DEBUG] ❌ Usuario no encontrado en BD:', decoded.idUsuario);
      return res.status(401).json({
        status: 'error',
        message: 'Usuario no encontrado'
      });
    }

    console.log('[AUTH DEBUG] ✅ Usuario autenticado:', usuario.nombre, `(${usuario.rol})`);
    req.usuario = usuario;
    next();
  } catch (error) {
    console.log('[AUTH DEBUG] ❌ Error en autenticación:', error.name, error.message);

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



