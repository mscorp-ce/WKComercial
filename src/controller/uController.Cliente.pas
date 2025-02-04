unit uController.Cliente;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Cliente;

type
  TControllerCliente = class(TInterfacedObject, IController<TCliente>)
  private
    ClienteService: IService<TCliente>;
  public
    function Fields(): TStrings;
    function CommandSQL(): String;
    function FindAll(): TObjectList<TCliente>; overload;

    function IsValid(Entity: TCliente; out MessageContext: String): Boolean;
    function Save(Entity: TCliente): Boolean;
    function Update(Entity: TCliente): Boolean;
    function DeleteById(Entity: TCliente): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): TCliente;
    function FindAll(CommandSQL: String): TObjectList<TCliente>; overload;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TControllerCliente }

uses
  uModel.Services.Cliente;

function TControllerCliente.CommandSQL(): string;
begin
  Result := ClienteService.CommandSQL();
end;

constructor TControllerCliente.Create();
begin
  inherited Create();

  ClienteService := TClienteService.Create();
end;

function TControllerCliente.DeleteById(Entity: TCliente): Boolean;
begin
  Result := ClienteService.DeleteById(Entity);
end;

destructor TControllerCliente.Destroy();
begin
  inherited Destroy();
end;

function TControllerCliente.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= ClienteService.Fields;

  Result:= Items;
end;

function TControllerCliente.Find(): Integer;
begin
  Result:= ClienteService.Find();
end;

function TControllerCliente.FindAll: TObjectList<TCliente>;
begin
  Result:= ClienteService.FindAll();
end;

function TControllerCliente.FindAll(CommandSQL: String): TObjectList<TCliente>;
begin
  Result:= ClienteService.FindAll(CommandSQL);
end;

function TControllerCliente.FindById(Id: Integer): TCliente;
begin
  Result:= ClienteService.FindById(Id);
end;

function TControllerCliente.IsValid(Entity: TCliente; out MessageContext: String): Boolean;
begin
  try
    Result := ClienteService.IsValid(Entity, MessageContext);
  except
    raise;
  end;
end;

function TControllerCliente.Save(Entity: TCliente): Boolean;
begin
  Result := ClienteService.Save(Entity);
end;

function TControllerCliente.Update(Entity: TCliente): Boolean;
begin
  Result:= ClienteService.Update(Entity);
end;

end.
