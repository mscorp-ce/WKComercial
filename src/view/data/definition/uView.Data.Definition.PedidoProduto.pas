unit uView.Data.Definition.PedidoProduto;

interface

type
  TDataDefinitionPedidoProduto = class
  public
    class function JSON(): String;
  end;

implementation

{ TDataDefinitionPedidoProduto }

uses
  Data.DB;

class function TDataDefinitionPedidoProduto.JSON(): String;
begin
  Result := '{' +
             '"fields": [' +
             '  { "name": "numero_pedido", "type": "ftInteger" },' +
             '  { "name": "autoincrem", "type": "ftInteger" },' +
             '  { "name": "codigo_produto", "type": "ftInteger" },' +
             '  { "name": "nome_produto", "type": "ftWideString", "length": 255 },' +
             '  { "name": "quantidade", "type": "ftCurrency", "displayFormat": "#,##0.00" },' +
             '  { "name": "valor_unitario", "type": "ftCurrency", "displayFormat": "R$ #,##0.00" },' +
             '  { "name": "valor_total", "type": "ftCurrency", "displayFormat": "R$ #,##0.00" }' +
             ']' +
             '}';
end;

end.
