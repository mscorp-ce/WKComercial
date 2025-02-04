unit uModel.uModel.Services.Exception.EFireDACPedidoDadosGeraisBusinessException;

interface

uses
  System.SysUtils;

type
  EFireDACPedidoDadosGeraisBusinessException = class(Exception)
  public
    constructor Create(const Msg: string); reintroduce;
  end;

implementation

{ EFireDACPedidoDadosGeraisBusinessException }

constructor EFireDACPedidoDadosGeraisBusinessException.Create(const Msg: string);
begin
  inherited Create('EFireDACPedidoDadosGeraisBusinessException: ' + Msg);
end;

end.
