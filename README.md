
# 📚 Backend E-Learning - Sprint 1

Backend completo para aplicación e-learning desarrollado con **Node.js, Express y MySQL**, implementando los requerimientos del Sprint 1.

## 🎯 Requerimientos Implementados

- **RE-01:** Registro e inicio de sesión de usuarios (autenticación segura con JWT)
- **RE-02:** Búsqueda e inscripción en cursos
- **RE-03:** Acceso y visualización de materiales

## 🚀 Tecnologías Utilizadas

- **Node.js** - Entorno de ejecución
- **Express** - Framework web
- **MySQL** - Base de datos relacional
- **Sequelize** - ORM para MySQL
- **JWT** - Autenticación mediante tokens
- **bcrypt** - Cifrado de contraseñas
- **express-validator** - Validación de datos
- **dotenv** - Variables de entorno
- **cors** - Soporte CORS

## 📁 Estructura del Proyecto

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

backend/
 ├── src/
 │   ├── config/
 │   │   └── db.js              # Configuración de base de datos
 │   ├── controllers/
 │   │   ├── authController.js   # Controladores de autenticación
 HEAD
 │   │   └── cursoController.js  # Controladores de cursos
 │   ├── middleware/
 │   │   └── auth.js             # Middleware de autenticación JWT
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
 │   │   └── index.js            # Relaciones entre modelos
 │   ├── routes/
 │   │   ├── authRoutes.js       # Rutas de autenticación
 │   │   └── cursoRoutes.js      # Rutas de cursos
 │   ├── utils/
 │   │   ├── jwt.js              # Utilidades JWT
 │   │   └── errorHandler.js     # Manejo de errores
 │   └── app.js                  # Configuración de Express
 ├── database.sql                # Script SQL de base de datos
 ├── server.js                   # Punto de entrada
 ├── package.json                # Dependencias del proyecto
 └── README.md                   # Esta documentación
```

## ⚙️ Instalación y Configuración

### 1. Instalar dependencias

```bash
npm install
```

### 2. Configurar variables de entorno

Crea un archivo `.env` en la raíz del proyecto con las siguientes variables:

```env
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
>>>>>>> 0ca347d6a5d5c006456af5045eb112b69f7853cd
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

# Sincronización de Base de Datos (opcional)
# Por defecto: NO sincroniza (para BDs existentes)
# SYNC_DB=true          # Habilitar sincronización automática
# SYNC_DB_ALTER=true    # Modificar tablas existentes (¡cuidado!)
```

### 3. Base de datos

**Si ya tienes la base de datos creada:**
- Asegúrate de que las tablas tengan los nombres exactos:
  - `Usuario` (con campos: idUsuario, nombre, correo, contrasena, rol)
  - `Curso` (con campos: idCurso, titulo, descripcion, categoria, idDocente)
  - `Inscripcion` (con campos: idUsuario, idCurso, fechaInscripcion)
  - `Material` (con campos: idMaterial, tipo, url, idCurso)
  - `Evaluacion`, `Foro`, `Mensaje`, `Reporte`
- El sistema NO sincronizará automáticamente si ya existe la BD (por defecto)
- Solo necesitas configurar las variables de entorno en `.env`

**Si necesitas crear la base de datos:**
Ejecuta el script SQL proporcionado:

```bash
mysql -u root -p < database.sql
```

O importa el archivo `database.sql` desde tu cliente MySQL.

### 4. Iniciar el servidor

```bash
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
El servidor estará disponible en `http://localhost:3000`

## 📡 Endpoints de la API

### 🔐 Autenticación

#### POST `/api/auth/register`
Registrar nuevo usuario.

**Body:**
```json
{
  "nombre": "Juan Pérez",
  "correo": "juan@ejemplo.com",
  "contrasena": "password123",
  "rol": "estudiante" // opcional: "estudiante" | "docente" | "admin"
}
```

