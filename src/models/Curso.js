const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Curso = sequelize.define('Curso', {
  idCurso: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    field: 'idCurso'
  },
  titulo: {
    type: DataTypes.STRING(200),
    allowNull: false,
    validate: {
      notEmpty: true,
      len: [3, 200]
    }
  },
  descripcion: {
    type: DataTypes.TEXT,
    allowNull: false,
    validate: {
      notEmpty: true
    }
  },
  categoria: {
    type: DataTypes.STRING(80),
    allowNull: false,
    validate: {
      notEmpty: true
    }
  },
  idDocente: {
    type: DataTypes.INTEGER,
    allowNull: false,
    field: 'idDocente',
    references: {
      model: 'Usuario',
      key: 'idUsuario'
    }
  }
}, {
  tableName: 'Curso',
  timestamps: false
});

module.exports = Curso;



