Select ac.user ,p.id, p.name,aap.id,aap.code,aap.title,p.city from contracts c
join people p on c.client_id = p.id
join authentication_contracts ac on c.id = ac.contract_id
join authentication_access_points aap on ac.authentication_access_point_id = aap.id
and c.`status` IN (1,2,3,5,6,7) AND c.stage IN (3)
and p.code_city_id in (4123907,4102406,4123105)
and c.deleted = 0


select * from authentication_access_points aap


 -- 4111001 Itambaracá
 -- 4123907 Sanra Mariana
 -- 4102406 Bandeirantes
 -- 4123105 Santa Amélia



select * from people p
where p.name like '%Santa Am%'
