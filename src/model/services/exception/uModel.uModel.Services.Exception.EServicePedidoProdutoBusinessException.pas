unit uModel.uModel.Services.Exception.EServicePedidoProdutoBusinessException;

interface

uses
  System.SysUtils;

type
  EServicePedidoProdutoBusinessException = class(Exception)
  public
    constructor Create(const Msg: string); reintroduce;
  end;

implementation

{ EServicePedidoProdutoBusinessException }

constructor EServicePedidoProdutoBusinessException.Create(const Msg: string);
begin
  inherited Create('EServicePedidoProdutoBusinessException: ' + Msg);
end;

end.
