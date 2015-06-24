-- Versión Origen Ejecutable: 2015-05-26
-- Versión Destino Ejecutable: 2015-


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



