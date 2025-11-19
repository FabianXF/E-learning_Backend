const { Usuario, Curso } = require('../models');

exports.getUsuarios = async (req, res) => {
  if (req.user.rol !== 'admin') {
    return res.status(403).json({ status: 'error', message: 'No autorizado' });
  }

  try {
    const usuarios = await Usuario.findAll({ attributes: { exclude: ['contrasena'] } });
    res.json({ status: 'success', message: 'Usuarios obtenidos', data: { usuarios } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.updateUsuario = async (req, res) => {
  if (req.user.rol !== 'admin') {
    return res.status(403).json({ status: 'error', message: 'No autorizado' });
  }

  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) {
      return res.status(404).json({ status: 'error', message: 'Usuario no encontrado' });
    }

    await usuario.update(req.body);
    res.json({ status: 'success', message: 'Usuario actualizado', data: { usuario } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.deleteUsuario = async (req, res) => {
  if (req.user.rol !== 'admin') {
    return res.status(403).json({ status: 'error', message: 'No autorizado' });
  }

  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) {
      return res.status(404).json({ status: 'error', message: 'Usuario no encontrado' });
    }

    await usuario.destroy();
    res.json({ status: 'success', message: 'Usuario eliminado' });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};

exports.getMonitor = async (req, res) => {
  if (req.user.rol !== 'admin') {
    return res.status(403).json({ status: 'error', message: 'No autorizado' });
  }

  try {
    const usuariosActivos = await Usuario.count();
    const cursosActivos = await Curso.count();

    res.json({ status: 'success', message: 'Monitoreo obtenido', data: { usuariosActivos, cursosActivos } });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message });
  }
};