unit dmcuentacorriente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmgeneral;


type

  { TDM_CuentaCorriente }

  TDM_CuentaCorriente = class(TDataModule)
    CuentaCorriente: TRxMemoryData;
    CuentaCorrienteComprobante: TStringField;
    CuentaCorrienteDebe: TFloatField;
    CuentaCorrienteEmpresa: TStringField;
    CuentaCorrienteFecha: TDateField;
    CuentaCorrientefila_id: TStringField;
    CuentaCorrienteHaber: TFloatField;
    CuentaCorrienteNroInterno: TLongintField;
    CuentaCorrienteSaldo: TFloatField;
    CuentaCorrienteTipoComprobante: TStringField;
    CuentaCorrientetipo_id: TLongintField;
    qCompras: TZQuery;
    qComprasCOMPROBANTE: TStringField;
    qComprasDEBE: TFloatField;
    qComprasEMPRESA: TStringField;
    qComprasFECHA: TDateField;
    qComprasFILA_ID: TStringField;
    qComprasHABER: TLongintField;
    qComprasNROINTERNO: TLongintField;
    qComprasTIPOCOMPROBANTE: TStringField;
    qComprasTIPO_ID: TLongintField;
    qOrdenesPagoFILA_ID: TStringField;
    qOrdenesPagoTIPO_ID: TLongintField;
    qPedidos: TZQuery;
    qOrdenesPagoCOMPROBANTE: TLongintField;
    qOrdenesPagoDEBE: TLongintField;
    qOrdenesPagoEMPRESA: TStringField;
    qOrdenesPagoFECHA: TDateField;
    qOrdenesPagoHABER: TFloatField;
    qOrdenesPagoNROINTERNO: TLongintField;
    qOrdenesPagoTIPOCOMPROBANTE: TStringField;
    qPedidosCOMPROBANTE: TLongintField;
    qPedidosDEBE: TLongintField;
    qPedidosEMPRESA: TStringField;
    qPedidosFECHA: TDateField;
    qPedidosFILA_ID: TStringField;
    qPedidosHABER: TFloatField;
    qPedidosNROINTERNO: TLongintField;
    qPedidosTIPOCOMPROBANTE: TStringField;
    qPedidosTIPO_ID: TLongintField;
    qVentas: TZQuery;
    qOrdenesPago: TZQuery;
    qVentasCOMPROBANTE: TStringField;
    qVentasDEBE: TFloatField;
    qVentasEMPRESA: TStringField;
    qVentasFECHA: TDateField;
    qVentasFILA_ID: TStringField;
    qVentasHABER: TLongintField;
    qVentasNROINTERNO: TLongintField;
    qVentasTIPOCOMPROBANTE: TStringField;
    qVentasTIPO_ID: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
  private
    _idEmpresa: GUID_ID;
    _incCompras: boolean;
    _incOP: boolean;
    _incPedidos: boolean;
    _incVentas: boolean;
    _saldo: Double;
    procedure consultaFechas(fechaIni, fechaFin: TDate; var consulta: TZQuery;
      campoFecha: string);
    procedure consultaEmpresa (var consulta: TZQuery; campoID: string);
    procedure ejecutarConsulta (var consulta: TZQuery);

    procedure prepararConsultaCompras;
    procedure prepararConsultaVentas;
    procedure prepararConsultaOPs;
    procedure prepararConsultaPedidos;

    procedure ajustarSaldo;
  public
    property Saldo: Double read _saldo;
    property incluirCompras: boolean write _incCompras;
    property incluirVentas: boolean write _incVentas;
    property incluirOP: boolean write _incOP;
    property incluirPedidos: boolean write _incPedidos;
    property empresaID: GUID_ID write _idEmpresa;

    procedure ListadoCompleto (fIni, fFin: TDate);
  end;

var
  DM_CuentaCorriente: TDM_CuentaCorriente;

implementation

{$R *.lfm}

{ TDM_CuentaCorriente }

procedure TDM_CuentaCorriente.DataModuleCreate(Sender: TObject);
begin
  _saldo:= 0;
  _incCompras:= true;
  _incPedidos:= true;
  _incOP:= true;
  _incVentas:= true;
end;

procedure TDM_CuentaCorriente.consultaFechas(fechaIni, fechaFin: TDate;
  var consulta: TZQuery; campoFecha: string);
