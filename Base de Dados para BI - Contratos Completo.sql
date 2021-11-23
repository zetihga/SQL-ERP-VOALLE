SELECT c.client_id 'Cod Cliente',
       c.contract_number 'N°Contrato',
       ct.title 'Tipo de Contrato',
       c.beginning_date 'Data Cadastro',
CASE
           WHEN c.automatic_blocking = true THEN 'Sim'
           WHEN c.automatic_blocking = false THEN 'Não'
        END AS 'Bloqueio Automático',
       c.approval_date 'Data Aprovação',
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
c.cancellation_date 'Data Cancelamento',
c.cancellation_motive 'Motivo de cancelamento',
pp.name 'Vendedor',
c.created 'Data da Venda',
c.amount 'Valor do contrato'
FROM contracts c
JOIN people p ON p.id = c.client_id
JOIN contract_types ct on c.contract_type_id = ct.id
left join people pp on pp.id = c.seller_1_id
left join person_use
where c.contract_number = 161102







SELECT c.client_id 'Cod Cliente',
       c.contract_number 'N°Contrato',
       ct.title 'Tipo de Contrato',
       c.beginning_date 'Data Cadastro',
CASE
           WHEN c.automatic_blocking = true THEN 'Sim'
           WHEN c.automatic_blocking = false THEN 'Não'
        END AS 'Bloqueio Automático',
       c.approval_date 'Data Aprovação',
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
c.cancellation_date 'Data Cancelamento',
c.cancellation_motive 'Motivo de cancelamento',
pp.name 'Vendedor',
c.created 'Data da Venda',
c.amount 'Valor do contrato',
ppp.name 'criado por'
FROM contracts c
JOIN people p ON p.id = c.client_id
JOIN contract_types ct on c.contract_type_id = ct.id
LEFT JOIN people pp on pp.id = c.seller_1_id
LEFT JOIN people ppp on ppp.id = c.created_by
