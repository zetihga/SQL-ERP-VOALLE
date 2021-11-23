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
ce.description 'Tipo do evento',
ce.contract_event_type_id,
ce.date'Data do Evento'
 -- pp.name 'Responsável pelo Evento'
FROM contracts c
JOIN people p ON p.id = c.client_id
JOIN contract_types ct on c.contract_type_id = ct.id
join contract_events ce on c.id = ce.contract_id
 -- join people pp on pp.id = ce.person_id
and c.contract_number = 01519
and ce.contract_event_type_id in (10,40,41,81,171,142,129)
 -- and ce.description like '%Situação alterada%'





select * from contract_events ce
where ce.contract_id = 09081


select c.contract_number from contracts c
where c.status = 9

