USE metalflex;

-- 1) Lista pedidos com nome do cliente
SELECT
    p.id_pedido,
    p.numero_pedido,
    c.nome_razao AS cliente,
    p.data_emissao,
    p.prazo_entrega,
    p.status_pedido
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
ORDER BY p.data_emissao DESC;

-- 2) Itens de um pedido específico (JOIN + WHERE)
SELECT
    p.numero_pedido,
    i.codigo_item,
    i.descricao,
    ip.quantidade_solicitada,
    ip.preco_unitario,
    (ip.quantidade_solicitada * ip.preco_unitario) AS valor_total
FROM item_pedido ip
JOIN pedido p ON p.id_pedido = ip.id_pedido
JOIN item i   ON i.id_item   = ip.id_item
WHERE p.numero_pedido = 'P2025-001';

-- 3) Ordens de produção em aberto, com item e cliente
SELECT
    op.numero_op,
    i.codigo_item,
    i.descricao,
    c.nome_razao AS cliente,
    op.quantidade_planejada,
    op.quantidade_produzida,
    op.status_op
FROM ordem_producao op
JOIN item i      ON i.id_item = op.id_item
LEFT JOIN pedido p ON p.id_pedido = op.id_pedido
LEFT JOIN cliente c ON c.id_cliente = p.id_cliente
WHERE op.status_op <> 'CONCLUIDA'
ORDER BY op.data_emissao;

-- 4) Requisições de material por OP
SELECT
    op.numero_op,
    i.codigo_item,
    rm.quantidade_requisitada,
    rm.data_requisicao
FROM requisicao_material rm
JOIN ordem_producao op ON op.id_op = rm.id_op
JOIN item i            ON i.id_item = rm.id_item
WHERE op.numero_op = 'OP-1001'
ORDER BY rm.data_requisicao;

-- 5) Apontamentos por colaborador e máquina (JOIN + LIMIT)
SELECT
    a.id_apontamento,
    op.numero_op,
    e.descricao AS etapa,
    col.nome AS colaborador,
    m.codigo AS maquina,
    a.data_hora_inicio,
    a.data_hora_fim,
    a.quantidade_produzida
FROM apontamento a
JOIN ordem_producao op ON op.id_op = a.id_op
JOIN etapa_processo e ON e.id_etapa = a.id_etapa
JOIN colaborador col  ON col.id_colaborador = a.id_colaborador
JOIN maquina m        ON m.id_maquina = a.id_maquina
ORDER BY a.data_hora_inicio DESC
LIMIT 10;
