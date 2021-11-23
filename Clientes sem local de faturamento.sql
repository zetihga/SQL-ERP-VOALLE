SELECT cp.description 'Local',
c.bill_company_place_id,
c.contract_number 'N°Contrato',
p.name 'Nome'
from contracts c
INNER JOIN people p ON c.client_id = p.id
INNER JOIN companies_places cp ON cp.id = c.company_place_id
WHERE c.`status` IN (1,2,3,5,6,7) AND c.stage IN (3)
AND c.deleted = 0
and c.bill_company_place_id is null

 -- GROUP BY p.city


select * from incident
join solicitation_classifications_solicitation_problems scsp
where ii.id = 1539

select * from solicitation_classifications sc
join incident_types it on sc.incident_type_id = it.id
where it.id = 1539

select * from incident_types it
join solicitation_classifications sc on it.id = sc.incident_type_id
where it.id = 1539

select * from solicitation_classifications sc





SELECT
it.title AS 'Solicitação Tipo'
 -- sp.title AS 'Problema',
 -- sc.title AS 'Contexto'
from assignment_incidents ai
join incident_types it on ai.incident_type_id = it.id
 -- LEFT JOIN solicitation_problems sp ON ai.solicitation_problem_id = sp.id
 -- LEFT JOIN solicitation_classifications sc ON sc.id = ai.solicitation_classification_id
where it.id = 1539




SELECT cp.description 'Local',
p.name 'Nome',
case
		when p.type_tx_id = 2 then 'PF'
		when p.type_tx_id = 1 then 'PJ'
END 'Tipo',
p.city 'Cidade',
ba.description 'Conta',
frt.fine_amount 'Acrescimo',
frt.discount_value 'Desconto',
frt.amount 'Valor Pago',
frt.total_amount 'Valor Total',
frt.receipt_date 'Data Recebimento',
case
		when frt.payment_form_id = 1 then 'Dinheiro'
		when frt.payment_form_id = 2 then 'Cheque a vista'
		when frt.payment_form_id = 3 then 'Cheque Pré'
		when frt.payment_form_id = 4 then 'Cartão Débito'
		when frt.payment_form_id = 5 then 'Cartão Crédito'
		when frt.payment_form_id = 6 then 'Crediário'
		when frt.payment_form_id = 7 then 'Boleto'
		when frt.payment_form_id = 8 then 'Débito'
		when frt.payment_form_id = 9 then 'PIX'
END 'Forma de pagamento'
from financial_receipt_titles frt
INNER JOIN people p ON p.id = frt.client_id
INNER JOIN companies_places cp ON frt.company_place_id = cp.id
INNER JOIN bank_accounts ba ON ba.id = frt.bank_account_id
INNER JOIN financial_receivable_titles frtt ON frtt.id = frt.financial_receivable_title_id
WHERE frt.receipt_date BETWEEN '2021-01-01' AND '2021-12-31'
AND cp.code = 5
AND frt.payment_form_id IS NOT NULL
AND frtt.bill_title_id IS NULL






SELECT cp.description 'Local',
fn.title 'Natureza Financeira',
frtt.title 'Titulo',
p.name 'Nome',
case
		when p.type_tx_id = 2 then 'PF'
		when p.type_tx_id = 1 then 'PJ'
END 'Tipo',
p.city 'Cidade',
ba.description 'Conta',
frt.fine_amount 'Acrescimo',
frt.discount_value 'Desconto',
frt.amount 'Valor Pago',
frt.total_amount 'Valor Total',
frt.receipt_date 'Data Recebimento',
case
		when frt.payment_form_id = 1 then 'Dinheiro'
		when frt.payment_form_id = 2 then 'Cheque a vista'
		when frt.payment_form_id = 3 then 'Cheque Pré'
		when frt.payment_form_id = 4 then 'Cartão Débito'
		when frt.payment_form_id = 5 then 'Cartão Crédito'
		when frt.payment_form_id = 6 then 'Crediário'
		when frt.payment_form_id = 7 then 'Boleto'
		when frt.payment_form_id = 8 then 'Débito'
		when frt.payment_form_id = 9 then 'PIX'
END 'Forma de pagamento'
from financial_receipt_titles frt
INNER JOIN people p ON p.id = frt.client_id
INNER JOIN companies_places cp ON frt.company_place_id = cp.id
INNER JOIN bank_accounts ba ON ba.id = frt.bank_account_id
INNER JOIN financial_receivable_titles frtt ON frtt.id = frt.financial_receivable_title_id
join financers_natures fn on frt.financer_nature_id = fn.id
WHERE frt.receipt_date BETWEEN '2021-09-01' AND '2021-09-10'
AND frt.payment_form_id IS NOT NULL
AND frtt.bill_title_id IS NULL