unit uModel.uModel.Services.Exception.EServicePedidoDadosGeraisBusinessException;

interface

uses
  System.SysUtils;

type
  EServicePedidoDadosGeraisBusinessException = class(Exception)
  public
    constructor Create(const Msg: string); reintroduce;
  end;

implementation

{ EServicePedidoDadosGeraisBusinessException }

constructor EServicePedidoDadosGeraisBusinessException.Create(const Msg: string);
begin
  inherited Create('EServicePedidoDadosGeraisBusinessException: ' + Msg);
end;

end.
