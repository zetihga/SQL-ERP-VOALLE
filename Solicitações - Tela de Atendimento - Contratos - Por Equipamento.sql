## COM CONTRATO
Select
        count(c.contract_number) 'Total Contratos',
        case
            when ac.equipment_type = 1 then 'Mikrotik'
            when ac.equipment_type = 2 then 'Ubiquiti'
            when ac.equipment_type = 3 then 'Intelbras'
            when ac.equipment_type = 4 then 'Parks'
            when ac.equipment_type = 5 then 'Huawei'
            when ac.equipment_type = 6 then 'FiberHome'
            when ac.equipment_type = 7 then 'Zte'
            when ac.equipment_type = 8 then 'DATACOM'
            when ac.equipment_type = 14 then 'Digistar'
            when ac.equipment_type = 15 then 'Nokia'
            when ac.equipment_type = 16 then 'Gigatelco'
            when ac.equipment_type = 17 then 'Raisecom'
            when ac.equipment_type = 0 then 'Não Informado'
            when ac.equipment_type is null then 'NÃO REPLICADO'
                END 'Tipo Equipamento'
from assignment_incidents ai
join assignments a on ai.assignment_id = a.id
join incident_types it on ai.incident_type_id = it.id
JOIN people p2 ON a.responsible_id = p2.id
JOIN teams t ON t.id = ai.team_id
join people p ON p.id = ai.client_id
join contracts c on p.id = c.client_id
JOIN authentication_contracts ac on c.id = ac.contract_id
join authentication_concentrators acc on ac.authentication_concentrator_id = acc.id
WHERE it.id in (11,12,1016,1033,1037,1042,1109,1110,1183,1194,1195,1196,
 1204,1211,1212,1215,1216,1217,1219,1411,1413,1423,1473,
 1487,1519,1520,1521,1522,1524,1533,1544,1545,1572,1611,1614,
 1675,1678,1679,1689,1693,1694,1700,1705,1709,1710,1711)
AND DATEDIFF(curdate(), a.created) <= 0
 -- and ac.equipment_type is null
group by ac.equipment_type
order by `Total Contratos` desc