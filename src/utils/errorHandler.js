// Middleware para manejo centralizado de errores
const errorHandler = (err, req, res, next) => {
  console.error('Error:', err);

  // Errores de validación de Sequelize
  if (err.name === 'SequelizeValidationError') {
    return res.status(400).json({
      status: 'error',
      message: 'Error de validación',
      errors: err.errors.map(e => ({
        field: e.path,
        message: e.message
      }))
    });
  }

  // Error de duplicado único
  if (err.name === 'SequelizeUniqueConstraintError') {
    return res.status(409).json({
      status: 'error',
      message: 'El recurso ya existe',
      field: err.errors[0]?.path
    });
  }

  // Error de foreign key
  if (err.name === 'SequelizeForeignKeyConstraintError') {
    return res.status(400).json({
      status: 'error',
      message: 'Referencia inválida'
    });
  }

  // Error personalizado
  if (err.status) {
    return res.status(err.status).json({
      status: 'error',
      message: err.message
    });
  }

  // Error genérico del servidor
  res.status(500).json({
    status: 'error',
    message: 'Error interno del servidor',
    error: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
};

module.exports = errorHandler;


