Select
p.name 'Nome',
frt.competence 'Competencia',
in2.financial_operation_id 'Cod Operação',
fo.title 'Operação',
c.amount 'Valor plano',
frt.title_amount 'Valor Faturado',
p.city 'Cidade',
p.type_tx_id 'Pf ou Pj',
c.billing_beginning_date 'Faturar De',
c.beginning_date 'Data de Aprovação',
c.`status` 'Status',
       case
            WHEN in2.id IS NULL THEN 'NÃO FATURADO'
            WHEN in2.id IS NOT NULL THEN 'FATURADO'
      END 'STATUS'
FROM invoice_notes in2
		LEFT JOIN financial_receivable_titles frt ON in2.id = frt.invoice_note_id
		JOIN contracts c ON c.id = frt.contract_id
		JOIN people p ON p.id = frt.client_id
		JOIN financial_operations fo ON fo.id = frt.financial_operation_id
	WHERE  -- DATE_FORMAT(frt.competence,'2021-07-01','%d/%m/%Y')
 -- AND in2.issue_date BETWEEN '2021-01-01' AND '2021-06-30'
c.stage = '3'
 -- AND frt.`type` = 2
 -- AND frt.deleted = 0
 -- AND frt.finished = 0
AND frt.bill_title_id IS NULL
and frt.expiration_date between '2021-08-01' and '2021-08-01'
and in2.id IS NULL
AND c.`status` IN (1,2,3,5,6,7)



SELECT
    p.id 'Cod Cliente',
    p.name 'Nome',
    c.contract_number 'N° Contrato',
    CASE
           WHEN c.status = 1 THEN 'Normal'
           WHEN c.status = 2 THEN 'Demonstração'
           WHEN c.status = 3 THEN 'Cortesia'
           WHEN c.status = 4 THEN 'Cancelado'
           WHEN c.status = 5 THEN 'Suspenso'
           WHEN c.status = 6 THEN 'Bloqueio Financeiro'
           WHEN c.status = 7 THEN 'Bloqueio Administrativo'
           WHEN c.status = 9 THEN 'Encerrado'
        END AS 'Status',
       CASE
           WHEN c.stage = 1 THEN 'Pré-Contrato'
           WHEN c.stage = 2 THEN 'Em Aprovação'
           WHEN c.stage = 3 THEN 'Aprovado'
           WHEN c.stage = 4 THEN 'Rejeitado'
           WHEN c.stage = 5 THEN 'Cancelado'
        END AS 'Situação',
        p.city 'Cidade',
     -- COUNT(distinct p.tx_id) 'Base',
    count(frt.title)'Qtd Títulos TOTAL',
    sum(frt.balance)'Qtd Títulos valor'
            from financial_receivable_titles frt
            join people p on frt.client_id = p.id
            join contracts c ON c.id = frt.client_id
                 where frt.balance > 0
	                 and frt.deleted = 0
	                 and frt.p_is_receivable = 1
	                  -- and frt.bank_title_number is not null
	                  -- and frt.finished = 0
	                  -- and frt.renegotiated = 0
	                  GROUP BY p.name;