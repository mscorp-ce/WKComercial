unit uModel.Entities.Produto;

interface

type
  TProduto = class
  private
    FDescricao: String;
    FCodigo: Integer;
    FPrecoVenda: Currency;
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetPrecoVenda(const Value: Currency);
  public
    property Codigo: Integer read FCodigo write SetCodigo;
    property Descricao: String read FDescricao write SetDescricao;
    property PrecoVenda: Currency read FPrecoVenda write SetPrecoVenda;
  end;

implementation

{ TProduto }

procedure TProduto.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProduto.SetPrecoVenda(const Value: Currency);
begin
  FPrecoVenda := Value;
end;

end.
