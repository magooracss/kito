unit dmcuentacorriente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset;

type

  { TDM_CuentaCorriente }

  TDM_CuentaCorriente = class(TDataModule)
    CuentaCorriente: TRxMemoryData;
    CuentaCorrienteComprobante: TStringField;
    CuentaCorrienteEgreso: TFloatField;
    CuentaCorrienteEmpresa: TStringField;
    CuentaCorrienteFecha: TDateField;
    CuentaCorrienteIngreso: TFloatField;
    CuentaCorrienteNroInterno: TLongintField;
    CuentaCorrienteSaldo: TFloatField;
    CuentaCorrienteTipoComprobante: TStringField;
    qCompras: TZQuery;
    qComprasCOMPROBANTE: TStringField;
    qComprasDEBE: TFloatField;
    qComprasEMPRESA: TStringField;
    qComprasFECHA: TDateField;
    qComprasNROINTERNO: TLongintField;
    qComprasTIPOCOMPROBANTE: TStringField;
    qVentas: TZQuery;
    qVentasCOMPROBANTE: TStringField;
    qVentasDEBE: TFloatField;
    qVentasEMPRESA: TStringField;
    qVentasFECHA: TDateField;
    qVentasNROINTERNO: TLongintField;
    qVentasTIPOCOMPROBANTE: TStringField;
  private
    procedure prepararConsultaCompras;
    procedure prepararConsultaVentas;
  public
    { public declarations }
  end;

var
  DM_CuentaCorriente: TDM_CuentaCorriente;

implementation

{$R *.lfm}

{ TDM_CuentaCorriente }

procedure TDM_CuentaCorriente.prepararConsultaCompras;
begin
  with qCompras do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add(' SELECT  CC.FECHA');
    SQL.Add('      , E.RAZONSOCIAL as Empresa');
    SQL.Add('      , TCC.COMPROBANTECOMPRA as TipoComprobante');
    SQL.Add('      , (CC.PUNTOVENTA || '-' || CC.COMPROBANTENRO) as Comprobante');
    SQL.Add('      , CC.NUMERO as nroInterno');
    SQL.Add('      , CC.MONTOTOTAL as DEBE');
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
    SQL.Add('      , (CV.PUNTOVENTA || '-' || CV.NROCOMPROBANTE) as Comprobante ');
    SQL.Add('      , 0 as NroInterno');
    SQL.Add('      , (CV.NETOGRAVADO + CV.NETONOGRAVADO + CV.EXENTO) as DEBE');
    SQL.Add(' FROM COMPROBANTESVENTA CV');
    SQL.Add('      left join CLIENTES C ON C.ID = CV.CLIENTE_ID');
    SQL.Add('      left join EMPRESAS E on E.ID = C.EMPRESA_ID');
    SQL.Add('      left join TIPOSCOMPROBANTESVENTAS TCV ON TCV.ID = CV.TIPOCOMPROBANTE_ID');
    SQL.Add(' WHERE (CV.BVISIBLE = 1) ');
  end;
end;

end.

