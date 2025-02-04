unit uView.PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  uModel.Abstraction, Vcl.WinXCalendars, uModel.Entities.PedidoProduto, uModel.Entities.PedidoDadosGerais, uModel.Entities.Produto,
  uModel.Entities.Cliente;

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
    procedure grdItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdItensKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Memory: IMemory;

    PedidoProdutoController: IController<TPedidoProduto>;
    ProdutoController: IController<TProduto>;
    ClienteController: IController<TCliente>;
    PedidoDadosGerais: TPedidoDadosGerais;
    ControllerPedidoDadosGerais: IController<TPedidoDadosGerais>;
    PedidoProduto: TPedidoProduto;

    procedure ConsultarClientes();
    procedure ConsultarProdutos();
    procedure SetPedidoDadosGerais();
    procedure SetPedidoProduto();
    procedure SetRegistrosItens();
    procedure CalcularTotal();
    procedure CalcularValorTotal(const Quantidade, ValorUnit: String);
    procedure InserirProdutos();
    procedure EditarProdutos();
    procedure LimparCampos();
    procedure ExecuteKeyPress(Sender: TObject; var Key: Char);
    procedure ExecuteNumericoKeyPress(Sender: TObject; var Key: Char);
    procedure ExecuteCancelarLetrasKeyPress(Sender: TObject; var Key: Char);
    procedure ExecuteTrocarPontoPorVirguaKeyPress(Sender: TObject; var Key: Char);
    procedure ExecuteCancelarTrocarPontoOuVirguaKeyPress(Sender: TObject; var Key: Char);

    procedure GravarPedido();
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
  uController.PedidoProduto, uController.Produto, uController.Cliente, uController.PedidoDadosGerais, uModel.FireDAC.CustomConnection,
  uModel.Repository.DataManager, uModel.FireDAC.Transaction;

{$R *.dfm}

{ TfrmPedidoVenda }

procedure TfrmPedidoVenda.btnClientesClick(Sender: TObject);
begin
  ConsultarClientes();
end;

procedure TfrmPedidoVenda.GravarPedido();
begin
  try
    SetPedidoDadosGerais();

    var Transaction: ITransaction<TModelFireDACCustomConnection>;

    Transaction := TModelFireDACTransaction<TModelFireDACCustomConnection>.Create(DataManager.Connection);

    Transaction.SetOptions(ioRepeatableRead);

    Transaction.StartTransaction();
    try
      if PedidoDadosGerais.NumeroPedido = 0 then
        begin
          ControllerPedidoDadosGerais.Save(PedidoDadosGerais);
        end
      else
        begin
          ControllerPedidoDadosGerais.Update(PedidoDadosGerais);
        end;

      Transaction.Commit();

      edtNumeroPedido.Text := PedidoDadosGerais.NumeroPedido.ToString();
       except
      on E: Exception do
        begin
          Transaction.Rollback();
        end;
    end;

 except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmPedidoVenda.btnGravarPedidoClick(Sender: TObject);
begin
  GravarPedido();
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
    if PedidoProdutoController.IsValid(PedidoProduto, MessageContext) and (Memory.State in[dsOpening, dsInsert]) then // Data.IsEmpty() then
      begin
        InserirProdutos();
        LimparCampos();
        edtCodProduto.SetFocus();
        Memory.Data.Open();
        CalcularTotal();
      end
  else EditarProdutos();


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

  dsPedido.DataSet := Memory.Data;

  PedidoDadosGerais := TPedidoDadosGerais.Create();
  PedidoProduto := TPedidoProduto.Create();
  ProdutoController := TControllerProduto.Create();
  ClienteController:= TControllerCliente.Create();

  ControllerPedidoDadosGerais := TControllerPedidoDadosGerais.Create(Memory);

  PedidoProdutoController := TControllerPedidoProduto.Create();

  var TotalDoPedido := 0.00;

  stbRodape.Font.Style := [TFontStyle.fsBold];
  stbRodape.Panels[0].Style := psOwnerDraw;
  stbRodape.Panels[0].Text:= 'Total do pedido: '+ FormatFloat('R$ 0.00', TotalDoPedido);

  capStartDate.Date := Date();

  edtCliente.SetFocus();
end;

procedure TfrmPedidoVenda.CalcularTotal();
begin
  Memory.Data.DisableControls();

  var Total: Currency;
  Total := 0.00;

  Memory.Data.First();

  while not Memory.Data.Eof do
    begin
      Total:= Total + Memory.Data.FieldByName('valor_total').AsCurrency;
      Memory.Data.Next();
    end;

  stbRodape.Panels[0].Text:= 'Total do pedido: '+ FormatFloat('R$ 0.00', Total);

  Memory.Data.EnableControls();
end;

procedure TfrmPedidoVenda.CalcularValorTotal(const Quantidade, ValorUnit: String);
begin
  edtTotal.Text:= FloatToStr(StrToFloatDef(Quantidade, 0) * StrToFloatDef(ValorUnit, 0));
end;

