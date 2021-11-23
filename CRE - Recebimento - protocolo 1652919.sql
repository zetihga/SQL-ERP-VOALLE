select cp.code,
       cp.description,
       p.name,
       frtt.title,
       frtt.bank_title_number,
       frt.receipt_date,
       frtt.expiration_date,
       frt.amount 'Valor Pago',
       frt.receipt_date 'Data Recebimento',
       pc.title,
       fn.title 'Natureza Financeira',
       frtt.complement,
       frto.description 'EVento',
       pp.name 'Responsavel'
       from financial_receipt_titles frt
join financial_receivable_titles frtt on frt.financial_receivable_title_id = frtt.id
join companies_places cp on frt.company_place_id = cp.id
left join contracts c on frtt.contract_id = c.id
left join people p on p.id = c.client_id
left join financers_natures fn on frt.financer_nature_id = fn.id
left join payment_conditions pc on frt.payment_condition_id = pc.id
left join financial_receivable_title_occurrences frto on frtt.id = frto.financial_receivable_title_id
left join people pp on pp.id = frto.person_id
where frt.receipt_date between '2021-09-01' and '2021-09-30'
and frt.finished = 0
and frt.deleted = 0
and frto.description like '%Título criado na geração da fatura do cliente%'
and fn.code = '1.6.03'
 -- and frtt.title like '%FAT210816300747713%'
and frtt.bill_title_id is null