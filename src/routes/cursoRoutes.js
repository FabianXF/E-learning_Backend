const express = require('express');
const router = express.Router();
const { body } = require('express-validator');
const { buscarCursos, crearCurso, inscribirseEnCurso, obtenerMateriales, editarCurso, eliminarCurso, agregarModulo, obtenerModulos } = require('../controllers/cursoController');
const { authenticateToken, requireRole } = require('../middleware/auth');

// Validaciones para crear curso
const validarCrearCurso = [
  body('titulo')
    .trim()
    .notEmpty()
    .withMessage('El título es requerido')
    .isLength({ min: 3, max: 200 })
    .withMessage('El título debe tener entre 3 y 200 caracteres'),
  body('descripcion')
    .trim()
    .notEmpty()
    .withMessage('La descripción es requerida'),
  body('categoria')
    .trim()
    .notEmpty()
    .withMessage('La categoría es requerida')
    .isLength({ max: 80 })
    .withMessage('La categoría no puede tener más de 80 caracteres')
];

// Validaciones para editar curso (opcionales)
const validarEditarCurso = [
  body('titulo')
    .optional()
    .trim()
    .isLength({ min: 3, max: 200 })
    .withMessage('El título debe tener entre 3 y 200 caracteres'),
  body('descripcion')
    .optional()
    .trim()
    .notEmpty()
    .withMessage('La descripción no puede estar vacía'),
  body('categoria')
    .optional()
    .trim()
    .isLength({ max: 80 })
    .withMessage('La categoría no puede tener más de 80 caracteres')
];

// Validaciones para agregar módulo
const validarAgregarModulo = [
  body('titulo')
    .trim()
    .notEmpty()
    .withMessage('El título del módulo es requerido'),
  body('orden')
    .isInt()
    .withMessage('El orden debe ser un número entero')
];

// GET /api/cursos - Buscar cursos (público, con filtros opcionales)
router.get('/', buscarCursos);

// POST /api/cursos - Crear curso (solo docentes)
router.post('/', authenticateToken, requireRole('docente', 'admin'), validarCrearCurso, crearCurso);

// PUT /api/cursos/:id - Editar curso (solo docente o admin)
router.put('/:id', authenticateToken, requireRole('docente', 'admin'), validarEditarCurso, editarCurso);

// DELETE /api/cursos/:id - Eliminar curso (solo docente o admin)
router.delete('/:id', authenticateToken, requireRole('docente', 'admin'), eliminarCurso);

// POST /api/cursos/:id/modulos - Agregar módulo (solo docente)
router.post('/:id/modulos', authenticateToken, requireRole('docente'), validarAgregarModulo, agregarModulo);

// GET /api/cursos/:id/modulos - Obtener módulos de un curso (inscritos y docentes)
router.get('/:id/modulos', authenticateToken, obtenerModulos);

// POST /api/cursos/:id/inscribirse - Inscribirse en un curso (autenticado)
router.post('/:id/inscribirse', authenticateToken, inscribirseEnCurso);

// GET /api/cursos/:id/materiales - Obtener materiales de un curso (solo inscritos)
router.get('/:id/materiales', authenticateToken, obtenerMateriales);

module.exports = router;