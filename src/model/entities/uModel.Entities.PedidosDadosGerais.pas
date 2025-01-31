unit uModel.Entities.PedidosDadosGerais;

interface

uses
  uModel.Entities.Cliente;

type
  TPedidosDadosGerais = class
  private
    FCliente: TCliente;
    FValorTotal: Currency;
    FDataEmissao: TDate;
    FNumeroPedido: Integer;
    procedure SetCliente(const Value: TCliente);
    procedure SetDataEmissao(const Value: TDate);
    procedure SetNumeroPedido(const Value: Integer);
    procedure SetValorTotal(const Value: Currency);
  public
    constructor Create(); reintroduce;
    destructor Destroy; override;

    property NumeroPedido: Integer read FNumeroPedido write SetNumeroPedido;
    property DataEmissao: TDate read FDataEmissao write SetDataEmissao;
    property Cliente: TCliente read FCliente write SetCliente;
    property ValorTotal: Currency read FValorTotal write SetValorTotal;
  end;

implementation

{ TPedidosDadosGerais }

uses
  System.SysUtils;

constructor TPedidosDadosGerais.Create();
begin
  inherited Create();

  FCliente := TCliente.Create();
end;

destructor TPedidosDadosGerais.Destroy();
begin
  FreeAndNil(FCliente);

  inherited Destroy();
end;

procedure TPedidosDadosGerais.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TPedidosDadosGerais.SetDataEmissao(const Value: TDate);
begin
  FDataEmissao := Value;
end;

procedure TPedidosDadosGerais.SetNumeroPedido(const Value: Integer);
begin
  FNumeroPedido := Value;
end;

procedure TPedidosDadosGerais.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

end.
