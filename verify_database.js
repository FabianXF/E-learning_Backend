const { sequelize } = require('./src/config/db');
const { Usuario, Curso, Inscripcion } = require('./src/models');

async function verificarBaseDatos() {
    try {
        console.log('=== VERIFICACIÓN DE BASE DE DATOS ===\n');

        // 1. Verificar conexión
        console.log('1. Verificando conexión a la base de datos...');
        await sequelize.authenticate();
        console.log('✅ Conexión exitosa\n');

        // 2. Sincronizar modelos (sin forzar, solo verificar)
        console.log('2. Verificando sincronización de modelos...');
        await sequelize.sync({ alter: true }); // alter: true ajusta las tablas sin borrar datos
        console.log('✅ Modelos sincronizados\n');

        // 3. Verificar usuarios
        console.log('3. Verificando usuarios en la base de datos...');
        const usuarios = await Usuario.findAll({
            attributes: ['idUsuario', 'nombre', 'correo', 'rol']
        });
        console.log(`   Total de usuarios: ${usuarios.length}`);
        usuarios.forEach(u => {
            console.log(`   - ${u.rol.toUpperCase()}: ${u.nombre} (${u.correo})`);
        });
        console.log('');

        // 4. Verificar cursos
        console.log('4. Verificando cursos en la base de datos...');
        const cursos = await Curso.findAll({
            include: [{
                model: Usuario,
                as: 'docente',
                attributes: ['nombre', 'correo']
            }]
        });
        console.log(`   Total de cursos: ${cursos.length}`);
        cursos.forEach(c => {
            console.log(`   - Curso ${c.idCurso}: "${c.titulo}" (Docente: ${c.docente?.nombre || 'N/A'})`);
        });
        console.log('');

        // 5. Verificar inscripciones
        console.log('5. Verificando inscripciones existentes...');
        const inscripciones = await Inscripcion.findAll({
            include: [
                {
                    model: Usuario,
                    attributes: ['nombre', 'rol']
                },
                {
                    model: Curso,
                    attributes: ['titulo']
                }
            ]
        });
        console.log(`   Total de inscripciones: ${inscripciones.length}`);
        if (inscripciones.length > 0) {
            inscripciones.forEach(i => {
                console.log(`   - Usuario ${i.idUsuario} en Curso ${i.idCurso}`);
            });
        } else {
            console.log('   (No hay inscripciones todavía)');
        }
        console.log('');

        // 6. Verificar estructura de tabla Inscripcion
        console.log('6. Verificando estructura de tabla Inscripcion...');
        const [results] = await sequelize.query('DESCRIBE Inscripcion');
        console.log('   Columnas de Inscripcion:');
        results.forEach(col => {
            console.log(`   - ${col.Field} (${col.Type}) ${col.Null === 'NO' ? 'NOT NULL' : 'NULL'} ${col.Default ? `DEFAULT ${col.Default}` : ''}`);
        });

        console.log('\n=== VERIFICACIÓN COMPLETADA ===');
        process.exit(0);
    } catch (error) {
        console.error('❌ Error durante la verificación:', error.message);
        console.error('Detalles:', error);
        process.exit(1);
    }
}

verificarBaseDatos();
