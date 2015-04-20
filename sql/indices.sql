CREATE INDEX stockProducto ON stock (producto_id);
CREATE INDEX ProductoMovimiento ON MovimientosStockDetalles (producto_id, cantidad, movimiento);
CREATE INDEX ProductoPedidos ON PedidosDetalles (producto_id, cantidad);
CREATE INDEX DevDetallesCabecera ON DEVOLUCIONESDETALLES (devolucion_id);
CREATE INDEX DevPorFecha ON DEVOLUCIONES (fecha);
CREATE INDEX PedDetallesCabecera ON PedidosDetalles (pedido_id, producto_id);
CREATE INDEX PedidosFecha ON Pedidos (fToma);
CREATE INDEX PreciosProducto ON Precios (producto_id);
CREATE INDEX PrecioProdLista ON Precios (listaprecio_id, producto_id);
