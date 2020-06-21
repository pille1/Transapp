-- CREATE SCHEMA proyectoFinal;

DROP TABLE proyectoFinal.mensaje;
DROP TABLE proyectoFinal.viaje;
DROP TABLE proyectoFinal.vehiculo;
DROP TABLE proyectoFinal.credencial_usuario;

CREATE TABLE proyectoFinal.credencial_usuario
(
	uuid UUID NOT NULL DEFAULT uuid_in(md5(random()::text || clock_timestamp()::text)::cstring),
	alias varchar(10) NOT NULL,
    password bytea,
    salt bytea,
    nombre varchar(50) NOT NULL,
	correo varchar(50) NOT NULL,
	telefono varchar (12) NOT NULL,
	ciudad varchar (50) NOT NULL,
  rating integer NOT NULL,
  avatar bytea,
  rol integer NOT NULL,
	activo boolean NOT NULL DEFAULT FALSE,
	CONSTRAINT "credencial_pkey" PRIMARY KEY (uuid)
)
WITH (
  OIDS = FALSE
)
;
ALTER TABLE proyectoFinal.credencial_usuario
  OWNER TO afjimenez;

CREATE TABLE proyectoFinal.vehiculo
(
  matricula varchar(10) NOT NULL,
	id_usuario UUID NOT NULL,
  color varchar(10) NOT NULL,
  marca varchar(10) NOT NULL,
  modelo varchar(10) NOT NULL,
  plazas integer NOT NULL,
	CONSTRAINT "vehiculo_pkey" PRIMARY KEY (matricula),

	CONSTRAINT fk_uuidviaje_uuidperfil FOREIGN KEY (id_usuario)
      REFERENCES proyectoFinal
	.credencial_usuario (uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS = FALSE
)
;
ALTER TABLE proyectoFinal.vehiculo
  OWNER TO afjimenez;

CREATE TABLE proyectoFinal.viaje
(
  id_viaje UUID NOT NULL DEFAULT uuid_in(md5(random()::text || clock_timestamp()::text)::cstring),
	id_usuario UUID NOT NULL,
  matricula varchar(10) NOT NULL,
	fch_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  destino varchar(100) NOT NULL,
  inicio varchar(100) NOT NULL,
  plazas integer NOT NULL,
  comentario TEXT, 
  opciones varchar(100),
	CONSTRAINT "viaje_pkey" PRIMARY KEY (id_viaje),

	CONSTRAINT fk_uuidviaje_uuidperfil FOREIGN KEY (id_usuario)
      REFERENCES proyectoFinal
	.credencial_usuario (uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,

  CONSTRAINT fk_uuidviaje_uuidmatricula FOREIGN KEY (matricula)
      REFERENCES proyectoFinal
	.vehiculo (matricula) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS = FALSE
)
;
ALTER TABLE proyectoFinal.viaje
  OWNER TO afjimenez;


CREATE TABLE proyectoFinal.mensaje
(
	uuid UUID NOT NULL,
	fch_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cuerpo TEXT NOT NULL,

	CONSTRAINT fk_uuidmensaje_uuidperfil FOREIGN KEY (uuid)
      REFERENCES proyectoFinal
	.credencial_usuario (uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS = FALSE
)
;
ALTER TABLE proyectoFinal.mensaje
  OWNER TO afjimenez;


-------------------------------------------

INSERT INTO proyectoFinal.credencial_usuario(alias, password, nombre, correo, telefono, ciudad, rating, rol, activo)
    VALUES ('pille1', 'password', 'Miguel Jimenez', 'migue.pille@gmail.com', '671803508', 'El Puerto de Santa María', 2, 0, true);
