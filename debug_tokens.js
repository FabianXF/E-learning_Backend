const jwt = require('jsonwebtoken');
require('dotenv').config();

// Script para debuggear tokens JWT
console.log('=== DEBUG DE TOKENS JWT ===\n');

// Simular diferentes usuarios
const usuarios = [
    { idUsuario: 1, correo: 'estudiante@test.com', rol: 'estudiante' },
    { idUsuario: 2, correo: 'docente@test.com', rol: 'docente' },
    { idUsuario: 3, correo: 'admin@test.com', rol: 'admin' }
];

console.log('JWT_SECRET configurado:', process.env.JWT_SECRET ? 'SÍ ✓' : 'NO ✗');
console.log('JWT_EXPIRES_IN:', process.env.JWT_EXPIRES_IN || '24h (default)');
console.log('');

usuarios.forEach(usuario => {
    console.log(`\n--- ${usuario.rol.toUpperCase()} ---`);

    // Generar token (igual que en jwt.js)
    const payload = {
        idUsuario: usuario.idUsuario,
        correo: usuario.correo,
        rol: usuario.rol
    };

    try {
        const token = jwt.sign(payload, process.env.JWT_SECRET, {
            expiresIn: process.env.JWT_EXPIRES_IN || '24h'
        });

        console.log('Token generado:', token.substring(0, 50) + '...');

        // Verificar token (igual que en auth.js)
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        console.log('Token decodificado correctamente:');
        console.log('  - idUsuario:', decoded.idUsuario);
        console.log('  - correo:', decoded.correo);
        console.log('  - rol:', decoded.rol);
        console.log('  - exp:', new Date(decoded.exp * 1000).toLocaleString());

    } catch (error) {
        console.log('❌ ERROR:', error.message);
    }
});

console.log('\n\n=== PRUEBA DE HEADER AUTHORIZATION ===\n');

// Simular diferentes formatos de header
const testHeaders = [
    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test',  // Sin "Bearer"
    'Bearer  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test',  // Doble espacio
    ''
];

testHeaders.forEach((header, index) => {
    console.log(`\nTest ${index + 1}: "${header}"`);
    const token = header && header.split(' ')[1];
    console.log('Token extraído:', token || '(vacío)');
});

console.log('\n=== FIN DEL DEBUG ===');
