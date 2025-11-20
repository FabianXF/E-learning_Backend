const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Pregunta = sequelize.define('Pregunta', {
  idPregunta: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  idEvaluacion: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  textoPregunta: {
    type: DataTypes.TEXT,
    allowNull: false
  },
  tipo: {
    type: DataTypes.ENUM('opcion_multiple', 'verdadero_falso', 'abierta'),
    allowNull: false
  },
  puntos: {
    type: DataTypes.INTEGER,
    defaultValue: 10
  }
}, {
  tableName: 'Pregunta',
  timestamps: false
});

module.exports = Pregunta;