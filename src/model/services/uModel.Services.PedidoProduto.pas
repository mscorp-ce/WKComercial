unit uModel.Services.PedidoProduto;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.PedidoProduto,
  Data.DB, uModel.Entities.Produto;

type
  TPedidoProdutoService = class(TInterfacedObject, IService<TPedidoProduto>)
  private
    PedidoProdutoRepository: IRepository<TPedidoProduto>;
    ProdutoRepository: IRepository<TProduto>;
  public
    function Fields(): TStrings;
    function FindAll(): TObjectList<TPedidoProduto>; overload;
    function IsValid(Entity: TPedidoProduto; out MessageContext: String): Boolean;
    function Save(Entity: TPedidoProduto): Boolean;
    function Update(Entity: TPedidoProduto): Boolean; overload;
    function DeleteById(Entity: TPedidoProduto): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): TPedidoProduto;
    function CommandSQL(): string;
    function FindAll(CommandSQL: String): TObjectList<TPedidoProduto>; overload;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TPedidoProdutoService }

uses
  System.SysUtils, uModel.Repository.PedidoProduto, Vcl.Dialogs,
  uModel.uModel.Services.Exception.EFireDACPedidoProdutoBusinessException,
  uModel.Repository.Produto;

function TPedidoProdutoService.CommandSQL(): string;
begin
  Result := PedidoProdutoRepository.CommandSQL();
end;

constructor TPedidoProdutoService.Create();
begin
  inherited Create();

  PedidoProdutoRepository := TPedidoProdutoRepository.Create();
  ProdutoRepository := TProdutoRepository.Create();
end;

function TPedidoProdutoService.DeleteById(Entity: TPedidoProduto): Boolean;
begin
  Result := PedidoProdutoRepository.DeleteById(Entity);
end;

destructor TPedidoProdutoService.Destroy();
begin
  inherited Destroy();
end;

function TPedidoProdutoService.Fields(): TStrings;
var
  Items: TStrings;
begin
  Items := PedidoProdutoRepository.Fields;

  Result := Items;
end;

function TPedidoProdutoService.FindAll(): TObjectList<TPedidoProduto>;
begin
  Result:= PedidoProdutoRepository.FindAll();
end;

function TPedidoProdutoService.FindAll(CommandSQL: String): TObjectList<TPedidoProduto>;
begin
  Result := PedidoProdutoRepository.FindAll(CommandSQL);
end;

function TPedidoProdutoService.Find(): Integer;
begin
  Result:= PedidoProdutoRepository.Find();
end;

function TPedidoProdutoService.FindById(Id: Integer): TPedidoProduto;
begin
  Result := PedidoProdutoRepository.FindById(Id);
end;

function TPedidoProdutoService.IsValid(Entity: TPedidoProduto; out MessageContext: String): Boolean;
begin
  var Produto: TProduto;

  if Entity.Produto.Codigo = 0 then
    begin
      MessageContext:= 'Informe um produto válido.';
      raise EFireDACPedidoProdutoBusinessException.Create(MessageContext);
    end;

  Produto := ProdutoRepository.FindById(Entity.Produto.Codigo);
  try
    if not Assigned(Produto) then
      begin
        MessageContext:= 'Informe um produto válido.';
        raise EFireDACPedidoProdutoBusinessException.Create(MessageContext);
      end;

    if Produto.Codigo = 0 then
      begin
        MessageContext:= 'Informe um produto válido.';
        raise EFireDACPedidoProdutoBusinessException.Create(MessageContext);
      end;

    if Entity.Quantidade <= 0.01 then
      begin
        MessageContext:= 'Informe uma quantidade maior do que zero.';
        raise EFireDACPedidoProdutoBusinessException.Create(MessageContext);
      end;

    if Entity.ValorUnitario < Produto.PrecoVenda then
      begin
        MessageContext:= 'O valor unitário informado é menor do que o preço de venda cadastrado.';
        raise EFireDACPedidoProdutoBusinessException.Create(MessageContext);
      end;

    if Entity.ValorUnitario <= 0.00 then
      begin
        MessageContext:= 'Informe um preço de venda maior do que zero.';
        raise EFireDACPedidoProdutoBusinessException.Create(MessageContext);
      end;

  finally
    if Assigned(Produto) then
      FreeAndNil(Produto);
  end;

  Result := True;
end;

function TPedidoProdutoService.Save(Entity: TPedidoProduto): Boolean;
var
  MessageContext: String;
begin
  Result := False;

  if IsValid(Entity, MessageContext) then
    Result := PedidoProdutoRepository.Save(Entity)
  else ShowMessage(MessageContext);
end;

function TPedidoProdutoService.Update(Entity: TPedidoProduto): Boolean;
var
  MessageContext: String;
begin
  Result := False;

  if IsValid(Entity, MessageContext) then
    Result := PedidoProdutoRepository.Update(Entity)
  else ShowMessage(MessageContext);
end;

end.
