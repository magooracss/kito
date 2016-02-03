/*
  PROGRAMA: ALCON
  VERSION: 2016-02-01
 */

Alter table TiposComprobantesVentas add contable varchar(1) default '-';

update TiposComprobantesVentas 
set contable = 'H';

update tiposComprobantesVentas
set contable = 'D'
WHERE (codigo = '003')
     or (codigo = '008')
     or (codigo = '021')
     or (codigo = '038')
     or (codigo = '044')
     or (codigo = '053')
     or (codigo = '090')
     or (codigo = '112')
     or (codigo = '113')
     or (codigo = '119')
     or (codigo = '013');


