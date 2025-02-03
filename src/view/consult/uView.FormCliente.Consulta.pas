unit uView.FormCliente.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.FormConsult, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  uModel.Abstraction, uModel.Entities.Cliente;

type
  TfrmFormClienteConsulta = class(TfrmConsult)
  private
    { Private declarations }
    RootControllerCliente: IRootController<TCliente>;
  protected
    { Protected declarations }
    procedure DoShow(); override;
    procedure Filter(); override;
    procedure All(); override;
    procedure Remove(); override;
    procedure Confirm(); override;
  public
    { Public declarations }
  end;

var
  frmFormClienteConsulta: TfrmFormClienteConsulta;

implementation

uses
  uController.RootCliente, uModel.FireDAC.Memory, uView.Data.Definition.Cliente, uView.DataConverter.Cliente;

{$R *.dfm}

{ TfrmFormClienteConsulta }

procedure TfrmFormClienteConsulta.All();
var
  DataConverter: IDataConverter<TCliente>;
begin
  var Clientes := RootControllerCliente.FindAll();
  try
    DataConverter:= TDataConverterCliente.Create();
    DataConverter.Populate(Clientes, Memory.Data);
    Memory.Open();

  finally
    FreeAndNil(Clientes);
  end;
end;

procedure TfrmFormClienteConsulta.Confirm;
begin
  inherited;
  Id:=   Memory.Data.FieldByName('codigo').AsInteger;
  Descricao := Memory.Data.FieldByName('nome').AsString;

  Close();
end;

procedure TfrmFormClienteConsulta.DoShow();
begin
  inherited;
  RootControllerCliente := TControllerRootCliente.Create();

  Memory := TModelFireDACMemory.Create(TDataDefinitionCliente.JSON());
  Memory.Data.Name := 'MemoryDataFormClienteConsulta';

  dsConsult.DataSet := Memory.Data;

  All();
end;

procedure TfrmFormClienteConsulta.Filter();
begin
  inherited;

end;

procedure TfrmFormClienteConsulta.Remove();
begin
  inherited;

end;

end.
