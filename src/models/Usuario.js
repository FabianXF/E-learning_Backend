const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');
const bcrypt = require('bcrypt');

const Usuario = sequelize.define('Usuario', {
  idUsuario: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    field: 'idUsuario'
  },
  nombre: {
    type: DataTypes.STRING(100),
    allowNull: false,
    validate: {
      notEmpty: true,
      len: [2, 100]
    }
  },
  correo: {
    type: DataTypes.STRING(150),
    allowNull: false,
    unique: true,
    validate: {
      isEmail: true,
      notEmpty: true
    }
  },
  contrasena: {
    type: DataTypes.STRING(255),
    allowNull: false,
    validate: {
      notEmpty: true,
      len: [6, 255]
    }
  },
  rol: {
    type: DataTypes.STRING(20),
    allowNull: false,
    defaultValue: 'estudiante',
    validate: {
      isIn: [['estudiante', 'docente', 'admin']]
    }
  },
  avatar: {
    type: DataTypes.STRING(255),
    allowNull: true
  }
}, {
  tableName: 'Usuario',
  timestamps: false,
  hooks: {
    beforeCreate: async (usuario) => {
      if (usuario.contrasena) {
        const salt = await bcrypt.genSalt(10);
        usuario.contrasena = await bcrypt.hash(usuario.contrasena, salt);
      }
    },
    beforeUpdate: async (usuario) => {
      if (usuario.changed('contrasena')) {
        const salt = await bcrypt.genSalt(10);
        usuario.contrasena = await bcrypt.hash(usuario.contrasena, salt);
      }
    }
  }
});

// Método para comparar contraseñas
Usuario.prototype.comparePassword = async function(password) {
  return await bcrypt.compare(password, this.contrasena);
};

module.exports = Usuario;

