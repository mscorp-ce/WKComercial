unit uController.PedidoProduto;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.PedidoProduto;

type
  TControllerPedidoProduto = class(TInterfacedObject, IController<TPedidoProduto>)
  private
    PedidoProdutoService: IService<TPedidoProduto>;

  public
    function Fields(): TStrings;
    function CommandSQL(): String;
    function FindAll(): TObjectList<TPedidoProduto>; overload;

    function IsValid(Entity: TPedidoProduto; out MessageContext: String): Boolean;
    function Save(Entity: TPedidoProduto): Boolean;
    function Update(Entity: TPedidoProduto): Boolean;
    function DeleteById(Entity: TPedidoProduto): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): TPedidoProduto;
    function FindAll(CommandSQL: String): TObjectList<TPedidoProduto>; overload;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TControllerPedidoProduto }

uses
  uModel.Services.PedidoProduto;

{ TControllerPedidoProduto }

function TControllerPedidoProduto.CommandSQL(): string;
begin
  Result := PedidoProdutoService.CommandSQL();
end;

constructor TControllerPedidoProduto.Create();
begin
  inherited Create();

  PedidoProdutoService := TPedidoProdutoService.Create();
end;

function TControllerPedidoProduto.DeleteById(Entity: TPedidoProduto): Boolean;
begin
  Result := PedidoProdutoService.DeleteById(Entity);
end;

destructor TControllerPedidoProduto.Destroy();
begin
  inherited Destroy();
end;

function TControllerPedidoProduto.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= PedidoProdutoService.Fields;

  Result:= Items;
end;

function TControllerPedidoProduto.Find(): Integer;
begin
  Result:= PedidoProdutoService.Find();
end;

function TControllerPedidoProduto.FindAll: TObjectList<TPedidoProduto>;
begin
  Result:= PedidoProdutoService.FindAll();
end;

function TControllerPedidoProduto.FindAll(CommandSQL: String): TObjectList<TPedidoProduto>;
begin
  Result:= PedidoProdutoService.FindAll(CommandSQL);
end;

function TControllerPedidoProduto.FindById(Id: Integer): TPedidoProduto;
begin
  Result:= PedidoProdutoService.FindById(Id);
end;

function TControllerPedidoProduto.IsValid(Entity: TPedidoProduto; out MessageContext: String): Boolean;
begin
  try
    Result := PedidoProdutoService.IsValid(Entity, MessageContext);
  except
    raise;
  end;
end;

function TControllerPedidoProduto.Save(Entity: TPedidoProduto): Boolean;
begin
  Result := PedidoProdutoService.Save(Entity);
end;

function TControllerPedidoProduto.Update(Entity: TPedidoProduto): Boolean;
begin
  Result:= PedidoProdutoService.Update(Entity);
end;

end.
