unit uModel.Repository.PedidoProduto;

interface

uses
  System.Classes, System.Generics.Collections, Data.DB, uModel.Abstraction, uModel.Entities.PedidoProduto;

type
  TPedidoProdutoRepository = class(TInterfacedObject, IRepository<TPedidoProduto>)
  private
    procedure SetStatement(Statement: IStatement; Entity: TPedidoProduto);
    procedure SetProperty(Statement: IStatement; Entity: TPedidoProduto);
    procedure PopulateListEntitie(var List: TObjectList<TPedidoProduto>; const Statement: IStatement);
    function Find(): Integer;
  public
    function Fields(): TStrings;
    function FindAll(CommandSQL: String): TObjectList<TPedidoProduto>; overload;
    function Save(Entity: TPedidoProduto): Boolean;
    function Update(Entity: TPedidoProduto): Boolean;
    function DeleteById(Entity: TPedidoProduto): Boolean;
    function FindById(Id: Integer): TPedidoProduto;
    function CommandSQL(): string;
    function FindAll(): TObjectList<TPedidoProduto>; overload;
  end;

implementation

uses
  System.SysUtils, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Comp.Client, uModel.Repository.DataManager, uModel.Design.Factory.StatementFactory,
  uModel.FireDACEngineException, uModel.ConstsStatement.PedidoProduto, uModel.ConstsStatement.Repository.Commun,
  uModel.FireDAC.Transaction;

{ TPedidoProdutoRepository }

function TPedidoProdutoRepository.CommandSQL(): string;
begin
  Result := QUERY_PEDIDO_PRODUTOS;
end;

function TPedidoProdutoRepository.DeleteById(Entity: TPedidoProduto): Boolean;
begin
  var Statement: IStatement;
  var Transaction: ITransaction<TFDCustomConnection>;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Transaction := TModelFireDACTransaction<TFDCustomConnection>.Create(DataManager.Connection);
    Transaction.StartTransaction();

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_DELETE_PEDIDO_PRODUTO_CLAUSE_WHERE_BY_AUTOINCREM);
    Statement.Query.Params.ParamByName('autoincrem').AsInteger:= Entity.AutoIncrem;
    Statement.Query.ExecSQL();

    Transaction.Commit();

    Result:=  Statement.Query.RowsAffected = ROWS_AFFECTED;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TPedidoProdutoRepository.Fields: TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEntity('pedidos_produtos').GetFieldNames;

    Result:= Items;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TPedidoProdutoRepository.FindAll(CommandSQL: String): TObjectList<TPedidoProduto>;
var
  Statement: IStatement;
  List: TObjectList<TPedidoProduto>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TPedidoProduto>.Create();

    Statement.Query.SQL.Clear();
    Statement.SQL(CommandSQL).Open();

    PopulateListEntitie(List, Statement);

    Result:= List;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TPedidoProdutoRepository.Find(): Integer;
begin
  var Statement: IStatement;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_INSERT_PEDIDO_PRODUTO_LAST_INSERT_ID);
    Statement.Query.Open();

    Result:= Statement.Query.FieldByName('autoincrem').AsInteger;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TPedidoProdutoRepository.FindAll: TObjectList<TPedidoProduto>;
var
  Statement: IStatement;
  List: TObjectList<TPedidoProduto>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TPedidoProduto>.Create;

    Statement.Query.SQL.Clear();
    Statement.SQL(QUERY_PEDIDO_PRODUTOS).Open();

    PopulateListEntitie(List, Statement);

    Result:= List;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TPedidoProdutoRepository.FindById(Id: Integer): TPedidoProduto;
begin
  var Statement: IStatement;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_PEDIDO_PRODUTO_WHERE_CLAUSE_WHERE_BY_AUTOINCREM);
    Statement.Query.Params.ParamByName('autoincrem').AsInteger:= Id;
    Statement.Query.Open();

    var PedidoProduto := TPedidoProduto.Create();
    SetProperty(Statement, PedidoProduto);

    Result:= PedidoProduto;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TPedidoProdutoRepository.PopulateListEntitie(var List: TObjectList<TPedidoProduto>; const Statement: IStatement);
var
  PedidoProduto: TPedidoProduto;
begin
  Statement.Query.First();

  while not Statement.Query.Eof do
    begin
      PedidoProduto := TPedidoProduto.Create();

      SetProperty(Statement, PedidoProduto);

      List.Add(PedidoProduto);
      Statement.Query.Next();
    end;
end;

function TPedidoProdutoRepository.Save(Entity: TPedidoProduto): Boolean;
begin
  var Statement: IStatement;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_INSERT_PEDIDO_PRODUTO);
    SetStatement(Statement, Entity);
    Statement.Query.ExecSQL();

    var RowsAffected := Statement.Query.RowsAffected = ROWS_AFFECTED;

    Entity.AutoIncrem := Find();

    Result:= RowsAffected;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TPedidoProdutoRepository.SetProperty(Statement: IStatement; Entity: TPedidoProduto);
begin
  try
    Entity.AutoIncrem     := Statement.Query.FieldByName('autoincrem').AsInteger;
    Entity.NumeroPedido   := Statement.Query.FieldByName('numero_pedido').AsInteger;
    Entity.Produto.Codigo := Statement.Query.FieldByName('codigo_produto').AsInteger;
    Entity.Produto.Descricao:= Statement.Query.FieldByName('nome_produto').AsString;
    Entity.Quantidade     := Statement.Query.FieldByName('quantidade').AsCurrency;
    Entity.ValorUnitario  := Statement.Query.FieldByName('valor_unitario').AsCurrency;
    Entity.ValorTotal     := Statement.Query.FieldByName('valor_total').AsCurrency;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TPedidoProdutoRepository.SetStatement(Statement: IStatement; Entity: TPedidoProduto);
begin
  try
    Statement.Query.Params.ParamByName('numero_pedido').AsInteger   := Entity.NumeroPedido;
    Statement.Query.Params.ParamByName('codigo_produto').AsInteger  := Entity.Produto.Codigo;
    Statement.Query.Params.ParamByName('quantidade').AsCurrency     := Entity.Quantidade;
    Statement.Query.Params.ParamByName('valor_unitario').AsCurrency := Entity.ValorUnitario;
    Statement.Query.Params.ParamByName('valor_total').AsCurrency    := Entity.ValorTotal;

  except
    on Error: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(Error));
  end;
end;

function TPedidoProdutoRepository.Update(Entity: TPedidoProduto): Boolean;
begin
  var Statement: IStatement;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_UPDATE_PEDIDO_PRODUTO_BY_AUTOINCREM);
    Statement.Query.Params.ParamByName('autoincrem').AsInteger:= Entity.AutoIncrem;
    SetStatement(Statement, Entity);
    Statement.Query.ExecSQL();

    Result:= Statement.Query.RowsAffected = ROWS_AFFECTED;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

end.
