select ppp.id 'Cod Cliente',
       c.contract_number 'N° Contrato',
       ppp.name 'Cliente',
       ai.protocol 'Protocolo',
       sp.title 'Problema',
       it.title 'Status',
	   t2.title 'Equipe',
	   atd.name 'Atendente Atual',
	   itt.title 'Tipo de Solicitação',
	   a.beginning_date 'Abertura',
	   a.conclusion_date 'Encerramento',
	   a.modified 'Última Interação',
       ppp.city 'Cidade',
         case
		 when ai.incident_status_id = 3 then 'Fechamento'
		 when ai.incident_status_id = 4 then 'Encerramento'
		 when ai.incident_status_id = 1 then 'Abertura'
		 when ai.incident_status_id = 2 then 'Andamento'
		 when ai.incident_status_id = 10 then 'Aguardando Retorno'
         when ai.incident_status_id = 11 then 'Cliente Ausente'
         when ai.incident_status_id = 0 then 'Cancelado'
		   END 'Status Solicitação'
    	from assignments a
left join people atd on atd.id = a.responsible_id
left join people clt on clt.id = a.requestor_id
left join assignment_incidents ai on a.id = ai.assignment_id
left join incident_status it on ai.incident_status_id = it.id
left join teams t2 on t2.id = ai.team_id
left join incident_types itt on itt.id = ai.incident_type_id
left join solicitation_problems sp on sp.id = ai.solicitation_problem_id
left join contract_service_tags etq on etq.id =ai.contract_service_tag_id
left join contracts c on c.id = etq.contract_id
left join people ppp on ppp.id = c.client_id
where itt.id in (1700,1473,1694,1487,1709)


select * from incident_types it
where it.title like '%Relacionamento'