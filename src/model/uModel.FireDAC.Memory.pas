unit uModel.FireDAC.Memory;

interface

uses
  System.Generics.Collections, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient, uModel.Abstraction,
  System.Json;

type
  TModelFireDACMemory = class(TInterfacedObject, IMemory)
  private
    FData: TFDMemTable;
    FRecNo: Integer;
    procedure AddFields(const StructureData: String);
    procedure AddDisplayFormat(const Fields: TJSONArray);
    function GetData(): TFDMemTable;
    procedure SetRecNo(const Value: Integer);
    function GetRecNo: Integer;
  public
    constructor Create(const StructureData: String);
    destructor Destroy(); override;

    procedure Open();

    property Data: TFDMemTable read GetData;
    property RecNo: Integer read GetRecNo write SetRecNo;
  end;

const
  IS_EMPTY_RECORDS = 0;

implementation

{ TModelFireDACMemory }

uses
  System.Classes, System.SysUtils;

procedure TModelFireDACMemory.AddDisplayFormat(const Fields: TJSONArray);
begin
  for var i := 0 to Fields.Count - 1 do
  begin
    var Field := Fields.Items[i] as TJSONObject;
    var FieldName: string;

    if not Field.TryGetValue<string>('name', FieldName) then
      Continue;

    var DataField := FData.FieldByName(FieldName);
    if Assigned(DataField) and (DataField is TNumericField) then
      begin
        var DisplayFormat: string;
        if Field.TryGetValue<string>('displayFormat', DisplayFormat) then
          TNumericField(DataField).DisplayFormat := DisplayFormat;
      end;
  end;
end;

procedure TModelFireDACMemory.AddFields(const StructureData: String);
begin
  FData.Close();
  FData.FieldDefs.Clear();

  var JSONObject := TJSONObject.ParseJSONValue(StructureData) as TJSONObject;
  try
    var Fields := JSONObject.GetValue<TJSONArray>('fields');

    if not Assigned(Fields) then
      raise Exception.Create('JSON inválido: "fields" não encontrado.');

    for var i := 0 to Fields.Count - 1 do
      begin
        var Field := Fields.Items[i] as TJSONObject;

        var FieldName := Field.GetValue<string>('name');
        var FieldType := Field.GetValue<TFieldType>('type');
        var FieldLength := Field.GetValue<Integer>('length', 0);

        FData.FieldDefs.Add(FieldName, FieldType, FieldLength);
      end;

    FData.CreateDataSet();

    AddDisplayFormat(Fields);

  finally
    JSONObject.Free;
  end;
end;

constructor TModelFireDACMemory.Create(const StructureData: String);
begin
  inherited Create();

  FData := TFDMemTable.Create(nil);

  AddFields(StructureData);
end;

destructor TModelFireDACMemory.Destroy();
begin
  FData.Close();
  FreeAndNil( FData );

  inherited Destroy();
end;

function TModelFireDACMemory.GetData: TFDMemTable;
begin
  Result := FData;
end;

function TModelFireDACMemory.GetRecNo: Integer;
begin
  Result := FRecNo;
end;

procedure TModelFireDACMemory.Open();
begin
  FData.Open();

  if FRecNo > IS_EMPTY_RECORDS then
    FData.RecNo := FRecNo
  else
    FData.First();
end;

procedure TModelFireDACMemory.SetRecNo(const Value: Integer);
begin
  FRecNo := Value;
end;

end.
