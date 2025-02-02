unit uModel.Services.Cliente;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Cliente,
  Data.DB;

type
  TClienteService = class(TInterfacedObject, IService<TCliente>)
  private
    ClienteRepository: IRepository<TCliente>;
  public
    function Fields(): TStrings;
    function FindAll(): TObjectList<TCliente>; overload;
    function IsValid(Entity: TCliente; out MessageContext: String): Boolean;
    function Save(Entity: TCliente): Boolean;
    function Update(Entity: TCliente): Boolean; overload;
    function DeleteById(Entity: TCliente): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): TCliente;
    function CommandSQL(): string;
    function FindAll(CommandSQL: String): TObjectList<TCliente>; overload;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TClienteService }

uses
  System.SysUtils, uModel.Repository.Cliente, Vcl.Dialogs;

function TClienteService.CommandSQL(): string;
begin
  Result := ClienteRepository.CommandSQL();
end;

constructor TClienteService.Create();
begin
  inherited Create();

  ClienteRepository:= TClienteRepository.Create();
end;

function TClienteService.DeleteById(Entity: TCliente): Boolean;
begin
  Result := ClienteRepository.DeleteById(Entity);
end;

destructor TClienteService.Destroy();
begin
  inherited Destroy();
end;

function TClienteService.Fields(): TStrings;
var
  Items: TStrings;
begin
  Items := ClienteRepository.Fields;

  Result := Items;
end;

function TClienteService.FindAll(): TObjectList<TCliente>;
begin
  Result:= ClienteRepository.FindAll();
end;

function TClienteService.FindAll(CommandSQL: String): TObjectList<TCliente>;
begin
  Result := ClienteRepository.FindAll(CommandSQL);
end;

function TClienteService.Find: Integer;
begin
  Result := 0;
end;

function TClienteService.FindById(Id: Integer): TCliente;
begin
  Result := ClienteRepository.FindById(Id);
end;

function TClienteService.IsValid(Entity: TCliente; out MessageContext: String): Boolean;
begin
  Result := False;

  if Length( Entity.Nome ) = 0 then
    begin
      MessageContext:= 'Nome do cliente não fornecido.';
      Exit();
    end;

  Result := True;
end;

function TClienteService.Save(Entity: TCliente): Boolean;
var
  MessageContext: String;
begin
  Result := False;

  if IsValid(Entity, MessageContext) then
    Result := ClienteRepository.Save(Entity)
  else ShowMessage(MessageContext);
end;

function TClienteService.Update(Entity: TCliente): Boolean;
var
  MessageContext: String;
begin
  Result := False;

  if IsValid(Entity, MessageContext) then
    Result := ClienteRepository.Update(Entity)
  else ShowMessage(MessageContext);
end;

end.
