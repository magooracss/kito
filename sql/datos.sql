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


