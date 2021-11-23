SELECT
       p.city 'Cidade',
       count(c.id) 'Contratos',
       sum(c.amount),
       fct.title 'Carteira'
from contracts c
left  JOIN people p ON c.client_id = p.id
left JOIN companies_places cp ON cp.id = c.company_place_id
join financial_collection_types fct on c.financial_collection_type_id = fct.id
WHERE c.`status` IN (1,2,3,5,6,7) AND c.stage IN (3)
AND c.deleted = 0
 -- and fct.deleted = 0
GROUP BY p.city,fct.id
