const { Foro, Mensaje, Curso, Inscripcion, Usuario } = require('../models');
const { validationResult } = require('express-validator');

exports.createForo = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      status: 'error',
      message: 'Validación fallida',
      errors: errors.array()
    });
  }

  try {
    const { tema, idCurso } = req.body;

    const curso = await Curso.findByPk(idCurso);

    if (!curso || curso.idDocente !== req.usuario.idUsuario) {
      return res.status(403).json({
        status: 'error',
        message: 'No autorizado para crear foros en este curso'
      });
    }

    const foro = await Foro.create({ tema, idCurso });

    return res.status(201).json({
      status: 'success',
      message: 'Foro creado',
      data: { foro }
    });

  } catch (error) {
    return res.status(500).json({
      status: 'error',
      message: error.message
    });
  }
};


exports.getForo = async (req, res) => {
  try {
    const foro = await Foro.findByPk(req.params.id, {
      include: [{
        model: Mensaje,
        as: 'mensajes',
        include: [{
          model: Usuario,
          as: 'usuario',
          attributes: ['idUsuario', 'nombre', 'avatar']
        }]
      }]
    });

    if (!foro) {
      return res.status(404).json({
        status: 'error',
        message: 'Foro no encontrado'
      });
    }

    const curso = await foro.getCurso();

    const isInscrito = await Inscripcion.findOne({
      where: {
        idUsuario: req.usuario.idUsuario,
        idCurso: curso.idCurso
      }
    });

    const isDocente = curso.idDocente === req.usuario.idUsuario;

    if (!isInscrito && !isDocente) {
      return res.status(403).json({
        status: 'error',
        message: 'No autorizado para ver este foro'
      });
    }

    return res.json({
      status: 'success',
      message: 'Foro obtenido',
      data: { foro }
    });

  } catch (error) {
    return res.status(500).json({
      status: 'error',
      message: error.message
    });
  }
};


exports.createMensaje = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      status: 'error',
      message: 'Validación fallida',
      errors: errors.array()
    });
  }

  try {
    const { contenido } = req.body;

    const foro = await Foro.findByPk(req.params.id);

    if (!foro) {
      return res.status(404).json({
        status: 'error',
        message: 'Foro no encontrado'
      });
    }

    const curso = await foro.getCurso();

    const isInscrito = await Inscripcion.findOne({
      where: {
        idUsuario: req.usuario.idUsuario,
        idCurso: curso.idCurso
      }
    });

    const isDocente = curso.idDocente === req.usuario.idUsuario;

    if (!isInscrito && !isDocente) {
      return res.status(403).json({
        status: 'error',
        message: 'No autorizado para publicar en este foro'
      });
    }

    const mensaje = await Mensaje.create({
      contenido,
      idForo: foro.idForo,
      idUsuario: req.usuario.idUsuario
    });

    const mensajeCompleto = await Mensaje.findByPk(mensaje.idMensaje, {
      include: [{
        model: Usuario,
        as: 'usuario',
        attributes: ['idUsuario', 'nombre', 'avatar']
      }]
    });

    return res.status(201).json({
      status: 'success',
      message: 'Mensaje publicado',
      data: { mensaje: mensajeCompleto }
    });

  } catch (error) {
    return res.status(500).json({
      status: 'error',
      message: error.message
    });
  }
};


exports.deleteMensaje = async (req, res) => {
  try {
    const mensaje = await Mensaje.findByPk(req.params.id);

    if (!mensaje) {
      return res.status(404).json({
        status: 'error',
        message: 'Mensaje no encontrado'
      });
    }

    const foro = await mensaje.getForo();
    const curso = await foro.getCurso();

    // Verificar permisos: docente del curso O administrador
    const esDocenteDelCurso = curso.idDocente === req.usuario.idUsuario;
    const esAdmin = req.usuario.rol === 'admin';

    if (!esDocenteDelCurso && !esAdmin) {
      return res.status(403).json({
        status: 'error',
        message: 'No autorizado para moderar este mensaje'
      });
    }

    await mensaje.destroy();

    return res.json({
      status: 'success',
      message: 'Mensaje eliminado'
    });

  } catch (error) {
    return res.status(500).json({
      status: 'error',
      message: error.message
    });
  }
};
exports.getForosByCurso = async (req, res) => {
  try {
    const { idCurso } = req.params;
    console.log(`Getting foros for curso: ${idCurso}`);
    const curso = await Curso.findByPk(idCurso);

    if (!curso) {
      console.log('Curso not found');
      return res.status(404).json({
        status: 'error',
        message: 'Curso no encontrado'
      });
    }

    // Verificar si el usuario está inscrito o es el docente
    // Ensure req.usuario is defined
    if (!req.usuario) {
      console.log('req.usuario is undefined');
      return res.status(401).json({
        status: 'error',
        message: 'Usuario no autenticado'
      });
    }

    const esDocente = curso.idDocente === req.usuario.idUsuario;
    const estaInscrito = await Inscripcion.findOne({
      where: {
        idUsuario: req.usuario.idUsuario,
        idCurso
      }
    });

    if (!esDocente && !estaInscrito) {
      console.log('User not authorized');
      return res.status(403).json({
        status: 'error',
        message: 'No autorizado para ver foros de este curso'
      });
    }

    const foros = await Foro.findAll({
      where: { idCurso },
      include: [
        {
          model: Mensaje,
          as: 'mensajes', // Explicitly specify alias
          limit: 1,
          order: [['fecha', 'DESC']],
          include: [{ model: Usuario, as: 'usuario', attributes: ['nombre', 'avatar'] }]
        }
      ]
    });

    res.json({
      status: 'success',
      message: 'Foros obtenidos',
      data: { foros }
    });
  } catch (error) {
    console.error('Error in getForosByCurso:', error);
    res.status(500).json({
      status: 'error',
      message: error.message
    });
  }
};

// Obtener todos los foros de los cursos donde el usuario participa (docente o estudiante)
exports.getMisForos = async (req, res) => {
  try {
    const idUsuario = req.usuario.idUsuario;

    // 1. Cursos donde es docente
    const cursosDocente = await Curso.findAll({
      where: { idDocente: idUsuario },
      attributes: ['idCurso']
    });
    const idsCursosDocente = cursosDocente.map(c => c.idCurso);

    // 2. Cursos donde es estudiante
    const inscripciones = await Inscripcion.findAll({
      where: { idUsuario },
      attributes: ['idCurso']
    });
    const idsCursosEstudiante = inscripciones.map(i => i.idCurso);

    // Unir IDs (Set para únicos)
    const allCursoIds = [...new Set([...idsCursosDocente, ...idsCursosEstudiante])];

    if (allCursoIds.length === 0) {
      return res.json({
        status: 'success',
        message: 'No tienes foros disponibles',
        data: [],
        foros: []
      });
    }

    // 3. Buscar foros de estos cursos
    const foros = await Foro.findAll({
      where: {
        idCurso: allCursoIds
      },
      include: [
        {
          model: Curso,
          as: 'curso',
          attributes: ['titulo', 'imagenUrl']
        },
        {
          model: Mensaje,
          as: 'mensajes',
          // separate: true,
          // limit: 1,
          order: [['fecha', 'DESC']],
          include: [{ model: Usuario, as: 'usuario', attributes: ['nombre', 'avatar'] }]
        }
      ],
      order: [['idForo', 'DESC']]
    });

    res.json({
      status: 'success',
      message: 'Mis foros obtenidos',
      data: foros, // Array [ ... ]
      foros: foros // Array [ ... ]
    });

  } catch (error) {
    console.error('[GET MIS FOROS] Error:', error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};
