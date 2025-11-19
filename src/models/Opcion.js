const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Opcion = sequelize.define('Opcion', {
  idOpcion: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  idPregunta: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  texto: {
    type: DataTypes.STRING(255),
    allowNull: false
  },
  esCorrecta: {
    type: DataTypes.BOOLEAN,
    allowNull: false
  }
}, {
  tableName: 'Opcion',
  timestamps: false
});

module.exports = Opcion;