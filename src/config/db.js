const { Sequelize } = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    dialect: 'mysql',
    logging: process.env.NODE_ENV === 'development' ? console.log : false
  }
);

async function connectDB() {
  try {
    await sequelize.authenticate();
    console.log('Conexión a DB establecida');
    if (process.env.SYNC_DB === 'true') {
      // Cambiado de alter: true a false para evitar ER_TOO_MANY_KEYS
      // alter: true intenta modificar tablas existentes y puede causar problemas con índices
      await sequelize.sync({ alter: false });
      console.log('Modelos sincronizados (solo nuevas tablas)');
    }
  } catch (error) {
    console.error('Error conectando a DB:', error);
    throw error;
  }
}

module.exports = { connectDB, sequelize };