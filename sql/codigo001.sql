/*  Versión Kito: 0-17  */


CREATE Table HistoDB
(
  id 		integer default -1 not null primary key
, version	integer default -1
, exe_ver	integer default -1
, exe_sub	integer default -1
, fecha		timestamp default 'NOW'
);

CREATE GENERATOR histoDBID;

SET GENERATOR histoDBID TO 0;

INSERT INTO HistoDB (version, exe_ver, exe_sub) VALUES (2,2,5);

CREATE TABLE RecibosInternos
(
  id		"guid"  NOT NULL PRIMARY KEY
, numero	integer default -1
, fecha		date	default 'NOW'
, monto		"money" 
, cliente_id	"guid"
, bAnulado	smallint default 0
, fAnulado	date	default 'NOW'
, bCerrado	smallint default 0
, bVisible	smallint default 1
);

CREATE GENERATOR RecibosInternosNro;

SET GENERATOR RecibosInternosNro TO 0;


SET TERM ^ ;

CREATE TRIGGER RecibosInternosNro FOR RecibosInternos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.numero = -1) then
   New.numero = GEN_ID(recibosInternosNro,1);
END^

SET TERM ; ^  


CREATE TABLE RecibosIntConceptos
(
  id		"guid"	NOT NULL PRIMARY KEY
, recibo_id	"guid"  NOT NULL
, concepto	varchar (3000)
, monto		"money"
, pedido_id	"guid"
, bVisible	smallint default 1
);

CREATE TABLE RecibosIntMontos
(
  id		"guid" NOT NULL PRIMARY KEY
, recibo_id	"guid" NOT NULL
, formaPago_id	integer default 0
, monto		"money"
, bVisible	smallint default 1
);

CREATE TABLE FormasPago
(
  id		integer NOT NULL PRIMARY KEY
, formaPago	varchar(50)
, bEdit		smallint default 1
, bVisible	smallint default 1
);

CREATE GENERATOR FormasPagoID;

SET GENERATOR FormasPagoID TO 5;


SET TERM ^ ;

CREATE TRIGGER FormasPagoID FOR FormasPago
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(FormasPagoID,1);
END^

SET TERM ; ^  

INSERT INTO FormasPago
(id, formaPago, bEdit, bVisible)
VALUES
(0, 'Desconocido', 0 , 0);

INSERT INTO FormasPago
(id, formaPago, bEdit, bVisible)
VALUES
(1, 'Efectivo', 0 , 1);

INSERT INTO FormasPago
(id, formaPago, bEdit, bVisible)
VALUES
(2, 'Cheque', 0 , 1);

INSERT INTO FormasPago
(id, formaPago, bEdit, bVisible)
VALUES
(3, 'A cuenta', 0 , 1);

INSERT INTO FormasPago
(id, formaPago, bEdit, bVisible)
VALUES
(4, 'VISA', 1 , 1);

INSERT INTO FormasPago
(id, formaPago, bEdit, bVisible)
VALUES
(5, 'Mastercard', 1 , 1);

