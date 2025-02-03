unit uInfra.Libary;

interface

type
  TLibary = class
  private
    class function GetExeName: string; static;
  public
    class function GetINI(Session, Key: String): String;
    class function GetNameAppToINI: String;
    class function Iif(const Condicao: Boolean; Se, SeNao: Variant): Variant;
    class function SwapPointByComma(const Value: string): string;
    class function GetStrNumber(const Value: string): string;
  end;

implementation

{ TLibary }

uses
  Winapi.Windows, System.SysUtils, System.IniFiles;

class function TLibary.GetExeName(): string;
var
  Buffer: array[0..MAX_PATH] of Char;
begin
  if GetModuleFileName(0, Buffer, MAX_PATH) > 0 then
    Result := Buffer
  else
    Result := '';
end;

class function TLibary.GetNameAppToINI: String;
begin
  Result:= ChangeFileExt(GetExeName(), '.ini');
end;

class function TLibary.GetINI(Session, Key: String): String;
begin
  var Ini:= TIniFile.Create(GetNameAppToINI);

  try
    Result:= Ini.ReadString(Session, Key, '');
  finally
    FreeAndNil(Ini);
  end;
end;

class function TLibary.Iif(const Condicao: Boolean; Se, SeNao: Variant): Variant;
begin
  if Condicao then
    Result:= Se
  else Result := SeNao;
end;

class function TLibary.SwapPointByComma(const Value: string): string;
var
  LText : PChar;
  LResult: String;
begin
  LText := PChar(Value);
  LResult := '';

  while (LText^ <> #0) do
    begin
      if LText^ = '.' then
        LResult := LResult + ','
      else LResult := LResult+ LText^;

      Inc(LText);
    end;

  Result:= LResult;
end;

class function TLibary.GetStrNumber(const Value: string): string;
var
  LText : PChar;
  LResult: String;
begin
  LText := PChar(Value);
  LResult := '';

  while (LText^ <> #0) do
    begin
      if LText^ in ['0'..'9'] then
        LResult := LResult + LText^;

      Inc(LText);
    end;

  Result := LResult;
end;

end.



