-- CRIADO POR ZETI
 -- relatório localizado na rotina abaixo
 -- faturameto/relatório/faturaento por local (sintético)

SELECT p.city,
       cpp.description,
       count(c.id) 'Contratos',
       SUM(in2.total_amount_liquid) as 'Total'
FROM invoice_notes in2
INNER JOIN contracts c ON c.id = in2.contract_id
INNER JOIN people p ON p.id = in2.client_id
INNER JOIN invoice_series iss ON iss.id = in2.invoice_serie_id
INNER JOIN companies_places cpp ON cpp.id = in2.company_place_id
 -- INNER JOIN financial_receivable_titles frt ON in2.id = frt.invoice_note_id
 -- INNER JOIN invoice_note_items ini ON in2.id = ini.invoice_note_id
WHERE in2.issue_date BETWEEN '2021-05-01' AND '2021-05-31'
AND c.`status` IN (1,2,3,4,5,6,7,9) AND c.stage = '3'
 -- AND in2.financial_operation_id IN (64)
 -- AND ini.description LIKE '%SCM%'
 -- AND in2.billing_competence BETWEEN '2019-12-01' AND '2020-02-28'
AND in2.cancellation_date IS NULL
AND iss.id = 1
AND c.deleted = 0
AND cpp.id = 1
GROUP BY p.city,cpp.description;
 -- 26,27,28,29,30,31,32,53,59,
 --  p.name,ini.description,in2.financial_operation_id
 -- p.state,

select * from authentication_contracts