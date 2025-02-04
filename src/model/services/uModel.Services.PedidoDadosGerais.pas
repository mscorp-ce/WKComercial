unit uModel.Services.PedidoDadosGerais;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.PedidoDadosGerais,
  Data.DB, uModel.Entities.Cliente;

type
  TPedidoDadosGeraisService = class(TInterfacedObject, IDomain<TPedidoDadosGerais>)
  private
    FMemory: IMemory;
    PedidoDadosGeraisRepository: IRepository<TPedidoDadosGerais>;
    ClienteRepository: IRepository<TCliente>;
  public
    function Fields(): TStrings;
    function FindAll(): TObjectList<TPedidoDadosGerais>; overload;
    function IsValid(Entity: TPedidoDadosGerais; out MessageContext: String): Boolean; overload;
    function IsValid(Entity: TPedidoDadosGerais; const Memory: IMemory): Boolean; overload;
    function Save(Entity: TPedidoDadosGerais): Boolean;
    function Update(Entity: TPedidoDadosGerais): Boolean; overload;
    function DeleteById(Entity: TPedidoDadosGerais): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): TPedidoDadosGerais;
    function CommandSQL(): string;
    function FindAll(CommandSQL: String): TObjectList<TPedidoDadosGerais>; overload;

    constructor Create(Memory: IMemory); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TPedidoDadosGeraisService }

uses
  System.SysUtils, uModel.Repository.PedidoDadosGerais, uModel.uModel.Services.Exception.EServicePedidoDadosGeraisBusinessException,
  uModel.Repository.Cliente;

function TPedidoDadosGeraisService.CommandSQL(): string;
begin
  Result := PedidoDadosGeraisRepository.CommandSQL();
end;

constructor TPedidoDadosGeraisService.Create(Memory: IMemory);
begin
  inherited Create();

  FMemory := Memory;

  PedidoDadosGeraisRepository := TPedidoDadosGeraisRepository.Create();
  ClienteRepository := TClienteRepository.Create();
end;

function TPedidoDadosGeraisService.DeleteById(Entity: TPedidoDadosGerais): Boolean;
begin
  Result := PedidoDadosGeraisRepository.DeleteById(Entity);
end;

destructor TPedidoDadosGeraisService.Destroy();
begin
  inherited Destroy();
end;

function TPedidoDadosGeraisService.Fields(): TStrings;
var
  Items: TStrings;
begin
  Items := PedidoDadosGeraisRepository.Fields;

  Result := Items;
end;

function TPedidoDadosGeraisService.FindAll(): TObjectList<TPedidoDadosGerais>;
begin
  Result:= PedidoDadosGeraisRepository.FindAll();
end;

function TPedidoDadosGeraisService.FindAll(CommandSQL: String): TObjectList<TPedidoDadosGerais>;
begin
  Result := PedidoDadosGeraisRepository.FindAll(CommandSQL);
end;

function TPedidoDadosGeraisService.Find(): Integer;
begin
  Result:= PedidoDadosGeraisRepository.Find();
end;

function TPedidoDadosGeraisService.FindById(Id: Integer): TPedidoDadosGerais;
begin
  Result := PedidoDadosGeraisRepository.FindById(Id);
end;

function TPedidoDadosGeraisService.IsValid(Entity: TPedidoDadosGerais; const Memory: IMemory): Boolean;
begin
  if Memory.Data.IsEmpty() then
    begin
      raise EServicePedidoDadosGeraisBusinessException.Create('Informe os produtos.');
    end;

  if Entity.DataEmissao <= 0 then
    begin
      raise EServicePedidoDadosGeraisBusinessException.Create('Informe uma data de emissão válida.');
    end;

  if Entity.Cliente.Codigo = 0 then
    begin
      raise EServicePedidoDadosGeraisBusinessException.Create('Informe um cliente válido.');
    end;

  var Cliente: TCliente;

  Cliente := ClienteRepository.FindById(Entity.Cliente.Codigo);
  try
    if not Assigned(Cliente) then
      begin
        raise EServicePedidoDadosGeraisBusinessException.Create('Informe um cliente válido.');
      end;

    if Cliente.Codigo = 0 then
      begin
        raise EServicePedidoDadosGeraisBusinessException.Create('Informe um cliente válido.');
      end;

  finally
    if Assigned(Cliente) then
      FreeAndNil(Cliente);
  end;

  Result := True;
end;

function TPedidoDadosGeraisService.IsValid(Entity: TPedidoDadosGerais; out MessageContext: String): Boolean;
begin
  Result := False;
end;

function TPedidoDadosGeraisService.Save(Entity: TPedidoDadosGerais): Boolean;
begin
  if not IsValid(Entity, FMemory) then
    raise EServicePedidoDadosGeraisBusinessException.Create('Erro validar um Pedido Dados Gerais.');

  Result := PedidoDadosGeraisRepository.Save(Entity);

  if not Result then
    raise EServicePedidoDadosGeraisBusinessException.Create('Erro ao tentar salvar um Pedido Dados Gerais.');
end;

function TPedidoDadosGeraisService.Update(Entity: TPedidoDadosGerais): Boolean;
var
  MessageContext: String;
begin
  if not IsValid(Entity, FMemory) then
    raise EServicePedidoDadosGeraisBusinessException.Create(MessageContext);

  Result := PedidoDadosGeraisRepository.Update(Entity);

  if not Result then
    raise EServicePedidoDadosGeraisBusinessException.Create('Erro ao tentar alterar um Pedido Dados Gerais.');
end;

end.
