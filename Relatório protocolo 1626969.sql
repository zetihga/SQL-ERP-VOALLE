SELECT c.client_id 'Cod Cliente',
       c.contract_number 'N°Contrato',
       p.name 'Nome',
       p.cell_phone_1 'Celular',
       p.phone 'Telefone',
       p.street 'Rua',
       p.city 'Cidade',
       pt.title 'Equipamento',
       p.neighborhood 'Bairro',
       case
		when p.type_tx_id = 2 then 'PF'
		when p.type_tx_id = 1 then 'PJ'
        END 'Tipo',
    p.tx_id 'Documento',
       p.birth_date 'Data de Nascimento',
CASE
           WHEN c.status = 1 THEN 'Normal'
           WHEN c.status = 2 THEN 'Demonstração'
           WHEN c.status = 3 THEN 'Cortesia'
           WHEN c.status = 4 THEN 'Cancelado'
           WHEN c.status = 5 THEN 'Suspenso'
           WHEN c.status = 6 THEN 'Bloqueio Financeiro'
           WHEN c.status = 7 THEN 'Bloqueio Administrativo'
           WHEN c.status = 9 THEN 'Encerrado'
        END AS 'Status',
       CASE
           WHEN c.stage = 1 THEN 'Pré-Contrato'
           WHEN c.stage = 2 THEN 'Em Aprovação'
           WHEN c.stage = 3 THEN 'Aprovado'
           WHEN c.stage = 4 THEN 'Rejeitado'
           WHEN c.stage = 5 THEN 'Cancelado'
        END AS 'Situação',
c.collection_day 'Dia de Cobrança',
c.amount 'Valor do contrato atual',
pp.name 'Vendedor',
p.email 'E-mail',
c.beginning_date 'Data de Cadastro',
c.approval_date 'Data de Aprovação',
c.approval_date 'Data Ativação',
c.cancellation_date 'Data Cancelamento'
FROM contracts c
INNER JOIN people p ON p.id = c.client_id
LEFT JOIN patrimonies pt ON pt.contract_id = c.id
INNER JOIN people pp ON pp.id = c.seller_1_id
 -- LEFT JOIN financial_receivable_titles frt on c.id = frt.contract_id
WHERE c.`status` IN (1,2,3,4,5,6,7,9)
AND c.stage = 3
AND c.deleted = 0
AND p.type_tx_id = 1
ORDER BY c.contract_number;

