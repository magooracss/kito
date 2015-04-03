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

