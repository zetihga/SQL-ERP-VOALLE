Select c.contract_number 'N° Contrato',
       p.name 'Nome',
       CASE
           WHEN c.status = 1 THEN 'Normal'
           WHEN c.status = 2 THEN 'Demonstração'
           WHEN c.status = 3 THEN 'Cortesia'
           WHEN c.status = 4 THEN 'Cancelado'
           WHEN c.status = 5 THEN 'Suspenso'
           WHEN c.status = 6 THEN 'Bloqueio Financeiro'
           WHEN c.status = 7 THEN 'Bloqueio Administrativo'
           WHEN c.status = 9 THEN 'Encerrado'
        END AS 'Situação - Contrato',
       ce.description 'Tipo',
       p.id,
       ce.created 'Data Evento'
       from contract_events ce
join contracts c on ce.contract_id = c.id
join people p on c.client_id = p.id
join contract_event_types cet on ce.contract_event_type_id = cet.id
where cet.id = 41
and c.stage = 3