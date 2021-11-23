## COM CONTRATO
Select  -- p.name 'Nome cliente',
        -- ai.incident_status_id,
        count(ai.protocol) 'Quantidade',
        aap.title
      /* case
		 when ai.incident_status_id = 3 then 'Fechamento'
		 when ai.incident_status_id = 4 then 'Encerramento'
		 when ai.incident_status_id = 1 then 'Abertura'
		 when ai.incident_status_id = 2 then 'Andamento'
		 when ai.incident_status_id = 10 then 'Aguardando Retorno'
         when ai.incident_status_id = 11 then 'Cliente Ausente'
         when ai.incident_status_id = 8 then 'Cancelada'
		   END 'Status',*/
          /* CASE
           WHEN c.status = 1 THEN 'Normal'
           WHEN c.status = 2 THEN 'Demonstração'
           WHEN c.status = 3 THEN 'Cortesia'
           WHEN c.status = 4 THEN 'Cancelado'
           WHEN c.status = 5 THEN 'Suspenso'
           WHEN c.status = 6 THEN 'Bloqueio Financeiro'
           WHEN c.status = 7 THEN 'Bloqueio Administrativo'
           WHEN c.status = 9 THEN 'Encerrado'
        END AS 'Status Contrato' */
        -- p.city 'Cidade',
        -- it.title 'Tipo Solicitação',
        -- p2.name 'Atendente',
        -- date_format(a.created,'%d/%m/%y') as 'Data de Abertura',
        -- a.conclusion_date 'Data Encerramento'
from assignment_incidents ai
join assignments a on ai.assignment_id = a.id
join incident_types it on ai.incident_type_id = it.id
JOIN people p2 ON a.responsible_id = p2.id
JOIN teams t ON t.id = ai.team_id
join people p ON p.id = ai.client_id
left join contracts c on p.id = c.client_id
left join authentication_access_points aap on c.authentication_access_point_id = aap.id
WHERE it.id in (11,12,1016,1033,1037,1042,1109,1110,1183,1194,1195,1196,
 1204,1211,1212,1215,1216,1217,1219,1411,1413,1423,1473,
 1487,1519,1520,1521,1522,1524,1533,1544,1545,1572,1611,1614,
 1675,1678,1679,1689,1693,1694,1700,1705,1709,1710,1711)
 -- and ai.protocol = 1789525
AND DATEDIFF(curdate(), a.created) <= 0
group by aap.title

select * from authentication_access_points

