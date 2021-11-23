 -- CRIADO POR ZETI
 -- Todas AS solicitações de vendas..

SELECT ai.protocol 'Protocolo',
       p.id 'CodCliente',
       p.name 'Nome cliente',
       p.phone,
       p.cell_phone_1,
       p.email 'E-mail',
        p.city 'Cidade',
       t.title 'Equipe',
	   it.title 'Tipo Solicitação',
       p2.name 'Atendente',
       a.created 'Data de abertura',
       it.id,
	   a.conclusion_date 'Data de Encerramento',
 case
		 when ai.incident_status_id = 3 then 'Fechamento'
		 when ai.incident_status_id = 4 then 'Encerramento'
		 when ai.incident_status_id = 2 then 'Andamento'
		 when ai.incident_status_id = 10 then 'Aguardando Retorno'
         when ai.incident_status_id = 11 then 'Cliente Ausente'
         when ai.incident_status_id = 0 then 'Cancelado'
		   END 'Status Solicitação',
		    it.title 'Tipo Solicitação'
from assignment_incidents ai
join assignments a on ai.assignment_id = a.id
join incident_types it on ai.incident_type_id = it.id
JOIN people p2 ON a.responsible_id = p2.id
JOIN teams t ON t.id = ai.team_id
join people p ON p.id = ai.client_id
WHERE it.id in (1194,1195,1183)
and ai.incident_status_id = 4
and a.created between date_sub(current_date, interval 1 year)and current_date


select * from assignments