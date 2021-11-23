Select
       count(c.contract_number),
       --  p.name,
       ct.title,
       acp.title 'Ponto de acesso',
       acc.title 'Concentrador'
    from contracts c
join people p on c.client_id = p.id
join contract_types ct on c.contract_type_id = ct.id
join financial_collection_types fct on c.financial_collection_type_id = fct.id
join authentication_contracts ac on c.id = ac.contract_id
join authentication_concentrators acc on ac.authentication_concentrator_id = acc.id
join authentication_access_points acp on c.authentication_access_point_id = acp.id
and ct.code in ('12.1.1','12.2.1','13.0','13.1','13.2','13.3')
group by acc.title,acp.title
 -- and acc.title like '%jnp_sp_our_coe_bras_03%'

SELECT * FROM authentication_access_points acp
where acp.title like '%CAIABU%'


SELECT acp.code,acp.title,acp.deleted FROM authentication_access_points acp
where acp.code in ('28.6','28.9','28.1','28.7','28.3','28.4','28.8')

    --    acp.title like '%STETNET-RFJ%'

select
       count(c.contract_number),
       ct.title,
       cp.description,
        -- p.name,
        CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
       p.tx_id from contracts c
join people p on c.client_id = p.id
join contract_types ct on c.contract_type_id = ct.id
join companies_places cp on c.company_place_id = cp.id
where c.status in (1,3,6,7)
and c.stage = 3
and cp.id = 5
and p.type_tx_id = 1
group by ct.title

