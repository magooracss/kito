INSERT INTO marcas
(id, marca, bVisible)
VALUES
(0, 'Desconocida', 1);

INSERT INTO categorias
(id, categoria, bVisible)
VALUES
(0, 'Desconocida', 1);

INSERT INTO Unidades
(id, unidad, totaliza, factor, bVisible)
VALUES
(0, 'Desconocida', 'Desconocida', 1, 1);

INSERT INTO listasprecios
(id, listaPrecio, bVisible)
VALUES
(0, 'Desconocida', 1);

INSERT INTO localidades
(id, localidad, codigoPostal, provincia_id, bVisible)
VALUES
(0, 'Desconocida','Desconocido', 0,  1);

INSERT INTO provincias
(id, provincia, pais_id, bVisible)
VALUES
(0, 'Desconocida', 0, 1);

INSERT INTO Paises
(id, pais, bVisible)
VALUES
(0, 'Desconocido', 1);

INSERT INTO tiposContactos
(id, tipoContacto, bVisible)
VALUES
(0, 'Desconocido', 1);

INSERT INTO CondicionesFiscales
(id, CondicionFiscal, tipoFactura, bVisible)
VALUES
(0, 'Desconocida', 0, 1);

INSERT INTO Zonas
(id, zona, bVisible)
VALUES
(0, 'Desconocida', 1);

INSERT INTO PedidosTiposEstados
(id, TipoEstado, bVisible)
VALUES
(0, 'Desconocido', 1);

INSERT INTO PedidosTiposEstados
(id, TipoEstado, bVisible)
VALUES
(1, 'Tomado', 1);

INSERT INTO PedidosTiposEstados
(id, TipoEstado, bVisible)
VALUES
(2, 'Armado', 1);

INSERT INTO PedidosTiposEstados
(id, TipoEstado, bVisible)
VALUES
(3, 'En transporte', 1);

INSERT INTO PedidosTiposEstados
(id, TipoEstado, bVisible)
VALUES
(4, 'Entregado', 1);

INSERT INTO PedidosTiposEstados
(id, TipoEstado, bVisible)
VALUES
(5, 'Rechazado', 1);

INSERT INTO GruposListados
(id, GrupoListado, bVisible)
VALUES
(1, 'Mercadería', 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(1, 1, 'Productos por debajo del stock mínimo', 0, 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(2, 1, 'Productos devueltos entre fechas (Detallado)', 1, 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(3, 1, 'Productos devueltos entre fechas (Totalizado por producto)', 2, 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(4, 1, 'Productos pedidos entre fechas', 3, 1);

INSERT INTO GruposListados
(id, GrupoListado, bVisible)
VALUES
(2, 'Listas', 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(5, 2, 'Lista de precios', 4, 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(6, 2, 'Lista de clientes por zona', 5, 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(7, 2, 'Lista de clientes por vendedor', 6, 0);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(8, 2, 'Lista de todos los clientes', 7, 1);

INSERT INTO GruposListados
(id, GrupoListado, bVisible)
VALUES
(3, 'Pedidos', 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(9, 3, 'Pedidos por vendedor', 8, 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(10, 3, 'Pedidos por cliente', 9, 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(11, 3, 'Pedidos tomados entre dos fechas', 10, 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(12, 3, 'Pedidos por Transportista', 11, 1);

INSERT INTO Listado
(id, grupoListado_id, listado, idx, bVisible)
VALUES
(13, 3, 'Pedidos por Estado', 12, 1);



