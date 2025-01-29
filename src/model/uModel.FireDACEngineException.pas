unit uModel.FireDACEngineException;

interface

uses
  FireDAC.Stan.Error;

type
  TFireDACEngineException = class
  public
    class function GetMessage(const Eroor: EFDDBEngineException): String;
  end;

implementation

{ TFireDACEngineException }

class function TFireDACEngineException.GetMessage(
  const Eroor: EFDDBEngineException): String;
begin
  case Eroor.Kind of
    ekOther: Result:= 'O erro n�o se enquadra em nenhuma das categorias previstas.';
    ekNoDataFound:
      Result:= 'Dados n�o encontrado. Uma solicita��o para uma quantidade espec�fica de dados foi solicitado, mas n�o foi encontrado.';
    ekTooManyRows:
      Result:= 'H� multiplas linhas para a opera��o, sendo o esperado uma �nica linha, rever o comando.';
    ekRecordLocked:
      Result:= 'Registro em uso bloqueado por outra conex�o, tente novamente.';
    ekUKViolated:
      Result:= 'J� existe uma registro com a mesma chave �nica na tabela, tente outra combina��o.';
    ekFKViolated:
      Result:= 'Tentativa de inserir um dado que n�o esta presente na tabela externa de relacionamento, tente um registro v�lido.';
    ekObjNotExists:
      Result:= 'Tentativa de opera��o com um objeto do banco de dados que n�o existe.';
    ekUserPwdInvalid, ekUserPwdExpired, ekUserPwdWillExpire:
      Result:= 'Login com usu�rio n�o autorizado.';
    ekCmdAborted:
      Result:= 'Comando encerrado inesperadamente, tente novamente ou chame o administrador.';
    ekServerGone:
      Result:= 'Servidor desconectado, n�o � poss�vel executar a opera��o.';
    ekServerOutput:
      Result:= Eroor.Message;
    ekArrExecMalfunc:
      Result:= Eroor.Message;
    ekInvalidParams:
      Result:= 'Parametros inv�lidos, tente nova combina��o de parametros.';
  end;
end;

end.


