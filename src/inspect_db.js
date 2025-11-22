const { Pregunta, Opcion } = require('./models');

async function inspect() {
    try {
        const pregunta = await Pregunta.findByPk(1, {
            include: [{ model: Opcion, as: 'opciones' }]
        });

        if (!pregunta) { console.log('NO FOUND'); return; }

        console.log(`PREGUNTA: ${pregunta.textoPregunta}`);
        pregunta.opciones.forEach(opc => {
            console.log(`[ID:${opc.idOpcion}] ${opc.texto} -> Correcta: ${opc.esCorrecta}`);
        });

    } catch (error) { console.error(error); }
}

inspect();
