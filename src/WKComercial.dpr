program WKComercial;

uses
  Vcl.Forms,
  uView.PedidoVenda in 'view\uView.PedidoVenda.pas' {frmPedidoVenda},
  uModel.FireDACEngineException in 'model\uModel.FireDACEngineException.pas',
  uInfra.Libary in 'infra\uInfra.Libary.pas',
  uModel.Abstraction in 'model\uModel.Abstraction.pas',
  uModel.FireDAC.Memory in 'model\uModel.FireDAC.Memory.pas',
  uModel.FireDAC in 'model\uModel.FireDAC.pas',
  uModel.Repository.Statement in 'model\repository\uModel.Repository.Statement.pas',
  uModel.Design.Factory.DataManagerFactory in 'model\design\factory\uModel.Design.Factory.DataManagerFactory.pas',
  uModel.Design.Factory.StatementFactory in 'model\design\factory\uModel.Design.Factory.StatementFactory.pas',
  uModel.Repository.DataManager in 'model\repository\uModel.Repository.DataManager.pas',
  uModel.Entities.Cliente in 'model\entities\uModel.Entities.Cliente.pas',
  uModel.Entities.Produto in 'model\entities\uModel.Entities.Produto.pas',
  uModel.Entities.PedidoDadosGerais in 'model\entities\uModel.Entities.PedidoDadosGerais.pas',
  uModel.Entities.PedidoProduto in 'model\entities\uModel.Entities.PedidoProduto.pas',
  uView.Data.Definition.PedidoProduto in 'view\data\definition\uView.Data.Definition.PedidoProduto.pas',
  uModel.ConstsStatement.PedidoDadosGerais in 'model\repository\uModel.ConstsStatement.PedidoDadosGerais.pas',
  uModel.ConstsStatement.Repository.Commun in 'model\repository\uModel.ConstsStatement.Repository.Commun.pas',
  uModel.ConstsStatement.PedidoProduto in 'model\repository\uModel.ConstsStatement.PedidoProduto.pas',
  uModel.Repository.PedidoDadosGerais in 'model\repository\uModel.Repository.PedidoDadosGerais.pas',
  uModel.FireDAC.Transaction in 'model\uModel.FireDAC.Transaction.pas',
  uModel.Repository.PedidoProduto in 'model\repository\uModel.Repository.PedidoProduto.pas',
  uModel.FireDAC.CustomConnection in 'model\uModel.FireDAC.CustomConnection.pas',
  uView.FormConsult in 'view\consult\uView.FormConsult.pas' {frmConsult},
  uController.RootCliente in 'controller\uController.RootCliente.pas',
  uModel.Services.Cliente in 'model\services\uModel.Services.Cliente.pas',
  uModel.Repository.Cliente in 'model\repository\uModel.Repository.Cliente.pas',
  uModel.ConstsStatement.Clientes in 'model\repository\uModel.ConstsStatement.Clientes.pas',
  uView.FormCliente.Consulta in 'view\consult\uView.FormCliente.Consulta.pas' {frmFormClienteConsulta},
  uView.Data.Definition.Cliente in 'view\data\definition\uView.Data.Definition.Cliente.pas',
  uView.DataConverter.Cliente in 'view\uView.DataConverter.Cliente.pas',
  uView.DataConverter in 'view\uView.DataConverter.pas',
  uView.FormProduto.Consulta in 'view\consult\uView.FormProduto.Consulta.pas' {frmFormProdutoConsulta},
  uController.RootProduto in 'controller\uController.RootProduto.pas',
  uModel.Services.Produto in 'model\services\uModel.Services.Produto.pas',
  uModel.Repository.Produto in 'model\repository\uModel.Repository.Produto.pas',
  uModel.ConstsStatement.Produtos in 'model\repository\uModel.ConstsStatement.Produtos.pas',
  uView.Data.Definition.Produto in 'view\data\definition\uView.Data.Definition.Produto.pas',
  uView.DataConverter.Produto in 'view\uView.DataConverter.Produto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
  Application.Run;
end.
