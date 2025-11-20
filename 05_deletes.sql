USE metalflex;

-- 1) Apaga apontamentos de teste (exemplo com WHERE bem específico)
DELETE FROM apontamento
WHERE data_hora_inicio = '2025-11-16 08:00:00'
  AND quantidade_produzida = 15;

-- 2) Remove uma etiqueta específica (ex: etiqueta impressa com erro)
DELETE FROM etiqueta
WHERE codigo_barra = '7890000001002';

-- 3) Remove uma requisição de material lançada incorretamente
DELETE FROM requisicao_material
WHERE id_requisicao = 3;
