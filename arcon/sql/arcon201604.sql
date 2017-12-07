/* 
 Version Origen Ejecutable: 2016-02-01
 Version Destino Ejecutable: 2016-04-
*/

DROP TABLE PLANDECUENTAS;

CREATE TABLE PlanDeCuentas
(
  id Integer DEFAULT -1,
  CODIGO Varchar(10),
  CUENTA Varchar(50),
  OPERACION Varchar(1),
  PORCIVA Float DEFAULT 0,
  BVISIBLE Smallint DEFAULT 1,
  cuentaPadre_id integer default 0
);


/* CREATE GENERATOR planDeCuentasID; */ 

SET GENERATOR planDeCuentasID TO 150;

SET TERM ^ ;

CREATE TRIGGER planDeCuentasID FOR PlanDeCuentas
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(planDeCuentasID,1);
END^

SET TERM ; ^  


INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (0, '00000000', 'Desconocido', 'x', 0.0, 0, 0);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (2, '1000', 'ACTIVO', 'x', 0.0, 1, 0);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (3, '1100', 'DISPONIBILIDADES', 'x', 0.0, 1, 2);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (4, '1101', 'CAJA', 'x', 0.0, 1, 3);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (5, '1102', 'VALORES A DEPOSITAR', 'x', 0.0, 1, 3);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (6, '1104', 'CC 031-042617/2', 'x', 0.0, 1, 3);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (7, '1105', 'FONDO FIJO', 'x', 0.0, 1, 3);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (8, '1200', 'INVERSIONES', 'x', 0.0, 1, 2);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (9, '1201', 'DEPOSITOS A PLAZO FIJO', 'x', 0.0, 1, 8);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (10, '1300', 'CREDITOS', 'x', 0.0, 1, 2);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (11, '1301', 'DEUDORES POR VENTAS', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (12, '1302', 'DOCUMENTOS A COBRAR', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (13, '1303', 'CHEQUES RECHAZADOS', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (14, '1304', 'GASTOS A RENDIR', 'x', 0.0, 1,10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (15, '1305', 'ANTICIPOS DE IMPUESTOS', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (16, '1306', 'DEPOSITOS EN GARANTIA', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (17, '1307', 'ANTICIPOS COMPRAS BIENES', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (18, '1308', 'JUAN CARLOS MARCHESINI', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (19, '1309', 'ENRIQUE LA ROSA', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (20, '1310', 'IVA PERCEPCION', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (21, '1311', 'IIBB PERCEPCION CABA', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (22, '1312', 'IIBB PERCEPCION BS AS', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (23, '1313', 'ACCIONISTAS', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (24, '1314', 'CUENTAS A IMPUTAR', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (25, '1315', 'BIENES PERSONALES PARTICIPACIONES SOCIETARIAS', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (26, '1316', 'RETENCION S.U.S.S.', 'x', 0.0, 1, 10);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (27, '1317', 'RETENCION IMPUESTO GANANCIAS', 'x', 0.0, 1, 10);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (28, '1400', 'BIENES DE CAMBIO', 'x', 0.0, 1, 2);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (29, '1401', 'MATERIAS PRIMAS Y MATERIALES', 'x', 0.0, 1, 28);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (30, '1500', 'BIENES DE USO', 'x', 0.0, 1, 2);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (31, '1500', 'BIENES DE USO', 'x', 0.0, 1, 30);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (32, '1502', 'INMUEBLES AMORTIZACION', 'x', 0.0, 1, 30);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (33, '1503', 'INSTALACIONES', 'x', 0.0, 1, 30);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (34, '1504', 'INSTALACIONES AMORTIZACION', 'x', 0.0, 1, 30);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (35, '1505', 'RODADOS', 'x', 0.0, 1, 30);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (36, '1506', 'RODADOS AMORTIZACION', 'x', 0.0, 1, 30);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (37, '1507', 'MAQUINARIAS Y HERRAMIENTAS', 'x', 0.0, 1, 30);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (38, '1509', 'MUEBLES Y UTILES', 'x', 0.0, 1, 30);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (40, '1510', 'MUEBLES Y UTILES AMORTIZACION', 'x', 0.0, 1, 30);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (120, '2000', 'PASIVO', 'x', 0.0, 1, 0);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (41, '2100', 'DEUDAS', 'x', 0.0, 1, 120);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (43, '2102', 'OBLIGACIONES A PAGAR', 'x', 0.0, 1, 41);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (44, '2103', 'ADELANTOS DE CLIENTES', 'x', 0.0, 1, 41);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (45, '2104', 'DEUDAS BANCARIAS', 'x', 0.0, 1, 41);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (46, '2105', 'I.V.A.', 'x', 0.0, 1, 41);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (1, '2106', 'PLAN FACILIDADES AFIP', 'x', 0.0, 1, 41);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (47, '2107', 'IMPUESTOS A PAGAR', 'x', 0.0, 1, 41);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (48, '2108', 'REMUNERACIONES A PAGAR', 'x', 0.0, 1, 41);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (49, '2109', 'CARGAS SOCIALES A PAGAR', 'x', 0.0, 1, 41);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (50, '2110', 'PROVISION PARA IMPUESTOS', 'x', 0.0, 1, 41);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (52, '2111', 'RETENCIONES A PAGAR', 'x', 0.0, 1, 41);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (51, '3000', 'PATRIMONIO NETO', 'x', 0.0, 1, 0);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (53, '3100', 'CAPITAL SOCIAL', 'x', 0.0, 1, 51);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (54, '3101', 'ACCIONES EN CIRCULACION', 'x', 0.0, 1, 53);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (55, '3102', 'AJUSTE AL CAPITAL', 'x', 0.0, 1, 53);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (56, '3200', 'RESERVAS', 'x', 0.0, 1, 51);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (57, '3201', 'RESERVA LEGAL', 'x', 0.0, 1, 56);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (58, '3300', 'RESULTADOS NO ASIGNADOS', 'x', 0.0, 1, 51);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (59, '3302', 'RESULTADOS DEL EJERCICIO', 'x', 0.0, 1, 58);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (60, '4000', 'RESULTADOS', 'x', 0.0, 1, 0);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (61, '4100', 'VENTAS', 'x', 0.0, 1, 60);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (62, '4101', 'VENTAS DE ASCENSORES', 'x', 0.0, 1, 60);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (63, '4102', 'VENTAS SERVICE Y REPUESTOS', 'x', 0.0, 1, 60);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (64, '5000', 'EGRESOS', 'x', 0.0, 1, 0);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (65, '5100', 'COSTOS DE VENTAS', 'x', 0.0, 1, 64);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (66, '5101', 'COSTO DE MATERIAS PRIMAS', 'x', 0.0, 1, 65);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (120, '5102', 'COMPRAS', 'x', 0.0, 1, 65);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (67, '5200', 'GASTOS DE COMERCIALIZACION', 'x', 0.0, 1, 64);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (68, '5201', 'GASTOS DE TRANSPORTE', 'x', 0.0, 1, 67);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (69, '5202', 'PLIEGOS Y SELLADOS', 'x', 0.0, 1, 67);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (70, '5203', 'PUBLICIDAD', 'x', 0.0, 1, 67);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (71, '5204', 'GASTOS DE REPRESENTACION', 'x', 0.0, 1, 67);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (72, '5205', 'IMPUESTO SOBRE LOS IIBB', 'x', 0.0, 1, 67);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (73, '5206', 'FLETES Y ACARREOS', 'x', 0.0, 1, 67);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (74, '5207', 'GASTOS DE RODADOS', 'x', 0.0, 1, 67);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (75, '5208', 'DEUDORES INCOBRABLES', 'x', 0.0, 1, 67);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (76, '5209', 'CERTIFIC C.P.C.E.C.A.B.A.', 'x', 0.0, 1, 67);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (77, '5210', 'I.G.J.', 'x', 0.0, 1, 67);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (78, '5300', 'GASTOS DE PERSONAL', 'x', 0.0, 1, 64);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (79, '5301', 'SUELDOS Y JORNALES', 'x', 0.0, 1, 78);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (80, '5302', 'CARGAS SOCIALES', 'x', 0.0, 1, 78);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (81, '5303', 'GASTOS VARIOS PERSONAL', 'x', 0.0, 1, 78);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (82, '5304', 'HONORARIOS', 'x', 0.0, 1, 78);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (83, '5305', 'INDEMNIZACIONES', 'x', 0.0, 1, 78);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (84, '5306', 'SALARIO FAMILIAR', 'x', 0.0, 1, 78);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (85, '5307', 'HONORARIOS AL DIRECTORIO', 'x', 0.0, 1, 78);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (86, '5308', 'OBRA SOCIAL DIRECTORES', 'x', 0.0, 1, 78);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (87, '5400', 'GASTOS DE ADMINISTRACION', 'x', 0.0, 1, 64);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (88, '5401', 'PAPELERIA, UTILES E IMPRESOS', 'x', 0.0, 1, 87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (89, '5402', 'SERVICIOS PUBLICOS, CORREOS, TELEFEFONO', 'x', 0.0, 1, 87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (90, '5403', 'AMORTIZACION DE BIENES', 'x', 0.0, 1, 87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (91, '5404', 'SEGUROS', 'x', 0.0, 1, 87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (92, '5405', 'MOVILIDAD Y VIATICOS', 'x', 0.0, 1, 87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (93, '5406', 'AVISOS Y SUSCRIPCION', 'x', 0.0, 1, 87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (94, '5407', 'IMPUESTOS, TASAS Y CONTRIBUCIONES', 'x', 0.0, 1, 87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (95, '5408', 'ALQUILERES', 'x', 0.0, 1, 87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (96, '5409', 'IMPUESTO A LAS GANANCIAS', 'x', 0.0, 1, 87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (97, '5411', 'GASTOS GENERALES', 'x', 0.0, 1,  87);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (98, '5412', 'HONORARIOS ADMINISTRATIVOS', 'x', 0.0, 1, 87);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (99, '5500', 'GASTOS FINANCIEROS', 'x', 0.0, 1, 64);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (100, '5501', 'COMISIONES Y GASTOS BANCARIOS', 'x', 0.0, 1, 99);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (101, '5502', 'INTERESES BANCARIOS', 'x', 0.0, 1, 99);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (102, '5503', 'INTERESES COMERCIALES', 'x', 0.0, 1, 99);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (103, '5504', 'INTERESES IMPOSITIVOS', 'x', 0.0, 1, 99);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (104, '5505', 'DIFERENCIAS DE CAMBIO', 'x', 0.0, 1, 99);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (105, '5506', 'IMPUESTO LEY Nº 25413', 'x', 0.0, 1, 99);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (106, '5600', 'GASTOS DE PRODUCCION', 'x', 0.0, 1, 64);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (107, '5601', 'GASTOS DE MANTENIMIENTO', 'x', 0.0, 1, 106);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (108, '5602', 'MATERIALES VARIOS', 'x', 0.0, 1, 106);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (109, '5603', 'TRABAJOS DE TERCEROS', 'x', 0.0, 1, 106);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (110, '5604', 'GASTOS VARIOS DE TALLER', 'x', 0.0, 1, 106);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (111, '5605', 'HONORARIOS TÉCNICOS', 'x', 0.0, 1, 106);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (112, '5606', 'GASTOS TRAMIT Y HABILITACIONES', 'x', 0.0, 1, 106);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (113, '5607', 'GASTOS DE ADUANA', 'x', 0.0, 1, 106);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (121, '6100', 'BONIFICACIONES-CREDITOS', 'x', 0.0, 1, 0);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (114, '6101', 'BONIFICACIONES RECIBIDAS', 'x', 0.0, 1, 121);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (115, '6102', 'BONIFICACIONES OTORGADAS', 'x', 0.0, 1, 121);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (116, '6103', 'CREDITOS POR DEVOLUCION', 'x', 0.0, 1, 121);

INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (122, '7100', 'INICIALIZACION', 'x', 0.0, 1, 0);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (117, '7101', 'INICIALIZACION COMPRAS', 'x', 0.0, 1, 122);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (118, '7102', 'INICIALIZACION VENTAS', 'x', 0.0, 1, 122);
INSERT INTO PLANDECUENTAS (id, CODIGO, CUENTA, OPERACION, PORCIVA, BVISIBLE, cuentaPadre_id) VALUES (119, '7103', 'TRANSFERENCIAS RECIBIDAS', 'x', 0.0, 1, 122);