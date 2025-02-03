unit uModel.Repository.Produto;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Produto,
  Data.DB;

type
  TProdutoRepository = class(TInterfacedObject, IRepository<TProduto>)
  private
    procedure SetStatement(Statement: IStatement; Entity: TProduto);
    procedure SetProperty(Statement: IStatement; Entity: TProduto);
    procedure PopulateListEntitie(var List: TObjectList<TProduto>; const Statement: IStatement);
  public
    function Fields(): TStrings;
    function Save(Entity: TProduto): Boolean;
    function Update(Entity: TProduto): Boolean; overload;
    function DeleteById(Entity: TProduto): Boolean;
    function FindById(Id: Integer): TProduto;
    function Find(): Integer;
    function CommandSQL(): string;
    function FindAll(): TObjectList<TProduto>; overload;
    function FindAll(CommadSQL: String): TObjectList<TProduto>; overload;
    function FindAll(CommadSQL: String; Entity: TProduto): TObjectList<TProduto>; overload;

    destructor Destroy; override;
  end;

implementation

{ TProdutoRepository }

uses
  System.SysUtils, FireDAC.Stan.Error, uModel.Design.Factory.StatementFactory, uModel.Design.Factory.DataManagerFactory, uModel.Repository.DataManager,
  uModel.FireDACEngineException, FireDAC.Stan.Param, uModel.ConstsStatement.Repository.Commun, uModel.ConstsStatement.Produtos;

function TProdutoRepository.CommandSQL(): string;
begin
  Result := QUERY_PRODUTOS;
end;

function TProdutoRepository.DeleteById(Entity: TProduto): Boolean;
begin
  Result := False;
end;

destructor TProdutoRepository.Destroy();
begin
  inherited Destroy;
end;

function TProdutoRepository.Fields(): TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEntity('produtos').GetFieldNames();

    Result:= Items;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TProdutoRepository.FindAll(CommadSQL: String): TObjectList<TProduto>;
var
  Statement: IStatement;
  List: TObjectList<TProduto>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TProduto>.Create();

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

procedure TProdutoRepository.PopulateListEntitie(var List: TObjectList<TProduto>; const Statement: IStatement);
var
  Produto: TProduto;
begin
  Statement.Query.First();
  while not Statement.Query.Eof do
    begin
      Produto:= TProduto.Create();

      SetProperty(Statement, Produto);

      List.Add(Produto);

      Statement.Query.Next();
    end;
end;

function TProdutoRepository.FindAll(): TObjectList<TProduto>;
var
  Statement: IStatement;
  List: TObjectList<TProduto>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TProduto>.Create();

    Statement.Query.SQL.Clear();
    Statement.SQL(QUERY_PRODUTOS).Open();

    PopulateListEntitie(List, Statement);

    Result:= List;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TProdutoRepository.FindById(Id: Integer): TProduto;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_PRODUTOS_BY_CODIGO);
    Statement.Query.Params.ParamByName('codigo').AsInteger:= Id;
    Statement.Query.Open();

    var Produto:= TProduto.Create();
    SetProperty(Statement, Produto);

    Result:= Produto;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TProdutoRepository.Save(Entity: TProduto): Boolean;
begin
  Result := False;
end;
procedure TProdutoRepository.SetProperty(Statement: IStatement;
  Entity: TProduto);
begin
  try
    Entity.Codigo := Statement.Query.FieldByName('codigo').AsInteger;
    Entity.Descricao   := Statement.Query.FieldByName('descricao').AsString;
    Entity.PrecoVenda := Statement.Query.FieldByName('preco_venda').AsCurrency;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TProdutoRepository.SetStatement(Statement: IStatement;
  Entity: TProduto);
begin
  try
    Statement.Query.Params.ParamByName('descricao').AsString := Entity.Descricao;
    Statement.Query.Params.ParamByName('preco_venda').AsCurrency := Entity.PrecoVenda;

  except
    on Error: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(Error));
  end;
end;

function TProdutoRepository.Update(Entity: TProduto): Boolean;
begin
  Result := False;
end;

function TProdutoRepository.Find: Integer;
begin
  Result := 0;
end;

function TProdutoRepository.FindAll(CommadSQL: String;
  Entity: TProduto): TObjectList<TProduto>;
begin
  Result:= nil;
end;

end.
