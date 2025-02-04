unit uModel.Services.Produto;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Produto,
  Data.DB;

type
  TProdutoService = class(TInterfacedObject, IService<TProduto>)
  private
    ProdutoRepository: IRepository<TProduto>;
  public
    function Fields(): TStrings;
    function FindAll(): TObjectList<TProduto>; overload;
    function IsValid(Entity: TProduto; out MessageContext: String): Boolean;
    function Save(Entity: TProduto): Boolean;
    function Update(Entity: TProduto): Boolean; overload;
    function DeleteById(Entity: TProduto): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): TProduto;
    function CommandSQL(): string;
    function FindAll(CommandSQL: String): TObjectList<TProduto>; overload;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TProdutoService }

uses
  System.SysUtils, uModel.Repository.Produto, uModel.uModel.Services.Exception.EServiceProdutoBusinessException;

function TProdutoService.CommandSQL(): string;
begin
  Result := ProdutoRepository.CommandSQL();
end;

constructor TProdutoService.Create();
begin
  inherited Create();

  ProdutoRepository:= TProdutoRepository.Create();
end;

function TProdutoService.DeleteById(Entity: TProduto): Boolean;
begin
  Result := ProdutoRepository.DeleteById(Entity);
end;

destructor TProdutoService.Destroy();
begin
  inherited Destroy();
end;

function TProdutoService.Fields(): TStrings;
var
  Items: TStrings;
begin
  Items := ProdutoRepository.Fields;

  Result := Items;
end;

function TProdutoService.FindAll(): TObjectList<TProduto>;
begin
  Result:= ProdutoRepository.FindAll();
end;

function TProdutoService.FindAll(CommandSQL: String): TObjectList<TProduto>;
begin
  Result := ProdutoRepository.FindAll(CommandSQL);
end;

function TProdutoService.Find(): Integer;
begin
  Result := ProdutoRepository.Find();
end;

function TProdutoService.FindById(Id: Integer): TProduto;
begin
  Result := ProdutoRepository.FindById(Id);
end;

function TProdutoService.IsValid(Entity: TProduto; out MessageContext: String): Boolean;
begin
  Result := False;

  if Length( Entity.Descricao ) = 0 then
    begin
      MessageContext:= 'Descrição do Produto não fornecida.';
      Exit();
    end;

  if Entity.PrecoVenda <= 0.00 then
    begin
      MessageContext:= 'Informe um preço de venda maior do que zero.';
      Exit();
    end;

  Result := True;
end;

function TProdutoService.Save(Entity: TProduto): Boolean;
var
  MessageContext: String;
begin
  if not IsValid(Entity, MessageContext) then
    raise EServiceProdutoBusinessException.Create(MessageContext);

  Result := ProdutoRepository.Save(Entity);

  if not Result then
    raise EServiceProdutoBusinessException.Create('Erro ao tentar salvar o produto.');
end;

function TProdutoService.Update(Entity: TProduto): Boolean;
var
  MessageContext: String;
begin
  if not IsValid(Entity, MessageContext) then
    raise EServiceProdutoBusinessException.Create(MessageContext);

  Result := ProdutoRepository.Update(Entity);

  if not Result then
    raise EServiceProdutoBusinessException.Create('Erro ao tentar alterar um produto.');
end;

end.
