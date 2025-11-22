// Script simple para probar inscripción directamente
const { Inscripcion, Usuario, Curso } = require('./src/models');

async function testInscripcionDirecta() {
    try {
        console.log('Probando creación de inscripción directa...\n');

        // Intentar crear una inscripción de prueba
        const nuevaInscripcion = await Inscripcion.create({
            idUsuario: 1,  // Ajustar según tus datos
            idCurso: 1,    // Ajustar según tus datos
            fechaInscripcion: new Date()
        });

        console.log('Inscripcion creada exitosamente:');
        console.log(nuevaInscripcion.toJSON());

    } catch (error) {
        console.error('Error al crear inscripcion:');
        console.error('Mensaje:', error.message);
        console.error('Nombre:', error.name);
        if (error.errors) {
            console.error('Errores de validacion:');
            error.errors.forEach(e => console.error(`  - ${e.message}`));
        }
    }

    process.exit(0);
}

testInscripcionDirecta();
