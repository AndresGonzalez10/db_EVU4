CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    apellido_paterno VARCHAR(60) NOT NULL,
    apellido_materno VARCHAR(60),
    correo VARCHAR(120) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    contrasena_hash TEXT NOT NULL,
    rol VARCHAR(20) NOT NULL,
    activo BOOLEAN DEFAULT TRUE NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE instructores (
    id SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL REFERENCES usuarios(id),
    especialidad VARCHAR(100)
);

CREATE TABLE disponibilidad_instructores (
    id SERIAL PRIMARY KEY,
    id_instructor INT NOT NULL REFERENCES instructores(id),
    dia_semana VARCHAR(15) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    activo BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE automoviles (
    id SERIAL PRIMARY KEY,
    modelo VARCHAR(80) NOT NULL,
    placa VARCHAR(20) UNIQUE NOT NULL,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE cursos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    descripcion TEXT,
    duracion INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE inscripciones (
    id SERIAL PRIMARY KEY,
    id_alumno INT NOT NULL REFERENCES usuarios(id),
    id_curso INT NOT NULL REFERENCES cursos(id),
    fecha_inicio DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE clases (
    id SERIAL PRIMARY KEY,
    id_inscripcion INT NOT NULL REFERENCES inscripciones(id),
    id_instructor INT NOT NULL REFERENCES instructores(id),
    id_automovil INT REFERENCES automoviles(id),
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE bitacora_clases (
    id SERIAL PRIMARY KEY,
    id_clase INT NOT NULL REFERENCES clases(id),
    estado_anterior VARCHAR(20) NOT NULL,
    estado_nuevo VARCHAR(20) NOT NULL,
    motivo TEXT,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE notificaciones (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuarios(id),
    titulo VARCHAR(120) NOT NULL,
    mensaje TEXT NOT NULL,
    leida BOOLEAN DEFAULT FALSE NOT NULL,
    creada_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);