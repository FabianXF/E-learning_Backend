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

```
backend/
 ├── src/
 │   ├── config/
 │   │   └── db.js              # Configuración de base de datos
 │   ├── controllers/
 │   │   ├── authController.js   # Controladores de autenticación
 │   │   └── cursoController.js  # Controladores de cursos
 │   ├── middleware/
 │   │   └── auth.js             # Middleware de autenticación JWT
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

