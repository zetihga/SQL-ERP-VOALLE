
## POR DIA
Select  -- p.name 'Nome cliente',
       count(ai.protocol) 'Quantidade',
       date_format(a.created,'%d/%m/%y') as 'Data de Abertura',
        -- ai.protocol,
       case
           when DATEDIFF(curdate(), a.created) = 0 then 'Dia Atual'
           when DATEDIFF(curdate(), a.created) = 1 then 'Ha 1 dia'
           when DATEDIFF(curdate(), a.created) = 2 then 'Ha 2 dias'
           when DATEDIFF(curdate(), a.created) = 3 then 'Ha 3 dias'
           when DATEDIFF(curdate(), a.created) = 4 then 'Ha 4 dias'
           when DATEDIFF(curdate(), a.created) = 5 then 'Ha 5 dias'
           when DATEDIFF(curdate(), a.created) = 6 then 'Ha 6 dias'
           when DATEDIFF(curdate(), a.created) = 7 then 'Ha 7 dias'
               end 'Dia'
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
WHERE it.id in (11,12,1016,1033,1037,1042,1109,1110,1183,1194,1195,1196,
 1204,1211,1212,1215,1216,1217,1219,1411,1413,1423,1473,
 1487,1519,1520,1521,1522,1524,1533,1544,1545,1572,1611,1614,
 1675,1678,1679,1689,1693,1694,1700,1705,1709,1710,1711)
 -- and ai.protocol = 1789525
AND DATEDIFF(curdate(), a.created) <= 7
group by CAST(a.created AS DATE)
 -- group by 'Data de Abertura'