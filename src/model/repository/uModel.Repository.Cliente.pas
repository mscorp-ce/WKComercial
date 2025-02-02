unit uModel.Repository.Cliente;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Cliente,
  Data.DB;

type
  TClienteRepository = class(TInterfacedObject, IRepository<TCliente>)
  private
    procedure SetStatement(Statement: IStatement; Entity: TCliente);
    procedure SetProperty(Statement: IStatement; Entity: TCliente);
    procedure PopulateListEntitie(var List: TObjectList<TCliente>; const Statement: IStatement);
  public
    function Fields(): TStrings;
    function Save(Entity: TCliente): Boolean;
    function Update(Entity: TCliente): Boolean; overload;
    function DeleteById(Entity: TCliente): Boolean;
    function FindById(Id: Integer): TCliente;
    function Find(): Integer;
    function CommandSQL(): string;
    function FindAll(): TObjectList<TCliente>; overload;
    function FindAll(CommadSQL: String): TObjectList<TCliente>; overload;
    function FindAll(CommadSQL: String; Entity: TCliente): TObjectList<TCliente>; overload;

    destructor Destroy; override;
  end;

implementation

{ TClienteRepository }

uses
  System.SysUtils, FireDAC.Stan.Error, uModel.Design.Factory.StatementFactory, uModel.Design.Factory.DataManagerFactory, uModel.Repository.DataManager,
  uModel.FireDACEngineException, FireDAC.Stan.Param, uModel.ConstsStatement.Repository.Commun, uModel.ConstsStatement.Clientes;

function TClienteRepository.CommandSQL(): string;
begin
  Result := QUERY_CLIENTES;
end;

function TClienteRepository.DeleteById(Entity: TCliente): Boolean;
begin
  Result := False;
end;

destructor TClienteRepository.Destroy();
begin
  inherited Destroy;
end;

function TClienteRepository.Fields(): TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEntity('clientes').GetFieldNames();

    Result:= Items;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TClienteRepository.FindAll(CommadSQL: String): TObjectList<TCliente>;
var
  Statement: IStatement;
  List: TObjectList<TCliente>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TCliente>.Create();

    Statement.Query.SQL.Clear();
    Statement.SQL(CommadSQL).Open();

    PopulateListEntitie(List, Statement);

    Result:= List;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TClienteRepository.PopulateListEntitie(var List: TObjectList<TCliente>; const Statement: IStatement);
var
  Cliente: TCliente;
begin
  Statement.Query.First();
  while not Statement.Query.Eof do
    begin
      Cliente:= TCliente.Create();

      SetProperty(Statement, Cliente);

      List.Add(Cliente);

      Statement.Query.Next();
    end;
end;

function TClienteRepository.FindAll(): TObjectList<TCliente>;
var
  Statement: IStatement;
  List: TObjectList<TCliente>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TCliente>.Create();

    Statement.Query.SQL.Clear();
    Statement.SQL(QUERY_CLIENTES).Open();

    PopulateListEntitie(List, Statement);

    Result:= List;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TClienteRepository.FindById(Id: Integer): TCliente;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_CLIENTES_BY_CODIGO);
    Statement.Query.Params.ParamByName('codigo').AsInteger:= Id;
    Statement.Query.Open();

    var Cliente:= TCliente.Create();
    SetProperty(Statement, Cliente);

    Result:= Cliente;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TClienteRepository.Save(Entity: TCliente): Boolean;
begin
  Result := False;
end;

procedure TClienteRepository.SetProperty(Statement: IStatement;
  Entity: TCliente);
begin
  try
    Entity.Codigo := Statement.Query.FieldByName('codigo').AsInteger;
    Entity.Nome   := Statement.Query.FieldByName('nome').AsString;
    Entity.Cidade := Statement.Query.FieldByName('cidade').AsString;
    Entity.UF     := Statement.Query.FieldByName('uf').AsString;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TClienteRepository.SetStatement(Statement: IStatement;
  Entity: TCliente);
begin
  try
    Statement.Query.Params.ParamByName('nome').AsString   := Entity.Nome;
    Statement.Query.Params.ParamByName('cidade').AsString := Entity.Cidade;
    Statement.Query.Params.ParamByName('uf').AsString     := Entity.UF;

  except
    on Error: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(Error));
  end;
end;

function TClienteRepository.Update(Entity: TCliente): Boolean;
begin
  Result := False;
end;

function TClienteRepository.Find: Integer;
begin
  Result := 0;
end;

function TClienteRepository.FindAll(CommadSQL: String;
  Entity: TCliente): TObjectList<TCliente>;
begin
  Result:= nil;
end;

end.
