unit uView.FormConsult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, uModel.Abstraction;

type
  TfrmConsult = class(TForm)
    pnlControl: TPanel;
    sbpFilter: TSpeedButton;
    spbAll: TSpeedButton;
    spbExit: TSpeedButton;
    dsConsult: TDataSource;
    grdConsul: TDBGrid;
    spbOK: TSpeedButton;
    procedure sbpFilterClick(Sender: TObject);
    procedure spbAllClick(Sender: TObject);
    procedure spbExitClick(Sender: TObject);
    procedure grdConsulCellClick(Column: TColumn);
    procedure spbOKClick(Sender: TObject);
    procedure grdConsulDblClick(Sender: TObject);
  private
    { Private declarations }
    FMemory: IMemory;
    FIdentification: String;
    FDescricao: String;
    FId: Integer;
    function ValidateDataSetHasRecords(const Menssage: String): Boolean;
    function ValidateDeletion(const Menssage: String): Boolean;
    procedure SetMemory(const Value: IMemory);
    procedure SetDescricao(const Value: String);
    procedure SetId(const Value: Integer);
  protected
    { Protected declarations }
    procedure Filter(); virtual; abstract;
    procedure All(); virtual; abstract;
    procedure Delete(); virtual;
    procedure Remove(); virtual; abstract;
    procedure Confirm(); virtual; abstract;

    property Memory: IMemory read FMemory write SetMemory;
  public
    { Public declarations }

    constructor Create(const Identification: String); reintroduce;

    property Id: Integer read FId write SetId;
    property Descricao: String read FDescricao write SetDescricao;
  end;

var
  frmConsult: TfrmConsult;

implementation

{$R *.dfm}

uses
  System.UITypes; //, uView.Consts.Commun;

function TfrmConsult.ValidateDataSetHasRecords(const Menssage: String): Boolean;
begin
  Result := False;

  if Memory.Data.IsEmpty() then
    begin
      ShowMessage(Menssage);
      Exit();
    end;

  Result := True;
end;

function TfrmConsult.ValidateDeletion(const Menssage: String): Boolean;
begin
  Result := ValidateDataSetHasRecords(Menssage);
end;

constructor TfrmConsult.Create(const Identification: String);
begin
  inherited Create(nil);

  FIdentification := Identification;
end;

procedure TfrmConsult.Delete();
const
  Msg = 'Você realmente deseja excluir o registro selecionado?';
begin
  inherited;

  if not ValidateDeletion('Não há registros a serem excluídos.') then
    Exit();

  if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      Remove();
    end;
end;

procedure TfrmConsult.grdConsulCellClick(Column: TColumn);
begin
  if dsConsult.DataSet.Active and not dsConsult.DataSet.IsEmpty then
  begin
    try
      var ColumnValue := dsConsult.DataSet.FieldByName(FIdentification).AsInteger;
      Memory.RecNo := ColumnValue;

    except
      on E: Exception do
        ShowMessage('Erro ao acessar o campo: ' + E.Message);
    end;
  end;
end;

procedure TfrmConsult.grdConsulDblClick(Sender: TObject);
begin
  Confirm();
end;

procedure TfrmConsult.sbpFilterClick(Sender: TObject);
begin
  Filter();
end;

procedure TfrmConsult.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TfrmConsult.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TfrmConsult.SetMemory(const Value: IMemory);
begin
  FMemory := Value;
end;

procedure TfrmConsult.spbExitClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmConsult.spbOKClick(Sender: TObject);
begin
  Confirm();
end;

procedure TfrmConsult.spbAllClick(Sender: TObject);
begin
  All();
end;

end.
