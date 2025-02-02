unit uView.DataConverter.Cliente;

interface

uses
  System.Generics.Collections, Data.DB, uModel.Abstraction, uModel.Entities.Cliente,
  uView.DataConverter;

type
  TDataConverterCliente = class(TDataConverter<TCliente>)
  public
    procedure Populate(Source: TObjectList<TCliente>; Target: TDataSet); override;

    destructor Destroy(); override;
  end;

implementation

{ TDataConverterCliente }

destructor TDataConverterCliente.Destroy();
begin
  inherited Destroy();
end;

procedure TDataConverterCliente.Populate(Source: TObjectList<TCliente>;
  Target: TDataSet);
begin
  inherited;

  Target.FieldByName('codigo').ReadOnly := False;

  for var i := 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('codigo').AsInteger:= Source.Items[i].Codigo;
      Target.FieldByName('nome').AsString:= Source.Items[i].Nome;
      Target.FieldByName('cidade').AsString:= Source.Items[i].Cidade;
      Target.FieldByName('uf').AsString:= Source.Items[i].UF;
      Target.Post;
    end;

  Target.FieldByName('codigo').ReadOnly := True;
end;

end.
