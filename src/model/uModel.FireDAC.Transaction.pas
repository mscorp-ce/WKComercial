unit uModel.FireDAC.Transaction;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Option, uModel.Abstraction;

type
  TModelFireDACTransaction = class(TInterfacedObject, ITransaction)
  private
    FTransaction: TFDTransaction;
  public
    constructor Create(Connection: TFDConnection); reintroduce;
    destructor Destroy(); override;

    procedure StartTransaction();
    procedure Commit();
    procedure Rollback();
    procedure SetOptions(Isolation: TInsulationOptions);
  end;

implementation

{ TModelFireDACTransaction }

uses
  System.SysUtils;

constructor TModelFireDACTransaction.Create(Connection: TFDConnection);
begin
  inherited Create();

  FTransaction := TFDTransaction.Create(nil);
  FTransaction.Connection := Connection;
end;

destructor TModelFireDACTransaction.Destroy();
begin
  FreeAndNil(FTransaction);

  inherited Destroy();
end;

procedure TModelFireDACTransaction.StartTransaction();
begin
  FTransaction.StartTransaction;
end;

procedure TModelFireDACTransaction.Commit();
begin
  FTransaction.Commit();
end;

procedure TModelFireDACTransaction.Rollback();
begin
   FTransaction.Rollback();
end;

procedure TModelFireDACTransaction.SetOptions(Isolation: TInsulationOptions);
begin
  case Isolation of
    ioDirtyRead: FTransaction.Options.Isolation := xiDirtyRead;
    ioReadCommitted: FTransaction.Options.Isolation := xiReadCommitted;
    ioRepeatableRead: FTransaction.Options.Isolation := xiRepeatableRead;
    ioSerializable: FTransaction.Options.Isolation := xiSerializible
  else
    FTransaction.Options.Isolation := xiReadCommitted;
  end;
end;

end.
