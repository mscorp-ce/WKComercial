unit uView.PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  uModel.Abstraction, Vcl.WinXCalendars;

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
    edtValorUnit: TEdit;
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
  private
    { Private declarations }
    Memory: IMemory;

    procedure ConsultarClientes();
    procedure ConsultarProdutos();
  protected
    { Protected declarations }
    procedure DoShow; override;
  public
    { Public declarations }
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

uses
  uModel.FireDAC.Memory, uView.Data.Definition.PedidoProduto, uView.FormCliente.Consulta, uView.FormProduto.Consulta;

{$R *.dfm}

{ TfrmPedidoVenda }

procedure TfrmPedidoVenda.btnClientesClick(Sender: TObject);
begin
  ConsultarClientes();
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

procedure TfrmPedidoVenda.DoShow();
begin
  inherited;
  Memory := TModelFireDACMemory.Create(TDataDefinitionPedidoProduto.JSON());

  var TotalDoPedido := 0.00;

  stbRodape.Font.Style := [TFontStyle.fsBold];
  stbRodape.Panels[0].Style := psOwnerDraw;
  stbRodape.Panels[0].Text:= 'Total do pedido: '+ FormatFloat('R$ 0.00', TotalDoPedido);

  capStartDate.Date := Date();

  edtCliente.SetFocus();
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
