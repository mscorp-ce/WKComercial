unit uView.DataConverter.Produto;

interface

uses
  System.Generics.Collections, Data.DB, uModel.Abstraction, uModel.Entities.Produto,
  uView.DataConverter;

type
  TDataConverterProduto = class(TDataConverter<TProduto>)
  public
    procedure Populate(Source: TObjectList<TProduto>; Target: TDataSet); override;

    destructor Destroy(); override;
  end;

implementation

{ TDataConverterProduto }

destructor TDataConverterProduto.Destroy();
begin
  inherited Destroy();
end;

procedure TDataConverterProduto.Populate(Source: TObjectList<TProduto>;
  Target: TDataSet);
begin
  inherited;

  Target.FieldByName('codigo').ReadOnly := False;

  for var i := 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('codigo').AsInteger       := Source.Items[i].Codigo;
      Target.FieldByName('descricao').AsString     := Source.Items[i].Descricao;
      Target.FieldByName('preco_venda').AsCurrency := Source.Items[i].PrecoVenda;
      Target.Post;
    end;

  Target.FieldByName('codigo').ReadOnly := True;
end;

end.
