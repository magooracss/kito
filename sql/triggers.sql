SET TERM ^ ;

CREATE TRIGGER marcasID FOR marcas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(marcasID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER categoriasID FOR categorias
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(categoriasID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER unidadesID FOR unidades
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(unidadesID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER listapreciosID FOR listasprecios
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(listapreciosID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER localidadesID FOR localidades
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(localidadesID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER provinciasID FOR provincias
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(provinciasID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER paisesID FOR paises
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(paisesID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER tiposContactosID FOR tiposContactos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(tiposContactosID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER condicionesFiscalesID FOR condicionesFiscales
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(condicionesFiscalesID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER zonasID FOR zonas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(zonasID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER nroPedido FOR Pedidos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.numero = -1) then
   New.numero = GEN_ID(NroPedido,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER TiposEstadosPedidosID FOR PedidosTiposEstados
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(TiposEstadosPedidoID,1);
END^

SET TERM ; ^  

SET TERM ^ ;

CREATE TRIGGER nroMovimientoStock FOR MovimientosStock
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.numero = -1) then
   New.numero = GEN_ID(NroMovimientoStock,1);
END^

SET TERM ; ^  

SET TERM ^ 
