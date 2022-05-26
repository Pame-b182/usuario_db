-- ///////////// PARTE 1: CREACIÓN ENTORNO DE TRABAJO /////////////
create schema usuario_db; -- Se crea la base de datos "usuario_db".
-- Se crea manualmente al usuario "admin_usuario_db" en MySQL Workbench con todos los privilegios para la base de datos "usuario_db".

-- ///////////// PARTE 2: CREACIÓN TABLA -"USUARIO" E "INGRESO_USUARIO" /////////////
create table usuario(
 id_usuario int unsigned not null auto_increment primary key, 
 nombre varchar(50) not null,
 apellido varchar(50) not null,
 clave varchar(8) not null,
 zona_horaria timestamp default (now()+interval 1 hour),
 genero enum('Femenino','Masculino','Otro', 'Sin declarar'),
 telefono int
);

create table ingreso_usuario(
	id_ingreso int unsigned not null auto_increment primary key,
    id_usuario int unsigned not null,
    fecha_hora timestamp default current_timestamp, 
    foreign key (id_usuario)
		references usuario(id_usuario)
);

-- ///////////// PARTE 3: MODIFICACIÓN DE LA TABLA "USUARIO"/////////////
alter table usuario 
modify column zona_horaria timestamp default (now()+interval 2 hour);

-- ///////////// PARTE 4: CREACIÓN DE REGISTROS PARA AMBAS TABLAS /////////////
insert into usuario (id_usuario, nombre, apellido, clave, genero, telefono)
values
(1, 'Elfrieda', 'Habbema', 'apkJZo7M', 'Femenino', '714338437'),
(2, 'Stafani', 'Ashborne', 'rbD12ogo', 'Femenino', '305265502'),
(3, 'Noble', 'Minney', '6Q7elzWv', 'Masculino', '671967808'),
(4, 'Constancy', 'Cleife', '19V053Vm', 'Femenino', '318843547'),
 (5, 'Loralee', 'Ege', 'MWHRghN3', 'Femenino', '384697379'),
(6, 'Alexander', 'Saines', 'arBdnnWm', 'Masculino', '539919166'),
(7, 'Jemimah', 'Parkman', 'JlxU82Fc', 'Femenino', '296587490'),
(8, 'Leif', 'Van Dale', 'TTJvLQr', 'Masculino', '979628905');

insert into ingreso_usuario (id_ingreso, id_usuario, fecha_hora)
values
(1, 1, '2021-06-06'),
(2, 2, '2021-08-30'),
(3, 3, '2022-02-10'),
(4, 4, '2022-03-05'),
(5, 5, '2021-10-14'),
(6, 6, '2022-02-03'),
(7, 7, '2021-10-01'),
(8, 8, '2021-06-23');
select * from ingreso_usuario;

-- ///////////// PARTE 5 : JUSTIFICACIÓN DE CADA TIPO DE DATOS /////////////
/* id_usuario|id_ingreso| int unsigned not null  auto_increment primary key: Se aplica la restricción primary key al id_usuario|id_ingreso para que sea el identificador
único no negativo ni nulo de la "tabla usuario"|"ingreso_usuario" respectivamente. Además, se deja auto incrementable para que al insertar un nuevo usaurio el id aumente automáticamente. */ 

/* nombre varchar(50) not null: Dado que los nombres se escriben como texto, se le da el tipo de dato varchar y largo 50 para que quepan en toda su longitud. */

/* apellido varchar(50) not null: Dado que los apellidos tambien se escriben como texto, se le da el tipo varchar y largo 50 para que quepan ambos apellidos. */

/* clave varchar(8) not null: Se deja el tipo de dato varchar para que el usuario pueda ingresa números, letras y caracteres especiales. De largo 8 para mayor seguridad. */

/* zona_horaria timestamp default (now()+interval 1 hour): para definir la zona horaria se utiliza el tipo de dato timestamp que muestra la fecha y hora.
Además, se especifica que a la hora actual se le debe agregar un intervalo de 1 hora para estar en la zona horaria UTC-3. */

/* genero enum('Femenino','Masculino','Otro', 'Sin declarar'): se elige el tipo de dato Enum para limitar 4 opciones de entrada. */

/* telefono int: se pone el tipo de dato Int dado que solo son campos numéricos y se ajusta al valor de los teléfonos. */

/* fecha_hora timestamp default current_timestamp: se utiliza el tipo de dato timestamp para que quede registrada la fecha y hora en que el usuario ingresó. Además se deja por defecto la fecha y hora actual */

/* foreign key (id_usuario) references usuario(id_usuario):  Se aplica la restricción foreign key para indicar una relacion entre la tabla "usuario" y la tabla "ingreso_usuario". Este vínculo se realiza a través del atributo "id_usuario".

-- ///////////// PARTE 6: CREACIÓN TABLA "CONTACTO" /////////////
create table contacto(
	id_contacto int unsigned not null auto_increment primary key,
    id_usuario int,
    telefono int,
    email varchar(60)
);


-- ///////////// PARTE 7: MODIFICACION DE LA COLUMNA TELÉFONO DE "CONTACTO" PARA CREAR VÍNCULO ENTRE "CONTACTO" Y "USUARIO" /////////////
select * from contacto; -- Se observa la tabla contacto y su composición.
select * from usuario; -- Se observa la tabla usuario y su composición.

insert into contacto (id_usuario, telefono)
(select id_usuario, telefono from usuario where id_usuario > 0); -- Se insertan los registros de la columna "id_usuario" y "telefono" de la tabla "usuario" a la tabla "contacto".

alter table contacto
modify column id_usuario int unsigned not null,
add foreign key (id_usuario)
references usuario(id_usuario); -- Se modifica la columna id_usuario para crear la llave foránea "id_usuario".

alter table usuario 
drop column telefono; -- Se borra la columna "telefono" de la tabla "usuario" para que no haya duplicidad de datos, ya que la tabla "contacto" ahora posee los telefonos de los usuarios.

