# 📚 E-Learning Platform - Backend

![Node.js](https://img.shields.io/badge/Node.js-v14+-green)
![Express](https://img.shields.io/badge/Express-4.x-blue)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange)
![License](https://img.shields.io/badge/License-Academic-yellow)

Plataforma de aprendizaje en línea desarrollada con Node.js y Express que provee una API REST completa para gestionar estudiantes, docentes, cursos, evaluaciones y foros de discusión.

## 🎯 Descripción del Proyecto

Este es el backend de una plataforma e-learning completa que sirve datos a un cliente frontend React. La aplicación permite:

- **Gestión de Usuarios**: Registro, autenticación y roles (Estudiante, Docente, Admin)
- **Gestión de Cursos**: Creación de cursos, módulos y subida de materiales multimedia
- **Evaluaciones**: Sistema completo de creación y calificación de exámenes con panel de resultados
- **Comunidad**: Foros de discusión con moderación por curso
- **Certificación**: Generación automática de certificados en PDF
- **Progreso**: Seguimiento detallado del avance de cada estudiante
- **Reportes**: Estadísticas y análisis para docentes y administradores

## 🚀 Tecnologías Utilizadas

### Core
- **Node.js** (v14+) - Entorno de ejecución para JavaScript
- **Express** (4.x) - Framework web para crear la API REST
- **MySQL** (8.0) - Base de datos relacional
- **Sequelize** (6.x) - ORM para manejo de base de datos

### Seguridad
- **JWT** - Autenticación segura mediante tokens
- **Bcrypt** - Cifrado de contraseñas con salt

### Utilidades
- **Multer** - Manejo de carga de archivos (PDF, videos, imágenes)
- **PDFKit** - Generación de certificados en PDF
- **Express Validator** - Validación de datos de entrada
- **CORS** - Configuración de políticas de acceso
- **Dotenv** - Gestión de variables de entorno

## 📁 Estructura del Proyecto

```
backend-elearning-main/
├── src/
│   ├── config/
│   │   └── db.js                    # Configuración de Sequelize y MySQL
│   │
│   ├── models/                      # Modelos de datos (Sequelize ORM)
│   │   ├── index.js                 # Relaciones entre modelos
│   │   ├── Usuario.js               # Modelo de usuarios
│   │   ├── Curso.js                 # Modelo de cursos
│   │   ├── Modulo.js                # Modelo de módulos
│   │   ├── Material.js              # Modelo de materiales
│   │   ├── Inscripcion.js           # Relación usuario-curso
│   │   ├── Evaluacion.js            # Modelo de evaluaciones
│   │   ├── Pregunta.js              # Preguntas de evaluaciones
│   │   ├── Opcion.js                # Opciones de respuesta
│   │   ├── RespuestaEstudiante.js   # Respuestas de estudiantes
│   │   ├── Foro.js                  # Modelo de foros
│   │   ├── Mensaje.js               # Mensajes en foros
│   │   ├── ProgresoMaterial.js      # Seguimiento de progreso
│   │   ├── Certificado.js           # Certificados generados
│   │   └── Reporte.js               # Reportes del sistema
│   │
│   ├── controllers/                 # Lógica de negocio
│   │   ├── authController.js        # Autenticación y registro
│   │   ├── cursoController.js       # CRUD de cursos y módulos
│   │   ├── materialController.js    # Subida y gestión de archivos
│   │   ├── evaluacionController.js  # Evaluaciones y resultados
│   │   ├── foroController.js        # Foros y mensajes
│   │   ├── progresoController.js    # Seguimiento de estudiantes
│   │   ├── certificadoController.js # Generación de certificados
│   │   ├── reporteController.js     # Reportes y estadísticas
│   │   ├── adminController.js       # Panel de administración
│   │   └── userController.js        # Gestión de perfiles
│   │
│   ├── routes/                      # Definición de endpoints
│   │   ├── authRoutes.js
│   │   ├── cursoRoutes.js
│   │   ├── materialRoutes.js
│   │   ├── evaluacionRoutes.js
│   │   ├── foroRoutes.js
│   │   ├── progresoRoutes.js
│   │   ├── certificadoRoutes.js
│   │   ├── reporteRoutes.js
│   │   ├── adminRoutes.js
│   │   └── userRoutes.js
│   │
│   ├── middleware/                  # Middlewares
│   │   └── auth.js                  # Verificación JWT y roles
│   │
│   ├── utils/                       # Utilidades
│   │   └── errorHandler.js          # Manejo centralizado de errores
│   │
│   └── app.js                       # Configuración de Express
│
├── uploads/                         # Archivos subidos (ignorado en git)
├── certificates/                    # Certificados PDF (ignorado en git)
├── .env                             # Variables de entorno (NO subir a git)
├── .gitignore                       # Archivos ignorados
├── package.json                     # Dependencias del proyecto
├── server.js                        # Punto de entrada
└── elearning_db.sql                 # Backup de la base de datos
```

## 🔧 Instalación y Configuración

### Prerrequisitos

- **Node.js** (v14 o superior) - [Descargar](https://nodejs.org/)
- **MySQL Server** (8.0 o superior) - [Descargar](https://dev.mysql.com/downloads/)
- **Git** - [Descargar](https://git-scm.com/)
- **npm** o **yarn** - Incluido con Node.js

### Pasos de Instalación

#### 1. Clonar el repositorio

```bash
git clone https://github.com/TU_USUARIO/backend-elearning-main.git
cd backend-elearning-main
```

#### 2. Instalar dependencias

```bash
npm install
```

#### 3. Configurar Variables de Entorno

Crea un archivo `.env` en la raíz del proyecto:

```env
# Servidor
PORT=8080
NODE_ENV=development

# Base de Datos MySQL
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_contraseña_mysql
DB_NAME=elearning_db
DB_PORT=3306

# Autenticación JWT
JWT_SECRET=tu_clave_secreta_super_segura_cambiar_en_produccion
JWT_EXPIRES_IN=24h
```

⚠️ **IMPORTANTE**: Cambia `JWT_SECRET` por una clave segura y única.

#### 4. Configurar Base de Datos

Opción A - Importar el backup completo:
```bash
mysql -u root -p < elearning_db.sql
```

Opción B - Crear base de datos vacía (Sequelize creará las tablas):
```bash
mysql -u root -p
CREATE DATABASE elearning_db;
exit;
```

#### 5. Crear carpetas necesarias

```bash
mkdir uploads certificates
```

#### 6. Iniciar el servidor

```bash
# Desarrollo (con recarga automática)
npm run dev

# Producción
npm start
```

El servidor estará disponible en `http://localhost:8080`

✅ Si ves el mensaje "🚀 Servidor corriendo en http://localhost:8080", ¡todo está funcionando!

## 👥 Roles y Funcionalidades

### 🎓 Estudiante

- ✅ Ver catálogo de cursos disponibles
- ✅ Inscribirse en cursos
- ✅ Acceder a materiales (videos, PDFs, enlaces)
- ✅ Realizar evaluaciones
- ✅ Ver calificaciones y retroalimentación
- ✅ Participar en foros de discusión
- ✅ Seguir su progreso en tiempo real
- ✅ Descargar certificados al completar 100%

### 👨‍🏫 Docente

- ✅ Crear y gestionar cursos
- ✅ Organizar contenido en módulos
- ✅ Subir materiales multimedia
- ✅ Crear evaluaciones con preguntas de opción múltiple
- ✅ **Ver resultados de todos los estudiantes** (NUEVO)
- ✅ Moderar foros de sus cursos
- ✅ Acceder a reportes y estadísticas
- ✅ Gestionar inscripciones

### 👨‍💼 Administrador

- ✅ Control total sobre usuarios (crear, editar, eliminar)
- ✅ Gestión de todos los cursos del sistema
- ✅ Monitoreo de estadísticas globales
- ✅ Moderación de contenido inapropiado
- ✅ Acceso a todos los reportes
- ✅ Configuración del sistema

## 🔐 Autenticación y Seguridad

### Sistema JWT (JSON Web Tokens)

1. **Login**: El usuario envía credenciales a `/api/auth/login`
2. **Token**: El servidor valida y retorna un `token` JWT
3. **Autenticación**: El cliente envía el token en cada petición:
   ```
   Authorization: Bearer <token>
   ```
4. **Verificación**: El middleware `auth.js` valida el token y extrae el usuario
5. **Autorización**: Se verifica el rol antes de permitir acceso a recursos

### Características de Seguridad

- 🔒 Contraseñas hasheadas con bcrypt (10 rounds)
- 🔒 Tokens JWT con expiración configurable
- 🔒 Validación de datos con express-validator
- 🔒 Protección contra inyección SQL (Sequelize ORM)
- 🔒 CORS configurado para frontend específico
- 🔒 Variables sensibles en archivo .env (no versionado)

## 📡 Endpoints Principales

### Autenticación
```http
POST   /api/auth/register          # Registrar nuevo usuario
POST   /api/auth/login             # Iniciar sesión
GET    /api/auth/me                # Datos del usuario actual
```

### Cursos
```http
GET    /api/cursos                 # Listar todos los cursos
POST   /api/cursos                 # Crear curso (Docente)
GET    /api/cursos/:id             # Ver detalles de un curso
PUT    /api/cursos/:id             # Actualizar curso (Docente)
DELETE /api/cursos/:id             # Eliminar curso (Docente)
POST   /api/cursos/:id/inscribirse # Inscribirse en curso
GET    /api/cursos/:id/modulos     # Ver módulos del curso
POST   /api/cursos/:id/modulos     # Crear módulo (Docente)
GET    /api/cursos/:id/materiales  # Ver materiales del curso
```

### Materiales
```http
POST   /api/materiales/upload      # Subir archivo (Docente)
GET    /api/materiales/:id         # Descargar/ver material
```

### Evaluaciones
```http
POST   /api/evaluaciones/create                    # Crear evaluación (Docente)
GET    /api/evaluaciones/curso/:idCurso            # Listar evaluaciones de un curso
GET    /api/evaluaciones/:id                       # Ver detalles de evaluación
POST   /api/evaluaciones/:id/submit                # Enviar respuestas (Estudiante)
GET    /api/evaluaciones/:id/results               # Ver resultados propios
GET    /api/evaluaciones/:id/estudiantes-results   # Ver resultados de todos (Docente/Admin)
```

### Foros
```http
POST   /api/foros                  # Crear foro (Docente)
GET    /api/foros/curso/:idCurso   # Ver foros de un curso
GET    /api/foros/:id              # Ver mensajes de un foro
POST   /api/foros/:id/mensajes     # Publicar mensaje
DELETE /api/foros/mensajes/:id     # Eliminar mensaje (Autor/Docente/Admin)
```

### Progreso y Certificados
```http
GET    /api/progreso/:idCurso                      # Ver progreso en un curso
PUT    /api/progreso/:idCurso/material/:idMaterial # Marcar material como completado
DELETE /api/progreso/:idCurso/material/:idMaterial # Desmarcar material
GET    /api/certificados/:idCurso                  # Descargar certificado PDF
```

### Administración
```http
GET    /api/admin/usuarios         # Listar todos los usuarios (Admin)
PUT    /api/admin/usuarios/:id     # Actualizar usuario (Admin)
DELETE /api/admin/usuarios/:id     # Eliminar usuario (Admin)
GET    /api/admin/monitor          # Estadísticas del sistema (Admin)
```

## 🗄️ Base de Datos

### Diagrama de Relaciones

```
Usuario ──┬── Curso (como docente)
          ├── Inscripcion ── Curso
          ├── Mensaje ── Foro
          ├── RespuestaEstudiante ── Pregunta
          ├── ProgresoMaterial ── Material
          └── Certificado ── Curso

Curso ──┬── Modulo ── Material
        ├── Evaluacion ── Pregunta ── Opcion
        └── Foro ── Mensaje
```

### Tablas Principales

- **usuario**: Usuarios del sistema (estudiantes, docentes, admins)
- **curso**: Cursos disponibles
- **modulo**: Módulos dentro de cada curso
- **material**: Archivos y recursos de aprendizaje
- **inscripcion**: Relación estudiante-curso
- **evaluacion**: Exámenes y pruebas
- **pregunta**: Preguntas de las evaluaciones
- **opcion**: Opciones de respuesta
- **respuestaestudiante**: Respuestas enviadas por estudiantes
- **foro**: Foros de discusión por curso
- **mensaje**: Mensajes en los foros
- **progresomaterial**: Seguimiento de materiales completados
- **certificado**: Certificados generados

## 🐛 Solución de Problemas Comunes

### Error: "SequelizeConnectionError"
**Causa**: Credenciales de base de datos incorrectas  
**Solución**: 
1. Verificar que MySQL esté corriendo
2. Revisar usuario, contraseña y puerto en `.env`
3. Verificar que la base de datos `elearning_db` exista

### Error: "jwt malformed" o "Token inválido"
**Causa**: Token JWT inválido o expirado  
**Solución**: 
1. Volver a iniciar sesión para obtener un nuevo token
2. Verificar que el header `Authorization` esté bien formado

### Error 404 en subida de archivos
**Causa**: Carpeta `uploads/` no existe  
**Solución**: 
```bash
mkdir uploads certificates
```

### Error: "Cannot find module"
**Causa**: Dependencias no instaladas  
**Solución**: 
```bash
npm install
```

### Puerto 8080 ya en uso
**Causa**: Otro proceso usando el puerto  
**Solución**: 
1. Cambiar `PORT` en `.env` a otro valor (ej: 8081)
2. O detener el proceso que usa el puerto 8080

## 📦 Scripts Disponibles

```bash
# Desarrollo (con Nodemon - reinicio automático)
npm run dev

# Producción
npm start

# Verificar sintaxis
npm run lint
```

## 🔄 Flujo de Trabajo Git

```bash
# Clonar repositorio
git clone https://github.com/TU_USUARIO/backend-elearning-main.git

# Crear rama para nueva funcionalidad
git checkout -b feature/nueva-funcionalidad

# Hacer commits descriptivos
git add .
git commit -m "✨ Agregar funcionalidad X"

# Subir cambios
git push origin feature/nueva-funcionalidad

# Crear Pull Request en GitHub
```

## 🌐 Integración con Frontend

Este backend está diseñado para trabajar con el frontend React ubicado en:
- **Repositorio**: [elearning-frontend](https://github.com/TU_USUARIO/elearning-frontend)
- **Puerto**: El frontend corre en `http://localhost:3000`
- **CORS**: Ya configurado para permitir peticiones desde localhost:3000

### Configuración del Frontend

En el frontend, configurar la URL del backend:
```javascript
// src/api/client.js
const client = axios.create({
  baseURL: 'http://localhost:8080/api'
});
```

## 📄 Licencia

Este proyecto es parte de un trabajo académico para la materia de **Tecnología Web - 7° Semestre**.

## 👨‍💻 Autores

- **Equipo de Desarrollo** - Proyecto E-Learning
- **Universidad**: [Tu Universidad]
- **Semestre**: 7° Semestre - 2025

## 🤝 Contribución

Las contribuciones son bienvenidas. Para cambios importantes:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Soporte

Para preguntas, problemas o sugerencias:
- Crear un [Issue en GitHub](https://github.com/TU_USUARIO/backend-elearning-main/issues)
- Contactar al equipo de desarrollo

## 🎯 Roadmap

- [x] Sistema de autenticación JWT
- [x] CRUD de cursos y materiales
- [x] Sistema de evaluaciones
- [x] Panel de resultados para docentes
- [x] Foros de discusión
- [x] Generación de certificados
- [ ] Notificaciones por email
- [ ] Chat en tiempo real
- [ ] Integración con plataformas de pago
- [ ] App móvil

---

**Última actualización**: Noviembre 2025  
**Versión**: 1.0.0  
**Estado**: ✅ Producción

