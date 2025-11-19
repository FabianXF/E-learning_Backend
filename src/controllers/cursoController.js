const { Curso, Inscripcion, Material, Usuario, Modulo } = require('../models');
const { Op } = require('sequelize');
const { validationResult } = require('express-validator');

// Buscar cursos con filtros
const buscarCursos = async (req, res, next) => {
  try {
    const { categoria, titulo } = req.query;
    const where = {};

    // Aplicar filtros
    if (categoria) {
      where.categoria = { [Op.like]: `%${categoria}%` };
    }
    if (titulo) {
      where.titulo = { [Op.like]: `%${titulo}%` };
    }

    const cursos = await Curso.findAll({
      where,
      include: [
        {
          model: Usuario,
          as: 'docente',
          attributes: ['idUsuario', 'nombre', 'correo']
        }
      ],
      order: [['idCurso', 'DESC']]
    });

    res.status(200).json({
      status: 'success',
      message: 'Cursos encontrados',
      data: {
        cursos,
        total: cursos.length
      }
    });
  } catch (error) {
    next(error);
  }
};

// Crear nuevo curso (solo docentes)
const crearCurso = async (req, res, next) => {
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

    const { titulo, descripcion, categoria } = req.body;
    const idDocente = req.usuario.idUsuario;

    const nuevoCurso = await Curso.create({
      titulo,
      descripcion,
      categoria,
      idDocente
    });

    // Cargar curso con docente
    const cursoCompleto = await Curso.findByPk(nuevoCurso.idCurso, {
      include: [
        {
          model: Usuario,
          as: 'docente',
          attributes: ['idUsuario', 'nombre', 'correo']
        }
      ]
    });

    res.status(201).json({
      status: 'success',
      message: 'Curso creado exitosamente',
      data: {
        curso: cursoCompleto
      }
    });
  } catch (error) {
    next(error);
  }
};

// Inscribirse en un curso
const inscribirseEnCurso = async (req, res, next) => {
  try {
    const { id } = req.params;
    const idUsuario = req.usuario.idUsuario;

    // Verificar que el curso existe
    const curso = await Curso.findByPk(id);
    if (!curso) {
      return res.status(404).json({
        status: 'error',
        message: 'Curso no encontrado'
      });
    }

    // Verificar que el usuario no sea el docente del curso
    if (curso.idDocente === idUsuario) {
      return res.status(400).json({
        status: 'error',
        message: 'No puedes inscribirte en tu propio curso'
      });
    }

    // Verificar si ya está inscrito
    const inscripcionExistente = await Inscripcion.findOne({
      where: {
        idUsuario,
        idCurso: id
      }
    });

    if (inscripcionExistente) {
      return res.status(409).json({
        status: 'error',
        message: 'Ya estás inscrito en este curso'
      });
    }

    // Crear inscripción
    const nuevaInscripcion = await Inscripcion.create({
      idUsuario,
      idCurso: id,
      fechaInscripcion: new Date()
    });

    res.status(201).json({
      status: 'success',
      message: 'Inscripción realizada exitosamente',
      data: {
        inscripcion: nuevaInscripcion
      }
    });
  } catch (error) {
    next(error);
  }
};

// Obtener materiales de un curso (solo usuarios inscritos)
const obtenerMateriales = async (req, res, next) => {
  try {
    const { id } = req.params;
    const idUsuario = req.usuario.idUsuario;

    // Verificar que el curso existe
    const curso = await Curso.findByPk(id);
    if (!curso) {
      return res.status(404).json({
        status: 'error',
        message: 'Curso no encontrado'
      });
    }

    // Verificar si el usuario está inscrito o es el docente
    const esDocente = curso.idDocente === idUsuario;
    const estaInscrito = await Inscripcion.findOne({
      where: {
        idUsuario,
        idCurso: id
      }
    });

    if (!esDocente && !estaInscrito) {
      return res.status(403).json({
        status: 'error',
        message: 'Debes estar inscrito en el curso para acceder a los materiales'
      });
    }

    // Obtener materiales
    const materiales = await Material.findAll({
      where: { idCurso: id },
      order: [['idMaterial', 'DESC']]
    });

    res.status(200).json({
      status: 'success',
      message: 'Materiales obtenidos exitosamente',
      data: {
        materiales,
        total: materiales.length
      }
    });
  } catch (error) {
    next(error);
  }
};

// Editar curso (solo docente del curso)
const editarCurso = async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: 'error',
        message: 'Errores de validación',
        errors: errors.array()
      });
    }

    const { id } = req.params;
    const idUsuario = req.usuario.idUsuario;

    const curso = await Curso.findByPk(id);
    if (!curso) {
      return res.status(404).json({
        status: 'error',
        message: 'Curso no encontrado'
      });
    }

    if (curso.idDocente !== idUsuario && req.usuario.rol !== 'admin') {
      return res.status(403).json({
        status: 'error',
        message: 'No autorizado para editar este curso'
      });
    }

    await curso.update(req.body);

    const cursoActualizado = await Curso.findByPk(id, {
      include: [
        {
          model: Usuario,
          as: 'docente',
          attributes: ['idUsuario', 'nombre', 'correo']
        }
      ]
    });

    res.status(200).json({
      status: 'success',
      message: 'Curso actualizado exitosamente',
      data: {
        curso: cursoActualizado
      }
    });
  } catch (error) {
    next(error);
  }
};

// Eliminar curso (solo docente o admin)
const eliminarCurso = async (req, res, next) => {
  try {
    const { id } = req.params;
    const idUsuario = req.usuario.idUsuario;

    const curso = await Curso.findByPk(id);
    if (!curso) {
      return res.status(404).json({
        status: 'error',
        message: 'Curso no encontrado'
      });
    }

    if (curso.idDocente !== idUsuario && req.usuario.rol !== 'admin') {
      return res.status(403).json({
        status: 'error',
        message: 'No autorizado para eliminar este curso'
      });
    }

    await curso.destroy();

    res.status(200).json({
      status: 'success',
      message: 'Curso eliminado exitosamente'
    });
  } catch (error) {
    next(error);
  }
};

// Agregar módulo a curso
const agregarModulo = async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: 'error',
        message: 'Errores de validación',
        errors: errors.array()
      });
    }

    const { id } = req.params;
    const { titulo, descripcion, orden } = req.body;
    const idUsuario = req.usuario.idUsuario;

    const curso = await Curso.findByPk(id);
    if (!curso) {
      return res.status(404).json({
        status: 'error',
        message: 'Curso no encontrado'
      });
    }

    if (curso.idDocente !== idUsuario) {
      return res.status(403).json({
        status: 'error',
        message: 'No autorizado para agregar módulos a este curso'
      });
    }

    const nuevoModulo = await Modulo.create({
      titulo,
      descripcion,
      orden,
      idCurso: id
    });

    res.status(201).json({
      status: 'success',
      message: 'Módulo agregado exitosamente',
      data: {
        modulo: nuevoModulo
      }
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  buscarCursos,
  crearCurso,
  inscribirseEnCurso,
  obtenerMateriales,
  editarCurso,
  eliminarCurso,
  agregarModulo
};