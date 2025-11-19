const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Mensaje = sequelize.define('Mensaje', {
  idMensaje: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    field: 'idMensaje'
  },
  contenido: {
    type: DataTypes.TEXT,
    allowNull: false,
    validate: {
      notEmpty: true
    }
  },
  fecha: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: DataTypes.NOW,
    field: 'fecha'
  },
  idForo: {
    type: DataTypes.INTEGER,
    allowNull: false,
    field: 'idForo',
    references: {
      model: 'Foro',
      key: 'idForo'
    }
  },
  idUsuario: {
    type: DataTypes.INTEGER,
    allowNull: false,
    field: 'idUsuario',
    references: {
      model: 'Usuario',
      key: 'idUsuario'
    }
  }
}, {
  tableName: 'Mensaje',
  timestamps: false
});

module.exports = Mensaje;



