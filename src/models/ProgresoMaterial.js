const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const ProgresoMaterial = sequelize.define('ProgresoMaterial', {
  idUsuario: {
    type: DataTypes.INTEGER,
    primaryKey: true
  },
  idMaterial: {
    type: DataTypes.INTEGER,
    primaryKey: true
  },
  completado: {
    type: DataTypes.BOOLEAN,
    defaultValue: false
  },
  fechaCompletado: {
    type: DataTypes.DATE
  }
}, {
  tableName: 'ProgresoMaterial',
  timestamps: false
});

module.exports = ProgresoMaterial;