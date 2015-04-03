CREATE TABLE Productos
(
  id		"guid"  NOT NULL PRIMARY KEY
, marca_id	integer default 0
, codigo	varchar(20)
, categoria_id	integer default 0
, nombre	varchar(300)
, minimo	float	default 0
, unidad_id	integer default 0
, cantTotalizar	float	default 0
, codBarras	varchar(50)
, bVisible	smallint default 1
);

CREATE TABLE Marcas
(
  id		integer  NOT NULL PRIMARY KEY
, marca		varchar(150)
, bVisible	smallint default 1
);

CREATE TABLE Categorias
(
  id		integer  NOT NULL PRIMARY KEY
, categoria	varchar(100)
, bVisible	smallint default 1
);

CREATE TABLE Unidades
(
  id		integer NOT NULL PRIMARY KEY
, unidad	varchar(50)
, totaliza	varchar(50)
, factor	float	default 0
, bVisible	smallint default 1
);

CREATE TABLE Precios
(
  id		"guid"  NOT NULL PRIMARY KEY
, monto		float default 0
, producto_id	"guid" default '{00000000-0000-0000-0000-000000000000}'
, listaPrecio_id integer default 0
, iva		float default 0
, bVisible	smallint default 1
);

CREATE TABLE ListasPrecios
(
  id		integer  NOT NULL PRIMARY KEY
, ListaPrecio	varchar(100)
, bVisible	smallint default 1
);

