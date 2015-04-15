CREATE INDEX stockProducto ON stock (producto_id);
CREATE INDEX ProductoMovimiento ON MovimientosStockDetalles (producto_id, cantidad, movimiento);
CREATE INDEX ProductoPedidos ON PedidosDetalles (producto_id, cantidad);
