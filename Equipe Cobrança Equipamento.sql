select  c.contract_number 'N° Contrato',
         case
		 when ai.incident_status_id = 3 then 'Fechamento'
		 when ai.incident_status_id = 4 then 'Encerramento'
		 when ai.incident_status_id = 1 then 'Abertura'
		 when ai.incident_status_id = 2 then 'Andamento'
		 when ai.incident_status_id = 10 then 'Aguardando Retorno'
         when ai.incident_status_id = 11 then 'Cliente Ausente'
         when ai.incident_status_id = 0 then 'Cancelado'
		   END 'Status Solicitação',
       pa.title 'Patrimonio',
       ai.protocol,
       p.name 'Nome'
    from contracts c
join people p on c.client_id = p.id
left join patrimonies pa on c.id = pa.contract_id
join assignment_incidents ai on p.id = ai.client_id
JOIN assignments a ON ai.assignment_id = a.id
left join incident_types it on ai.incident_type_id = it.id
left join teams t on a.team_id = t.id
where -- it.id in (1493,1443,1444,1441,1442)
      t.id in (1015) -- 1092 1178
      and ai.incident_status_id not in (4,0)

select * from teams t
where t.title like '%Retira%'
