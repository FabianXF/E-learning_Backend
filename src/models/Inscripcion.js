const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Inscripcion = sequelize.define('Inscripcion', {
  idUsuario: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    field: 'idUsuario',
    references: {
      model: 'Usuario',
      key: 'idUsuario'
    }
  },
  idCurso: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    field: 'idCurso',
    references: {
      model: 'Curso',
      key: 'idCurso'
    }
  },
  fechaInscripcion: {
    type: DataTypes.DATEONLY,
    allowNull: false,
    defaultValue: DataTypes.NOW,
    field: 'fechaInscripcion'
  }
}, {
  tableName: 'Inscripcion',
  timestamps: false
});

module.exports = Inscripcion;



