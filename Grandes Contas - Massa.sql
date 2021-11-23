SELECT
     -- count(cb.id)  'Total Agrupadores',
    sum(ci.total_amount) as 'Total Agrupador',
    sp.title 'Serviço',
    c.amount 'TotalContrato',
     CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
    p.name,
    c.contract_number
     /* ci.total_amount 'Total',
    cb.cnae,
    cb.id,
    cp.description as Local,
	c.id as id_contrato,
	tt.name as tipo_pessoa,
    c.description as desc_contrato,
	fo.title as Agrup_Operacao_financeira,
    ci.description,
    ci.contract_configuration_billing_id,
    ci.deleted,
    ci.demonstration,
    fct.title 'Tipo de cobrança' */
from Contract_configuration_billings as cb
  inner JOIN contracts AS c ON c.id = cb.contract_id
  inner join financial_operations as fo ON fo.id = cb.financial_operation_id
  inner join people as p on p.id = c.client_id
  inner join tx_types as tt on p.type_tx_id = tt.id
  inner join contract_items as ci on ci.contract_configuration_billing_id = cb.id
  inner join financers_natures as fn ON fn.id = cb.financer_nature_id
  inner join companies_places as cp on cp.id = cb.company_place_id
  left join financial_collection_types fct on cb.financial_collection_type_id = fct.id
  join service_products sp on ci.service_product_id = sp.id
   -- INNER JOIN contract_items cii ON c.id = cii.contract_id AND cii.is_composition = 1 AND cii.p_is_billable = 0
  where ci.deleted = 0
   and c.deleted = 0
   and c.status not in (4,9) and c.stage = 3
   and p.type_tx_id = 1
   group by c.contract_number
   HAVING `Total Agrupador` >= 500


SELECT cp.description 'Local',
c.contract_number 'N°Contrato',
p.name 'Nome',
 CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
p.tx_id 'Documento'
from contracts c
INNER JOIN people p ON c.client_id = p.id
INNER JOIN companies_places cp ON cp.id = c.company_place_id
join contract_configuration_billings ccb on c.id = ccb.contract_id
 -- INNER JOIN contract_items ci ON c.id = ci.contract_id AND ci.is_composition = 1 AND ci.p_is_billable = 0
WHERE c.`status` IN (1,2,3,5,6,7) AND c.stage IN (3)
AND c.deleted = 0
and p.type_tx_id = 1








SELECT
     -- count(cb.id)  'Total Agrupadores',
    sum(ci.total_amount) as 'Total Agrupador',
    sp.title 'Serviço',
    c.amount 'TotalContrato',
     CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
    p.name,
    count(c.contract_number),
    fct.title 'Tipo de cobrança'
     /* ci.total_amount 'Total',
    cb.cnae,
    cb.id,
    cp.description as Local,
	c.id as id_contrato,
	tt.name as tipo_pessoa,
    c.description as desc_contrato,
	fo.title as Agrup_Operacao_financeira,
    ci.description,
    ci.contract_configuration_billing_id,
    ci.deleted,
    ci.demonstration,
    */
from Contract_configuration_billings as cb
  inner JOIN contracts AS c ON c.id = cb.contract_id
  inner join financial_operations as fo ON fo.id = cb.financial_operation_id
  inner join people as p on p.id = c.client_id
  inner join tx_types as tt on p.type_tx_id = tt.id
  inner join contract_items as ci on ci.contract_configuration_billing_id = cb.id
  inner join financers_natures as fn ON fn.id = cb.financer_nature_id
  inner join companies_places as cp on cp.id = cb.company_place_id
  left join financial_collection_types fct on cb.financial_collection_type_id = fct.id
  join service_products sp on ci.service_product_id = sp.id
   -- INNER JOIN contract_items cii ON c.id = cii.contract_id AND cii.is_composition = 1 AND cii.p_is_billable = 0
  where ci.deleted = 0
   and c.deleted = 0
   and c.status not in (4,9) and c.stage = 3
   and p.type_tx_id = 1
   group by fct.title
   HAVING `Total Agrupador` >= 500



