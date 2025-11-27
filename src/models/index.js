const Usuario = require('./Usuario');
const Curso = require('./Curso');
const Inscripcion = require('./Inscripcion');
const Material = require('./Material');
const Evaluacion = require('./Evaluacion');
const Foro = require('./Foro');
const Mensaje = require('./Mensaje');
const Reporte = require('./Reporte');
const Modulo = require('./Modulo');
const ProgresoMaterial = require('./ProgresoMaterial');
const Pregunta = require('./Pregunta');
const Opcion = require('./Opcion');
const RespuestaEstudiante = require('./RespuestaEstudiante');
const Certificado = require('./Certificado');
const { sequelize } = require('../config/db');

// Definir relaciones
Usuario.hasMany(Curso, { foreignKey: 'idDocente', as: 'cursos' });
Curso.belongsTo(Usuario, { foreignKey: 'idDocente', as: 'docente' });

Usuario.belongsToMany(Curso, {
  through: Inscripcion,
  foreignKey: 'idUsuario',
  otherKey: 'idCurso',
  as: 'cursosInscritos'
});
Curso.belongsToMany(Usuario, {
  through: Inscripcion,
  foreignKey: 'idCurso',
  otherKey: 'idUsuario',
  as: 'estudiantes'
});

// Direct associations for Inscripcion
Inscripcion.belongsTo(Usuario, { foreignKey: 'idUsuario', as: 'usuario' });
Inscripcion.belongsTo(Curso, { foreignKey: 'idCurso', as: 'curso' });
Usuario.hasMany(Inscripcion, { foreignKey: 'idUsuario', as: 'inscripciones' });
Curso.hasMany(Inscripcion, { foreignKey: 'idCurso', as: 'inscripciones' });

Usuario.hasMany(Mensaje, { foreignKey: 'idUsuario', as: 'mensajes' });
Mensaje.belongsTo(Usuario, { foreignKey: 'idUsuario', as: 'usuario' });

Foro.hasMany(Mensaje, { foreignKey: 'idForo', as: 'mensajes' });
Mensaje.belongsTo(Foro, { foreignKey: 'idForo', as: 'foro' });

Curso.hasMany(Material, { foreignKey: 'idCurso', as: 'materiales' });
Material.belongsTo(Curso, { foreignKey: 'idCurso', as: 'curso' });

Curso.hasMany(Evaluacion, { foreignKey: 'idCurso', as: 'evaluaciones' });
Evaluacion.belongsTo(Curso, { foreignKey: 'idCurso', as: 'curso' });

Curso.hasMany(Foro, { foreignKey: 'idCurso', as: 'foros' });
Foro.belongsTo(Curso, { foreignKey: 'idCurso', as: 'curso' });

Usuario.hasMany(Reporte, { foreignKey: 'idUsuario', as: 'reportes' });
Reporte.belongsTo(Usuario, { foreignKey: 'idUsuario', as: 'usuario' });

// Nuevas relaciones para Sprints 2-4
Curso.hasMany(Modulo, { foreignKey: 'idCurso', onDelete: 'CASCADE', as: 'modulos' });
Modulo.belongsTo(Curso, { foreignKey: 'idCurso', as: 'curso' });

Modulo.hasMany(Material, { foreignKey: 'idModulo', onDelete: 'CASCADE', as: 'materiales' });
Material.belongsTo(Modulo, { foreignKey: 'idModulo', as: 'modulo' });

Usuario.belongsToMany(Material, {
  through: ProgresoMaterial,
  foreignKey: 'idUsuario',
  otherKey: 'idMaterial',
  as: 'progresoMateriales'
});
Material.belongsToMany(Usuario, {
  through: ProgresoMaterial,
  foreignKey: 'idMaterial',
  otherKey: 'idUsuario',
  as: 'usuariosProgreso'
});

Evaluacion.hasMany(Pregunta, { foreignKey: 'idEvaluacion', onDelete: 'CASCADE', as: 'preguntas' });
Pregunta.belongsTo(Evaluacion, { foreignKey: 'idEvaluacion', as: 'evaluacion' });

Pregunta.hasMany(Opcion, { foreignKey: 'idPregunta', onDelete: 'CASCADE', as: 'opciones' });
Opcion.belongsTo(Pregunta, { foreignKey: 'idPregunta', as: 'pregunta' });

Pregunta.hasMany(RespuestaEstudiante, { foreignKey: 'idPregunta', onDelete: 'CASCADE', as: 'respuestas' });
RespuestaEstudiante.belongsTo(Pregunta, { foreignKey: 'idPregunta', as: 'pregunta' });

Usuario.hasMany(RespuestaEstudiante, { foreignKey: 'idUsuario', onDelete: 'CASCADE', as: 'respuestasEstudiante' });
RespuestaEstudiante.belongsTo(Usuario, { foreignKey: 'idUsuario', as: 'usuario' });

Usuario.hasMany(Certificado, { foreignKey: 'idUsuario', as: 'certificados' });
Certificado.belongsTo(Usuario, { foreignKey: 'idUsuario', as: 'usuario' });

Curso.hasMany(Certificado, { foreignKey: 'idCurso', as: 'certificados' });
Certificado.belongsTo(Curso, { foreignKey: 'idCurso', as: 'curso' });

// Asociaciones de Foros (Ya definidas arriba)

module.exports = {
  Usuario,
  Curso,
  Inscripcion,
  Material,
  Evaluacion,
  Foro,
  Mensaje,
  Reporte,
  Modulo,
  ProgresoMaterial,
  Pregunta,
  Opcion,
  RespuestaEstudiante,
  Certificado
};