--APAGAR BANCO DE DADOS E USUARIO SE ELES JÁ EXISTIREM NO SISTEMA--
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS leonnardo;

--Criar usuário com senha e permissões--
CREATE USER 
leonnardo WITH
	  CREATEDB
	  CREATEROLE
	  ENCRYPTED PASSWORD '2307';

--Criar banco de dados 'uvv'
CREATE DATABASE uvv
	WITH OWNER = leonnardo
	TEMPLATE = template0
	ENCODING = UTF8
	LC_COLLATE = 'pt_BR.UTF-8'
	LC_CTYPE = 'pt_BR.UTF-8'
	ALLOW_CONNECTIONS = true
;
	
--Entrar no banco de dados 'uvv' com o usuario 'leonnardo'--
\c "dbname=uvv user=leonnardo password=2307"	

--Criar Schema 'lojas' e autorizar o usuario 'leonnardo'--
CREATE SCHEMA lojas AUTHORIZATION leonnardo;

--Alternar para o usuario 'leonnardo' para mudar o schema principal de public para lojas de forma permanente--
ALTER USER leonnardo WITH LOGIN;

--Tornar o schema lojas como padrão para o usuario--
SET SEARCH_PATH TO lojas, "$user", public;

--Criar a tabela produtos no schema lojas--
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

--Comentario na tabela produtos do schema lojas--
COMMENT ON TABLE lojas.produtos IS 'tabela produtos
';
--Comentário nas colunas da tabela produtos do schema lojas--
COMMENT ON COLUMN lojas.produtos.produto_id IS 'id do produto - pk da tabela produtos
';
COMMENT ON COLUMN lojas.produtos.nome IS 'nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'preco unitario do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'detalhes do produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'imagem mime type do produto';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'arquivo da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'imagem charset do produto';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'data da ultima atualizacao da imagem do produto';

--Criar tabela lojas no schema lojas--
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);
--Comentários na tabela lojas no schema lojas--
COMMENT ON TABLE lojas.lojas IS 'tabela das lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'id da loja - pk na tabela lojas
';
--Comentários nas colunas da tabela lojas no schema lojas--
COMMENT ON COLUMN lojas.lojas.nome IS 'nome da loja';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'endereco web da loja';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'endereco fisico da loja';
COMMENT ON COLUMN lojas.lojas.latitude IS 'latitude da loja';
COMMENT ON COLUMN lojas.lojas.longitude IS 'longitude da loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'logo mime type da loja';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'arquivo da logo da loja
';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'charset da logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'ultima atualizacao da logo da loja';

--Criar tabela estoques no schema lojas--
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
--Comentários na tabela estoques no schema lojas--
COMMENT ON TABLE lojas.estoques IS 'tabela dos estoques';
--Comentários nas colunas da tabela estoques no schema lojas--
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'id do estoque - pk na tabela estoques';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'id da loja - fk na tabela estoques
';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'id do produto - fk na tabela estoques

';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'quantidade do estoque';

--Criar tabela clientes no schema lojas--
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
--Comentários na tabela clientes no schema lojas--
COMMENT ON TABLE lojas.clientes IS 'Tabela clientes';
--Comentários nas colunas da tabela clientes no schema lojas--
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'id do cliente - pk na tabela clientes
';
COMMENT ON COLUMN lojas.clientes.email IS 'email do cliente';
COMMENT ON COLUMN lojas.clientes.nome IS 'nome do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'telefone 1 do cliente
';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'telefone 2 do cliente
';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'telefone 3 do cliente
';

--Criar tabela pedidos no schema lojas--
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
--Comentários na tabela pedidos no schema lojas--
COMMENT ON TABLE lojas.pedidos IS 'tabela pedidos';
--Comentários nas colunas da tabela pedidos no schema lojas--
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'id do pedido - pk na tabela pedidos
';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'data e hora do pedido';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'id do cliente - fk na tabela pedidos';
COMMENT ON COLUMN lojas.pedidos.status IS 'status do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'id da loja - fk na tabela pedidos';

--Criar tabela envios no schema lojas--
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
--Comentários na tabela envios no schema lojas--
COMMENT ON TABLE lojas.envios IS 'tabela envios';
--Comentários nas colunas da tabela envios no schema lojas--
COMMENT ON COLUMN lojas.envios.envio_id IS 'id do envio - pk na tabela envios';
COMMENT ON COLUMN lojas.envios.loja_id IS 'id da loja - fk na tabela envios
';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'id do cliente - fk na tabela envios
';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'endereco da entrega do envio';
COMMENT ON COLUMN lojas.envios.status IS 'status do envio';

--Criar tabela pedidos_itens no schema lojas--
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);
--Comentários na tabela pedidos_itens no schema lojas--
COMMENT ON TABLE lojas.pedidos_itens IS 'tabela dos itens dos pedidos';
--Comentários nas colunas da tabela pedidos_itens no schema lojas--
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'id dos pedidos - pfk da tabela pedidos_itens
';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'id dos produtos - pfk na tabela pedidos_itens
';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'numero da linha';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'preco unitario do item do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'quantidades do item do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'id do envio - fk na tabela pedidos_itens
';

--Foreign Keys das tabelas--
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)

--
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Restrições do preço_unitario--
ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_preco_unitario
CHECK(preco_unitario >= 0);

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_preco_unitario
CHECK(preco_unitario >= 0);

--Restrições da quantidade de itens--
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK(quantidade >= 0);

ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoque_quantidade
CHECK(quantidade >= 0);

--Restrições ao status_envios--
ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK (lojas.pedidos.status IN('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

--Restrições ao status_pedidos--
ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_status
CHECK (lojas.envios.status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

--Restrição ao endereco_web e endereco_fisico, onde pelo um dos dois tenha informação--
ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_endereco
CHECK (lojas.lojas.endereco_web IS NOT NULL OR lojas.lojas.endereco_fisico IS NOT NULL);
