select max(v.created),name from (
select pp.name,
       r.person_id,
       r.created,
        -- DATE_FORMAT(r.created,'%d/%m/%Y'),
       t.title 'Equipe',
 case
		 when ai.incident_status_id = 3 then 'Fechamento'
		 when ai.incident_status_id = 4 then 'Encerramento'
		 when ai.incident_status_id = 2 then 'Andamento'
		 when ai.incident_status_id = 10 then 'Aguardando Retorno'
         when ai.incident_status_id = 11 then 'Cliente Ausente'
         when ai.incident_status_id = 0 then 'Cancelado'
		   END 'Status Solicitação'
from assignment_incidents ai
join assignments a on ai.assignment_id = a.id
join incident_types it on ai.incident_type_id = it.id
join reports r on a.id = r.assignment_id
 -- join people p ON p.id = ai.client_id
join people pp ON pp.id = r.person_id
JOIN teams t ON t.id = ai.team_id
WHERE ai.protocol = 1591281
 -- and r.created = (select max(r.created))
      ) v

 -- and a.created between date_sub(current_date, interval 2 year)and current_date