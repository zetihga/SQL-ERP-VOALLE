with tabela1 as (
Select
             case
                 when floor(count(ai.protocol)/30) = 0 then '1'
                 else
                     floor(count(ai.protocol)/30)
                     end 'Média',
             it.id
             from assignment_incidents ai
                      join assignments a on ai.assignment_id = a.id
                      join incident_types it on ai.incident_type_id = it.id
                      join people p ON p.id = ai.client_id
                      join code_cities cc on p.code_city_id = cc.id
             WHERE it.id in (11, 12, 1016, 1033, 1037, 1042, 1109, 1110, 1183, 1194, 1195, 1196,
                             1204, 1211, 1212, 1215, 1216, 1217, 1219, 1411, 1413, 1423, 1473,
                             1487, 1519, 1520, 1521, 1522, 1524, 1533, 1544, 1545, 1572, 1611, 1614,
                             1675, 1678, 1679, 1689, 1693, 1694, 1700, 1705, 1709, 1710, 1711)
               AND DATEDIFF(curdate(), a.created) <= 30
               group by it.title)

Select  -- p.name 'Nome cliente',
       it.title 'Tipo de Solicitação',
       count(ai2.protocol) 'Quantidade',
       t1.Média
from assignment_incidents as ai2
join assignments a on ai2.assignment_id = a.id
join incident_types it on ai2.incident_type_id = it.id
JOIN people p2 ON a.responsible_id = p2.id
JOIN teams t ON t.id = ai2.team_id
join people p ON p.id = ai2.client_id
join tabela1 t1 on t1.id = ai2.incident_type_id
WHERE it.id in (11,12,1016,1033,1037,1042,1109,1110,1183,1194,1195,1196,
 1204,1211,1212,1215,1216,1217,1219,1411,1413,1423,1473,
 1487,1519,1520,1521,1522,1524,1533,1544,1545,1572,1611,1614,
 1675,1678,1679,1689,1693,1694,1700,1705,1709,1710,1711)
AND DATEDIFF(curdate(), a.created) <= 0
group by it.title
