const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const RespuestaEstudiante = sequelize.define('RespuestaEstudiante', {
  idRespuesta: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  idPregunta: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  idUsuario: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  respuestaTexto: {
    type: DataTypes.TEXT
  },
  idOpcionSeleccionada: {
    type: DataTypes.INTEGER
  },
  correcta: {
    type: DataTypes.BOOLEAN
  }
}, {
  tableName: 'RespuestaEstudiante',
  timestamps: false
});

module.exports = RespuestaEstudiante;