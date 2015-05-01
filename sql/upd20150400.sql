-- Versión Origen Ejecutable: 2015-04-00
-- Versión Destino Ejecutable: 2015-05-01

Alter table MovimientosStock add pedido_id "guid" default '{00000000-0000-0000-0000-000000000000}';

Alter table MovimientosStock add tipoMovimiento integer default 0;

Update MovimientosStock
set TipoMovimiento = 1;

CREATE TABLE TiposMovimientosStock
(
  id		integer  NOT NULL PRIMARY KEY
, tipoMovimientoStock varchar(50)
, bVisible	smallint default 1	
);

INSERT INTO TiposMovimientosStock
(id, tipoMovimientoStock, bVisible)
VALUES
(0, 'Desconocido', 0);

INSERT INTO TiposMovimientosStock
(id, tipoMovimientoStock, bVisible)
VALUES
(1, 'General', 1);

INSERT INTO TiposMovimientosStock
(id, tipoMovimientoStock, bVisible)
VALUES
(2, 'Devolucion', 1);

INSERT INTO TiposMovimientosStock
(id, tipoMovimientoStock, bVisible)
VALUES
(3, 'Pedido', 1);

