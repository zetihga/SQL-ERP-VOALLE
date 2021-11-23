SELECT cp.description 'Local',
c.contract_number 'N°Contrato',
ci.description 'Plano',
p.name 'Nome', 
c.description,
 CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
p.tx_id 'Documento',
p.postal_code 'CEP',
p.street 'Rua',
p.street_type 'Tipo',
p.number 'Número',
p.address_complement 'Complemento',
p.neighborhood 'Bairro',
p.city 'Cidade',
p.state 'Estado',
p.country 'Pais',
p.address_reference 'Ponto de referencia'
from contracts c
INNER JOIN people p ON c.client_id = p.id
INNER JOIN companies_places cp ON cp.id = c.company_place_id
left JOIN contract_items ci ON c.id = ci.contract_id
                                   AND ci.is_composition = 1
                                   AND ci.deleted = 0
                                   AND ci.p_is_billable = 0
WHERE c.`status` IN (1,2,3,5,6,7) AND c.stage IN (3)
AND ci.description IS NOT NULL
AND c.deleted = 0
 -- GROUP BY p.city