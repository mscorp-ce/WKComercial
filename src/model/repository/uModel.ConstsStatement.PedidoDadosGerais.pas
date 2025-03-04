unit uModel.ConstsStatement.PedidoDadosGerais;

interface

uses
  uModel.ConstsStatement.Repository.Commun;

const
  QUERY_PEDIDO_DADOS_GERAIS =
    '   SELECT PDG.data_emissao, ' + sLineBreak +
    '          PDG.numero_pedido, ' + sLineBreak +
    '          PDG.codigo_cliente, ' + sLineBreak +
    '          PDG.valor_total ' + sLineBreak +
    '     FROM pedidos_dados_gerais PDG ';

  QUERY_ORDER_BY_PEDIDO_DADOS_GERAIS =
    ' ORDER BY PDG.data_emissao,  ' + sLineBreak +
    '          PEP.numero_pedido ';

  QUERY_PEDIDO_DADOS_GERAIS_ORDER_BY = QUERY_PEDIDO_DADOS_GERAIS + sLineBreak + QUERY_ORDER_BY_PEDIDO_DADOS_GERAIS;

  QUERY_INSERT_PEDIDO_DADOS_GERAIS =
    'INSERT INTO pedidos_dados_gerais (data_emissao, codigo_cliente) ' + sLineBreak +
    'VALUES (:data_emissao, :codigo_cliente) ';

  QUERY_PEDIDO_DADOS_GERAIS_LAST_INSERT_ID =
    'SELECT LAST_INSERT_ID() AS numero_pedido ';

  QUERY_CLAUSE_WHERE_BY_NUMERO_PEDIDO = ' WHERE numero_pedido = :numero_pedido ';

  QUERY_PEDIDO_DADOS_GERAIS_BY_NUMERO_PEDIDO = QUERY_PEDIDO_DADOS_GERAIS + sLineBreak + QUERY_CLAUSE_WHERE_BY_NUMERO_PEDIDO;

  QUERY_DADOS_GERAIS_CLAUSE_WHERE_BY_NUMERO_PEDIDO = QUERY_PEDIDO_DADOS_GERAIS + sLineBreak + QUERY_CLAUSE_WHERE_BY_NUMERO_PEDIDO;

  QUERY_UPDATE_DADOS_GERAIS_BY_NUMERO_PEDIDO =
    'UPDATE pedidos_dados_gerais ' + sLineBreak +
    '   SET data_emissao = :data_emissao, ' + sLineBreak +
    '       codigo_cliente = :codigo_cliente' + sLineBreak +
    QUERY_CLAUSE_WHERE_BY_NUMERO_PEDIDO;

  QUERY_DELETE_DADOS_GERAIS_BY_NUMERO_PEDIDO_NUMERO_PEDIDO =
    'DELETE ' + sLineBreak +
    '  FROM pedidos_dados_gerais ' + sLineBreak +
    QUERY_CLAUSE_WHERE_BY_NUMERO_PEDIDO;

implementation

end.
