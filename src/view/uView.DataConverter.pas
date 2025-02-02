unit uView.DataConverter;

interface

uses
  System.Generics.Collections, Data.DB, uModel.Abstraction;

type
  TDataConverter<T: class> = class(TInterfacedObject, IDataConverter<T>)
  public
    procedure Populate(Source: TObjectList<T>; Target: TDataSet); virtual;

    destructor Destroy(); override;
  end;

implementation

{ TDataConverter }

destructor TDataConverter<T>.Destroy();
begin
  inherited Destroy();
end;

procedure TDataConverter<T>.Populate(Source: TObjectList<T>;
  Target: TDataSet);
begin
  Target.Close();
  Target.Open();
end;

end.
