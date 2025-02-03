unit uView.Data.Definition.Produto;

interface

type
  TDataDefinitionProduto = class
  public
    class function JSON(): String;
  end;

implementation

{ TDataDefinitionProduto }

class function TDataDefinitionProduto.JSON(): String;
begin
  Result := '{' +
             '"fields": [' +
             '  { "name": "codigo", "type": "ftInteger" },' +
             '  { "name": "descricao", "type": "ftWideString", "length": 255 },' +
             '  { "name": "preco_v", "type": "ftWideString", "length": 50 },' +
             '  { "name": "preco_venda", "type": "ftCurrency", "displayFormat": "#,##0.00" }' +
             ']' +
             '}';
end;

end.

