SELECT
    sum(ci.total_amount) as 'Total Agrupador',
       p.name Cliente,
       c.contract_number 'N° Contrato',
       ac.user 'User',
       ac.password Senha,
       ac.equipment_serial_number 'Serial Equipamento' ,
       ac.neighborhood 'Bairro',
       ac.street 'Rua',
       ac.city 'Cidade',
       ac.state 'Estado',
       acc.title 'Concentrador',
       aap.title 'Ponto de Acesso'
    from Contract_configuration_billings as cb
JOIN contracts AS c ON c.id = cb.contract_id
join financial_operations as fo ON fo.id = cb.financial_operation_id
  inner join people as p on p.id = c.client_id
  inner join tx_types as tt on p.type_tx_id = tt.id
  inner join contract_items as ci on ci.contract_configuration_billing_id = cb.id AND ci.p_is_billable = 1
  inner join financers_natures as fn ON fn.id = cb.financer_nature_id
  inner join companies_places as cp on cp.id = cb.company_place_id
  left join authentication_contracts ac on c.id = ac.contract_id
  left join authentication_concentrators acc on ac.authentication_concentrator_id = acc.id
  left join authentication_access_points aap on ac.authentication_access_point_id = aap.id
   where ci.deleted = 0
        and c.deleted = 0
        and c.status not in (4,9) and c.stage = 3
        and p.type_tx_id = 1
        group by c.contract_number
        HAVING `Total Agrupador` >= 500


SELECT * FROM contracts c
INNER JOIN people p ON p.id = c.client_id
INNER JOIN financial_receivable_titles frt ON c.id = frt.contract_id
JOIN financial_receivable_titles frt2 ON frt2.bill_title_id = frt.id
WHERE frt.balance != 0.00
