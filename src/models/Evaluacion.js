const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Evaluacion = sequelize.define('Evaluacion', {
  idEvaluacion: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    field: 'idEvaluacion'
  },
  titulo: {
    type: DataTypes.STRING(200),
    allowNull: false,
    validate: {
      notEmpty: true
    }
  },
  descripcion: {
    type: DataTypes.TEXT,
    allowNull: true
  },
  fechaInicio: {
    type: DataTypes.DATEONLY,
    allowNull: false,
    field: 'fechaInicio'
  },
  fechaFin: {
    type: DataTypes.DATEONLY,
    allowNull: false,
    field: 'fechaFin',
    validate: {
      isAfter: function (value) {
        if (this.fechaInicio && value < this.fechaInicio) {
          throw new Error('La fecha de fin debe ser posterior o igual a la fecha de inicio');
        }
      }
    }
  },
  idCurso: {
    type: DataTypes.INTEGER,
    allowNull: false,
    field: 'idCurso',
    references: {
      model: 'Curso',
      key: 'idCurso'
    }
  }
}, {
  tableName: 'Evaluacion',
  timestamps: false
});

module.exports = Evaluacion;
