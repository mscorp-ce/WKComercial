unit uModel.uModel.Services.Exception.EServiceProdutoBusinessException;

interface

uses
  System.SysUtils;

type
  EServiceProdutoBusinessException = class(Exception)
  public
    constructor Create(const Msg: string); reintroduce;
  end;

implementation

{ EServiceProdutoBusinessException }

constructor EServiceProdutoBusinessException.Create(const Msg: string);
begin
  inherited Create('EServiceProdutoBusinessException: ' + Msg);
end;

end.
