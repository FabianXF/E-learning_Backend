require('dotenv').config();
const { sequelize } = require('./src/config/db');
const { Foro, Mensaje, Usuario } = require('./src/models');

(async () => {
    try {
        await sequelize.authenticate();
        console.log('DB Connected');

        const foro = await Foro.findOne();
        if (!foro) {
            console.log('No forums found');
            return;
        }

        console.log(`Testing getForo for ID: ${foro.idForo}`);

        // Simulate controller logic
        const fetchedForo = await Foro.findByPk(foro.idForo, {
            include: [{
                model: Mensaje,
                as: 'mensajes',
                include: [{
                    model: Usuario,
                    as: 'usuario',
                    attributes: ['idUsuario', 'nombre', 'avatar']
                }]
            }]
        });

        if (fetchedForo) {
            console.log('Success! Forum fetched.');
            if (fetchedForo.mensajes.length > 0) {
                const firstMsg = fetchedForo.mensajes[0];
                console.log('First message content:', firstMsg.contenido);
                console.log('First message author:', firstMsg.usuario ? firstMsg.usuario.nombre : 'Unknown (User include failed)');
            } else {
                console.log('No messages in this forum.');
            }
        } else {
            console.log('Forum not found (unexpected).');
        }

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await sequelize.close();
    }
})();
