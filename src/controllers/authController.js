const { Usuario } = require('../models');
const { generateToken } = require('../utils/jwt');
const { validationResult } = require('express-validator');

// Registrar nuevo usuario
const register = async (req, res, next) => {
  try {
    // Verificar errores de validación
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: 'error',
        message: 'Errores de validación',
        errors: errors.array()
      });
    }

    const { emailAddress, password, nombre } = req.body;

    // Normalizar campos (aceptar ambos formatos)
    const correo = (emailAddress || req.body.correo || '').trim().toLowerCase();
    const contrasena = password || req.body.contrasena;
    const nombreUsuario = nombre || req.body.nombre;

    // Verificar si el correo ya existe
    const usuarioExistenteCorreo = await Usuario.findOne({ where: { correo } });
    if (usuarioExistenteCorreo) {
      return res.status(409).json({
        status: 'error',
        message: 'El correo electrónico ya está registrado',
        field: 'emailAddress'
      });
    }

    // Crear nuevo usuario
    const nuevoUsuario = await Usuario.create({
      nombre: nombreUsuario,
      correo,
      contrasena,
      rol: req.body.rol || 'estudiante',
      avatar: req.body.avatar || null
    });

    // Retornar respuesta (sin contraseña) - Formato según guía de estilos
    const usuarioResponse = {
      id: nuevoUsuario.idUsuario,
      idUsuario: nuevoUsuario.idUsuario,
      nombre: nuevoUsuario.nombre,
      email: nuevoUsuario.correo,
      correo: nuevoUsuario.correo,
      rol: nuevoUsuario.rol
    };

    res.status(201).json({
      success: true,
      status: 'success',
      message: 'Usuario registrado exitosamente',
      data: {
        user: usuarioResponse,
        usuario: usuarioResponse
      }
    });
  } catch (error) {
    next(error);
  }
};

// Iniciar sesión
const login = async (req, res, next) => {
  try {
    // Verificar errores de validación
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: 'error',
        message: 'Errores de validación',
        errors: errors.array()
      });
    }

    const { password, correo, contrasena } = req.body;

    // Normalizar campos (aceptar ambos formatos)
    const correoLogin = (correo || req.body.emailAddress || '').trim().toLowerCase();
    const contrasenaLogin = password || contrasena;

    if (!correoLogin) {
      return res.status(400).json({
        success: false,
        status: 'error',
        message: 'Debes proporcionar el correo electrónico',
        errors: {
          emailAddress: 'Debes proporcionar el correo electrónico'
        }
      });
    }

    // Buscar usuario por correo
    const usuario = await Usuario.findOne({
      where: { correo: correoLogin }
    });

    if (!usuario) {
      return res.status(401).json({
        success: false,
        status: 'error',
        message: 'Credenciales inválidas',
        errors: {
          credentials: 'El correo electrónico no existe'
        }
      });
    }

    // Verificar contraseña
    const contrasenaValida = await usuario.comparePassword(contrasenaLogin);
    if (!contrasenaValida) {
      return res.status(401).json({
        success: false,
        status: 'error',
        message: 'Credenciales inválidas',
        errors: {
          credentials: 'La contraseña es incorrecta'
        }
      });
    }

    // Generar token
    const token = generateToken(usuario);

    // Retornar respuesta (sin contraseña) - Formato según guía de estilos
    const usuarioResponse = {
      id: usuario.idUsuario,
      idUsuario: usuario.idUsuario,
      nombre: usuario.nombre,
      email: usuario.correo,
      correo: usuario.correo,
      rol: usuario.rol
    };

    res.status(200).json({
      success: true,
      status: 'success',
      message: 'Inicio de sesión exitoso',
      data: {
        user: usuarioResponse,
        usuario: usuarioResponse,
        token,
        expiresIn: process.env.JWT_EXPIRES_IN || '24h'
      }
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  register,
  login
};

