unit uModel.Repository.PedidoDadosGerais;

interface

uses
  System.Classes, System.Generics.Collections, Data.DB, uModel.Abstraction, uModel.Entities.PedidoDadosGerais;

type
  TPedidoDadosGeraisRepository = class(TInterfacedObject, IRepository<TPedidoDadosGerais>)
  private
    procedure SetStatement(Statement: IStatement; Entity: TPedidoDadosGerais);
    procedure SetProperty(Statement: IStatement; Entity: TPedidoDadosGerais);
    procedure PopulateListEntitie(var List: TObjectList<TPedidoDadosGerais>; const Statement: IStatement);
    function Find(): Integer;
  public
    function Fields(): TStrings;
    function FindAll(CommandSQL: String): TObjectList<TPedidoDadosGerais>; overload;
    function Save(Entity: TPedidoDadosGerais): Boolean;
    function Update(Entity: TPedidoDadosGerais): Boolean;
    function DeleteById(Entity: TPedidoDadosGerais): Boolean;
    function FindById(Id: Integer): TPedidoDadosGerais;
    function CommandSQL(): String;
    function FindAll(): TObjectList<TPedidoDadosGerais>; overload;
  end;

implementation

uses
  System.SysUtils, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Comp.Client, uModel.Repository.DataManager,
  uModel.Design.Factory.StatementFactory, uModel.FireDACEngineException, uModel.ConstsStatement.PedidoDadosGerais,
  uModel.ConstsStatement.Repository.Commun, uModel.FireDAC.Transaction, uModel.Repository.PedidoProduto, uModel.Entities.PedidoProduto;

{ TPedidoDadosGeraisRepository }

function TPedidoDadosGeraisRepository.CommandSQL(): String;
begin
  Result := QUERY_PEDIDO_DADOS_GERAIS;
end;

function TPedidoDadosGeraisRepository.DeleteById(Entity: TPedidoDadosGerais): Boolean;
begin
  var Statement: IStatement;
  var Transaction: ITransaction<TFDCustomConnection>;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Transaction := TModelFireDACTransaction<TFDCustomConnection>.Create(DataManager.Connection);
    Transaction.StartTransaction();

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_DELETE_DADOS_GERAIS_BY_NUMERO_PEDIDO_NUMERO_PEDIDO);
    Statement.Query.Params.ParamByName('numero_pedido').AsInteger:= Entity.NumeroPedido;
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

function TPedidoDadosGeraisRepository.Fields: TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEntity('pedidos_dados_gerais').GetFieldNames;

    Result:= Items;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TPedidoDadosGeraisRepository.FindAll(CommandSQL: String): TObjectList<TPedidoDadosGerais>;
var
  Statement: IStatement;
  List: TObjectList<TPedidoDadosGerais>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TPedidoDadosGerais>.Create();

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

function TPedidoDadosGeraisRepository.FindAll: TObjectList<TPedidoDadosGerais>;
var
  Statement: IStatement;
  List: TObjectList<TPedidoDadosGerais>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TPedidoDadosGerais>.Create;

    Statement.Query.SQL.Clear();
    Statement.SQL(QUERY_PEDIDO_DADOS_GERAIS).Open();

    PopulateListEntitie(List, Statement);

    Result:= List;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TPedidoDadosGeraisRepository.Find(): Integer;
begin
  var Statement: IStatement;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_PEDIDO_DADOS_GERAIS_LAST_INSERT_ID);
    Statement.Query.Open();

    Result:= Statement.Query.FieldByName('numero_pedido').AsInteger;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TPedidoDadosGeraisRepository.FindById(Id: Integer): TPedidoDadosGerais;
begin
  var Statement: IStatement;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_DADOS_GERAIS_CLAUSE_WHERE_BY_NUMERO_PEDIDO);
    Statement.Query.Params.ParamByName('numero_pedido').AsInteger:= Id;
    Statement.Query.Open();

    var PedidoDadosGerais := TPedidoDadosGerais.Create();
    SetProperty(Statement, PedidoDadosGerais);

    var PedidoProdutoRepository: IRepositoryDetails<TPedidoProduto>;

    PedidoProdutoRepository := TPedidoProdutoRepository.Create();

    var List := PedidoProdutoRepository.FindAll(Id);
    try
      for var Pedido in List do
        begin
          var NovoPedidoProduto := TPedidoProduto.Create();

          NovoPedidoProduto.AutoIncrem := Pedido.AutoIncrem;
          NovoPedidoProduto.NumeroPedido := Pedido.NumeroPedido;
          NovoPedidoProduto.Produto.Codigo := Pedido.Produto.Codigo;
          NovoPedidoProduto.Produto.Descricao := Pedido.Produto.Descricao;
          NovoPedidoProduto.Quantidade := Pedido.Quantidade;
          NovoPedidoProduto.ValorUnitario := Pedido.ValorUnitario;
          NovoPedidoProduto.ValorTotal := Pedido.ValorTotal;

          PedidoDadosGerais.Produtos.Add(NovoPedidoProduto);
        end;

    finally
      FreeAndNil(List);
    end;

    Result:= PedidoDadosGerais;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TPedidoDadosGeraisRepository.PopulateListEntitie(var List: TObjectList<TPedidoDadosGerais>; const Statement: IStatement);
var
  PedidoDadosGerais: TPedidoDadosGerais;
begin
  Statement.Query.First();

  while not Statement.Query.Eof do
    begin
      PedidoDadosGerais := TPedidoDadosGerais.Create();

      SetProperty(Statement, PedidoDadosGerais);

      List.Add(PedidoDadosGerais);
      Statement.Query.Next();
    end;
end;

function TPedidoDadosGeraisRepository.Save(Entity: TPedidoDadosGerais): Boolean;
begin
  var Statement: IStatement;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_INSERT_PEDIDO_DADOS_GERAIS);
    SetStatement(Statement, Entity);
    Statement.Query.ExecSQL();

    var RowsAffected := Statement.Query.RowsAffected = ROWS_AFFECTED;

    Entity.NumeroPedido := Find();

    Result:= RowsAffected;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TPedidoDadosGeraisRepository.SetProperty(Statement: IStatement; Entity: TPedidoDadosGerais);
begin
  try
    Entity.NumeroPedido := Statement.Query.FieldByName('numero_pedido').AsInteger;
    Entity.DataEmissao := Statement.Query.FieldByName('data_emissao').AsDateTime;
    Entity.Cliente.Codigo := Statement.Query.FieldByName('codigo_cliente').AsInteger;
    Entity.ValorTotal := Statement.Query.FieldByName('valor_total').AsInteger;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TPedidoDadosGeraisRepository.SetStatement(Statement: IStatement; Entity: TPedidoDadosGerais);
begin
  try
    Statement.Query.Params.ParamByName('data_emissao').AsDateTime := Entity.DataEmissao;
    Statement.Query.Params.ParamByName('codigo_cliente').AsInteger := Entity.Cliente.Codigo;

  except
    on Error: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(Error));
  end;
end;

function TPedidoDadosGeraisRepository.Update(Entity: TPedidoDadosGerais): Boolean;
begin
  var Statement: IStatement;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_UPDATE_DADOS_GERAIS_BY_NUMERO_PEDIDO);
    Statement.Query.Params.ParamByName('numero_pedido').AsInteger:= Entity.NumeroPedido;
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
