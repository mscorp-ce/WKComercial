unit uModel.uModel.Services.Exception.EServiceClienteBusinessException;

interface

uses
  System.SysUtils;

type
  EServiceClienteBusinessException = class(Exception)
  public
    constructor Create(const Msg: string); reintroduce;
  end;

implementation

{ EServiceClienteBusinessException }

constructor EServiceClienteBusinessException.Create(const Msg: string);
begin
  inherited Create('EServiceClienteBusinessException: ' + Msg);
end;

end.
