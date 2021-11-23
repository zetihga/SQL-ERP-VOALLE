SELECT  -- count(p.id) 'Quantidade',
       c.contract_number,
       p.name,
       c.collection_day 'Dia de Vencimento',
        CASE p.type_tx_id
           WHEN 2 THEN 'PF'
           WHEN 1 THEN 'PJ'
       END 'Tipo Documento',
       fct.title 'Tipo de cobrança'
from contracts c
INNER JOIN people p ON c.client_id = p.id
INNER JOIN companies_places cp ON cp.id = c.company_place_id
left join financial_collection_types fct on c.financial_collection_type_id = fct.id
WHERE c.`status` IN (1,2,3,5,6,7) AND c.stage IN (5,3)
AND c.deleted = 0
and c.collection_day = 0
and fct.title is null
 -- GROUP BY c.collection_day,fct.title,p.type_tx_id