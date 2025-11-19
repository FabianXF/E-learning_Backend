const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const Foro = sequelize.define('Foro', {
  idForo: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    field: 'idForo'
  },
  tema: {
    type: DataTypes.STRING(200),
    allowNull: false,
    validate: {
      notEmpty: true,
      len: [3, 200]
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
  tableName: 'Foro',
  timestamps: false
});

module.exports = Foro;



