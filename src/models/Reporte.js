const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Reporte = sequelize.define('Reporte', {
  idReporte: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    field: 'idReporte'
  },
  tipo: {
    type: DataTypes.STRING(50),
    allowNull: false,
    validate: {
      notEmpty: true
    }
  },
  fecha: {
    type: DataTypes.DATEONLY,
    allowNull: false,
    defaultValue: DataTypes.NOW,
    field: 'fecha'
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
  tableName: 'Reporte',
  timestamps: false
});

module.exports = Reporte;



