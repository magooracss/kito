CREATE TABLE Productos
(
  id		"guid"  NOT NULL PRIMARY KEY
, marca_id	integer default 0
, codigo	varchar(20)
, categoria_id	integer default 0
, nombre	varchar(300)
, minimo	float	default 0
, unidad_id	integer default 0
, cantTotalizar	float	default 0
, codBarras	varchar(50)
, bVisible	smallint default 1
);

CREATE TABLE Marcas
(
  id		integer  NOT NULL PRIMARY KEY
, marca		varchar(150)
, bVisible	smallint default 1
);

CREATE TABLE Categorias
(
  id		integer  NOT NULL PRIMARY KEY
, categoria	varchar(100)
, bVisible	smallint default 1
);

CREATE TABLE Unidades
(
  id		integer NOT NULL PRIMARY KEY
, unidad	varchar(50)
, totaliza	varchar(50)
, factor	float	default 0
, bVisible	smallint default 1
);

CREATE TABLE Precios
(
  id		"guid"  NOT NULL PRIMARY KEY
, monto		float default 0
, producto_id	"guid" default '{00000000-0000-0000-0000-000000000000}'
, listaPrecio_id integer default 0
, iva		float default 0
, bVisible	smallint default 1
);

CREATE TABLE ListasPrecios
(
  id		integer  NOT NULL PRIMARY KEY
, ListaPrecio	varchar(100)
, bVisible	smallint default 1
);

CREATE TABLE Empresas
(
  id		"guid"  NOT NULL PRIMARY KEY
, razonSocial	varchar(500)
, cuit		varchar(15)
, condicionFiscal_id	integer default 0
, bvisible	smallint default 1
);

CREATE TABLE Domicilios
(
  id		"guid"  NOT NULL PRIMARY KEY
, empresa_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'	
, domicilio	varchar (500)
, localidad_id	integer default 0
, bVisible 	smallint default 1
);

CREATE TABLE Localidades
(
  id		integer NOT NULL PRIMARY KEY
, localidad	varchar(200)
, codigoPostal	varchar(30)
, provincia_id	integer default 0
, bVisible	smallint default 1	
);

CREATE TABLE Provincias
(
  id		integer NOT NULL PRIMARY KEY
, provincia	varchar(100)
, pais_id	integer default 0
, bVisible	smallint default 1		
);

CREATE TABLE Paises
(
  id		integer NOT NULL PRIMARY KEY
, pais		varchar(150)
, bVisible	smallint default 1		
);

CREATE TABLE Contactos
(
  id		"guid"  NOT NULL PRIMARY KEY
, empresa_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'	
, contacto	varchar (200)
, tipoContacto_id integer default 0
, bVisible 	smallint default 1
);

CREATE TABLE TiposContactos
(
  id		integer NOT NULL PRIMARY KEY
, TipoContacto	varchar(30)
, bVisible	smallint default 1			
);

CREATE TABLE CondicionesFiscales
(
  id		integer NOT NULL PRIMARY KEY
, condicionFiscal varchar(30)
, tipoFactura	integer default 0
, bVisible	smallint default 1	
);

CREATE TABLE Clientes
(
  id		"guid"  NOT NULL PRIMARY KEY
, empresa_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, codigo	varchar(10)
, emailFactura	varchar(50)
, domicilioFactura varchar(500)
, zona_id	integer default 0
, listaPrecio_id integer default 0
, bVisible	smallint default 1
);

CREATE TABLE Proveedores
(
  id		"guid"  NOT NULL PRIMARY KEY
, empresa_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, codigo	varchar(10)
, listaPrecio_id integer default 0
, bVisible	smallint default 1
);

CREATE TABLE Transportistas
(
  id		"guid"  NOT NULL PRIMARY KEY
, empresa_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, codigo	varchar(10)
, zona_id	integer default 0
, bVisible	smallint default 1
);

CREATE TABLE Zonas
(
  id		integer NOT NULL PRIMARY KEY
, zona varchar(100)
, bVisible	smallint default 1		
);

CREATE TABLE Vendedores
(
  id		"guid"  NOT NULL PRIMARY KEY
, empresa_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, codigo	varchar(10)
, zona_id	integer default 0
, listaPrecio_id integer default 0
, bVisible	smallint default 1
);


CREATE TABLE Pedidos
(
  id		"guid"  NOT NULL PRIMARY KEY
, numero	integer	default -1
, cliente_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, txNotas	varchar(3000)
, vendedor_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, fToma		date
, fAEntregar	date
, pagoAnticipado float default 0
, transportista_id "guid"	default '{00000000-0000-0000-0000-000000000000}'
, gastosEnvio	float default 0
, estadoActual_id "guid"	default '{00000000-0000-0000-0000-000000000000}'
, bFacturado	smallint default 0
, fFacturacion	date
, factura_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, porcentajeAplicar float default 0
, montoAplicar	float default 0
, bDescuento	smallint default 1
, TotalPedido	float default 0
, bVisible	smallint default 0
);

CREATE TABLE PedidosDetalles
(
  id		"guid"  NOT NULL PRIMARY KEY
, pedido_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, producto_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, listaPrecio_id integer default 0
, precioUnitario float default 0
, porcentajeAplicar float default 0
, bDescuento	smallint default 1
, precioSubtotal float default 0
, bVisible	smallint default 0
);

CREATE TABLE PedidosEstados
(
  id		"guid"  NOT NULL PRIMARY KEY
, pedido_id	"guid"	default '{00000000-0000-0000-0000-000000000000}'
, fecha		date
, tipoEstado_id	integer default 0
, notas		varchar(3000)
, bVisible	smallint default 0
);

CREATE TABLE PedidosTiposEstados
(
  id		integer NOT NULL PRIMARY KEY
, TipoEstado	varchar(30)
, bVisible	smallint default 1			
);
