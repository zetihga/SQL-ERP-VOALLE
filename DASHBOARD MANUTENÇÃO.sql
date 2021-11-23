SELECT cp.description 'Local',
       c.contract_number 'N°Contrato',
       p.name 'Nome',
       c.description
from contracts c
INNER JOIN people p ON c.client_id = p.id
INNER JOIN companies_places cp ON cp.id = c.company_place_id
WHERE c.`status` IN (1,2,3,5,6,7) AND c.stage IN (5,3)
AND c.deleted = 0
 -- AND c.beginning_date <= '2021-09-13'

 select * from incident_types it
where it.title like '%Retirada%'