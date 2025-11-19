# Backend E-Learning - Sprints 1-4 Completos

Backend completo para aplicación e-learning desarrollado con Node.js, Express y MySQL, implementando todos los requerimientos de los Sprints 1-4 basados en el plan de sprints y la especificación de requerimientos (RE, RD, RA, CU, RNF) del documento "DERS_GRUPO_1_APP_E_LEARNING (2).pdf".

🎯 Requerimientos Implementados

* RE-01: Registro e inicio de sesión de usuarios (autenticación segura con JWT)
* RE-02: Búsqueda e inscripción en cursos
* RE-03: Acceso y visualización de materiales
* RE-04: Visualización y descarga de materiales didácticos
* RE-05: Realización de evaluaciones en línea con retroalimentación
* RE-06: Seguimiento de progreso del estudiante
* RE-07: Participación en foros y mensajería
* RE-08: Generación de certificados al finalizar cursos
* RD-01/02/03: Creación y gestión de cursos/materiales por docentes
* RD-04/06: Creación de evaluaciones y foros
* RD-05/07: Reportes y cohortes
* RA-01/02/03/04: Gestión de usuarios, monitoreo admin y reportes
* CU-01 a CU-08: Todos los casos de uso cubiertos (registro, inscripción, materiales, evaluaciones, foros, progreso, reportes, certificados)
* RNF-02/06/07/09/13/15: Compatibilidad multimedia, seguridad (JWT/bcrypt), usabilidad, retroalimentación inmediata

🚀 Tecnologías Utilizadas

* Node.js - Entorno de ejecución
* Express - Framework web
* MySQL - Base de datos relacional
* Sequelize - ORM para MySQL
* JWT - Autenticación mediante tokens
* bcrypt - Cifrado de contraseñas
* express-validator - Validación de datos
* dotenv - Variables de entorno
* cors - Soporte CORS
* multer - Manejo de uploads de archivos
* pdfkit - Generación de PDFs (reportes y certificados)
* nodemailer - Envío de emails (reportes)
* chart.js - Datos para gráficos de progreso (JSON para frontend)
* uuid - Generación de códigos únicos para certificados

📁 Estructura del Proyecto

```
backend/
 ├── src/
 │   ├── config/
 │   │   └── db.js              # Configuración de base de datos
 │   ├── controllers/
 │   │   ├── authController.js   # Controladores de autenticación
 │   │   ├── cursoController.js  # Controladores de cursos (crear, editar, eliminar, módulos)
 │   │   ├── materialController.js  # Upload y acceso a materiales
 │   │   ├── evaluacionController.js  # Creación, envío y resultados de evaluaciones
 │   │   ├── foroController.js    # Foros y mensajes (crear, leer, moderar)
 │   │   ├── progresoController.js  # Seguimiento de progreso
 │   │   ├── reporteController.js  # Generación de reportes
 │   │   ├── certificadoController.js  # Generación de certificados
 │   │   └── adminController.js    # Gestión admin (usuarios, monitoreo)
 │   ├── middleware/
 │   │   ├── auth.js             # Middleware de autenticación JWT y roles
 │   │   └── upload.js           # Configuración de multer para archivos
 │   ├── models/
 │   │   ├── Usuario.js          # Modelo de Usuario
 │   │   ├── Curso.js            # Modelo de Curso
 │   │   ├── Inscripcion.js      # Modelo de Inscripción
 │   │   ├── Material.js         # Modelo de Material
 │   │   ├── Evaluacion.js       # Modelo de Evaluación
 │   │   ├── Foro.js             # Modelo de Foro
 │   │   ├── Mensaje.js          # Modelo de Mensaje
 │   │   ├── Reporte.js          # Modelo de Reporte
 │   │   ├── Modulo.js           # Modelo de Módulo
 │   │   ├── ProgresoMaterial.js # Modelo de Progreso en Materiales
 │   │   ├── Pregunta.js         # Modelo de Pregunta en Evaluaciones
 │   │   ├── Opcion.js           # Modelo de Opciones en Preguntas
 │   │   ├── RespuestaEstudiante.js # Modelo de Respuestas de Estudiantes
 │   │   ├── Certificado.js      # Modelo de Certificado
 │   │   └── index.js            # Relaciones entre modelos
 │   ├── routes/
 │   │   ├── authRoutes.js       # Rutas de autenticación
 │   │   ├── cursoRoutes.js      # Rutas de cursos
 │   │   ├── materialRoutes.js   # Rutas de materiales
 │   │   ├── evaluacionRoutes.js # Rutas de evaluaciones
 │   │   ├── foroRoutes.js       # Rutas de foros
 │   │   ├── progresoRoutes.js   # Rutas de progreso
 │   │   ├── reporteRoutes.js    # Rutas de reportes
 │   │   ├── certificadoRoutes.js # Rutas de certificados
 │   │   └── adminRoutes.js      # Rutas admin
 │   ├── utils/
 │   │   ├── jwt.js              # Utilidades JWT
 │   │   ├── errorHandler.js     # Manejo de errores
 │   │   ├── pdfGenerator.js     # Generador de PDFs
 │   │   └── emailSender.js      # Envío de emails
 │   └── app.js                  # Configuración de Express
 ├── uploads/                     # Archivos subidos (materiales)
 ├── certificates/                # PDFs de certificados generados
 ├── reports/                     # PDFs de reportes generados
 ├── database.sql                 # Script SQL de base de datos
 ├── server.js                    # Punto de entrada
 ├── package.json                 # Dependencias del proyecto
 └── README.md                    # Esta documentación
```

⚙️ Instalación y Configuración
1. Instalar dependencias

```
npm install
```

