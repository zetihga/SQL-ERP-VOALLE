SELECT
    c.amount as 'Total Contrato',
    count(c.contract_number) 'Contratos',
    fct.title
    from contracts c
  join financial_operations as fo ON c.operation_id = fo.id
  inner join people as p on p.id = c.client_id
  inner join tx_types as tt on p.type_tx_id = tt.id
  left join financial_collection_types fct on c.financial_collection_type_id = fct.id
  where  c.deleted = 0
        and c.status not in (4,9) and c.stage = 3
        and p.type_tx_id = 1
        and c.amount >= 500
        group by fct.title