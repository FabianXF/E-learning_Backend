require('dotenv').config();
const models = require('./src/models');

console.log('Keys in models:', Object.keys(models));
console.log('Foro:', !!models.Foro);
console.log('Mensaje:', !!models.Mensaje);
console.log('Usuario:', !!models.Usuario);
console.log('Sequelize:', !!models.sequelize);