2. Configurar variables de entorno
Crea un archivo .env en la raíz del proyecto con las siguientes variables:

```
# Configuración de Base de Datos
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_contraseña
DB_NAME=elearning_db
DB_PORT=3306

# Configuración JWT
JWT_SECRET=tu_clave_secreta_super_segura_cambiar_en_produccion
JWT_EXPIRES_IN=24h

# Configuración del Servidor
PORT=8080
NODE_ENV=development

# Email para reportes
EMAIL_USER=tuemail@gmail.com
EMAIL_PASS=tuapppassword

# Sincronización de Base de Datos (opcional)
SYNC_DB=true
SYNC_DB_ALTER=true
```

3. Base de datos
Ejecuta el script SQL proporcionado:

```
mysql -u root -p < database.sql
```

4. Iniciar el servidor

```
# Modo desarrollo (con nodemon)
npm run dev

# Modo producción
npm start
```

El servidor estará disponible en http://localhost:8080

📡 Endpoints de la API
Todas las respuestas siguen el formato: { status, message, data }. Endpoints protegidos requieren `Authorization: Bearer <token>`.

🔐 Autenticación
- POST /api/auth/register - Registrar usuario (body: {nombre, correo, contrasena, rol})
- POST /api/auth/login - Iniciar sesión (body: {correo, contrasena})

📚 Cursos
- GET /api/cursos - Buscar cursos (?categoria, ?titulo)
- POST /api/cursos - Crear curso (solo docentes/admin, body: {titulo, descripcion, categoria})
- PUT /api/cursos/:id - Editar curso (solo docente/admin, body opcional)
- DELETE /api/cursos/:id - Eliminar curso (solo docente/admin)
- POST /api/cursos/:id/modulos - Agregar módulo (solo docente, body: {titulo, descripcion, orden})
- POST /api/cursos/:id/inscribirse - Inscribirse
- GET /api/cursos/:id/materiales - Obtener materiales (inscritos/docente)

🗂️ Materiales
- POST /api/materiales/upload - Subir material (multipart file + body: {titulo, tipo, idModulo}, solo docente)
- GET /api/materiales/:id - Ver/descargar material (inscritos/docente)

📝 Evaluaciones
- POST /api/evaluaciones/create - Crear evaluación (solo docentes, body: {titulo, descripcion, fechaInicio, fechaFin, idCurso, preguntas[]})
- POST /api/evaluaciones/:id/submit - Enviar respuestas (estudiantes, body: {respuestas[]})
- GET /api/evaluaciones/:id/results - Ver resultados

💬 Foros y Mensajes
- POST /api/foros - Crear foro (solo docentes, body: {tema, idCurso})
- GET /api/foros/:id - Ver foro y mensajes (inscritos/docente)
- POST /api/foros/:id/mensajes - Publicar mensaje (body: {contenido})
- DELETE /api/mensajes/:id - Moderar/eliminar mensaje (solo docente)

📈 Progreso
- GET /api/progreso/:idCurso - Ver progreso (% y gráfico data)
- PUT /api/progreso/:idCurso/material/:idMaterial - Marcar material completado

📊 Reportes
- GET /api/reportes/:idCurso - Generar reporte (?email=true para enviar)

🏆 Certificados
- GET /api/certificados/:idCurso - Generar/descargar certificado (al 100% progreso)

🛠️ Admin
- GET /api/admin/usuarios - Listar usuarios
- PUT /api/admin/usuarios/:id - Editar usuario (incl. roles)
- DELETE /api/admin/usuarios/:id - Eliminar usuario
- GET /api/admin/monitor - Monitoreo general (actividad, stats)

🏥 Health Check
- GET /health - Verificar estado

🔒 Autenticación
Token JWT requerido para protegidos, válido 24h.

🎭 Roles de Usuario
* estudiante: Buscar/inscribir cursos, ver materiales, evaluaciones, foros, progreso, certificados
* docente: Crear/editar cursos/materiales/evaluaciones/foros, moderar, reportes
* admin: Acceso completo, gestión usuarios/monitoreo

🛡️ Validaciones Implementadas
- Registro: Nombre (2-100), correo único, contraseña (min 6), rol válido
- Cursos: Título (3-200), descripción requerida, categoría (max 80)
- Materiales: Formatos permitidos (pdf, video, etc.), acceso restringido
- Evaluaciones: Fechas válidas, tipos de preguntas, feedback auto
- Foros: Contenido no vacío, moderación
- Progreso: Solo inscritos
- Reportes/Certificados: Autorización y condiciones (e.g., 100% progreso)

📊 Modelo de Datos
Entidades: Usuario, Curso, Inscripcion, Modulo, Material, ProgresoMaterial, Evaluacion, Pregunta, Opcion, RespuestaEstudiante, Foro, Mensaje, Certificado, Reporte. Relaciones definidas en index.js.

🐛 Manejo de Errores
Centralizado: 400 (validación), 401 (no auth), 403 (sin permisos), 404 (no encontrado), 409 (conflicto), 500 (interno).

📝 Notas Importantes
- Contraseñas cifradas con bcrypt
- Sincronización DB automática en dev
- Uploads limitados a 10MB, formatos validados
- PDFs generados on-demand, emails opcionales para reportes
- Cobertura completa de sprints: Interactividad (foros/evaluaciones), tracking (progreso), admin tools

🚧 Alcance Completo (Sprints 1-4)
✅ Registro/login, cursos/materiales, evaluaciones, foros, progreso, reportes, certificados, admin.  
❌ Pagos (fuera de alcance).

👤 Autor
Desarrollado para el proyecto E-Learning de Edutecnia.

📄 Licencia
ISC
