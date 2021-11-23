SELECT
    sum(ci.total_amount) as 'Total Agrupador',
    (sum(ci.total_amount) - c.amount ) as 'Desmonstração',
    c.amount 'TotalContrato',
    case
        when sum(ci.total_amount) >= 500 then 'GC'
        when sum(ci.total_amount) <= 500 then 'Pj'
            END 'Tipo',
    p.name,
    c.contract_number
    from Contract_configuration_billings as cb
join contracts AS c ON c.id = cb.contract_id
join financial_operations as fo ON fo.id = cb.financial_operation_id
join people as p on p.id = c.client_id
join tx_types as tt on p.type_tx_id = tt.id
join contract_items as ci on ci.contract_configuration_billing_id = cb.id
join financers_natures as fn ON fn.id = cb.financer_nature_id
join companies_places as cp on cp.id = cb.company_place_id
left join financial_collection_types fct on cb.financial_collection_type_id = fct.id
    where ci.deleted = 0
        and c.deleted = 0
        and c.status not in (4,9) and c.stage = 3
        and p.type_tx_id = 1
        group by c.contract_number
        HAVING `Total Agrupador` >= 500
