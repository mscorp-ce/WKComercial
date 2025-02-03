unit uView.PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  uModel.Abstraction, Vcl.WinXCalendars, uModel.Entities.PedidoProduto,
  uModel.Entities.PedidoDadosGerais, uModel.Entities.Produto;

type
  TfrmPedidoVenda = class(TForm)
    stbRodape: TStatusBar;
    grbPedido: TGroupBox;
    lblCliente: TLabel;
    btnCarregarPedido: TButton;
    edtCliente: TEdit;
    edtClienteDesc: TEdit;
    btnCancelarPedido: TButton;
    grdItens: TDBGrid;
    GroupBox1: TGroupBox;
    lblCodProduto: TLabel;
    lblDescProduto: TLabel;
    lblQuantidade: TLabel;
    lblValorUnit: TLabel;
    lblTotal: TLabel;
    btnInserir: TButton;
    edtCodProduto: TEdit;
    edtQuantidade: TEdit;
    edtValorUnitatio: TEdit;
    edtTotal: TEdit;
    edtDescricao: TEdit;
    btnGravarPedido: TButton;
    btnClientes: TButton;
    ImgLista: TImageList;
    btnProdutos: TButton;
    dsPedido: TDataSource;
    lblStartDate: TLabel;
    capStartDate: TCalendarPicker;
    Label1: TLabel;
    edtNumeroPedido: TEdit;
    procedure btnClientesClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure stbRodapeDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure btnInserirClick(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitatioKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure edtValorUnitatioChange(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoChange(Sender: TObject);
  private
    { Private declarations }
    Memory: IMemory;

    PedidoProdutoController: IController<TPedidoProduto>;
    ProdutoController: IController<TProduto>;
    PedidoDadosGerais: TPedidoDadosGerais;
    PedidoProduto: TPedidoProduto;

    procedure ConsultarClientes();
    procedure ConsultarProdutos();
    procedure SetPedidoProduto();
    procedure CalcularTotal(const Quantidade, ValorUnit: String);
    procedure ExecuteKeyPress(Sender: TObject; var Key: Char);
  protected
    { Protected declarations }
    procedure DoShow(); override;
    procedure DoClose(var Action: TCloseAction); override;
  public
    { Public declarations }
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

uses
  uModel.FireDAC.Memory, uView.Data.Definition.PedidoProduto, uView.FormCliente.Consulta, uView.FormProduto.Consulta,
  uController.PedidoProduto, uController.Produto;

{$R *.dfm}

{ TfrmPedidoVenda }

procedure TfrmPedidoVenda.btnClientesClick(Sender: TObject);
begin
  ConsultarClientes();
end;

procedure TfrmPedidoVenda.btnInserirClick(Sender: TObject);
begin
  if (PedidoDadosGerais.NumeroPedido = 0) and (Memory.State = dsBrowse) then
    Memory.State := dsInsert
  else if (PedidoDadosGerais.NumeroPedido > 0)  then
    Memory.State := dsEdit;

  SetPedidoProduto();

  var MessageContext: String;

  try
    PedidoProdutoController.IsValid(PedidoProduto, MessageContext);

    MessageContext:= '';
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmPedidoVenda.btnProdutosClick(Sender: TObject);
begin
  ConsultarProdutos();
end;

procedure TfrmPedidoVenda.ConsultarClientes();
begin
  var FormClienteConsulta := TfrmFormClienteConsulta.Create('codigo');
  try
    FormClienteConsulta.ShowModal();

    edtCliente.Text := FormClienteConsulta.Id.ToString();
    edtClienteDesc.Text := FormClienteConsulta.Descricao;
  finally
    FreeAndNil(FormClienteConsulta);
  end;
end;

procedure TfrmPedidoVenda.ConsultarProdutos();
begin
  var FormProdutoConsulta := TfrmFormProdutoConsulta.Create('codigo');
  try
    FormProdutoConsulta.ShowModal();

    edtCodProduto.Text := FormProdutoConsulta.Id.ToString();
    edtDescricao.Text := FormProdutoConsulta.Descricao;
  finally
    FreeAndNil(FormProdutoConsulta);
  end;
end;

procedure TfrmPedidoVenda.DoClose(var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(PedidoProduto);

  FreeAndNil(PedidoDadosGerais);
end;

procedure TfrmPedidoVenda.DoShow();
begin
  inherited;
  Memory := TModelFireDACMemory.Create(TDataDefinitionPedidoProduto.JSON());

  PedidoDadosGerais := TPedidoDadosGerais.Create();
  PedidoProduto := TPedidoProduto.Create();
  ProdutoController := TControllerProduto.Create();

  PedidoProdutoController := TControllerPedidoProduto.Create();

  var TotalDoPedido := 0.00;

  stbRodape.Font.Style := [TFontStyle.fsBold];
  stbRodape.Panels[0].Style := psOwnerDraw;
  stbRodape.Panels[0].Text:= 'Total do pedido: '+ FormatFloat('R$ 0.00', TotalDoPedido);

  capStartDate.Date := Date();

  edtCliente.SetFocus();
end;

procedure TfrmPedidoVenda.CalcularTotal(const Quantidade, ValorUnit: String);
begin
  edtTotal.Text:= FloatToStr(StrToFloatDef(Quantidade, 0) * StrToFloatDef(ValorUnit, 0));
end;

procedure TfrmPedidoVenda.ExecuteKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(Key, ['0'..'9', #8, #13, ',', '.'])) then
    Key := #0;

  if (CharInSet(Key, ['.'])) then
    Key := ',';

  if (CharInSet(Key, [',', '.'])) and (Pos(Key, (Sender as TEdit).Text) > 0) then
    Key := #0;
end;

procedure TfrmPedidoVenda.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteKeyPress(Sender, Key);
end;

procedure TfrmPedidoVenda.edtValorUnitatioKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteKeyPress(Sender, Key);
end;

procedure TfrmPedidoVenda.edtCodProdutoChange(Sender: TObject);
begin
  var Produto := ProdutoController.FindById(StrToIntDef(edtCodProduto.Text, 0));
  try
    edtDescricao.Text := Produto.Descricao;
  finally
    FreeAndNil(Produto);
  end;
end;

procedure TfrmPedidoVenda.edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteKeyPress(Sender, Key);

  if (CharInSet(Key, [#13, ',', '.'])) then
    Key := #0;
end;

procedure TfrmPedidoVenda.edtQuantidadeChange(Sender: TObject);
begin
  CalcularTotal(edtQuantidade.Text, edtValorUnitatio.Text);
end;

procedure TfrmPedidoVenda.edtValorUnitatioChange(Sender: TObject);
begin
  CalcularTotal(edtQuantidade.Text, edtValorUnitatio.Text);
end;

procedure TfrmPedidoVenda.SetPedidoProduto();
begin
  PedidoProduto.Produto.Codigo := StrToIntDef(edtCodProduto.Text, 0);
  PedidoProduto.Quantidade :=  StrToFloatDef(edtQuantidade.Text, 0);
  PedidoProduto.ValorUnitario := StrToFloatDef(edtValorUnitatio.Text, 0);
  PedidoProduto.ValorTotal := StrToFloatDef(edtTotal.Text, 0);
end;

procedure TfrmPedidoVenda.stbRodapeDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
const
  PRIMEIRO_PANEL = 0;
  PIXELS_PARA_DIREITA = 2;
  PIXELS_PARA_BAIXO = 2;
begin
  if Panel.Index = PRIMEIRO_PANEL then
    begin
      StatusBar.Canvas.Font.Color := clRed;
      StatusBar.Canvas.TextOut(Rect.Left + PIXELS_PARA_DIREITA, Rect.Top + PIXELS_PARA_BAIXO, Panel.Text);
    end;
end;

end.
