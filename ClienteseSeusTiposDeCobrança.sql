Select
      c.contract_number,
       p.name,
       --  p.name,
      -- p.name,
       ct.title 'Tipo de contrato',
       fct.title
    from contracts c
join people p on c.client_id = p.id
join contract_types ct on c.contract_type_id = ct.id
join financial_collection_types fct on c.financial_collection_type_id = fct.id
join companies_places cp on c.company_place_id = cp.id
join financial_operations fo on c.operation_id = fo.id
join financers_natures fn on c.financer_nature_id = fn.id
 -- join authentication_contracts ac on c.id = ac.contract_id
 -- join authentication_concentrators acc on ac.authentication_concentrator_id = acc.id
 -- and ct.code in ('12.1.1','12.2.1','13.0','13.1','13.2','13.3')
 -- and cp.id = 11
and c.stage = 3
and c.status in (1,2,3,5,6,7)
and fct.code = 124
and c.deleted = 0
and c.invoice_type = 1
and cp.id = 11
and ct.id in (240,213,214)
 -- group by ct.title,fn.id,fo.id
 -- and acc.title like


select * from invoice_series