const { Sequelize } = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    dialect: 'mysql',
    logging: process.env.NODE_ENV === 'development' ? console.log : false,
    pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000
    }
  }
);

// Función para conectar a la base de datos
const connectDB = async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Conexión a MySQL establecida correctamente.');
    
    // Sincronizar modelos solo si se especifica en variables de entorno
    // Por defecto, NO sincroniza para bases de datos existentes
    if (process.env.SYNC_DB === 'true') {
      const syncOptions = process.env.SYNC_DB_ALTER === 'true' 
        ? { alter: true } 
        : { alter: false };
      
      await sequelize.sync(syncOptions);
      console.log('✅ Modelos sincronizados con la base de datos.');
    } else {
      console.log('ℹ️  Sincronización automática deshabilitada (BD existente).');
      console.log('   Para habilitar, configura SYNC_DB=true en .env');
    }
  } catch (error) {
    console.error('❌ Error al conectar con la base de datos:', error.message);
    process.exit(1);
  }
};

module.exports = {
  sequelize,
  connectDB
};

