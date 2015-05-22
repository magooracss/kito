-- Versión Origen Ejecutable: 2015-05-01
-- Versión Destino Ejecutable: 2015-05-

CREATE TABLE HojasDeRuta
(
  id		"guid"  NOT NULL PRIMARY KEY
, numero	integer default -1
, transportista_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, fecha		date
, bAnulada	smallint default 0
, fAnulada	date
, Estado	smallint default 1
, fPresentada	date
, bVisible	smallint default 1
);

CREATE TABLE HojaDeRutaDetalles
(
  id		"guid"  NOT NULL PRIMARY KEY
, hojaDeRuta_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, nroOrdena	integer default 0
, pedido_id	"guid" default '{00000000-0000-0000-0000-000000000000}'
, clienteDireccion_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, bultos	integer default 0
, bCobroDestino	smallint default 0
, montoCobrar	float default 0
, nota		varchar(3000)
, bEntregaCompleto smallint default 1
, montoCobrado	float default 0
, devolucion_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, bNoEntregado	smallint default 0
, motivoNoEntrega_id	integer default 0
, bVisible 	smallint default 1
);


CREATE TABLE MotivosNoEntrega
(
  id		integer  NOT NULL PRIMARY KEY
, motivoNoEntrega varchar(150)
, bVisible	smallint default 1	
);


CREATE GENERATOR motivosNoEntregaID;

SET GENERATOR motivosNoEntregaID TO 3;


SET TERM ^ ;

CREATE TRIGGER motivosNoEntregaID FOR MotivosNoEntrega
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(motivosNoEntregaID,1);
END^

SET TERM ; ^  


INSERT INTO motivosNoEntrega
(id, motivoNoEntrega, bVisible)
VALUES
(0, 'Desconocido', 1);

INSERT INTO motivosNoEntrega
(id, motivoNoEntrega, bVisible)
VALUES
(1, 'Comercio cerrado', 1);

INSERT INTO motivosNoEntrega
(id, motivoNoEntrega, bVisible)
VALUES
(2, 'Dirección Erronea', 1);

INSERT INTO motivosNoEntrega
(id, motivoNoEntrega, bVisible)
VALUES
(3, 'Ausencia de encargado/responsable', 1);

CREATE INDEX PedidosEStadosTiposID ON PedidosEstados (TIPOESTADO_ID, pedido_id)


CREATE GENERATOR numeraHojaDeRuta;

SET GENERATOR numeraHojaDeRuta TO 0;


SET TERM ^ ;

CREATE TRIGGER numerarHojaDeRuta FOR HojasDeRuta
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.numero = -1) then
   New.numero = GEN_ID(numeraHojaDeRuta,1);
END^

SET TERM ; ^  
