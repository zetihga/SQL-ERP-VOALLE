
SELECT p.state 'Stado',
       cpp.description 'Local',
       iss.title,
       p.name 'Nome',
      -- frt.competence 'Competencia',
      -- frt.title_amount 'Valor Faturado',
       fo.title 'Operação Financeira',
       fn.title 'Natureza Financeira',
       in2.issue_date 'Data',
       c.amount 'Valor do Plano',
       CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
       p.city 'Cidade',
       CASE
           WHEN c.status = 1 THEN 'Normal'
           WHEN c.status = 2 THEN 'Demonstração'
           WHEN c.status = 3 THEN 'Cortesia'
           WHEN c.status = 4 THEN 'Cancelado'
           WHEN c.status = 5 THEN 'Suspenso'
           WHEN c.status = 6 THEN 'Bloqueio Financeiro'
           WHEN c.status = 7 THEN 'Bloqueio Administrativo'
           WHEN c.status = 9 THEN 'Encerrado'
        END AS 'Status Contrato',
       c.billing_beginning_date 'Faturar De',
       CASE
           WHEN c.stage = 1 THEN 'Pré-Contrato'
           WHEN c.stage = 2 THEN 'Em Aprovação'
           WHEN c.stage = 3 THEN 'Aprovado'
           WHEN c.stage = 4 THEN 'Rejeitado'
           WHEN c.stage = 5 THEN 'Cancelado'
           WHEN c.stage = 6 THEN 'Integrado'
        END AS 'Situação Contrato',
       c.beginning_date 'Data de Aprovação',
       SUM(in2.total_amount_liquid) as 'Valor Liquido'
FROM invoice_notes in2
INNER JOIN contracts c ON c.id = in2.contract_id
INNER JOIN people p ON p.id = in2.client_id
INNER JOIN invoice_series iss ON iss.id = in2.invoice_serie_id
INNER JOIN companies_places cpp ON cpp.id = in2.company_place_id
left JOIN financial_operations fo on c.operation_id = fo.id
left join financers_natures fn on c.financer_nature_id = fn.id
 -- join financial_receivable_titles frt on frt.company_place_id = frt.id
 -- INNER JOIN financial_receivable_titles frt ON in2.id = frt.invoice_note_id
 -- INNER JOIN invoice_note_items ini ON in2.id = ini.invoice_note_id
WHERE in2.issue_date BETWEEN '2021-10-01' AND '2021-10-31'
 -- and c.stage = 3
 -- AND in2.financial_operation_id IN (64)
 -- AND ini.description LIKE '%SCM%'
 -- AND in2.billing_competence BETWEEN '2019-12-01' AND '2020-02-28'
AND in2.cancellation_date IS NULL
 -- AND iss.id = 1
AND c.deleted = 0
AND cpp.id = 11
AND iss.title not like'%CIS%'
 -- AND iss.title like'%NFSe - PM_Ourinhos_Offline%'
 -- AND iss.initials = 1
 -- AND iss.title like '%Webby - MOD21%'
 -- AND frt.bank_title_number IS NULL
 -- AND frt.competence is not null
 -- AND frt.bill_title_id is not null

 -- AND frt.deleted = 0
    -- AND frt.v_final_amount = 0
 --
   -- AND frt.bank_title_number IS NULL
   -- AND frt.finished = 0
   -- AND frt.renegotiated = 0
  --  AND frt.deleted = 0
  --  AND frt.competence IS NOT NULL
  --  AND frt.origin IS NOT NULL
    -- AND frt.bill_title_id IS NOT NULL
 -- AND frt.renegotiated = 0
 -- AND frt.finished = 0
 -- GROUP BY p.state
 -- 26,27,28,29,30,31,32,53,59,
 -- p.name,ini.description,in2.financial_operation_id
 -- p.state

select * from companies_places




  -- CRIADO POR ZETI
 -- relatório localizado na rotina abaixo
 -- faturameto/relatório/faturaento por local (sintético)
 --
 --
SELECT p.state 'Stado', SUM(in2.total_amount_liquid) as 'Total'
FROM invoice_notes in2
INNER JOIN contracts c ON c.id = in2.contract_id
INNER JOIN people p ON p.id = in2.client_id
INNER JOIN invoice_series iss ON iss.id = in2.invoice_serie_id
INNER JOIN companies_places cpp ON cpp.id = in2.company_place_id
 -- INNER JOIN financial_receivable_titles frt ON in2.id = frt.invoice_note_id
 -- INNER JOIN invoice_note_items ini ON in2.id = ini.invoice_note_id
WHERE in2.issue_date BETWEEN '2021-10-01' AND '2021-10-25'
AND c.`status` IN (1,2,3,4,5,6,7,9) AND c.stage = '3'
 -- AND in2.financial_operation_id IN (64)
 -- AND ini.description LIKE '%SCM%'
 -- AND in2.billing_competence BETWEEN '2019-12-01' AND '2020-02-28'
AND in2.cancellation_date IS NULL
AND iss.id = 1
AND c.deleted = 0
AND cpp.id = 1








SELECT cp.description 'Local',
c.bill_company_place_id,
c.contract_number 'N°Contrato',
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
and c.bill_company_place_id is null
 -- and c.contract_number = 71141
     -- 71141
 -- GROUP BY p.city