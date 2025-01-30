CREATE DATABASE wkcomercial 
DEFAULT CHARACTER SET utf8mb4 
DEFAULT COLLATE utf8mb4_general_ci; 

USE wkcomercial;

CREATE USER 'development'@'localhost' IDENTIFIED BY 'deV$933068';

GRANT ALL PRIVILEGES ON *.* TO 'development'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'development'@'localhost';

ALTER USER 'development'@'localhost' 
IDENTIFIED WITH mysql_native_password 
BY 'deV$933068';

SELECT user, host, plugin FROM mysql.user;

CREATE TABLE clientes( 
codigo INT NOT NULL AUTO_INCREMENT, 
nome VARCHAR(255), 
cidade VARCHAR(50), 
uf VARCHAR(2),
CONSTRAINT PRIMARY KEY pk_cli(codigo)
);

CREATE INDEX idx_clientes_nome ON clientes(nome);

INSERT INTO clientes(nome, cidade, uf) values('Mario Silva', 'Fortaleza', 'CE');
INSERT INTO clientes(nome, cidade, uf) values('Julia Isis Silva','Fortaleza', 'CE');
INSERT INTO clientes(nome, cidade, uf) VALUES('João Silva', 'Fortaleza', 'CE');
INSERT INTO clientes(nome, cidade, uf) VALUES('Maria Oliveira', 'São Paulo', 'SP');
INSERT INTO clientes(nome, cidade, uf) VALUES('Pedro Santos', 'Rio de Janeiro', 'RJ');
INSERT INTO clientes(nome, cidade, uf) VALUES('Ana Costa', 'Salvador', 'BA');
INSERT INTO clientes(nome, cidade, uf) VALUES('Lucas Lima', 'Belo Horizonte', 'MG');
INSERT INTO clientes(nome, cidade, uf) VALUES('Juliana Souza', 'Recife', 'PE');
INSERT INTO clientes(nome, cidade, uf) VALUES('Carlos Pereira', 'Curitiba', 'PR');
INSERT INTO clientes(nome, cidade, uf) VALUES('Fernanda Rocha', 'Porto Alegre', 'RS');
INSERT INTO clientes(nome, cidade, uf) VALUES('Rafael Mendes', 'Brasília', 'DF');
INSERT INTO clientes(nome, cidade, uf) VALUES('Patrícia Nunes', 'Belém', 'PA');
INSERT INTO clientes(nome, cidade, uf) VALUES('Tiago Almeida', 'Manaus', 'AM');
INSERT INTO clientes(nome, cidade, uf) VALUES('Mariana Ribeiro', 'Florianópolis', 'SC');
INSERT INTO clientes(nome, cidade, uf) VALUES('André Cardoso', 'Campo Grande', 'MS');
INSERT INTO clientes(nome, cidade, uf) VALUES('Aline Fernandes', 'João Pessoa', 'PB');
INSERT INTO clientes(nome, cidade, uf) VALUES('Ricardo Barros', 'Maceió', 'AL');
INSERT INTO clientes(nome, cidade, uf) VALUES('Isabela Vieira', 'Natal', 'RN');
INSERT INTO clientes(nome, cidade, uf) VALUES('Gabriel Farias', 'Aracaju', 'SE');
INSERT INTO clientes(nome, cidade, uf) VALUES('Larissa Gomes', 'Vitória', 'ES');
INSERT INTO clientes(nome, cidade, uf) VALUES('Eduardo Teixeira', 'Goiânia', 'GO');
INSERT INTO clientes(nome, cidade, uf) VALUES('Camila Batista', 'São Luís', 'MA');
INSERT INTO clientes(nome, cidade, uf) VALUES('Vinícius Monteiro', 'Teresina', 'PI');
INSERT INTO clientes(nome, cidade, uf) VALUES('Bruna Martins', 'Rio Branco', 'AC');
INSERT INTO clientes(nome, cidade, uf) VALUES('Diego Lopes', 'Macapá', 'AP');
INSERT INTO clientes(nome, cidade, uf) VALUES('Júlia Araújo', 'Boa Vista', 'RR');
INSERT INTO clientes(nome, cidade, uf) VALUES('Henrique Freitas', 'Palmas', 'TO');
INSERT INTO clientes(nome, cidade, uf) VALUES('Renata Duarte', 'Uberlândia', 'MG');
INSERT INTO clientes(nome, cidade, uf) VALUES('Fábio Castro', 'Campinas', 'SP');
INSERT INTO clientes(nome, cidade, uf) VALUES('Sabrina Pires', 'Niterói', 'RJ');
INSERT INTO clientes(nome, cidade, uf) VALUES('Gustavo Moura', 'Caxias do Sul', 'RS');
INSERT INTO clientes(nome, cidade, uf) VALUES('Letícia Carvalho', 'Sorocaba', 'SP');

