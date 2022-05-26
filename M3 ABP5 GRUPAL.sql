-- ///////////////////// CREAR ENTORNO DE TRABAJO /////////////
create schema usuario_db;
-- Se crea manualmente al usuario en workbench (admin_usuario_db) con todos los privilegios para la base usuario_db
use usuario_db;

-- /////////////////// CREACION 2 TABLAS //////////////////////////
create table usuario(
 id_usuario int unsigned not null  auto_increment primary key, /* Se aplica la restricción primary key al id_usuario para que sea el identificador único no negatico ni nulo. Además, se deja auto incrementable para que al ingresar un nuevo usaurio el id aumente automáticamente*/ 
 nombre varchar(50) not null, -- Dado que los nombres son texto, se le da el tipo varchar y largo 50 para que quepan todos los nombres.
 apellido varchar(50) not null, -- Dado que los apellidos son texto, se le da el tipo varchar y largo 50 para que quepan todos los 2 apellidos.
 clave varchar(8) not null, -- Se deja varchar para que el usuario pueda ingresa números, letras y caracteres especiales. De largo 8 para que de mas seguridad.
 zona_horaria timestamp default (now()+interval 1 hour), -- 
 genero enum('Femenino','Masculino','Otro', 'Sin declarar'), -- Enum porque la cantidad de opciones es limitada.
 telefono int -- Int dado que solo son campos numéricos y se ajusta al valor de los teléfonos.
);

create table ingreso_usuario(
	id_ingreso int unsigned not null auto_increment primary key, /* Se aplica la restricción primary key al id_usuario para que sea el identificador único no negatico ni nulo. Además, se deja auto incrementable para que al ingresar un nuevo usaurio el id aumente automáticamente*/ 
    id_usuario int unsigned not null, -- tiene los mismos atributos que el campos id_usuario de la tabla usuario 
    fecha_hora timestamp default current_timestamp, -- timestamp para sabaer la fecha y hora en que el usuario ingrsó. 
    foreign key (id_usuario)
		references usuario(id_usuario)
);

-- //////////////	MODIFICAR TABLA DE UTC-3 A UTC-2  //////////////////////
alter table usuario 
modify column zona_horaria timestamp default (now()+interval 2 hour);

--  /////////// CREAR 8 REGISTROS PARA CADA TABLA /////////////////
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

-- //////////////// CREAR TABLA CONTACTO //////////////////
create table contacto(
	id_contacto int unsigned not null auto_increment primary key, /* Se aplica la restricción primary key al id_usuario para que sea el identificador único no negatico ni nulo. Además, se deja auto incrementable para que al ingresar un nuevo usaurio el id aumente automáticamente*/ 
    id_usuario int, -- tiene los mismos atributos que el campos id_usuario de la tabla usuario 
    telefono int, -- Int dado que solo son campos numéricos y se ajusta al valor de los teléfonos.
    email varchar(60) -- Dado que los email tiene distintos tipos decaracteres se deja varchar con el largo suficiente para que lo sustente.
);

-- //////////////// Modificar telefono para vincular la tabla contacto con tabla usuario ////////////
/* Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la
tabla Contactos.
*/
select * from contacto;
select * from usuario;

insert into contacto (id_usuario, telefono)
(select id_usuario, telefono from usuario where id_usuario > 0);

alter table contacto
modify column id_usuario int unsigned not null,
add foreign key (id_usuario)
references usuario(id_usuario);



