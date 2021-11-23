Select p.name,
       p.email,
       p.email_NFE,
       p.cell_phone_1
from contracts c
join people p on c.client_id = p.id
join contract_items ci on c.id = ci.contract_id
join service_products sp on ci.service_product_id = sp.id
where c.deleted = 0
 -- and c.status in (1,3)
and sp.code = 02.14
and c.stage = 3
 -- and c.status = 1
group by c.contract_number
 -- and c.erp_code like '%stetnet-c%'

