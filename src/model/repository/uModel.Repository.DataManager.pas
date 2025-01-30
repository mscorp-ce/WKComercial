unit uModel.Repository.DataManager;

interface

uses
  uModel.Abstraction;

var
  DataManager: IDataManager;

implementation

uses
  uModel.Design.Factory.DataManagerFactory;

initialization
  DataManager:= TDataManagerFactory.GetDataManager();

finalization
  DataManager.Connection.Close();
end.

