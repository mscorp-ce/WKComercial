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
    class function SwapPointByComma(const Valor: string): string;
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

class function TLibary.SwapPointByComma(const Valor: string): string;
var
  vText : PChar;
  Ret: String;
begin
  vText := PChar(Valor);
  Ret := '';

  while (vText^ <> #0) do
  begin
    if vText^ = '.' then
      Ret:= Ret + ','
    else Ret:= Ret + vText^;

    Inc(vText);
  end;

  Result:= Ret;
end;

end.



