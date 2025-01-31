unit uModel.Entities.Cliente;

interface

type
  TCliente = class
  private
    FUF: String;
    FCodigo: Integer;
    FNome: String;
    FCidade: String;
    procedure SetCidade(const Value: String);
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetUF(const Value: String);
  public
    property Codigo: Integer read FCodigo write SetCodigo;
    property Nome: String read FNome write SetNome;
    property Cidade: String read FCidade write SetCidade;
    property UF: String read FUF write SetUF;
  end;

implementation

{ TCliente }

procedure TCliente.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TCliente.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
