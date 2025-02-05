unit uModel.Entities.PedidoDadosGerais;

interface

uses
  System.Generics.Collections, uModel.Entities.Cliente, uModel.Entities.PedidoProduto;

type
  TPedidoDadosGerais = class
  private
    FCliente: TCliente;
    FValorTotal: Currency;
    FDataEmissao: TDate;
    FNumeroPedido: Integer;
    FProdutos: TObjectList<TPedidoProduto>;
    procedure SetCliente(const Value: TCliente);
    procedure SetDataEmissao(const Value: TDate);
    procedure SetNumeroPedido(const Value: Integer);
    procedure SetValorTotal(const Value: Currency);
    procedure SetProdutos(const Value: TObjectList<TPedidoProduto>);
  public
    constructor Create(); reintroduce;
    destructor Destroy; override;

    property NumeroPedido: Integer read FNumeroPedido write SetNumeroPedido;
    property DataEmissao: TDate read FDataEmissao write SetDataEmissao;
    property Cliente: TCliente read FCliente write SetCliente;
    property ValorTotal: Currency read FValorTotal write SetValorTotal;

    property Produtos: TObjectList<TPedidoProduto> read FProdutos write SetProdutos;
  end;

implementation

{ TPedidoDadosGerais }

uses
  System.SysUtils;

constructor TPedidoDadosGerais.Create();
begin
  inherited Create();

  FCliente := TCliente.Create();

  FProdutos := TObjectList<TPedidoProduto>.Create();
end;

destructor TPedidoDadosGerais.Destroy();
begin
  FreeAndNil(FCliente);

  FreeAndNil(FProdutos);

  inherited Destroy();
end;

procedure TPedidoDadosGerais.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TPedidoDadosGerais.SetDataEmissao(const Value: TDate);
begin
  FDataEmissao := Value;
end;

procedure TPedidoDadosGerais.SetNumeroPedido(const Value: Integer);
begin
  FNumeroPedido := Value;
end;

procedure TPedidoDadosGerais.SetProdutos(const Value: TObjectList<TPedidoProduto>);
begin
  FProdutos := Value;
end;

procedure TPedidoDadosGerais.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

end.
