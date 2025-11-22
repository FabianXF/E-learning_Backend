const { Usuario, Curso } = require('../models');

exports.getUsuarios = async (req, res) => {
  if (req.usuario.rol !== 'admin') {
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
  if (req.usuario.rol !== 'admin') {
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
  if (req.usuario.rol !== 'admin') {
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
  if (req.usuario.rol !== 'admin') {
    return res.status(403).json({ status: 'error', message: 'No autorizado' });
  }

  try {
    // Contar usuarios por rol
    const totalUsuarios = await Usuario.count();
    const estudiantes = await Usuario.count({ where: { rol: 'estudiante' } });
    const docentes = await Usuario.count({ where: { rol: 'docente' } });
    const admins = await Usuario.count({ where: { rol: 'admin' } });

    // Contar cursos activos
    const cursosActivos = await Curso.count();

    console.log('[ADMIN MONITOR] Estadísticas:', {
      totalUsuarios,
      estudiantes,
      docentes,
      admins,
      cursosActivos
    });

    res.json({
      status: 'success',
      message: 'Monitoreo obtenido',
      data: {
        usuariosActivos: totalUsuarios, // Mantener por compatibilidad si es necesario
        totalUsuarios,
        estudiantes,
        docentes,
        admins,
        cursosActivos
      }
    });
  } catch (error) {
    console.error('[ADMIN MONITOR] Error:', error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};