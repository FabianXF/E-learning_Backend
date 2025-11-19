const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Modulo = sequelize.define('Modulo', {
  idModulo: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  titulo: {
    type: DataTypes.STRING(150),
    allowNull: false
  },
  descripcion: {
    type: DataTypes.TEXT
  },
  orden: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  idCurso: {
    type: DataTypes.INTEGER,
    allowNull: false
  }
}, {
  tableName: 'Modulo',
  timestamps: false
});

module.exports = Modulo;