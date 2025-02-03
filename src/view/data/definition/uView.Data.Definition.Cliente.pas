unit uView.Data.Definition.Cliente;

interface

type
  TDataDefinitionCliente = class
  public
    class function JSON(): String;
  end;

implementation

{ TDataDefinitionCliente }

class function TDataDefinitionCliente.JSON(): String;
begin
  Result := '{' +
             '"fields": [' +
             '  { "name": "codigo", "type": "ftInteger" },' +
             '  { "name": "nome", "type": "ftWideString", "length": 255 },' +
             '  { "name": "cidade", "type": "ftWideString", "length": 50 },' +
             '  { "name": "uf", "type": "ftString", "length": 2 }' +
             ']' +
             '}';
end;

end.

