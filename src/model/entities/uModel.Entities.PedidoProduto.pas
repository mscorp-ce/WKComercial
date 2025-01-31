unit uModel.Entities.PedidoProduto;

interface

uses
  uModel.Entities.Produto;

type
  TPedidoProduto = class
  private
    FProduto: TProduto;
    FAutoIncrem: Integer;
    FValorUnitario: Currency;
    FValorTotal: Currency;
    FQuantidade: Currency;
    FNumeroPedido: Integer;
    procedure SetAutoIncrem(const Value: Integer);
    procedure SetNumeroPedido(const Value: Integer);
    procedure SetProduto(const Value: TProduto);
    procedure SetQuantidade(const Value: Currency);
    procedure SetValorTotal(const Value: Currency);
    procedure SetValorUnitario(const Value: Currency);
  public
    constructor Create(); reintroduce;
    destructor Destroy; override;

    property AutoIncrem: Integer read FAutoIncrem write SetAutoIncrem;
    property NumeroPedido: Integer read FNumeroPedido write SetNumeroPedido;
    property Produto: TProduto read FProduto write SetProduto;
    property Quantidade: Currency read FQuantidade write SetQuantidade;
    property ValorUnitario: Currency read FValorUnitario write SetValorUnitario;
    property ValorTotal: Currency read FValorTotal write SetValorTotal;
  end;

implementation

{ TPedidoProduto }

uses
  System.SysUtils;

constructor TPedidoProduto.Create();
begin
  inherited Create();

  FProduto := TProduto.Create();
end;

destructor TPedidoProduto.Destroy();
begin
  FreeAndNil(FProduto);

  inherited Destroy();
end;

procedure TPedidoProduto.SetAutoIncrem(const Value: Integer);
begin
  FAutoIncrem := Value;
end;

procedure TPedidoProduto.SetNumeroPedido(const Value: Integer);
begin
  FNumeroPedido := Value;
end;

procedure TPedidoProduto.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TPedidoProduto.SetQuantidade(const Value: Currency);
begin
  FQuantidade := Value;
end;

procedure TPedidoProduto.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

procedure TPedidoProduto.SetValorUnitario(const Value: Currency);
begin
  FValorUnitario := Value;
end;

end.
