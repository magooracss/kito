/*  Versión KitoPos: 0-1  */


/*En la versión anterior codigo001.sql me olvidé el trigger...*/
SET TERM ^ ;

CREATE TRIGGER HistoDBID FOR HistoDB
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id= GEN_ID(HistoDBID,1);
END^

SET TERM ; ^  


INSERT INTO HistoDB (version, exe_ver, exe_sub) VALUES (3,1,0);


CREATE TABLE ProductosColores (
	id	"guid"  NOT NULL PRIMARY KEY
,	producto_id	"guid"  DEFAULT '{00000000-0000-0000-0000-000000000000}'
,	color_id	integer DEFAULT 0
,	bVisible	smallint default 1
);

CREATE TABLE ProductosTalles (
	id	"guid"  NOT NULL PRIMARY KEY
,	producto_id	"guid"  DEFAULT '{00000000-0000-0000-0000-000000000000}'
,	talle_id	integer default 0
,	bVisible	smallint default 1
);

CREATE TABLE Colores(
	id	integer not null primary key
,	color	varchar(50)
,	bVisible	smallint default 1
);

CREATE GENERATOR coloresID;

SET GENERATOR coloresID TO 0;


SET TERM ^ ;

CREATE TRIGGER coloresID FOR Colores
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(coloresID,1);
END^

SET TERM ; ^  


INSERT INTO Colores
(id, color, bVisible)
VALUES
(0, 'Desconocido', 1);

CREATE TABLE Talles(
	id	integer not null primary key
,	talle	varchar(25)
,	bVisible	smallint default 1
);

CREATE GENERATOR tallesID;

SET GENERATOR tallesID TO 0;


SET TERM ^ ;

CREATE TRIGGER tallesID FOR Talles
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(tallesID,1);
END^

SET TERM ; ^  


INSERT INTO Talles
(id, talle, bVisible)
VALUES
(0, 'Desconocido', 1);


CREATE TABLE CajaMovimientos (
	id	"guid"  NOT NULL PRIMARY KEY
,	fecha	date
,	tipo	smallint	default 1 /* 1 -> Ingreso a caja 2-> Egreso de caja 3-> Saldo */
,	detalle	varchar(200)
,	monto	"money"
,	referencia_id	"guid"  DEFAULT '{00000000-0000-0000-0000-000000000000}'
,	formaPago_id	integer default 0
,	bVisible	smallint default 1
);

CREATE TABLE PosProductosStock (
	id	"guid" NOT NULL PRIMARY KEY
,	producto_id	"guid"
,	color_id	"guid"
,	talle_id	"guid"
,	cantidad	decimal (10,3) default 0
,	bVisible	smallint default 1
);

CREATE INDEX idxPosProd ON PosProductosStock (producto_id, color_id, talle_id);

CREATE TABLE PosVentas (
	id	"guid" NOT NULL PRIMARY KEY
,	numero	integer default -1
,	fecha	date
,	cliente_id	"guid"
,	total	"money"
,	bAnulada	smallint default 0
,	bVisible	smallint default 1
);

CREATE GENERATOR PosVentaNumero;

SET GENERATOR PosVentaNumero TO 0;


SET TERM ^ ;

CREATE TRIGGER PosVentaNumero FOR PosVentas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.numero = -1) then
   New.numero = GEN_ID(PosVentaNumero,1);
END^

SET TERM ; ^  


CREATE TABLE PosVentaItems (
	id	"guid" NOT NULL PRIMARY KEY
,	venta_id	"guid"
,	productoStock_id	"guid"
,	cantidad	decimal (10,3) default 0
,	precioUnitario	"money"
,	descuento	"money"
, 	recargo	"money"
,	total	"money"
,	bVisible	smallint default 1
);

CREATE TABLE PosVentaFormaPago (
	id	"guid" NOT NULL PRIMARY KEY
,	venta_id	"guid"
,	formaPago_id	integer default 0
,	monto	"money"
,	bVisible	smallint default 1
);