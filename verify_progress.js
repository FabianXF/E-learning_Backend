require('dotenv').config();
const { sequelize } = require('./src/config/db');
const { Inscripcion, Modulo, Material, ProgresoMaterial } = require('./src/models');

(async () => {
    try {
        await sequelize.authenticate();
        console.log('DB Connected');

        // Find an active enrollment
        const inscripcion = await Inscripcion.findOne();
        if (!inscripcion) {
            console.log('No enrollments found');
            return;
        }

        console.log(`Testing progress for User ${inscripcion.idUsuario} in Course ${inscripcion.idCurso}`);

        // Simulate logic
        const modulos = await Modulo.findAll({ where: { idCurso: inscripcion.idCurso } });
        const totalMateriales = await Material.count({ where: { idModulo: modulos.map(m => m.idModulo) } });
        const completados = await ProgresoMaterial.count({ where: { idUsuario: inscripcion.idUsuario, completado: true } });

        const porcentaje = totalMateriales > 0 ? Math.round((completados / totalMateriales) * 100) : 0;
        console.log(`Progress: ${porcentaje}% (${completados}/${totalMateriales})`);

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await sequelize.close();
    }
})();
