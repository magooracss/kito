/*BORRA LA BD de KitoPos dejándola a formato fábrica*/

DELETE FROM Clientes;
DELETE FROM Empresas;
DELETE FROM Colores;
DELETE FROM CajaMovimientos;
DELETE FROM Categorias;
DELETE FROM Contactos;
DELETE FROM Domicilios;
DELETE FROM FormasPago;
DELETE FROM ListasPrecios;
DELETE FROM Marcas;
DELETE FROM PosProductosStock;
DELETE FROM PosVentaFormaPago;
DELETE FROM PosVentaItems;
DELETE FROM PosVentas;
DELETE FROM Precios;
DELETE FROM Productos;
DELETE FROM Proveedores;

SET GENERATOR PosVentaNumero TO 0;