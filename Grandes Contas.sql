SELECT cp.description 'Local',
c.contract_number 'N°Contrato',
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
left join financers_natures fn on c.financer_nature_id = fn.id
left join financial_operations fo on c.operation_id = fo.id
join financial_receivable_titles frt on c.id = frt.contract_id
WHERE c.`status` IN (1,2,3,5,6,7) AND c.stage IN (3)
AND c.deleted = 0
and frt.deleted = 0
and p.name like '%José Henrique Garcia Antunes%'
 -- GROUP BY p.city

SELECT
    -- count(cb.id)  'Total Agrupadores',
    sum(ci.total_amount) as 'Total Agrupador',
    (sum(ci.total_amount) - c.amount ) as 'Desmonstração',
     -- sp.title 'Serviço',
    c.amount 'TotalContrato',
    case
        when sum(ci.total_amount) >= 500 then 'GC'
        when sum(ci.total_amount) <= 500 then 'Pj'
            END 'Tipo',
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
  left join financial_receivable_titles frt on c.id = frt.contract_id
   -- join service_products sp on ci.service_product_id = sp.id
    where ci.deleted = 0
   and c.deleted = 0
   and c.status not in (4,9) and c.stage = 3
   and p.type_tx_id = 1
    -- and c.contract_number = 00015
   group by c.contract_number
   HAVING `Total Agrupador` >= 500






SELECT
    sum(ci.total_amount) as 'Total Agrupador',
     -- (sum(ci.total_amount) - c.amount ) as 'Desmonstração',
    c.amount 'TotalContrato',
   frt.title_amount Valor,
       frt.balance AS Saldo,
       frt.title,
    CASE
        WHEN frt.balance > 0 THEN 'Em Aberto'
        WHEN frt.balance = 0 THEN 'Liquidado'
    END AS Em_aberto_liquidado,
    frr.receipt_date 'Data de Recebimento',
    CASE
        WHEN frt.finished = 0 THEN 'Não Baixado'
        WHEN frt.finished = 1 THEN 'Baixado'
    END AS Baixado,
       p.name Cliente,
       c.contract_number,
       p.city Cidade,
       frt.issue_date Emissão,
       frt.expiration_date Vencimento,
       fct.title 'Tipo Cobrança'
    from Contract_configuration_billings as cb
JOIN contracts AS c ON c.id = cb.contract_id
join financial_operations as fo ON fo.id = cb.financial_operation_id
  inner join people as p on p.id = c.client_id
  inner join tx_types as tt on p.type_tx_id = tt.id
  inner join contract_items as ci on ci.contract_configuration_billing_id = cb.id AND ci.p_is_billable = 1
  inner join financers_natures as fn ON fn.id = cb.financer_nature_id
  inner join companies_places as cp on cp.id = cb.company_place_id
  left join financial_collection_types fct on cb.financial_collection_type_id = fct.id
  left join financial_receivable_titles frt on c.id = frt.contract_id
  LEFT JOIN financial_receipt_titles frr ON frt.id = frr.financial_receivable_title_id AND frt.deleted = 0
    where ci.deleted = 0
   and c.deleted = 0
   and c.status not in (4,9) and c.stage = 3
   and p.type_tx_id = 1
    -- and c.contract_number = 17282
   and frt.deleted = 0
    -- and frt.renegotiated = 0
   and frt.bill_title_id IS NULL
   group by frt.title
   HAVING `Total Agrupador` >= 500




SELECT
     -- sum(ci.total_amount) as 'Total Agrupador',
    c.amount as 'Total Contrato',
    count(c.contract_number) 'Contratos',
     -- count(c.contract_number) 'N° Contrato',
       p.city
    from contracts c
  join financial_operations as fo ON c.operation_id = fo.id
  inner join people as p on p.id = c.client_id
  inner join tx_types as tt on p.type_tx_id = tt.id
   -- inner join contract_items as ci on c.id = ci.contract_id AND ci.p_is_billable = 1
  where  -- ci.deleted = 0
   c.deleted = 0
   and c.status not in (4,9) and c.stage = 3
   and p.type_tx_id = 1
   and c.amount >= 500
    -- and p.city like '%Agudos%'
   group by p.city
   --  HAVING `Total Agrupador` >= 500














