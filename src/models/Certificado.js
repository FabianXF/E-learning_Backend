const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Certificado = sequelize.define('Certificado', {
  idCertificado: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  idUsuario: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  idCurso: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  fechaEmision: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW
  },
  codigoVerificacion: {
    type: DataTypes.STRING(50),
    unique: true
  },
  urlPDF: {
    type: DataTypes.STRING(255)
  }
}, {
  tableName: 'Certificado',
  timestamps: false
});

module.exports = Certificado;