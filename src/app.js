const express = require('express');
const cors = require('cors');
require('dotenv').config();

// Importar rutas
const authRoutes = require('./routes/authRoutes');
const cursoRoutes = require('./routes/cursoRoutes');
const materialRoutes = require('./routes/materialRoutes');
const evaluacionRoutes = require('./routes/evaluacionRoutes');
const foroRoutes = require('./routes/foroRoutes');
const progresoRoutes = require('./routes/progresoRoutes');
const reporteRoutes = require('./routes/reporteRoutes');
const certificadoRoutes = require('./routes/certificadoRoutes');
const adminRoutes = require('./routes/adminRoutes');
const userRoutes = require('./routes/userRoutes');

// Importar middleware de errores
const errorHandler = require('./utils/errorHandler');

// Crear aplicación Express
const app = express();

// Middlewares globales
app.use(cors()); // Permitir CORS
app.use(express.json()); // Parsear JSON
app.use(express.urlencoded({ extended: true })); // Parsear URL-encoded

// Ruta de salud/verificación
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'success',
    message: 'Servidor funcionando correctamente',
    timestamp: new Date().toISOString()
  });
});

// Rutas de la API
app.use('/api/auth', authRoutes);
app.use('/api/cursos', cursoRoutes);
app.use('/api/materiales', materialRoutes);
app.use('/api/evaluaciones', evaluacionRoutes);
app.use('/api/foros', foroRoutes);
app.use('/api/progreso', progresoRoutes);
app.use('/api/reportes', reporteRoutes);
app.use('/api/certificados', certificadoRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/users', userRoutes);

// Ruta 404 - No encontrada
app.use((req, res) => {
  res.status(404).json({
    status: 'error',
    message: 'Ruta no encontrada'
  });
});

// Middleware de manejo de errores (debe ir al final)
app.use(errorHandler);

module.exports = app;