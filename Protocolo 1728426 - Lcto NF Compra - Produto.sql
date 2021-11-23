Select inn.issue_date 'Emissão',
       inn.entry_date 'Entrada',
       fn.title 'Natureza Financeira',
       p.name 'Fornecedor',
       inn.total_amount_liquid 'Total',
       inn.document_number 'Dcto'
from invoice_notes inn
left join people p on inn.supplier_id = p.id
left join financers_natures fn on inn.financer_nature_id = fn.id
where inn.issue_date between '2021-09-01' and '2021-09-30'
and inn.signal = 1
and inn.origin = 6


Select inn.issue_date 'Emissão',
       cp.description,
       inn.entry_date 'Entrada',
       fn.title 'Natureza Financeira',
       p.name 'Fornecedor',
       inn.total_amount_liquid 'Total',
       inn.document_number 'Dcto',
       case
           when inn.origin = 6 then 'Produto'
           when inn.origin = 10 then 'Serviço'
               end 'Tipo de Nota',
       case
           when inn.status = 1 then 'Definitivo'
           when inn.status = 98 then 'Editável'
           when inn.status = 0 then 'Provisório'
               END 'Status'
from invoice_notes inn
left join people p on inn.supplier_id = p.id
left join financers_natures fn on inn.financer_nature_id = fn.id
left join companies_places cp on inn.company_place_id = cp.id
where inn.issue_date between '2021-09-01' and '2021-09-30'
and inn.signal = 1
and inn.origin in (10,6)