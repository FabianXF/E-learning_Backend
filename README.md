# 📚 E-Learning Platform - Backend

Plataforma de aprendizaje en línea desarrollada con Node.js y Express que provee una API REST completa para gestionar estudiantes, docentes, cursos, evaluaciones y foros de discusión.

## 🎯 Descripción del Proyecto

Este es el backend de una plataforma e-learning completa que sirve datos a un cliente frontend. La aplicación permite:

- **Gestión de Usuarios**: Registro, autenticación y roles (Estudiante, Docente, Admin)
- **Gestión de Cursos**: Creación de cursos, módulos y subida de materiales multimedia
- **Evaluaciones**: Sistema completo de creación y calificación de exámenes
- **Comunidad**: Foros de discusión con moderación
- **Certificación**: Generación automática de certificados en PDF

## 🚀 Tecnologías Utilizadas

- **Node.js** - Entorno de ejecución para JavaScript
- **Express** - Framework web para crear la API REST
- **MySQL** - Base de datos relacional
- **Sequelize** - ORM para manejo de base de datos
- **JWT** - Autenticación segura mediante tokens
- **Bcrypt** - Cifrado de contraseñas
- **Multer** - Manejo de carga de archivos
- **PDFKit** - Generación de documentos PDF

## 📁 Estructura del Proyecto

```
src/
├── config/                  # Configuración del sistema
│   └── db.js               # Conexión a base de datos MySQL
├── controllers/             # Lógica de negocio
│   ├── authController.js   # Autenticación y registro
│   ├── cursoController.js  # Gestión de cursos y módulos
│   ├── evaluacionController.js # Lógica de exámenes
│   ├── foroController.js   # Foros y mensajes
│   ├── materialController.js # Subida de archivos
│   ├── progresoController.js # Seguimiento de estudiantes
│   └── adminController.js  # Panel de administración
├── middleware/              # Intermediarios
│   ├── auth.js             # Verificación de JWT y roles
│   └── upload.js           # Configuración de Multer
├── models/                  # Modelos de datos (Sequelize)
│   ├── Usuario.js, Curso.js, Material.js...
│   └── index.js            # Relaciones entre tablas
├── routes/                  # Definición de endpoints
│   ├── authRoutes.js
│   ├── cursoRoutes.js
│   ├── evaluacionRoutes.js
│   └── ...
├── utils/                   # Utilidades
│   ├── pdfGenerator.js     # Generador de certificados
│   └── emailSender.js      # Envío de correos
└── app.js                   # Configuración de Express
```

## 🔧 Instalación y Configuración

### Prerrequisitos

- Node.js (v14 o superior)
- MySQL Server corriendo
- Git

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/FabianXF/elearning-backend.git
cd elearning-backend
```

2. **Instalar dependencias**
```bash
npm install
```

3. **Configurar Variables de Entorno**

Crea un archivo `.env` en la raíz del proyecto con las siguientes variables:

```env
# Servidor
PORT=8080
NODE_ENV=development

# Base de Datos
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_contraseña
DB_NAME=elearning_db
DB_PORT=3306

# Autenticación
JWT_SECRET=tu_clave_secreta_super_segura
JWT_EXPIRES_IN=24h
```

4. **Configurar Base de Datos**

Ejecuta el script SQL incluido para crear la estructura inicial:
```bash
mysql -u root -p < database.sql
```

5. **Iniciar el servidor**
```bash
# Desarrollo (con recarga automática)
npm run dev

# Producción
npm start
```

El servidor estará disponible en `http://localhost:8080`

## 👥 Roles y Funcionalidades

### 🎓 Estudiante

- **Acceso**: Puede inscribirse en cursos y ver contenido
- **Evaluaciones**: Puede enviar respuestas y ver sus calificaciones
- **Progreso**: Se registra su avance automáticamente
- **Certificados**: Puede descargar PDF al completar el 100%

### 👨‍🏫 Docente

- **Gestión**: Puede crear cursos, módulos y subir materiales
- **Evaluaciones**: Crea preguntas y define respuestas correctas
- **Foros**: Modera discusiones en sus cursos
- **Reportes**: Accede a estadísticas de sus alumnos

### 👨‍💼 Administrador

- **Control Total**: Gestiona todos los usuarios y cursos
- **Monitoreo**: Visualiza estadísticas globales del sistema
- **Moderación**: Puede eliminar cualquier contenido inapropiado

## 🔐 Autenticación

El sistema utiliza JWT (JSON Web Tokens) para proteger los endpoints:

1. El usuario envía credenciales a `/api/auth/login`
2. El servidor valida y retorna un `token`
3. El cliente debe enviar el token en el header: `Authorization: Bearer <token>`
4. El middleware `auth.js` valida el token y el rol antes de permitir el acceso

## 📡 Endpoints Principales

### Autenticación
```http
POST /api/auth/register  - Registrar usuario
POST /api/auth/login     - Iniciar sesión
GET  /api/auth/me        - Datos del usuario actual
```

### Cursos
```http
GET  /api/cursos         - Listar cursos
POST /api/cursos         - Crear curso (Docente)
POST /api/cursos/:id/inscribirse - Inscribirse
GET  /api/cursos/:id/materiales - Ver contenido
```

### Evaluaciones
```http
GET  /api/evaluaciones/curso/:id - Listar evaluaciones
GET  /api/evaluaciones/:id       - Ver detalles
POST /api/evaluaciones/create    - Crear (Docente)
POST /api/evaluaciones/:id/submit - Enviar respuestas
```

### Foros
```http
GET  /api/foros/mis-foros        - Ver mis foros
POST /api/foros/:id/mensajes     - Publicar mensaje
DELETE /api/foros/mensajes/:id   - Eliminar mensaje
```

### Progreso y Certificados
```http
GET  /api/progreso/:idCurso      - Ver porcentaje
GET  /api/certificados/:idCurso  - Descargar PDF
```

## 🐛 Solución de Problemas Comunes

### Error: "SequelizeConnectionError"
**Causa**: Credenciales de base de datos incorrectas en `.env`  
**Solución**: Verificar usuario, contraseña y puerto de MySQL

### Error: "jwt malformed"
**Causa**: Token inválido o expirado en el header  
**Solución**: Volver a iniciar sesión para obtener un nuevo token

### Error 404 en subida de archivos
**Causa**: Carpeta `uploads/` no existe  
**Solución**: Crear manualmente la carpeta `uploads` en la raíz

## � Scripts Disponibles

```bash
# Desarrollo
npm run dev        # Inicia con Nodemon (reinicio automático)

# Producción
npm start          # Inicia con Node estándar

# Linting
npm run lint       # Verifica estilo de código
```

## 🤝 Contribución

Para contribuir al proyecto:

1. Crear una rama para tu feature: `git checkout -b feature/nueva-funcionalidad`
2. Hacer commits descriptivos: `git commit -m "Agregar funcionalidad X"`
3. Push a la rama: `git push origin feature/nueva-funcionalidad`
4. Crear un Pull Request

## 📄 Licencia

Este proyecto es parte de un trabajo académico para la materia de Tecnología Web.

## 👨‍💻 Autores

- **Equipo de Desarrollo** - Proyecto E-Learning 7° Semestre

## 📞 Soporte

Para preguntas o problemas, contactar al equipo de desarrollo o crear un issue en GitHub.

---

**Última actualización**: Noviembre 2025
