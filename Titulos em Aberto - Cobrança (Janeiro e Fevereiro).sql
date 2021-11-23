SELECT cp.description,
       cp.tx_id,
    --   sp.title,
       p.name 'Nome',
       p.tx_id 'Documento',
       CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
       p.city 'Cidade',
       p.state 'Estado',
       p.postal_code 'CEP',
       p.country 'Pais',
       p.street 'Rua',
       ci.description `Plano`,
       p.street_type 'Tipo',
       p.number 'n°',
       p.address_complement 'Complemento',
       p.neighborhood 'Bairro',
       p.cell_phone_1 'Telefone',
       p.phone,
       p.email,
       p.email_NFE,
       p.birth_date 'Nascimento',
       c.contract_number 'N°Contrato',
       frt.title 'N° Titulo',
       c.amount 'Valor do contrato atual',
       frt.title_amount 'Valor do Título',
       frt.competence 'Competencia',
       DATE_FORMAT(frt.original_expiration_date, '%d/%m/%y') 'Data de vencimento original',
       DATE_FORMAT(frt.expiration_date, '%d/%m/%y') 'Data vencimento',
       CASE
           WHEN frt.balance > 0 THEN 'EM ABERTO'
           WHEN frt.balance <=0  THEN 'PAGO'
       END 'STATUS BOLETO'
FROM contracts c
INNER JOIN people p ON p.id = c.client_id
LEFT JOIN financial_receivable_titles frt on c.id = frt.contract_id
left JOIN financers_natures fn on frt.financer_nature_id = fn.id
left join companies_places cp on c.company_place_id = cp.id
left join contract_items ci on c.id = ci.contract_id AND ci.is_composition = 1 AND ci.deleted = 0 AND ci.p_is_billable = 0
left join service_products sp on ci.service_product_id = sp.id
 -- join contract_items ci on c.id = ci.contract_id
 -- join service_products sp on ci.service_product_id = sp.id
WHERE frt.deleted = 0
AND frt.bill_title_id is null
and c.status in (1,2,3,4,5,6,7,9)
and frt.balance > 0
and frt.deleted = 0
and frt.finished = 0
and frt.renegotiated = 0
and c.deleted = 0
and frt.expiration_date between '2021-01-01' and '2021-02-28'
 -- and p.name like '%Carlos Henrique Fernandes Gimenez%'