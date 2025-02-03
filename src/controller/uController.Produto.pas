unit uController.Produto;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Produto;

type
  TControllerProduto = class(TInterfacedObject, IController<TProduto>)
  private
    ProdutoService: IService<TProduto>;

  public
    function Fields(): TStrings;
    function CommandSQL(): String;
    function FindAll(): TObjectList<TProduto>; overload;

    function IsValid(Entity: TProduto; out MessageContext: String): Boolean;
    function Save(Entity: TProduto): Boolean;
    function Update(Entity: TProduto): Boolean;
    function DeleteById(Entity: TProduto): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): TProduto;
    function FindAll(CommandSQL: String): TObjectList<TProduto>; overload;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TControllerProduto }

uses
  uModel.Services.Produto;

function TControllerProduto.CommandSQL(): string;
begin
  Result := ProdutoService.CommandSQL();
end;

constructor TControllerProduto.Create();
begin
  inherited Create();

  ProdutoService := TProdutoService.Create();
end;

function TControllerProduto.DeleteById(Entity: TProduto): Boolean;
begin
  Result := ProdutoService.DeleteById(Entity);
end;

destructor TControllerProduto.Destroy();
begin
  inherited Destroy();
end;

function TControllerProduto.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= ProdutoService.Fields;

  Result:= Items;
end;

function TControllerProduto.Find(): Integer;
begin
  Result:= ProdutoService.Find();
end;

function TControllerProduto.FindAll: TObjectList<TProduto>;
begin
  Result:= ProdutoService.FindAll();
end;

function TControllerProduto.FindAll(CommandSQL: String): TObjectList<TProduto>;
begin
  Result:= ProdutoService.FindAll(CommandSQL);
end;

function TControllerProduto.FindById(Id: Integer): TProduto;
begin
  Result:= ProdutoService.FindById(Id);
end;

function TControllerProduto.IsValid(Entity: TProduto; out MessageContext: String): Boolean;
begin
  try
    Result := ProdutoService.IsValid(Entity, MessageContext);
  except
    raise;
  end;
end;

function TControllerProduto.Save(Entity: TProduto): Boolean;
begin
  Result := ProdutoService.Save(Entity);
end;

function TControllerProduto.Update(Entity: TProduto): Boolean;
begin
  Result:= ProdutoService.Update(Entity);
end;

end.
