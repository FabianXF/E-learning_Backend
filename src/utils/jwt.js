const jwt = require('jsonwebtoken');

// Generar token JWT
const generateToken = (usuario) => {
  const payload = {
    idUsuario: usuario.idUsuario,
    correo: usuario.correo,
    rol: usuario.rol
  };

  return jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN || '24h'
  });
};

module.exports = {
  generateToken
};




