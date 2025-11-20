DROP DATABASE IF EXISTS metalflex;
CREATE DATABASE metalflex;
USE metalflex;


-- Tabela CLIENTE

CREATE TABLE cliente (
    id_cliente      INT AUTO_INCREMENT PRIMARY KEY,
    nome_razao      VARCHAR(100) NOT NULL,
    documento       VARCHAR(20)  NOT NULL,
    telefone        VARCHAR(20),
    email           VARCHAR(100)
);


-- Tabela ITEM

CREATE TABLE item (
    id_item         INT AUTO_INCREMENT PRIMARY KEY,
    codigo_item     VARCHAR(30) NOT NULL UNIQUE,
    descricao       VARCHAR(150) NOT NULL,
    unidade         VARCHAR(10) NOT NULL,
    saldo           DECIMAL(10,2) DEFAULT 0,
    localizacao     VARCHAR(50)
);


-- Tabela PEDIDO

CREATE TABLE pedido (
    id_pedido       INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT NOT NULL,
    numero_pedido   VARCHAR(30) NOT NULL UNIQUE,
    data_emissao    DATE NOT NULL,
    prazo_entrega   DATE,
    volume_total    DECIMAL(10,2),
    status_pedido   VARCHAR(20) NOT NULL,
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- Tabela ITEM_PEDIDO
-- (relaciona muitos-para-muitos Pedido x Item)

CREATE TABLE item_pedido (
    id_pedido               INT NOT NULL,
    id_item                 INT NOT NULL,
    quantidade_solicitada   DECIMAL(10,2) NOT NULL,
    preco_unitario          DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_item),
    CONSTRAINT fk_item_pedido_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_item_pedido_item
        FOREIGN KEY (id_item) REFERENCES item(id_item)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- Tabela ORDEM_PRODUCAO (OP)

CREATE TABLE ordem_producao (
    id_op               INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido           INT NULL,
    id_item             INT NOT NULL,
    numero_op           VARCHAR(30) NOT NULL UNIQUE,
    quantidade_planejada DECIMAL(10,2) NOT NULL,
    quantidade_produzida DECIMAL(10,2) DEFAULT 0,
    data_emissao        DATE NOT NULL,
    data_conclusao      DATE,
    status_op           VARCHAR(20) NOT NULL,
    CONSTRAINT fk_op_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_op_item
        FOREIGN KEY (id_item) REFERENCES item(id_item)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- Tabela LOTE

CREATE TABLE lote (
    id_lote         INT AUTO_INCREMENT PRIMARY KEY,
    id_op           INT NOT NULL,
    codigo_lote     VARCHAR(50) NOT NULL UNIQUE,
    data_fabricacao DATE NOT NULL,
    CONSTRAINT fk_lote_op
        FOREIGN KEY (id_op) REFERENCES ordem_producao(id_op)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- Tabela ETIQUETA

CREATE TABLE etiqueta (
    id_etiqueta INT AUTO_INCREMENT PRIMARY KEY,
    id_lote     INT NOT NULL,
    codigo_barra VARCHAR(100) NOT NULL UNIQUE,
    data_emissao DATETIME NOT NULL,
    CONSTRAINT fk_etiqueta_lote
        FOREIGN KEY (id_lote) REFERENCES lote(id_lote)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- Tabela REQUISICAO_MATERIAL

CREATE TABLE requisicao_material (
    id_requisicao       INT AUTO_INCREMENT PRIMARY KEY,
    id_op               INT NOT NULL,
    id_item             INT NOT NULL,
    quantidade_requisitada DECIMAL(10,2) NOT NULL,
    data_requisicao     DATETIME NOT NULL,
    CONSTRAINT fk_req_op
        FOREIGN KEY (id_op) REFERENCES ordem_producao(id_op)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_req_item
        FOREIGN KEY (id_item) REFERENCES item(id_item)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- Tabela COLABORADOR

CREATE TABLE colaborador (
    id_colaborador  INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    funcao          VARCHAR(50)
);


-- Tabela MAQUINA

CREATE TABLE maquina (
    id_maquina  INT AUTO_INCREMENT PRIMARY KEY,
    codigo      VARCHAR(30) NOT NULL UNIQUE,
    descricao   VARCHAR(100) NOT NULL
);


-- Tabela ETAPA_PROCESSO

CREATE TABLE etapa_processo (
    id_etapa    INT AUTO_INCREMENT PRIMARY KEY,
    descricao   VARCHAR(100) NOT NULL,
    sequencia   INT NOT NULL
);


-- Tabela APONTAMENTO

CREATE TABLE apontamento (
    id_apontamento      INT AUTO_INCREMENT PRIMARY KEY,
    id_op               INT NOT NULL,
    id_etapa            INT NOT NULL,
    id_colaborador      INT NOT NULL,
    id_maquina          INT NOT NULL,
    data_hora_inicio    DATETIME NOT NULL,
    data_hora_fim       DATETIME NOT NULL,
    quantidade_produzida DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_apont_op
        FOREIGN KEY (id_op) REFERENCES ordem_producao(id_op)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_apont_etapa
        FOREIGN KEY (id_etapa) REFERENCES etapa_processo(id_etapa)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_apont_colab
        FOREIGN KEY (id_colaborador) REFERENCES colaborador(id_colaborador)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_apont_maquina
        FOREIGN KEY (id_maquina) REFERENCES maquina(id_maquina)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
