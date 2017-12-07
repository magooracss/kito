/*  Versión KitoPos: 1-1  */

INSERT INTO HistoDB (version, exe_ver, exe_sub) VALUES (4,1,1);

INSERT INTO FormasPago (id, formaPago, bEdit, bVisible) VALUES (-10, 'Descuento', 0, 0);
INSERT INTO FormasPago (id, formaPago, bEdit, bVisible) VALUES (-20, 'Recargo', 0, 0);

CREATE TABLE PosCambio (
	id	"guid" NOT NULL PRIMARY KEY
,	old_venta	"guid"
,	old_prod	"guid"
,	new_venta	"guid"
,	motivoCambio_id	integer default 0
,	bVisible	smallint default 1
);

CREATE TABLE MotivosCambio (
	id	integer not null primary key
,	motivo	varchar (50)
,	bEdit	smallint default 1
,	bVisible	smallint default 1
);


CREATE GENERATOR MotivosCambioID;

SET GENERATOR MotivosCambioID TO 2;

SET TERM ^ ;

CREATE TRIGGER MotivosCambioID FOR MotivosCambio
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(MotivosCambioID,1);
END^

SET TERM ; ^  

INSERT INTO MotivosCambio (id, motivo, bEdit, bVisible)
VALUES
(0, 'DESCONOCIDO', 0, 0);

INSERT INTO MotivosCambio (id, motivo, bEdit, bVisible)
VALUES
(1, 'Cambio normal', 0, 1);

INSERT INTO MotivosCambio (id, motivo, bEdit, bVisible)
VALUES
(2, 'Artículo defectuoso', 1, 1);
