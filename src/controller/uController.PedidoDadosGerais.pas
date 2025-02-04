unit uController.PedidoDadosGerais;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.PedidoDadosGerais;

type
  TControllerPedidoDadosGerais = class(TInterfacedObject, IController<TPedidoDadosGerais>)
  private
    PedidoDadosGeraisService: IDomain<TPedidoDadosGerais>;
    FMemory: IMemory;
  public
    function Fields(): TStrings;
    function CommandSQL(): String;
    function FindAll(): TObjectList<TPedidoDadosGerais>; overload;

    function IsValid(Entity: TPedidoDadosGerais; out MessageContext: String): Boolean;
    function Save(Entity: TPedidoDadosGerais): Boolean;
    function Update(Entity: TPedidoDadosGerais): Boolean;
    function DeleteById(Entity: TPedidoDadosGerais): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): TPedidoDadosGerais;
    function FindAll(CommandSQL: String): TObjectList<TPedidoDadosGerais>; overload;

    constructor Create(const Memory: IMemory); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TControllerPedidoDadosGerais }

uses
  uModel.Services.PedidoDadosGerais;

{ TControllerPedidoDadosGerais }

function TControllerPedidoDadosGerais.CommandSQL(): string;
begin
  Result := PedidoDadosGeraisService.CommandSQL();
end;

constructor TControllerPedidoDadosGerais.Create(const Memory: IMemory);
begin
  inherited Create();

  FMemory := Memory;

  PedidoDadosGeraisService := TPedidoDadosGeraisService.Create(FMemory);
end;

function TControllerPedidoDadosGerais.DeleteById(Entity: TPedidoDadosGerais): Boolean;
begin
  Result := PedidoDadosGeraisService.DeleteById(Entity);
end;

destructor TControllerPedidoDadosGerais.Destroy();
begin
  inherited Destroy();
end;

function TControllerPedidoDadosGerais.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= PedidoDadosGeraisService.Fields;

  Result:= Items;
end;

function TControllerPedidoDadosGerais.Find(): Integer;
begin
  Result:= PedidoDadosGeraisService.Find();
end;

function TControllerPedidoDadosGerais.FindAll: TObjectList<TPedidoDadosGerais>;
begin
  Result:= PedidoDadosGeraisService.FindAll();
end;

function TControllerPedidoDadosGerais.FindAll(CommandSQL: String): TObjectList<TPedidoDadosGerais>;
begin
  Result:= PedidoDadosGeraisService.FindAll(CommandSQL);
end;

function TControllerPedidoDadosGerais.FindById(Id: Integer): TPedidoDadosGerais;
begin
  Result:= PedidoDadosGeraisService.FindById(Id);
end;

function TControllerPedidoDadosGerais.IsValid(Entity: TPedidoDadosGerais; out MessageContext: String): Boolean;
begin
  try
    Result := PedidoDadosGeraisService.IsValid(Entity, MessageContext);
  except
    raise;
  end;
end;

function TControllerPedidoDadosGerais.Save(Entity: TPedidoDadosGerais): Boolean;
begin
  try
    Result := PedidoDadosGeraisService.Save(Entity);
  except
    raise;
  end;
end;

function TControllerPedidoDadosGerais.Update(Entity: TPedidoDadosGerais): Boolean;
begin
  Result:= PedidoDadosGeraisService.Update(Entity);
end;

end.
