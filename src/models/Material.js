const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Material = sequelize.define('Material', {
  idMaterial: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  titulo: {
    type: DataTypes.STRING(200),
    allowNull: false
  },
  tipo: {
    type: DataTypes.STRING(30),
    allowNull: false
  },
  url: {
    type: DataTypes.STRING(255),
    allowNull: false
  },
  duracionMinutos: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  idModulo: {
    type: DataTypes.INTEGER,
    allowNull: false
  }
}, {
  tableName: 'Material',
  timestamps: false
});

module.exports = Material;