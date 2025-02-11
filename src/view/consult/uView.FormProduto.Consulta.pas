unit uView.FormProduto.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.FormConsult, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  uModel.Abstraction, uModel.Entities.Produto;

type
  TfrmFormProdutoConsulta = class(TfrmConsult)
  private
    { Private declarations }
    RootControllerProduto: IRootController<TProduto>;
    FPrecoVenda: Currency;
    procedure SetPrecoVenda(const Value: Currency);
  protected
    { Protected declarations }
    procedure DoShow(); override;
    procedure Filter(); override;
    procedure All(); override;
    procedure Remove(); override;
    procedure Confirm(); override;
  public
    { Public declarations }
    property PrecoVenda: Currency read FPrecoVenda write SetPrecoVenda;
  end;

var
  frmFormProdutoConsulta: TfrmFormProdutoConsulta;

implementation

uses
  uController.RootProduto, uModel.FireDAC.Memory, uView.Data.Definition.Produto, uView.DataConverter.Produto;

{$R *.dfm}

{ TfrmFormProdutoConsulta }

procedure TfrmFormProdutoConsulta.All();
var
  DataConverter: IDataConverter<TProduto>;
begin
  var Produtos := RootControllerProduto.FindAll();
  try
    DataConverter:= TDataConverterProduto.Create();
    DataConverter.Populate(Produtos, Memory.Data);
    Memory.Open();

  finally
    FreeAndNil(Produtos);
  end;
end;

procedure TfrmFormProdutoConsulta.Confirm();
begin
  inherited;
  Id         := Memory.Data.FieldByName('codigo').AsInteger;
  Descricao  := Memory.Data.FieldByName('descricao').AsString;
  PrecoVenda := Memory.Data.FieldByName('preco_venda').AsCurrency;

  Close();
end;

procedure TfrmFormProdutoConsulta.DoShow();
begin
  inherited;
  RootControllerProduto := TControllerRootProduto.Create();

  Memory := TModelFireDACMemory.Create(TDataDefinitionProduto.JSON());
  Memory.Data.Name := 'MemoryDataFormProdutoConsulta';

  dsConsult.DataSet := Memory.Data;

  All();
end;

procedure TfrmFormProdutoConsulta.Filter();
begin
  inherited;

end;

procedure TfrmFormProdutoConsulta.Remove();
begin
  inherited;

end;

procedure TfrmFormProdutoConsulta.SetPrecoVenda(const Value: Currency);
begin
  FPrecoVenda := Value;
end;

end.
