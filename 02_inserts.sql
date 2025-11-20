USE metalflex;

INSERT INTO cliente (nome_razao, documento, telefone, email) VALUES
('Auto Peças Sul Ltda',  '12345678000101', '(54) 3333-1111', 'compras@autop-sul.com'),
('Mecânica Bom Motor',   '98765432000155', '(54) 3222-2222', 'contato@bommotor.com'),
('Distribuidora Norte',  '45678912000177', '(54) 3555-3333', 'vendas@distnorte.com');

-- ITENS

INSERT INTO item (codigo_item, descricao, unidade, saldo, localizacao) VALUES
('MOL-001', 'Mola traseira leve', 'UN', 50, 'A01-01'),
('MOL-002', 'Mola dianteira leve', 'UN', 30, 'A01-02'),
('KIT-001', 'Kit suspensão completa', 'CJ', 10, 'B02-01');

-- PEDIDOS

INSERT INTO pedido (id_cliente, numero_pedido, data_emissao, prazo_entrega, volume_total, status_pedido) VALUES
(1, 'P2025-001', '2025-11-10', '2025-11-20', 80, 'ABERTO'),
(2, 'P2025-002', '2025-11-11', '2025-11-25', 40, 'ABERTO'),
(3, 'P2025-003', '2025-11-12', '2025-11-30', 20, 'ABERTO');


-- ITENS DOS PEDIDOS

INSERT INTO item_pedido (id_pedido, id_item, quantidade_solicitada, preco_unitario) VALUES
(1, 1, 40, 120.00),
(1, 2, 40, 130.00),
(2, 3, 20, 450.00),
(3, 1, 10, 120.00),
(3, 2, 10, 130.00);


-- ORDEM DE PRODUÇÃO

INSERT INTO ordem_producao (id_pedido, id_item, numero_op, quantidade_planejada,
                            quantidade_produzida, data_emissao, data_conclusao, status_op)
VALUES
(1, 1, 'OP-1001', 40,  0, '2025-11-13', NULL, 'EM_ABERTO'),
(1, 2, 'OP-1002', 40,  0, '2025-11-13', NULL, 'EM_ABERTO'),
(2, 3, 'OP-1003', 20,  0, '2025-11-14', NULL, 'PLANEJADA');


-- LOTES

INSERT INTO lote (id_op, codigo_lote, data_fabricacao) VALUES
(1, 'L-OP1001-01', '2025-11-15'),
(2, 'L-OP1002-01', '2025-11-15');


-- ETIQUETAS

INSERT INTO etiqueta (id_lote, codigo_barra, data_emissao) VALUES
(1, '7890000001001', '2025-11-15 08:00:00'),
(1, '7890000001002', '2025-11-15 08:05:00'),
(2, '7890000002001', '2025-11-15 09:00:00');


-- REQUISIÇÃO DE MATERIAL

INSERT INTO requisicao_material (id_op, id_item, quantidade_requisitada, data_requisicao) VALUES
(1, 1, 45, '2025-11-14 07:30:00'),
(2, 2, 45, '2025-11-14 07:40:00'),
(3, 3, 22, '2025-11-15 07:50:00');


-- COLABORADORES

INSERT INTO colaborador (nome, funcao) VALUES
('João Silva', 'Operador'),
('Maria Souza', 'Operador'),
('Carlos Lima', 'Inspetor Qualidade');


-- MÁQUINAS

INSERT INTO maquina (codigo, descricao) VALUES
('PR-01', 'Prensa hidráulica 01'),
('PR-02', 'Prensa hidráulica 02'),
('MQ-INSP', 'Bancada de inspeção');


-- ETAPAS DE PROCESSO

INSERT INTO etapa_processo (descricao, sequencia) VALUES
('Corte', 1),
('Conformação', 2),
('Tratamento térmico', 3),
('Inspeção final', 4);


-- APONTAMENTOS

INSERT INTO apontamento
(id_op, id_etapa, id_colaborador, id_maquina,
 data_hora_inicio, data_hora_fim, quantidade_produzida)
VALUES
(1, 1, 1, 1, '2025-11-15 08:00:00', '2025-11-15 10:00:00', 20),
(1, 2, 2, 2, '2025-11-15 10:10:00', '2025-11-15 12:00:00', 20),
(1, 4, 3, 3, '2025-11-15 13:00:00', '2025-11-15 14:00:00', 40),
(2, 1, 1, 1, '2025-11-16 08:00:00', '2025-11-16 10:00:00', 15);
