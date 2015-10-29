
-- Version Origen Ejecutable: 2015-05-26
-- Version Destino Ejecutable: 2015-


CREATE TABLE GruposCuentas
(
  id    integer  NOT NULL PRIMARY KEY
, nombre    varchar(100)
, bVisible  smallint default 1
);



CREATE GENERATOR gruposCuentasID;

SET GENERATOR gruposCuentasID TO 0;


SET TERM ^ ;

CREATE TRIGGER gruposCuentasID FOR GruposCuentas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(gruposCuentasID,1);
END^

SET TERM ; ^  


INSERT INTO GruposCuentas
(id, nombre, bVisible)
VALUES
(0, 'Desconocido', 1);


CREATE TABLE AlicuotasIVA
(
  id    integer  NOT NULL PRIMARY KEY
, nombre    varchar(15)
, porcentaje    float default 0
, bVisible  smallint default 1

);


CREATE GENERATOR alicuotasIVAID;

SET GENERATOR alicuotasIVAID TO 0;


SET TERM ^ ;

CREATE TRIGGER alicuotasIVAID FOR AlicuotasIVA
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(alicuotasIVAID,1);
END^

SET TERM ; ^  


INSERT INTO AlicuotasIVA
(id, nombre, porcentaje, bVisible)
VALUES
(0,'Desconocido',0 , 1);


CREATE TABLE Conceptos
(
  id    integer  NOT NULL PRIMARY KEY
, nombre    varchar (200)
, planDeCuentas_id  integer default 0
, bExento   smallint default 0
, bNoGravado    smallint default 0  
, bVisible   smallint default 1    
);

CREATE GENERATOR ConceptosID;

SET GENERATOR ConceptosID TO 0;


SET TERM ^ ;

CREATE TRIGGER conceptosID FOR Conceptos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(ConceptosID,1);
END^

SET TERM ; ^  


INSERT INTO Conceptos
(id, nombre, planDeCuentas_id, bExento, bNoGravado, bVisible)
VALUES
(0,'Desconocido',0 , 0, 0, 1);



CREATE TABLE ConceptosAlicuotasIVA
(
  id    "guid"  NOT NULL PRIMARY KEY
, concepto_id  integer default 0
, alicuotaIVA_id  integer default 0
, bVisible   smallint default 1    
);


CREATE TABLE Impuestos
(
  id    integer  NOT NULL PRIMARY KEY
, nombre    varchar (100) 
, valor float default 0
, bPorcentaje   smallint default 1
, bVisible  smallint default 1
);

CREATE GENERATOR ImpuestosID;

SET GENERATOR ImpuestosID TO 0;


SET TERM ^ ;

CREATE TRIGGER ImpuestosID FOR Impuestos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(ImpuestosID,1);
END^

SET TERM ; ^  


INSERT INTO Impuestos
(id, nombre, valor,bPorcentaje, bVisible)
VALUES
(0,'Desconocido',0 ,0 , 1);

CREATE TABLE ConceptosImpuestos
(
  id    "guid"  NOT NULL PRIMARY KEY
, concepto_id  integer default 0
, impuesto_id  integer default 0
, bVisible   smallint default 1    
);


CREATE TABLE TiposComprobantesVentas
(
  id    integer  NOT NULL PRIMARY KEY
, codigo    varchar (3)
, comprobanteVenta varchar(100)
, bVisible   smallint default 1    

);

CREATE GENERATOR TiposComprobantesID;

SET GENERATOR TiposComprobantesID TO 65;


SET TERM ^ ;

CREATE TRIGGER TipoComprobanteID FOR TiposComprobantesVentas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(TiposComprobantesID,1);
END^

SET TERM ; ^  


INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(0,'000','Desconocido', 0);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(1,'001','FACTURAS A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(2,'002','NOTAS DE DEBITO A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(3,'003','NOTAS DE CREDITO A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(4,'004','RECIBOS A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(5,'005','NOTAS DE VENTA AL CONTADO A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(6,'006','FACTURAS B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(7,'007','NOTAS DE DEBITO B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(8,'008','NOTAS DE CREDITO B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(9,'009','RECIBOS B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(10,'010','NOTAS DE VENTA AL CONTADO B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(11,'017','LIQUIDACION DE SERVICIOS PUBLICOS CLASE A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(12,'018','LIQUIDACION DE SERVICIOS PUBLICOS CLASE B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(13,'019','FACTURAS DE EXPORTACION', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(14,'020','NOTAS DE DEBITO POR OPERACIONES CON EL EXTERIOR', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(15,'021','NOTAS DE CREDITO POR OPERACIONES CON EL EXTERIOR', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(16,'022','FACTURAS - PERMISO EXPORTACION SIMPLIFICADO - DTO. 855/97', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(17,'023','CPTES  A  DE COMPRA PRIMARIA PARA EL SECTOR PESQUERO MARITIMO', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(18,'024','CPTES  A  DE COSIGNACION PRIMARIA PARA EL SECTOR PESQUERO MARITIMO', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(19,'027','LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(20,'028','LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(21,'029','LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE C', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(22,'033','LIQUIDACION PRIMARIA DE GRANOS', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(23,'034','COMPROBANTES A DEL APARTADO A  INCISO F  R G  N  1415', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(24,'035','COMPROBANTES B DEL ANEXO I  APARTADO A  INC. F   RG N  1415', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(25,'037','NOTAS DE DEBITO O DOCUMENTO EQUIVALENTE QUE CUMPLAN CON LA R.G. N  1415', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(26,'038','NOTAS DE CREDITO O DOCUMENTO EQUIVALENTE QUE CUMPLAN CON LA R.G. N  1415', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(27,'039','OTROS COMPROBANTES A QUE CUMPLEN CON LA R G  1415', 1);


INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(28,'040','OTROS COMPROBANTES B QUE CUMPLAN CON LA R.G. 1415', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(29,'043','NOTA DE CREDITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(30,'044','NOTA DE CREDITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE C', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(31,'045','NOTA DE DEBITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(32,'046','NOTA DE DEBITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(33,'047','NOTA DE DEBITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE C', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(34,'048','NOTA DE CREDITO LIQUIDACION UNICA COMERCIAL IMPOSITIVA CLASE A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(35,'051','FACTURAS M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(36,'052','NOTAS DE DEBITO M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(37,'053','NOTAS DE CREDITO M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(38,'054','RECIBOS M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(39,'055','NOTAS DE VENTA AL CONTADO M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(40,'056','COMPROBANTES M DEL ANEXO I  APARTADO A  INC F   R G  N  1415', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(41,'057','OTROS COMPROBANTES M QUE CUMPLAN CON LA R G  N  1415', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(42,'058','CUENTAS DE VENTA Y LIQUIDO PRODUCTO M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(43,'059','LIQUIDACIONES M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(44,'060','CUENTAS DE VENTA Y LIQUIDO PRODUCTO A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(45,'061','CUENTAS DE VENTA Y LIQUIDO PRODUCTO B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(46,'063','LIQUIDACIONES A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(47,'064','LIQUIDACIONES B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(48,'068','LIQUIDACION C', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(49,'081','TIQUE FACTURA A   CONTROLADORES FISCALES', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(50,'082','TIQUE - FACTURA B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(51,'083','TIQUE', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(52,'090','NOTA DE CREDITO OTROS COMP  QUE NO CUMPLEN CON LA R G  1415 Y SUS MODIF', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(53,'099','OTROS COMP  QUE NO CUMPLEN CON LA R G  1415 Y SUS MODIF', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(54,'110','TIQUE NOTA DE CREDITO', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(55,'112','TIQUE NOTA DE CREDITO A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(56,'113','TIQUE NOTA DE CREDITO B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(57,'115','TIQUE NOTA DE DEBITO A', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(58,'116','TIQUE NOTA DE DEBITO B', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(59,'118','TIQUE FACTURA M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(60,'119','TIQUE NOTA DE CREDITO M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(61,'120','TIQUE NOTA DE DEBITO M', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(62,'331','LIQUIDACION SECUNDARIA DE GRANOS', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(64,'011','FACTURAS C', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(65,'012','NOTAS DE DEBITO C', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(66,'013','NOTAS DE CREDITO C', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(67,'015','RECIBOS C', 1);

INSERT INTO TiposComprobantesVentas
(id, codigo, comprobanteVenta,  bVisible)
VALUES
(68,'016','NOTAS DE VENTA AL CONTADO C', 1);



INSERT INTO PEDIDOSTIPOSESTADOS
(ID, TIPOESTADO, BVISIBLE)
VALUES
(7, 'Facturado', 1);


CREATE TABLE ComprobantesVenta 
(
  id		"guid"  NOT NULL PRIMARY KEY
, fecha     date
, cliente_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, tipoComprobante_id integer default 0
, puntoVenta integer default 0
, nroComprobante integer default 0
, bProducto smallint default 0
, bServicio smallint default 0
, formaPago_id integer default 0
, periodoFacturadoIni   date
, periodoFacturadoFin   date
, vtoPago   date
, netoGravado   float default 0
, netoNoGravado float default 0
, exento    float default 0
, factura_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, bVisible smallint default 1
);

CREATE TABLE ComprobantesVentaConceptos
(
  id		"guid"  NOT NULL PRIMARY KEY
, comprobanteVenta_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, orden integer default -1
, cantidad  float default 0
, concepto_id   integer default 0
, detalle   varchar(500)
, gravado   float default 0
, noGravado float default 0
, exento    float default 0
, producto_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, bVisible smallint default 1
);

CREATE TABLE ComprobantesVentaIVA
(
  id		"guid"  NOT NULL PRIMARY KEY
, comprobanteVentaConcepto_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, alicuota_id   integer default 0
, baseimponible float default 0
, monto float default 0
, bVisible smallint default 1
);

CREATE TABLE ComprobantesVentaImpuestos
(
  id		"guid"  NOT NULL PRIMARY KEY
, comprobanteVentaConcepto_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, impuesto_id   integer default 0
, monto float default 0
, bVisible smallint default 1
);



ALTER TABLE Precios add alicuotaIVA_id integer default 0;

DROP TABLE AlicuotasIVA;

CREATE TABLE AlicuotasIVA
(
  id    integer  NOT NULL PRIMARY KEY
, nombre    varchar(15)
, porcentaje    float default 0
, codigoAFIP    float default -1
, codigoFE	integer default 0
, bVisible   smallint default 1    
);

INSERT INTO AlicuotasIVA
(id, nombre, porcentaje, codigoAFIP, codigoFE, bVisible)
VALUES
(0, 'DESCONOCIDO', 0, 0,0, 0);


INSERT INTO AlicuotasIVA
(id, nombre, porcentaje, codigoAFIP, codigoFE, bVisible)
VALUES
(1, '0%', 0, 21, 3, 1);


INSERT INTO AlicuotasIVA
(id, nombre, porcentaje, codigoAFIP, codigoFE, bVisible)
VALUES
(2, '10,5%', 10.5, 10.5, 4, 1);


INSERT INTO AlicuotasIVA
(id, nombre, porcentaje, codigoAFIP, codigoFE, bVisible)
VALUES
(3, '21%', 21, 0, 5, 1);


INSERT INTO AlicuotasIVA
(id, nombre, porcentaje, codigoAFIP, codigoFE, bVisible)
VALUES
(4, '27%', 27, 27, 6, 1);


INSERT INTO AlicuotasIVA
(id, nombre, porcentaje, codigoAFIP, codigoFE, bVisible)
VALUES
(5, '5%', 5, 5, 8, 1);


INSERT INTO AlicuotasIVA
(id, nombre, porcentaje, codigoAFIP, codigoFE, bVisible)
VALUES
(6, '2,5%', 2.5, 2.5, 9, 1);

INSERT INTO AlicuotasIVA
(id, nombre, porcentaje, codigoAFIP, codigoFE, bVisible)
VALUES
(7, 'Exento', 0, 2, 3, 1);



ALTER TABLE PedidosDetalles ADD precio_id "guid" default '{00000000-0000-0000-0000-000000000000}';


CREATE TABLE TiposFormasDePago
(
  id    integer  NOT NULL PRIMARY KEY
, FormaDePago varchar(100)
, bVisible   smallint default 1    

);

CREATE GENERATOR TiposFormasDePagoID;

SET GENERATOR TiposFormasDePagoID TO 5;


SET TERM ^ ;

CREATE TRIGGER TiposFormasDePagoID FOR TiposFormasDePago
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(TiposFormasDePagoID,1);
END^

SET TERM ; ^  


INSERT INTO TiposFormasDePago
(id,  formaDePago,  bVisible)
VALUES
(0,'Desconocido', 0);

INSERT INTO TiposFormasDePago
(id,  formaDePago,  bVisible)
VALUES
(1,'Contado', 1);

INSERT INTO TiposFormasDePago
(id,  formaDePago,  bVisible)
VALUES
(2,'Tarjeta de Credito', 1);

INSERT INTO TiposFormasDePago
(id,  formaDePago,  bVisible)
VALUES
(3,'Tarjeta de Debito', 1);

INSERT INTO TiposFormasDePago
(id,  formaDePago,  bVisible)
VALUES
(4,'Cheque', 1);

INSERT INTO TiposFormasDePago
(id,  formaDePago,  bVisible)
VALUES
(5,'Transferencia Bancaria', 1);



CREATE TABLE NumerosComprobantesVenta
(
  id    integer  NOT NULL PRIMARY KEY
, comprobanteVenta_id integer default 0
, puntoDeVenta  integer default 0
, numero    integer default 0
, bVisible   smallint default 1    
);

CREATE GENERATOR NumerosComprobantesVentaID;

SET GENERATOR NumerosComprobantesVentaID TO 0;


SET TERM ^ ;

CREATE TRIGGER NumerosComprobantesVentaID FOR NumerosComprobantesVenta
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(NumerosComprobantesVentaID,1);
END^

SET TERM ; ^  


INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(0, 0, 0, 0, 0);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 1, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 2, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 3, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 4, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 5, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 6, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 7, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 8, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 9, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 10, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 11, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 12, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 13, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 14, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 15, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 16, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 17, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 18, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 19, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 20, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 21, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 22, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 23, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 24, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 25, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 26, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 27, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 28, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 29, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 30, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 31, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 32, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 33, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 34, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 35, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 36, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 37, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 38, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 39, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 40, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 41, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 42, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 43, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 44, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 45, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 46, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 47, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 48, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 49, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 50, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 51, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 52, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 53, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 54, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 55, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 56, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 57, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 58, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 59, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 60, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 61, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 62, 1, 0, 1);

INSERT INTO NumerosComprobantesVenta
(id,  comprobanteVenta_id, puntoDeVenta, numero,  bVisible)
VALUES
(-1, 63, 1, 0, 1);

CREATE DOMAIN "money"
  AS DECIMAL (18,4)
  DEFAULT 0 NOT NULL;

CREATE TABLE ComprobantesCompra
(
  id		"guid"  NOT NULL PRIMARY KEY
, numero	integer default -1
, proveedor_id	"guid" default '{00000000-0000-0000-0000-000000000000}'
, tipoComprobante_id integer default 0
, puntoVenta	     integer default 0
, comprobanteNro     integer default 0
, condicionPago_id   integer default 0
, plazoPago_id	     integer default 0
, fecha		     date
, montoTotal	     "money" default 0
, percepcionCapital  "money" default 0
, percepcionProvincia "money" default 0
, percepcionIva	      "money" default 0
, estadoPagado	      smallint default 0
, bAnulado	      smallint default 0
, fechaAnulado      date
, bVisible	      smallint default 1
);

CREATE TABLE ComprobantesCompraItems
(
  id		"guid"  NOT NULL PRIMARY KEY
, comprobanteCompra_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, cantidad	       float default 1
, concepto	       varchar (1000) default ''
, cuentaImputacion     integer default 0
, montoUnitario	       "money" default 0
, iva		       "money" default 0
, montoIVA	       "money" default 0
, montoTotal	       "money" default 0
, bVisible	       smallint default 1
);


CREATE TABLE TiposComprobantesCompras
(
  id    integer  NOT NULL PRIMARY KEY
, ComprobanteCompra  varchar (100)
, bVisible	     smallint default 1
);


CREATE GENERATOR ComprobantesCompraID;

SET GENERATOR ComprobantesCompraID TO 0;


SET TERM ^ ;

CREATE TRIGGER ComprobantesComprasID FOR TiposComprobantesCompras
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(ComprobantesCompraID,1);
END^

SET TERM ; ^  


INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(0, 'DESCONOCIDO' , 0);

INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(-1, 'FACTURA A' , 1);

INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(-1, 'FACTURA B' , 1);

INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(-1, 'FACTURA C' , 1);

INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(-1, 'NOTA CREDITO A' , 1);

INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(-1, 'NOTA CREDITO B' , 1);

INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(-1, 'NOTA CREDITO C' , 1);

INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(-1, 'NOTA DEBITO A' , 1);

INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(-1, 'NOTA DEBITO B', 1);

INSERT INTO TiposComprobantesCompras
(id,  ComprobanteCompra,  bVisible)
VALUES
(-1, 'NOTA DEBITO C' , 1);


CREATE TABLE condicionesPago
(
  id    integer  NOT NULL PRIMARY KEY
, CondicionPago  varchar (100)
, bVisible	     smallint default 1
);


CREATE GENERATOR condicionesPagoID;

SET GENERATOR condicionesPagoID TO 0;


SET TERM ^ ;

CREATE TRIGGER condicionesPagoID FOR condicionesPago
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(condicionesPagoID,1);
END^

SET TERM ; ^  

INSERT INTO condicionesPago
(id,  condicionPago,  bVisible)
VALUES
(0, 'DESCONOCIDO' , 0);

INSERT INTO condicionesPago
(id,  condicionPago,  bVisible)
VALUES
(-1, 'Contado' , 1);

INSERT INTO condicionesPago
(id,  condicionPago,  bVisible)
VALUES
(-1, 'Cuenta corriente' , 1);



CREATE TABLE plazosPagos
(
  id    integer  NOT NULL PRIMARY KEY
, plazoPago  varchar (100)
, bVisible	     smallint default 1
);


CREATE GENERATOR plazosPagosID;

SET GENERATOR plazosPagosID TO 0;


SET TERM ^ ;

CREATE TRIGGER plazosPagosID FOR plazosPagos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(plazosPagosID, 1);
END^

SET TERM ; ^  

INSERT INTO plazosPagos
(id,  plazoPago,  bVisible)
VALUES
(0, 'DESCONOCIDO' , 0);

INSERT INTO plazosPagos
(id,  plazoPago,  bVisible)
VALUES
(-1, 'Contado' , 1);

INSERT INTO plazosPagos
(id,  plazoPago,  bVisible)
VALUES
(-1, '7 dias' , 1);

INSERT INTO plazosPagos
(id,  plazoPago,  bVisible)
VALUES
(-1, '15 dias' , 1);

INSERT INTO plazosPagos
(id,  plazoPago,  bVisible)
VALUES
(-1, '20 dias' , 1);

INSERT INTO plazosPagos
(id,  plazoPago,  bVisible)
VALUES
(-1, '30 dias' , 1);

INSERT INTO plazosPagos
(id,  plazoPago,  bVisible)
VALUES
(-1, '60 dias' , 1);

INSERT INTO plazosPagos
(id,  plazoPago,  bVisible)
VALUES
(-1, '90 dias' , 1);


CREATE INDEX ComprobantesventaFK ON COMPROBANTESVENTAIVA (COMPROBANTEVENTACONCEPTO_ID);

CREATE INDEX ComprobantesVentaFK2 ON COMPROBANTESVENTA (FACTURA_ID);
CREATE INDEX FEComprobantesFK ON FE_Comprobantes (cbtHasta,PtoVta);


CREATE TABLE PLANDECUENTAS
(
  id Integer DEFAULT -1,
  CODIGO Varchar(10),
  CUENTA Varchar(50),
  OPERACION Varchar(1),
  PORCIVA Float DEFAULT 0,
  BVISIBLE Smallint DEFAULT 1,
  grupo integer default 0
);


CREATE GENERATOR planDeCuentasID;

SET GENERATOR planDeCuentasID TO 120;


SET TERM ^ ;

CREATE TRIGGER planDeCuentasID FOR PlanDeCuentas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(planDeCuentasID,1);
END^

SET TERM ; ^  



INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('0', '00000000', 'Desconocido', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('120', '5102', 'COMPRAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('2', '1000', 'ACTIVO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('1', '2106', 'PLAN FACILIDADES AFIP', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('3', '1100', 'DISPONIBILIDADES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('4', '1101', 'CAJA', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('5', '1102', 'VALORES A DEPOSITAR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('6', '1104', 'CC 031-042617/2', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('7', '1105', 'FONDO FIJO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('8', '1200', 'INVERSIONES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('9', '1201', 'DEPOSITOS A PLAZO FIJO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('10', '1300', 'CREDITOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('11', '1301', 'DEUDORES POR VENTAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('12', '1302', 'DOCUMENTOS A COBRAR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('13', '1303', 'CHEQUES RECHAZADOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('14', '1304', 'GASTOS A RENDIR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('15', '1305', 'ANTICIPOS DE IMPUESTOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('16', '1306', 'DEPOSITOS EN GARANTIA', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('17', '1307', 'ANTICIPOS COMPRAS BIENES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('18', '1308', 'JUAN CARLOS MARCHESINI', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('19', '1309', 'ENRIQUE LA ROSA', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('20', '1310', 'IVA PERCEPCION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('21', '1311', 'IIBB PERCEPCION CABA', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('22', '1312', 'IIBB PERCEPCION BS AS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('23', '1313', 'ACCIONISTAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('24', '1314', 'CUENTAS A IMPUTAR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('25', '1315', 'BIENES PERSONALES PARTICIPACIONES SOCIETARIAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('26', '1316', 'RETENCION S.U.S.S.', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('27', '1317', 'RETENCION IMPUESTO GANANCIAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('28', '1400', 'BIENES DE CAMBIO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('29', '1401', 'MATERIAS PRIMAS Y MATERIALES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('30', '1500', 'BIENES DE USO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('31', '1500', 'BIENES DE USO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('32', '1502', 'INMUEBLES AMORTIZACION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('33', '1503', 'INSTALACIONES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('34', '1504', 'INSTALACIONES AMORTIZACION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('35', '1505', 'RODADOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('36', '1506', 'RODADOS AMORTIZACION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('37', '1507', 'MAQUINARIAS Y HERRAMIENTAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('38', '1509', 'MUEBLES Y UTILES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('39', '1510', 'MUEBLES Y UTILES AMORTIZACION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('40', '1510', 'MUEBLES Y UTILES AMORTIZACION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('41', '2100', 'DEUDAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('42', '2100', 'DEUDAS', NULL, '0.000000', '0');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('43', '2102', 'OBLIGACIONES A PAGAR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('44', '2103', 'ADELANTOS DE CLIENTES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('45', '2104', 'DEUDAS BANCARIAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('46', '2105', 'I.V.A.', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('47', '2107', 'IMPUESTOS A PAGAR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('48', '2108', 'REMUNERACIONES A PAGAR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('49', '2109', 'CARGAS SOCIALES A PAGAR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('50', '2110', 'PROVISION PARA IMPUESTOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('51', '3000', 'PATRIMONIO NETO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('52', '2111', 'RETENCIONES A PAGAR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('53', '3100', 'CAPITAL SOCIAL', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('54', '3101', 'ACCIONES EN CIRCULACION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('55', '3102', 'AJUSTE AL CAPITAL', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('56', '3200', 'RESERVAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('57', '3201', 'RESERVA LEGAL', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('58', '3300', 'RESULTADOS NO ASIGNADOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('59', '3302', 'RESULTADOS DEL EJERCICIO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('60', '4000', 'RESULTADOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('61', '4100', 'VENTAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('62', '4101', 'VENTAS DE ASCENSORES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('63', '4102', 'VENTAS SERVICE Y REPUESTOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('64', '5000', 'EGRESOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('65', '5100', 'COSTOS DE VENTAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('66', '5101', 'COSTO DE MATERIAS PRIMAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('67', '5200', 'GASTOS DE COMERCIALIZACION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('68', '5201', 'GASTOS DE TRANSPORTE', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('69', '5202', 'PLIEGOS Y SELLADOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('70', '5203', 'PUBLICIDAD', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('71', '5204', 'GASTOS DE REPRESENTACION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('72', '5205', 'IMPUESTO SOBRE LOS IIBB', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('73', '5206', 'FLETES Y ACARREOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('74', '5207', 'GASTOS DE RODADOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('75', '5208', 'DEUDORES INCOBRABLES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('76', '5209', 'CERTIFIC C.P.C.E.C.A.B.A.', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('77', '5210', 'I.G.J.', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('78', '5300', 'GASTOS DE PERSONAL', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('79', '5301', 'SUELDOS Y JORNALES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('80', '5302', 'CARGAS SOCIALES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('81', '5303', 'GASTOS VARIOS PERSONAL', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('82', '5304', 'HONORARIOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('83', '5305', 'INDEMNIZACIONES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('84', '5306', 'SALARIO FAMILIAR', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('85', '5307', 'HONORARIOS AL DIRECTORIO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('86', '5308', 'OBRA SOCIAL DIRECTORES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('87', '5400', 'GASTOS DE ADMINISTRACION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('88', '5401', 'PAPELERIA, UTILES E IMPRESOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('89', '5402', 'SERVICIOS PUBLICOS, CORREOS, TELEFEFONO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('90', '5403', 'AMORTIZACION DE BIENES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('91', '5404', 'SEGUROS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('92', '5405', 'MOVILIDAD Y VIATICOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('93', '5406', 'AVISOS Y SUSCRIPCION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('94', '5407', 'IMPUESTOS, TASAS Y CONTRIBUCIONES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('95', '5408', 'ALQUILERES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('96', '5409', 'IMPUESTO A LAS GANANCIAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('97', '5411', 'GASTOS GENERALES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('98', '5412', 'HONORARIOS ADMINISTRATIVOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('99', '5500', 'GASTOS FINANCIEROS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('100', '5501', 'COMISIONES Y GASTOS BANCARIOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('101', '5502', 'INTERESES BANCARIOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('102', '5503', 'INTERESES COMERCIALES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('103', '5504', 'INTERESES IMPOSITIVOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('104', '5505', 'DIFERENCIAS DE CAMBIO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('105', '5506', 'IMPUESTO LEY Nº 25413', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('106', '5600', 'GASTOS DE PRODUCCION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('107', '5601', 'GASTOS DE MANTENIMIENTO', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('108', '5602', 'MATERIALES VARIOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('109', '5603', 'TRABAJOS DE TERCEROS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('110', '5604', 'GASTOS VARIOS DE TALLER', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('111', '5605', 'HONORARIOS TÉCNICOS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('112', '5606', 'GASTOS TRAMIT Y HABILITACIONES', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('113', '5607', 'GASTOS DE ADUANA', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('114', '6101', 'BONIFICACIONES RECIBIDAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('115', '6102', 'BONIFICACIONES OTORGADAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('116', '6103', 'CREDITOS POR DEVOLUCION', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('117', '7101', 'INICIALIZACION COMPRAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('118', '7102', 'INICIALIZACION VENTAS', NULL, '0.000000', '1');
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE) VALUES ('119', '7103', 'TRANSFERENCIAS RECIBIDAS', NULL, '0.000000', '1');


CREATE TABLE OrdenesDePago
(
  id		"guid"  NOT NULL PRIMARY KEY
, numero	integer default -1
, proveedor_id 	"guid" default '{00000000-0000-0000-0000-000000000000}'
, fecha		date   
, total		"money" default 0
, bAnulada	smallint default 0
, fAnulada	date
, bVisible	smallint default 1
);

CREATE GENERATOR nroOrdenesDePago;

SET GENERATOR nroOrdenesDePago TO 0;


SET TERM ^ ;

CREATE TRIGGER nroOrdenPago FOR OrdenesDePago
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.numero = -1) then
   New.numero = GEN_ID(nroOrdenesDePago,1);
END^

SET TERM ; ^  

CREATE TABLE OPComprobantes
(
  id		"guid"  NOT NULL PRIMARY KEY
, ordenDePago_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, comprobanteCompra_id	"guid" default '{00000000-0000-0000-0000-000000000000}'
, montoPagado	"money" default 0
, bVisible smallint default 1
);

CREATE TABLE OPFormasPago
(
  id		"guid"  NOT NULL PRIMARY KEY
, ordenDePago_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, cheque_id	 "guid" default '{00000000-0000-0000-0000-000000000000}'
, formaPago_id	 integer default 0
, monto		 "money" default 0
, bVisible 	 smallint default 1
);

CREATE TABLE Compensaciones
(
  id		"guid"  NOT NULL PRIMARY KEY
, ordenDePago_id "guid" default '{00000000-0000-0000-0000-000000000000}'
, monto		 "money" default 0
, compra_id	 "guid" default '{00000000-0000-0000-0000-000000000000}'
, fCompensacion date default 0
, bVisible 	 smallint default 1

);
