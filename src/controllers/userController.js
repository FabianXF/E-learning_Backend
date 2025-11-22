const { Usuario } = require('../models');
const { validationResult } = require('express-validator');

// Obtener perfil del usuario autenticado
exports.getProfile = async (req, res) => {
    try {
        const usuario = await Usuario.findByPk(req.usuario.idUsuario, {
            attributes: { exclude: ['contrasena'] }
        });

        if (!usuario) {
            return res.status(404).json({
                status: 'error',
                message: 'Usuario no encontrado'
            });
        }

        res.status(200).json({
            status: 'success',
            message: 'Perfil obtenido',
            data: {
                user: {
                    id: usuario.idUsuario,
                    idUsuario: usuario.idUsuario,
                    nombre: usuario.nombre,
                    email: usuario.correo,
                    correo: usuario.correo,
                    rol: usuario.rol,
                    avatar: usuario.avatar
                }
            }
        });
    } catch (error) {
        res.status(500).json({
            status: 'error',
            message: error.message
        });
    }
};

// Actualizar perfil del usuario autenticado
exports.updateProfile = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                status: 'error',
                message: 'Errores de validación',
                errors: errors.array()
            });
        }

        const { nombre, avatar, password } = req.body;
        const idUsuario = req.usuario.idUsuario;

        const usuario = await Usuario.findByPk(idUsuario);

        if (!usuario) {
            return res.status(404).json({
                status: 'error',
                message: 'Usuario no encontrado'
            });
        }

        // Preparar datos a actualizar
        const updateData = {};
        if (nombre) updateData.nombre = nombre;
        if (avatar) updateData.avatar = avatar;
        if (password) updateData.contrasena = password; // El hook de Sequelize lo hasheará

        // Actualizar usuario
        await usuario.update(updateData);

        // Obtener usuario actualizado sin contraseña
        const usuarioActualizado = await Usuario.findByPk(idUsuario, {
            attributes: { exclude: ['contrasena'] }
        });

        res.status(200).json({
            status: 'success',
            message: 'Perfil actualizado exitosamente',
            data: {
                user: {
                    id: usuarioActualizado.idUsuario,
                    idUsuario: usuarioActualizado.idUsuario,
                    nombre: usuarioActualizado.nombre,
                    email: usuarioActualizado.correo,
                    correo: usuarioActualizado.correo,
                    rol: usuarioActualizado.rol,
                    avatar: usuarioActualizado.avatar
                }
            }
        });
    } catch (error) {
        res.status(500).json({
            status: 'error',
            message: error.message
        });
    }
};
