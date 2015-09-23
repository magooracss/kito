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


CREATE TABLE PlanDeCuentas
(
  id    integer  NOT NULL PRIMARY KEY
, cuenta    varchar(15) DEFAULT '0'
, nombre    varchar(100) DEFAULT '-'
, grupo integer default 0
, bVisible  smallint default 1
);


CREATE GENERATOR planDeCuentasID;

SET GENERATOR planDeCuentasID TO 0;


SET TERM ^ ;

CREATE TRIGGER planDeCuentasID FOR PlanDeCuentas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(planDeCuentasID,1);
END^

SET TERM ; ^  


INSERT INTO PlanDeCuentas
(id, cuenta, nombre, grupo, bVisible)
VALUES
(0,'00000000000' ,'Desconocido',0 , 1);


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
(63,'332','CERTIFICADO DE DEPOSITO DE GRANOS EN PLANTA', 1);




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
, precepcionCapital  "money" default 0
, percepcionProvincia "money" default 0
, percepcionIva	      "money" default 0
, bAnulada	      smallint default 0
, bFechaAnulada	      date
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