CREATE TABLE produtos(
codigo INT NOT NULL AUTO_INCREMENT, 
descricao VARCHAR(255),
preco_venda DECIMAL(15,2),
CONSTRAINT PRIMARY KEY pk_prod(codigo)
);

CREATE INDEX idx_produtos_descricao ON produtos(descricao);

INSERT INTO produtos(descricao, preco_venda) VALUES('Arroz', 6.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Feijão', 5.50);
INSERT INTO produtos(descricao, preco_venda) VALUES('Açúcar', 4.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Farinha', 3.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Leite', 4.50);
INSERT INTO produtos(descricao, preco_venda) VALUES('Carne', 45.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Mamão', 3.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Melão', 2.50);
INSERT INTO produtos(descricao, preco_venda) VALUES('Goiaba', 3.80);
INSERT INTO produtos(descricao, preco_venda) VALUES('Frango', 15.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Refrigerante', 5.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Alho', 2.50);
INSERT INTO produtos(descricao, preco_venda) VALUES('Cebola', 2.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Pimentão', 1.60);
INSERT INTO produtos(descricao, preco_venda) VALUES('Tomate', 1.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Batata', 3.60);
INSERT INTO produtos(descricao, preco_venda) VALUES('Doce de Leite', 8.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Bombom', 1.12);
INSERT INTO produtos(descricao, preco_venda) VALUES('Cheiro Verde', 1.30);
INSERT INTO produtos(descricao, preco_venda) VALUES('Abóbora', 5.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Batata Doce', 6.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Macarrão', 3.50);
INSERT INTO produtos(descricao, preco_venda) VALUES('Manteiga', 12.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Queijo', 20.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Presunto', 18.50);
INSERT INTO produtos(descricao, preco_venda) VALUES('Óleo de Soja', 7.50);
INSERT INTO produtos(descricao, preco_venda) VALUES('Café', 12.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Chá', 4.80);
INSERT INTO produtos(descricao, preco_venda) VALUES('Biscoito', 2.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Sorvete', 15.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Pizza Congelada', 25.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Molho de Tomate', 3.90);
INSERT INTO produtos(descricao, preco_venda) VALUES('Laranja', 3.20);
INSERT INTO produtos(descricao, preco_venda) VALUES('Banana', 2.90);
INSERT INTO produtos(descricao, preco_venda) VALUES('Uva', 9.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Pão', 5.50);
INSERT INTO produtos(descricao, preco_venda) VALUES('Cereal', 10.00);
INSERT INTO produtos(descricao, preco_venda) VALUES('Iogurte', 6.50);
INSERT INTO produtos(descricao, preco_venda) VALUES('Água Mineral', 2.00);

CREATE TABLE pedidos_dados_gerais(
numero_pedido INT NOT NULL AUTO_INCREMENT,  
data_emissao DATE, 
codigo_cliente INT NOT NULL,
valor_total DECIMAL (15,2),
CONSTRAINT PRIMARY KEY pk_ped(numero_pedido),
CONSTRAINT FOREIGN KEY fk_cod_cli(codigo_cliente) REFERENCES clientes(codigo)
);

CREATE INDEX idx_pedidos_data_emissao ON pedidos_dados_gerais(data_emissao);

CREATE INDEX idx_pedidos_codigo_cliente ON pedidos_dados_gerais(codigo_cliente);

DELIMITER $$

CREATE TRIGGER trg_clientes_bd
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM pedidos_dados_gerais WHERE codigo_cliente = OLD.codigo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível excluir o cliente. Este cliente está associado a um pedido.';
    END IF;
END$$

DELIMITER ;

CREATE TABLE pedidos_produtos(
autoincrem INT NOT NULL AUTO_INCREMENT,   
numero_pedido INT NOT NULL, 
codigo_produto INT NOT NULL,
quantidade DECIMAL (15,2), 
valor_unitario DECIMAL(15,2),
valor_total DECIMAL (15,2), 
CONSTRAINT PRIMARY KEY pk_ped_prod(autoincrem),
CONSTRAINT FOREIGN KEY fk_ped_dad_ge(numero_pedido) REFERENCES pedidos_dados_gerais(numero_pedido) ON DELETE CASCADE,
CONSTRAINT FOREIGN KEY fk_cod_prod(codigo_produto) REFERENCES produtos(codigo)
);

CREATE INDEX idx_pedidos_produtos_numero_pedido ON pedidos_produtos(numero_pedido);

CREATE INDEX idx_pedidos_produtos_codigo_produto ON pedidos_produtos(codigo_produto);

CREATE INDEX idx_pedidos_produtos_pedido_produto ON pedidos_produtos(numero_pedido, codigo_produto);

DELIMITER $$

CREATE TRIGGER trg_produtos_bd
BEFORE DELETE ON produtos
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM pedidos_produtos WHERE codigo_produto = OLD.codigo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível excluir o produto. Este produto está associado a um pedido.';
    END IF;
END$$

DELIMITER ;