procedure TfrmPedidoVenda.ExecuteCancelarLetrasKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(Key, ['0'..'9', #8, #13])) then
    Key := #0;
end;

procedure TfrmPedidoVenda.ExecuteTrocarPontoPorVirguaKeyPress(Sender: TObject; var Key: Char);
begin
  if (CharInSet(Key, ['.'])) then
    Key := ',';

  if (Key = ',') and (Pos(',', (Sender as TEdit).Text) > 0) then
    Key := #0;
end;

procedure TfrmPedidoVenda.ExecuteCancelarTrocarPontoOuVirguaKeyPress(Sender: TObject; var Key: Char);
begin
  if (CharInSet(Key, ['.', ','])) then
    Key := #0;
end;

procedure TfrmPedidoVenda.ExecuteKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteCancelarLetrasKeyPress(Sender, Key);

  ExecuteCancelarTrocarPontoOuVirguaKeyPress(Sender, Key);
end;

procedure TfrmPedidoVenda.ExecuteNumericoKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteTrocarPontoPorVirguaKeyPress(Sender, Key);

  if Key = ',' then
    Exit();

  ExecuteCancelarLetrasKeyPress(Sender, Key);
end;

procedure TfrmPedidoVenda.grdItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = VK_DELETE) then
    Key := 0;

  if key = VK_DELETE then
    begin
      if MessageBox(Application.Handle, Pchar ('Deseja realmente deseja excluir o produto?'), 'Exclusão de produtos', MB_YESNO) = idYes then
        begin
          Memory.Data.Delete();
          CalcularTotal();
        end;
    end;
end;

procedure TfrmPedidoVenda.grdItensKeyPress(Sender: TObject; var Key: Char);
const
  ENTER = #13;
begin
  if key  = ENTER then
    SetRegistrosItens();
end;

procedure TfrmPedidoVenda.InserirProdutos();
begin
  Memory.Data.Append();
  Memory.Data.FieldByName('codigo_produto').AsInteger := PedidoProduto.Produto.Codigo;
  Memory.Data.FieldByName('nome_produto').AsString := PedidoProduto.Produto.Descricao;
  Memory.Data.FieldByName('quantidade').AsCurrency := PedidoProduto.Quantidade;
  Memory.Data.FieldByName('valor_unitario').AsCurrency := PedidoProduto.ValorUnitario;
  Memory.Data.FieldByName('valor_total').AsCurrency := PedidoProduto.ValorTotal;
  Memory.Data.Post();
end;

procedure TfrmPedidoVenda.EditarProdutos();
begin
  Memory.Data.FieldByName('codigo_produto').AsInteger := StrToIntDef(edtCodProduto.Text, 0);
  Memory.Data.FieldByName('nome_produto').AsString := edtDescricao.Text;
  Memory.Data.FieldByName('quantidade').AsCurrency := StrToFloatDef(edtQuantidade.Text, 0);
  Memory.Data.FieldByName('valor_unitario').AsCurrency := StrToFloatDef(edtValorUnitatio.Text, 0 );
  Memory.Data.FieldByName('valor_total').AsCurrency := StrToFloatDef(edtTotal.Text, 0);

  Memory.Data.Post();
  CalcularTotal();
  LimparCampos();
end;

procedure TfrmPedidoVenda.LimparCampos();
begin
  edtCodProduto.Text := '';
  edtDescricao.Text := '';
  edtQuantidade.Text := '';
  edtValorUnitatio.Text := '';
  edtTotal.Text := '';
end;

procedure TfrmPedidoVenda.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteNumericoKeyPress(Sender, Key);
end;

procedure TfrmPedidoVenda.edtValorUnitatioKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteNumericoKeyPress(Sender, Key);
end;

procedure TfrmPedidoVenda.edtClienteChange(Sender: TObject);
begin
  var Cliente := ClienteController.FindById(StrToIntDef(edtCliente.Text, 0));
  try
    edtClienteDesc.Text := Cliente.Nome;
  finally
    FreeAndNil(Cliente);
  end;
end;

procedure TfrmPedidoVenda.edtClienteKeyPress(Sender: TObject; var Key: Char);
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
end;

procedure TfrmPedidoVenda.edtQuantidadeChange(Sender: TObject);
begin
  CalcularValorTotal(edtQuantidade.Text, edtValorUnitatio.Text);
end;

procedure TfrmPedidoVenda.edtValorUnitatioChange(Sender: TObject);
begin
  CalcularValorTotal(edtQuantidade.Text, edtValorUnitatio.Text);
end;

procedure TfrmPedidoVenda.SetPedidoProduto();
begin
  PedidoProduto.Produto.Codigo := StrToIntDef(edtCodProduto.Text, 0);
  PedidoProduto.Produto.Descricao := edtDescricao.Text;
  PedidoProduto.Quantidade :=  StrToFloatDef(edtQuantidade.Text, 0);
  PedidoProduto.ValorUnitario := StrToFloatDef(edtValorUnitatio.Text, 0);
  PedidoProduto.ValorTotal := StrToFloatDef(edtTotal.Text, 0);
end;

procedure TfrmPedidoVenda.SetPedidoDadosGerais();
begin
  PedidoDadosGerais.DataEmissao := capStartDate.Date;
  PedidoDadosGerais.Cliente.Codigo := StrToIntDef(edtCliente.Text, 0);
end;

procedure TfrmPedidoVenda.SetRegistrosItens();
begin
  Memory.State := dsEdit;
  edtCodProduto.Text:= Memory.Data.FieldByName('codigo_produto').AsString;
  edtDescricao.Text := Memory.Data.FieldByName('nome_produto').AsString;
  edtQuantidade.Text:= FloatToStr(Memory.Data.FieldByName('quantidade').AsCurrency);
  edtValorUnitatio.Text := FloatToStr( Memory.Data.FieldByName('valor_unitario').AsCurrency);
  edtTotal.Text     := FloatToStr( Memory.Data.FieldByName('valor_total').AsCurrency);
  edtCodProduto.ReadOnly:= True;
  edtQuantidade.SetFocus;
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
