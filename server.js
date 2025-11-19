require('dotenv').config();
const app = require('./src/app');
const { connectDB } = require('./src/config/db');

const PORT = process.env.PORT || 8080;

// Iniciar servidor
const startServer = async () => {
  try {
    // Conectar a la base de datos
    await connectDB();

    // Iniciar servidor Express
    app.listen(PORT, () => {
      console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
      console.log(`📚 Ambiente: ${process.env.NODE_ENV || 'development'}`);
      console.log(`📝 Endpoints disponibles:`);
      console.log(`   - POST /api/auth/register`);
      console.log(`   - POST /api/auth/login`);
      console.log(`   - GET  /api/cursos`);
      console.log(`   - POST /api/cursos`);
      console.log(`   - PUT  /api/cursos/:id`);
      console.log(`   - DELETE /api/cursos/:id`);
      console.log(`   - POST /api/cursos/:id/modulos`);
      console.log(`   - POST /api/cursos/:id/inscribirse`);
      console.log(`   - GET  /api/cursos/:id/materiales`);
      console.log(`   - POST /api/materiales/upload`);
      console.log(`   - GET  /api/materiales/:id`);
      console.log(`   - POST /api/evaluaciones/create`);
      console.log(`   - POST /api/evaluaciones/:id/submit`);
      console.log(`   - GET  /api/evaluaciones/:id/results`);
      console.log(`   - POST /api/foros`);
      console.log(`   - GET  /api/foros/:id`);
      console.log(`   - POST /api/foros/:id/mensajes`);
      console.log(`   - DELETE /api/mensajes/:id`);
      console.log(`   - GET  /api/progreso/:idCurso`);
      console.log(`   - PUT  /api/progreso/:idCurso/material/:idMaterial`);
      console.log(`   - GET  /api/reportes/:idCurso`);
      console.log(`   - GET  /api/certificados/:idCurso`);
      console.log(`   - GET  /api/admin/usuarios`);
      console.log(`   - PUT  /api/admin/usuarios/:id`);
      console.log(`   - DELETE /api/admin/usuarios/:id`);
      console.log(`   - GET  /api/admin/monitor`);
    });
  } catch (error) {
    console.error('❌ Error al iniciar el servidor:', error);
    process.exit(1);
  }
};

startServer();