const axios = require('axios');

// Script para probar la inscripción en cursos con diferentes roles
const BASE_URL = 'http://localhost:3000/api';

// Función auxiliar para hacer login y obtener token
async function login(correo, contrasena) {
    try {
        const response = await axios.post(`${BASE_URL}/auth/login`, {
            correo,
            contrasena
        });
        return response.data.data.token;
    } catch (error) {
        console.error(`Error en login para ${correo}:`, error.response?.data || error.message);
        return null;
    }
}

// Función para inscribirse en un curso
async function inscribirseEnCurso(token, idCurso) {
    try {
        const response = await axios.post(
            `${BASE_URL}/cursos/${idCurso}/inscribirse`,
            {},
            {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            }
        );
        return { success: true, data: response.data };
    } catch (error) {
        return {
            success: false,
            error: error.response?.data || error.message,
            status: error.response?.status
        };
    }
}

// Función principal de prueba
async function testInscripcion() {
    console.log('=== PRUEBA DE INSCRIPCIÓN EN CURSOS ===\n');

    // Configuración de prueba - AJUSTAR ESTOS VALORES
    const idCurso = 1; // ID del curso a probar

    const usuarios = [
        { rol: 'estudiante', correo: 'estudiante@test.com', contrasena: 'password123' },
        { rol: 'docente', correo: 'docente@test.com', contrasena: 'password123' },
        { rol: 'admin', correo: 'admin@test.com', contrasena: 'password123' }
    ];

    for (const usuario of usuarios) {
        console.log(`\n--- Probando con ${usuario.rol.toUpperCase()} (${usuario.correo}) ---`);

        // 1. Login
        console.log('1. Intentando login...');
        const token = await login(usuario.correo, usuario.contrasena);

        if (!token) {
            console.log(`❌ No se pudo obtener token para ${usuario.rol}`);
            continue;
        }
        console.log('✅ Login exitoso');

        // 2. Intentar inscripción
        console.log(`2. Intentando inscripción en curso ${idCurso}...`);
        const resultado = await inscribirseEnCurso(token, idCurso);

        if (resultado.success) {
            console.log('✅ Inscripción exitosa:', resultado.data.message);
        } else {
            console.log(`❌ Error en inscripción (Status ${resultado.status}):`);
            console.log('   Mensaje:', resultado.error.message || resultado.error);
            if (resultado.error.errors) {
                console.log('   Detalles:', resultado.error.errors);
            }
        }
    }

    console.log('\n=== FIN DE PRUEBAS ===');
}

// Ejecutar pruebas
testInscripcion().catch(console.error);
