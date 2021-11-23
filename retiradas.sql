SELECT ai.protocol 'Protocolo',
       a.title 'Título',
       p.name 'Nome do cliente',
       p.city 'Cidade',
       case
		 when ai.incident_status_id = 3 then 'Fechamento'
		 when ai.incident_status_id = 4 then 'Encerramento'
		 when ai.incident_status_id = 1 then 'Abertura'
		 when ai.incident_status_id = 2 then 'Andamento'
		 when ai.incident_status_id = 10 then 'Aguardando Retorno'
         when ai.incident_status_id = 11 then 'Cliente Ausente'
         when ai.incident_status_id = 0 then 'Cancelado'
		   END 'Status Solicitação',
       p2.name 'Atendente',
       t.title 'Equipe',
       a.created 'Data de abertura',
	   a.conclusion_date 'Data de Encerramento'
from assignment_incidents ai
left join assignments a on ai.assignment_id = a.id
left join incident_types it on ai.incident_type_id = it.id
left JOIN people p2 ON a.responsible_id = p2.id
left JOIN teams t ON t.id = ai.team_id
left join people p ON p.id = ai.client_id
WHERE it.id in (219,1051,1052,1053,1054,1055,
 1056,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1070,
 1071,1072,1073,1074,1075,1076,1077,1078,1079,1080,1230,1231,1408,1434,
 1435,1436,1437,1438,1439,1440,1441,1442,1443,1444,1445,1447,1493,1600)
and t.id = 1015



