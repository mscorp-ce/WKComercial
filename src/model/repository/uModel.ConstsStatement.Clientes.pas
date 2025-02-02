unit uModel.ConstsStatement.Clientes;

interface

const
  QUERY_CLIENTES =
    'SELECT codigo, ' + sLineBreak +
    '       nome, ' + sLineBreak +
    '       cidade, ' + sLineBreak +
    '       uf' + sLineBreak +
    '  FROM clientes CLI ';

  QUERY_CLAUSE_WHERE_BY_CODIGO =
    ' WHERE codigo = :codigo ';

  QUERY_CLIENTES_BY_CODIGO =
    QUERY_CLIENTES + sLineBreak + QUERY_CLAUSE_WHERE_BY_CODIGO;

implementation

end.
