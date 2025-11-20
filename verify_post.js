require('dotenv').config();
const { sequelize } = require('./src/config/db');
const { Foro, Mensaje, Usuario, Curso, Inscripcion } = require('./src/models');

(async () => {
    const t = await sequelize.transaction();
    try {
        await sequelize.authenticate();
        console.log('DB Connected');

        // 1. Find a forum and a user (docente of the course to be safe)
        const foro = await Foro.findOne({ include: 'curso' });
        if (!foro) {
            console.log('No forums found');
            return;
        }
        const curso = await Curso.findByPk(foro.idCurso);
        const docente = await Usuario.findByPk(curso.idDocente);

        console.log(`Testing posting to Forum ${foro.idForo} as User ${docente.idUsuario} (${docente.nombre})`);

        // 2. Simulate createMensaje logic
        const contenido = "Test message from verification script " + new Date().toISOString();

        // Create
        const mensaje = await Mensaje.create({
            contenido,
            idForo: foro.idForo,
            idUsuario: docente.idUsuario
        }, { transaction: t });

        // Refetch with include (the fix I implemented)
        const mensajeCompleto = await Mensaje.findByPk(mensaje.idMensaje, {
            include: [{
                model: Usuario,
                as: 'usuario',
                attributes: ['idUsuario', 'nombre', 'avatar']
            }],
            transaction: t
        });

        if (mensajeCompleto && mensajeCompleto.usuario) {
            console.log('Success! Message created and fetched with user data.');
            console.log('Content:', mensajeCompleto.contenido);
            console.log('Author:', mensajeCompleto.usuario.nombre);
        } else {
            console.error('Failed: Message created but user data missing in fetch.');
        }

        // Rollback to not pollute DB
        await t.rollback();
        console.log('Transaction rolled back (cleanup).');

    } catch (error) {
        console.error('Error:', error);
        if (t) await t.rollback();
    } finally {
        await sequelize.close();
    }
})();