**Respuesta exitosa (201):**
```json
{
  "status": "success",
  "message": "Usuario registrado exitosamente",
  "data": {
    "usuario": {
      "idUsuario": 1,
      "nombre": "Juan Pérez",
      "correo": "juan@ejemplo.com",
      "rol": "estudiante"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

#### POST `/api/auth/login`
Iniciar sesión.

**Body:**
```json
{
  "correo": "juan@ejemplo.com",
  "contrasena": "password123"
}
```

**Respuesta exitosa (200):**
```json
{
  "status": "success",
  "message": "Inicio de sesión exitoso",
  "data": {
    "usuario": {
      "idUsuario": 1,
      "nombre": "Juan Pérez",
      "correo": "juan@ejemplo.com",
      "rol": "estudiante"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### 📚 Cursos

#### GET `/api/cursos`
Buscar cursos (público, sin autenticación).

**Query Parameters:**
- `categoria` (opcional): Filtrar por categoría
- `titulo` (opcional): Buscar por título

**Ejemplo:**
```
GET /api/cursos?categoria=programacion&titulo=javascript
```

**Respuesta exitosa (200):**
```json
{
  "status": "success",
  "message": "Cursos encontrados",
  "data": {
    "cursos": [
      {
        "idCurso": 1,
        "titulo": "Introducción a JavaScript",
        "descripcion": "Curso básico de JavaScript",
        "categoria": "programacion",
        "idDocente": 2,
        "docente": {
          "idUsuario": 2,
          "nombre": "Profesor Ejemplo",
          "correo": "docente@ejemplo.com"
        }
      }
    ],
    "total": 1
  }
}
```

#### POST `/api/cursos`
Crear nuevo curso (requiere autenticación, solo docentes).

**Headers:**
```
Authorization: Bearer <token>
```

**Body:**
```json
{
  "titulo": "Introducción a JavaScript",
  "descripcion": "Curso básico de JavaScript para principiantes",
  "categoria": "programacion"
}
```

**Respuesta exitosa (201):**
```json
{
  "status": "success",
  "message": "Curso creado exitosamente",
  "data": {
    "curso": {
      "idCurso": 1,
      "titulo": "Introducción a JavaScript",
      "descripcion": "Curso básico de JavaScript para principiantes",
      "categoria": "programacion",
      "idDocente": 2,
      "docente": {
        "idUsuario": 2,
        "nombre": "Profesor Ejemplo",
        "correo": "docente@ejemplo.com"
      }
    }
  }
}
```

#### POST `/api/cursos/:id/inscribirse`
Inscribirse en un curso (requiere autenticación).

**Headers:**
```
Authorization: Bearer <token>
```

**Respuesta exitosa (201):**
```json
{
  "status": "success",
  "message": "Inscripción realizada exitosamente",
  "data": {
    "inscripcion": {
      "idUsuario": 1,
      "idCurso": 1,
      "fechaInscripcion": "2024-01-15"
    }
  }
}
```

#### GET `/api/cursos/:id/materiales`
Obtener materiales de un curso (requiere autenticación, solo usuarios inscritos o docente).

**Headers:**
```
Authorization: Bearer <token>
```

**Respuesta exitosa (200):**
```json
{
  "status": "success",
  "message": "Materiales obtenidos exitosamente",
  "data": {
    "materiales": [
      {
        "idMaterial": 1,
        "tipo": "pdf",
        "url": "https://ejemplo.com/material1.pdf",
        "idCurso": 1
      },
      {
        "idMaterial": 2,
        "tipo": "video",
        "url": "https://ejemplo.com/video1.mp4",
        "idCurso": 1
      }
    ],
    "total": 2
  }
}
```

### 🏥 Health Check

#### GET `/health`
Verificar estado del servidor.

**Respuesta (200):**
```json
{
  "status": "success",
  "message": "Servidor funcionando correctamente",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

## 🔒 Autenticación

Todos los endpoints protegidos requieren un token JWT en el header:

```
Authorization: Bearer <token>
```

El token se obtiene al registrarse o iniciar sesión y tiene una validez de 24 horas por defecto.

## 🎭 Roles de Usuario

- **estudiante**: Puede buscar cursos, inscribirse y ver materiales
- **docente**: Puede crear cursos además de las funcionalidades de estudiante
- **admin**: Acceso completo (puede crear cursos)

## 🛡️ Validaciones Implementadas

### Registro de Usuario
- Nombre: 2-100 caracteres
- Correo: Formato válido y único
- Contraseña: Mínimo 6 caracteres
- Rol: Opcional, debe ser "estudiante", "docente" o "admin"

### Creación de Curso
- Título: 3-200 caracteres
- Descripción: Requerida
- Categoría: Máximo 80 caracteres

### Inscripción
- El usuario no puede inscribirse en su propio curso (si es docente)
- No se puede inscribir dos veces en el mismo curso

### Materiales
- Solo usuarios inscritos o el docente del curso pueden acceder

## 📊 Modelo de Datos

El sistema incluye las siguientes entidades:

- **Usuario**: Usuarios del sistema (estudiantes, docentes, admin)
- **Curso**: Cursos disponibles
- **Inscripcion**: Relación muchos a muchos entre Usuario y Curso
- **Material**: Materiales de los cursos (pdf, video, documentos, etc.)
- **Evaluacion**: Evaluaciones asociadas a cursos
- **Foro**: Foros de discusión por curso
- **Mensaje**: Mensajes en los foros
- **Reporte**: Reportes generados por usuarios

## 🐛 Manejo de Errores

El sistema maneja errores de forma centralizada:

- **400**: Error de validación
- **401**: No autenticado o token inválido
- **403**: Sin permisos
- **404**: Recurso no encontrado
- **409**: Conflicto (recurso duplicado)
- **500**: Error interno del servidor

## 📝 Notas Importantes

- Las contraseñas se cifran automáticamente con bcrypt antes de guardarse
- Los modelos se sincronizan automáticamente en modo desarrollo
- El sistema usa Sequelize para gestionar las relaciones entre modelos
- Todas las respuestas siguen el formato: `{ status, message, data }`

## 🚧 Sprint 1 - Alcance

Este Sprint 1 incluye:
- ✅ Registro e inicio de sesión
- ✅ Búsqueda e inscripción en cursos
- ✅ Acceso a materiales

**Fuera del alcance (Sprint 1):**
- ❌ Evaluaciones en línea
- ❌ Foros y mensajería
- ❌ Reportes
- ❌ Progreso de estudiantes
- ❌ Sistema de pagos

## 👤 Autor

Desarrollado para el Sprint 1 del proyecto E-Learning.

## 📄 Licencia

ISC

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

