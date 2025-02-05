unit uModel.ConstsStatement.PedidoProduto;

interface

uses
  uModel.ConstsStatement.Repository.Commun;

const
  QUERY_PEDIDO_DADOS_GERAIS =
    '   SELECT PDG.data_emissao, ' + sLineBreak +
    '          PEP.numero_pedido, ' + sLineBreak +
    '          PEP.autoincrem, ' + sLineBreak +
    '          PEP.codigo_produto, ' + sLineBreak +
    '          PRO.descricao AS nome_produto, ' + sLineBreak +
    '          PEP.quantidade, ' + sLineBreak +
    '          PEP.valor_unitario, ' + sLineBreak +
    '          PEP.valor_total ' + sLineBreak +
    '     FROM pedidos_produtos PEP ' + sLineBreak +
    '     JOIN produtos PRO ON PEP.codigo_produto = PRO.codigo ' + sLineBreak +
    '     JOIN pedidos_dados_gerais PDG ON PEP.numero_pedido = PDG.numero_pedido ';

  QUERY_PEDIDO_PRODUTOS =
    '   SELECT PEP.autoincrem, ' + sLineBreak +
    '          PEP.numero_pedido, ' + sLineBreak +
    '          PEP.codigo_produto, ' + sLineBreak +
    '          PRO.descricao AS nome_produto, ' + sLineBreak +
    '          PEP.quantidade, ' + sLineBreak +
    '          PEP.valor_unitario, ' + sLineBreak +
    '          PEP.valor_total ' + sLineBreak +
    '     FROM pedidos_produtos PEP ' + sLineBreak +
    '     JOIN produtos PRO ON PEP.codigo_produto = PRO.codigo ';

  QUERY_ORDER_BY_PEDIDO_PRODUTO =
    ' ORDER BY PEP.numero_pedido,  ' + sLineBreak +
    '          PEP.autoincrem ';

  QUERY_PEDIDO_PRODUTO_ORDER_BY = QUERY_PEDIDO_DADOS_GERAIS + sLineBreak + QUERY_ORDER_BY_PEDIDO_PRODUTO;

  QUERY_INSERT_PEDIDO_PRODUTO =
    'INSERT INTO pedidos_produtos (numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total) ' + sLineBreak +
    'VALUES (:numero_pedido, :codigo_produto, :quantidade, :valor_unitario, :valor_total) ';

  QUERY_INSERT_PEDIDO_PRODUTO_LAST_INSERT_ID =
    'SELECT LAST_INSERT_ID() AS autoincrem ';

  QUERY_CLAUSE_WHERE_BY_AUTOINCREM =
    ' WHERE autoincrem = :autoincrem ';

  QUERY_PEDIDO_PRODUTO_WHERE_CLAUSE_WHERE_BY_AUTOINCREM = QUERY_PEDIDO_PRODUTOS + sLineBreak + QUERY_CLAUSE_WHERE_BY_AUTOINCREM;

  QUERY_PEDIDO_PRODUTO_BY_NUMERO_PEDIDO = QUERY_PEDIDO_DADOS_GERAIS + sLineBreak + QUERY_CLAUSE_WHERE_BY_AUTOINCREM;

  QUERY_PEDIDO_PRODUTO_CLAUSE_WHERE_BY_NUMERO_PEDIDO = QUERY_PEDIDO_DADOS_GERAIS + sLineBreak + QUERY_CLAUSE_WHERE_BY_AUTOINCREM;

  QUERY_UPDATE_PEDIDO_PRODUTO_BY_AUTOINCREM =
    'UPDATE pedidos_produtos ' + sLineBreak +
    '   SET codigo_produto = :codigo_produto, ' + sLineBreak +
    '       quantidade = :quantidade, ' + sLineBreak +
    '       valor_unitario = :valor_unitario, ' + sLineBreak +
    '       valor_total = :valor_total ' + sLineBreak +
    QUERY_CLAUSE_WHERE_BY_AUTOINCREM;

  QUERY_DELETE_PEDIDO_PRODUTO_CLAUSE_WHERE_BY_AUTOINCREM =
    'DELETE ' + sLineBreak +
    '  FROM pedidos_produtos ' + sLineBreak +
    QUERY_CLAUSE_WHERE_BY_AUTOINCREM;

implementation

end.