var
  tmpFecha, tmpCadena: string;
begin
  tmpFecha:= FormatDateTime('MM-DD-YYYY', fechaIni);
  tmpCadena:= ' AND (' + campoFecha + ' >= ''' + tmpFecha +''') ';
  tmpFecha:= FormatDateTime('MM-DD-YYYY', fechaFin);
  tmpCadena:= tmpCadena + ' AND (' + campoFecha+ ' <= ''' + tmpFecha +''') ';
  consulta.SQL.Add(tmpCadena);
end;

procedure TDM_CuentaCorriente.consultaEmpresa(var consulta: TZQuery;
  campoID: string);
begin
  consulta.SQL.Add( ' AND ('+ campoID + ' = ''' + _idEmpresa + ''')');
end;

procedure TDM_CuentaCorriente.ejecutarConsulta(var consulta: TZQuery);
begin
  with consulta do
  begin
    if active then close;
    Open;
    CuentaCorriente.LoadFromDataSet(consulta, 0, lmAppend);
    close;
    CuentaCorriente.SortOnFields('fecha');
  end;
end;

procedure TDM_CuentaCorriente.prepararConsultaCompras;
begin
  with qCompras do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add(' SELECT  CC.FECHA');
    SQL.Add('      , E.RAZONSOCIAL as Empresa');
    SQL.Add('      , TCC.COMPROBANTECOMPRA as TipoComprobante');
    SQL.Add('      , (CC.PUNTOVENTA || '' - '' || CC.COMPROBANTENRO) as Comprobante');
    SQL.Add('      , CC.NUMERO as nroInterno');
    SQL.Add('      , CC.MONTOTOTAL as DEBE');
    SQL.Add('     , 0 as HABER ');
    SQL.Add('     , CC.id as fila_id ');
    SQL.Add('     , ' + IntToStr (INC_COMPRAS) +  ' as tipo_id ');
    SQL.Add(' FROM COMPROBANTESCOMPRA CC');
    SQL.Add('      left join PROVEEDORES P ON P.ID = CC.PROVEEDOR_ID');
    SQL.Add('      left join EMPRESAS E on E.ID = P.EMPRESA_ID');
    SQL.Add('      left join TIPOSCOMPROBANTESCOMPRAS TCC ON TCC.ID = CC.TIPOCOMPROBANTE_ID');
    SQL.Add(' WHERE (CC.BANULADO = 0) and (CC.BVISIBLE = 1)');
  end;
end;

procedure TDM_CuentaCorriente.prepararConsultaVentas;
begin
  with qVentas do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add(' SELECT  CV.FECHA');
    SQL.Add('      , E.RAZONSOCIAL as Empresa');
    SQL.Add('      , TCV.COMPROBANTEVENTA as TipoComprobante');
    SQL.Add('      , case ');
    SQL.Add('          when   (CF.PtoVta) is not null then  (CF.PtoVta || '' - '' || CF.CbtDesde) ');
    SQL.Add('          else  (CV.PUNTOVENTA || '' - '' || CV.NROCOMPROBANTE) ');
    SQL.Add('        end as Comprobante ');
    SQL.Add('      , 0 as NroInterno');
    SQL.Add('      , case ');
    SQL.Add('          when (TCV.contable = ''H'')  then (CV.NETOGRAVADO + CV.NETONOGRAVADO + CV.EXENTO) ');
    SQL.Add('          else 0 end as HABER');
    SQL.Add('      , case ');
    SQL.Add('          when (TCV.contable = ''D'')  then (CV.NETOGRAVADO + CV.NETONOGRAVADO + CV.EXENTO) ');
    SQL.Add('          else 0  end as DEBE ');
    SQL.Add('     , CV.id as fila_id ');
    SQL.Add('     , ' + IntToStr (INC_VENTAS) +  ' as tipo_id ');
    SQL.Add(' FROM COMPROBANTESVENTA CV');
    SQL.Add('      left join CLIENTES C ON C.ID = CV.CLIENTE_ID');
    SQL.Add('      left join EMPRESAS E on E.ID = C.EMPRESA_ID');
    SQL.Add('      left join TIPOSCOMPROBANTESVENTAS TCV ON TCV.ID = CV.TIPOCOMPROBANTE_ID');
    SQL.Add('      left join FE_COMPROBANTES CF ON CF.id = CV.Factura_id');

    SQL.Add(' WHERE (CV.BVISIBLE = 1) ');
  end;
end;

procedure TDM_CuentaCorriente.prepararConsultaOPs;
begin
  with qOrdenesPago do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add(' SELECT  OP.FECHA ');
    SQL.Add('     , E.RAZONSOCIAL as Empresa ');
    SQL.Add('     , ''ORDEN DE PAGO'' as TipoComprobante ');
    SQL.Add('     , OP.NUMERO as Comprobante ');
    SQL.Add('     , 0 as NroInterno ');
    SQL.Add('     , 0 as DEBE ');
    SQL.Add('     , OP.TOTAL as HABER ');
    SQL.Add('     , OP.id as fila_id ');
    SQL.Add('     , ' + IntToStr (INC_OP) +  ' as tipo_id ');
    SQL.Add(' FROM OrdenesDePago OP ');
    SQL.Add('    left join PROVEEDORES P ON P.ID = OP.PROVEEDOR_ID ');
    SQL.Add('    left join EMPRESAS E on E.ID = P.EMPRESA_ID ');
    SQL.Add('  WHERE (OP.BVISIBLE = 1) and (OP.BANULADA = 0) ');
  End;
end;

procedure TDM_CuentaCorriente.prepararConsultaPedidos;
begin
  with qPedidos do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add(' SELECT  P.FToma as FECHA ');
    SQL.Add(' , E.RAZONSOCIAL as Empresa ');
    SQL.Add(' , ''PEDIDO'' as TipoComprobante ');
    SQL.Add(' , P.NUMERO as Comprobante ');
    SQL.Add(' , P.NUMERO as NroInterno ');
    SQL.Add(' , 0 as HABER ');
    SQL.Add(' , P.TOTALPEDIDO as DEBE ');
    SQL.Add('     , P.id as fila_id ');
    SQL.Add('     , ' + IntToStr (INC_PEDIDOS) +  ' as tipo_id ');
    SQL.Add(' FROM PEDIDOS  P');
    SQL.Add('  left join  CLIENTES C ON C.ID = P.CLIENTE_ID ');
    SQL.Add('  left join EMPRESAS E on E.ID = C.EMPRESA_ID ');
    SQL.Add(' WHERE (P.BVISIBLE = 1) ');
  end;
end;

procedure TDM_CuentaCorriente.ajustarSaldo;
begin
  _saldo:= 0;
  with CuentaCorriente do
  begin
    DisableControls;
    if RecordCount > 0 then
    begin
      First;
      While Not EOF do
      begin
        _saldo:= _saldo
                 + CuentaCorrienteHaber.AsFloat
                 - CuentaCorrienteDebe.AsFloat;
        Edit;
        CuentaCorrienteSaldo.AsFloat:= _saldo;
        Post;

        Next;
      end;
    end;
    EnableControls;
  end;
end;


procedure TDM_CuentaCorriente.ListadoCompleto(fIni, fFin: TDate);
begin
  //Armo las consultas
  DM_General.ReiniciarTabla(CuentaCorriente);
  prepararConsultaCompras;
  prepararConsultaVentas;
  prepararConsultaOPs;
  prepararConsultaPedidos;

  //Agrego el filtro por fechas
  consultaFechas (fIni, fFin, qCompras, 'CC.FECHA');
  consultaFechas (fIni, fFin, qVentas, 'CV.FECHA');
  consultaFechas (fIni, fFin, qOrdenesPago, 'OP.FECHA');
  consultaFechas(fIni, fFin, qPedidos, 'P.FTOMA');

  if _idEmpresa <> GUIDNULO then
  begin
    consultaEmpresa (qCompras, 'E.id');
    consultaEmpresa (qVentas, 'E.id');
    consultaEmpresa (qOrdenesPago, 'E.id');
    consultaEmpresa (qPedidos, 'E.id');
  end;

  //Ejecuto las consultas;
  if _incCompras then
    ejecutarConsulta (qCompras);

  if _incVentas then
    ejecutarConsulta (qVentas);

  if _incOP then
    ejecutarConsulta(qOrdenesPago);

  if _incPedidos then
    ejecutarConsulta(qPedidos);

  //ajusto los Saldos
  ajustarSaldo;
end;

end.

