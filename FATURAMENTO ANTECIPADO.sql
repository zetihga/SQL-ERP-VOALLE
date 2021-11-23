SELECT cp.description 'Local',
       ct.title as 'Tipo de contrato',
       c.contract_number 'N°Contrato',
       c.invoice_type,
       --  count(p.type_tx_id),
       ct.invoice_type,
       p.tx_id 'Documento',
        CASE p.type_tx_id
          WHEN 2 THEN 'CPF'
          WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
        -- cp.description
       p.name 'Nome'
from contracts c
INNER JOIN people p ON c.client_id = p.id
INNER JOIN companies_places cp ON cp.id = c.company_place_id
join contract_types ct on c.contract_type_id = ct.id
WHERE c.`status` IN (1,2,3,5,6,7) AND c.stage IN (3)
AND c.deleted = 0
and ct.deleted = 0
and p.type_tx_id = 2
 -- and ct.title like '%Contrato Composto – PF - Webby Provedor M.02%'
and c.invoice_type = 1

select * from contract_types
 -- and ct.id = 210
 -- AND p.type_tx_id = 2
 -- and CT.title like '%PF%'
 -- group by ct.title,P.type_tx_id,cp.description


SELECT * FROM contract_types ct
WHERE CT.title like '%Webby Internet PF%'

CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',


 -- Clientes e seus tipos de faturamento
SELECT cp.description 'Local',
c.contract_number 'N°Contrato',
case
     when c.invoice_type = 1 then 'Mensal'
     when c.invoice_type = 2 then 'Múltiplas Operações'
     when c.invoice_type = 3 then 'Comunicação SCM/SVA'
     when c.invoice_type = 4 then 'Antecipado'
     when c.invoice_type = 5 then 'Não prevê faturamento'
    END 'Tipo Faturamento',
p.name 'Nome',
c.description,
 CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
p.tx_id 'Documento',
p.postal_code 'CEP',
p.street 'Rua',
p.street_type 'Tipo',
p.number 'Número',
p.address_complement 'Complemento',
p.neighborhood 'Bairro',
p.city 'Cidade',
p.state 'Estado',
p.country 'Pais',
p.address_reference 'Ponto de referencia'
from contracts c
INNER JOIN people p ON c.client_id = p.id
INNER JOIN companies_places cp ON cp.id = c.company_place_id
WHERE c.`status` IN (1,2,3,5,6,7) AND c.stage IN (3)
AND c.deleted = 0




case
     when c.invoice_type = 1 then 'Mensal'
     when c.invoice_type = 2 then 'Múltiplas Operações'
     when c.invoice_type = 3 then 'Comunicação SCM/SVA'
     when c.invoice_type = 4 then 'Antecipado'
     when c.invoice_type = 5 then 'Não prevê faturamento'
    END 'Tipo Faturamento'
