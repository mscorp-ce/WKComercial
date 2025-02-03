unit uModel.uModel.Services.Exception.EFireDACPedidoProdutoBusinessException;

interface

uses
  System.SysUtils;

type
  EFireDACPedidoProdutoBusinessException = class(Exception)
  public
    constructor Create(const Msg: string); reintroduce;
  end;

implementation

{ EFireDACPedidoProdutoBusinessException }

constructor EFireDACPedidoProdutoBusinessException.Create(const Msg: string);
begin
  inherited Create('EFireDACPedidoProdutoBusinessException: ' + Msg);
end;

end.
