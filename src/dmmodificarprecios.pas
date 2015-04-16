unit dmmodificarprecios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmgeneral
  ;

const
  IDX_INCREMENTO = 0;
  IDX_DECREMENTO = 1;

type

  { TDM_ModificarPrecios }

  TDM_ModificarPrecios = class(TDataModule)
    ModificarListaPrecio: TRxMemoryData;
    ModificarListaPrecioidPrecio: TStringField;
    ModificarListaPreciolxCodigo: TStringField;
    ModificarListaPreciolxProducto: TStringField;
    ModificarListaPrecioPrecioActual: TFloatField;
    ModificarListaPrecioPrecioNuevo: TFloatField;
    qPreciosPorLista: TZQuery;
  private
    { private declarations }
  public
    procedure ModificarGlobalValor (monto: double; operacion: integer);
    procedure ModificarGlobalPorcentaje (porcentaje: double; operacion: integer);

    procedure LevantarListaPrecio (refLista: Integer);
    procedure Grabar;
  end;

var
  DM_ModificarPrecios: TDM_ModificarPrecios;

implementation
{$R *.lfm}
uses
  dmproductos
  ;

{ TDM_ModificarPrecios }

procedure TDM_ModificarPrecios.ModificarGlobalValor(monto: double;
  operacion: integer);
begin
  with ModificarListaPrecio do
  begin
    First;
    DisableControls;
    While Not EOF do
    begin
      Edit;
      if operacion = IDX_DECREMENTO then
        ModificarListaPrecioPrecioNuevo.AsFloat:= ModificarListaPrecioPrecioActual
                                                     - monto
      else
        ModificarListaPrecioPrecioNuevo.AsFloat:= ModificarListaPrecioPrecioActual
                                                     + monto;
      Post;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TDM_ModificarPrecios.ModificarGlobalPorcentaje(porcentaje: double;
  operacion: integer);
var
  calculo: double;
begin
  with ModificarListaPrecio do
  begin
    First;
    DisableControls;
    While Not EOF do
    begin
      Edit;
      calculo:= (ModificarListaPrecioPrecioNuevo.AsFloat /100) * porcentaje;
      if operacion = IDX_DECREMENTO then
        ModificarListaPrecioPrecioNuevo.AsFloat:= ModificarListaPrecioPrecioActual
                                                     - calculo
      else
        ModificarListaPrecioPrecioNuevo.AsFloat:= ModificarListaPrecioPrecioActual
                                                     + calculo;
      Post;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TDM_ModificarPrecios.LevantarListaPrecio(refLista: Integer);
begin
  DM_General.ReiniciarTabla(ModificarListaPrecio);
  With qPreciosPorLista do
  begin
    if active then close;
    ParamByName('listaprecio_id').asInteger:= refLista;
    Open;
  end;
end;

procedure TDM_ModificarPrecios.Grabar;
begin
  if (ModificarListaPrecio.Active
      and
      (ModificarListaPrecio.RecordCount > 0)) then
  begin
    ModificarListaPrecio.DisableControls;
    ModificarListaPrecio.First;
    DM_General.ReiniciarTabla(DM_Productos.Precios);

    if DM_Productos.SELPrecios.Active then
      DM_Productos.SELPrecios.Close;
    While NOT ModificarListaPrecio.EOF do
    begin
      DM_Productos.SELPrecios.ParamByName('id').AsString:= ModificarListaPrecioidPrecio.AsString;
      DM_Productos.SELPrecios.Open;
      DM_Productos.Precios.LoadFromDataSet(DM_Productos.SELPrecios, 0, lmAppend);
      DM_Productos.Precios.Edit;
      DM_Productos.Preciosmonto.AsFloat:= ModificarListaPrecioPrecioNuevo.AsFloat;
      DM_Productos.Precios.Post;
      DM_Productos.GrabarPrecios;

      ModificarListaPrecio.Next;
    end;
    ModificarListaPrecio.EnableControls;
  end;
end;

end.

