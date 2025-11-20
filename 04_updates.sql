USE metalflex;

-- 1) Atualiza status de pedido após conclusão de OP
UPDATE pedido
SET status_pedido = 'EM_PRODUCAO'
WHERE numero_pedido = 'P2025-001';

-- 2) Atualiza quantidade produzida da OP-1001
UPDATE ordem_producao
SET quantidade_produzida = 40,
    status_op = 'CONCLUIDA',
    data_conclusao = '2025-11-15'
WHERE numero_op = 'OP-1001';

-- 3) Atualiza saldo do item associado à OP-1001 (entrada em estoque)
UPDATE item
SET saldo = saldo + 40
WHERE codigo_item = 'MOL-001';

-- 4) Corrige telefone de um cliente (extra, se quiser)
UPDATE cliente
SET telefone = '(54) 4002-8922'
WHERE nome_razao = 'Auto Peças Sul Ltda';
