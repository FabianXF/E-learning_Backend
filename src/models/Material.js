const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Material = sequelize.define('Material', {
  idMaterial: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    field: 'idMaterial'
  },
  tipo: {
    type: DataTypes.STRING(30),
    allowNull: false,
    validate: {
      notEmpty: true,
      isIn: [['pdf', 'video', 'documento', 'presentacion', 'enlace']]
    }
  },
  url: {
    type: DataTypes.STRING(255),
    allowNull: false,
    validate: {
      notEmpty: true,
      isUrl: true
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
  tableName: 'Material',
  timestamps: false
});

module.exports = Material;



