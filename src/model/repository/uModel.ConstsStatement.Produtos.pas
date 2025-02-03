unit uModel.ConstsStatement.Produtos;

interface

const
  QUERY_PRODUTOS =
    'SELECT codigo, ' + sLineBreak +
    '       descricao, ' + sLineBreak +
    '       preco_venda' + sLineBreak +
    '  FROM produtos PRO ';

  QUERY_CLAUSE_WHERE_BY_CODIGO =
    ' WHERE codigo = :codigo ';

  QUERY_PRODUTOS_BY_CODIGO =
    QUERY_PRODUTOS + sLineBreak + QUERY_CLAUSE_WHERE_BY_CODIGO;

implementation

end.
