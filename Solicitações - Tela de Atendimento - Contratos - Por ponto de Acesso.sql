## COM CONTRATO POR PONTO DE ACESSO
Select
       count(C.contract_number) 'Total Contratos',
       acp.title 'Ponto de Acesso'
from assignment_incidents ai
join assignments a on ai.assignment_id = a.id
join incident_types it on ai.incident_type_id = it.id
JOIN people p2 ON a.responsible_id = p2.id
JOIN teams t ON t.id = ai.team_id
join people p ON p.id = ai.client_id
join contracts c on p.id = c.client_id
join authentication_access_points acp on c.authentication_access_point_id = acp.id
WHERE it.id in (11,12,1016,1033,1037,1042,1109,1110,1183,1194,1195,1196,
 1204,1211,1212,1215,1216,1217,1219,1411,1413,1423,1473,
 1487,1519,1520,1521,1522,1524,1533,1544,1545,1572,1611,1614,
 1675,1678,1679,1689,1693,1694,1700,1705,1709,1710,1711)
AND DATEDIFF(curdate(), a.created) <= 0
group by acp.title
order by `Total Contratos` desc