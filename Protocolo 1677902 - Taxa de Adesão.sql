Select * from contracts c
join people p on c.client_id = p.id
join assignments a on c.assignment_id = a.id
 -- join teams t on a.team_id = t.id


SELECT     p.name 'Nome',
        -- c.client_id 'Cod Cliente',
        -- c.contract_number 'N°Contrato',
           frt.title 'N° Titulo',
        -- c.amount 'Valor do contrato atual',
        -- frt.title_amount 'Valor do Título',
        -- frt.competence 'Competencia',
        -- DATE_FORMAT(frt.original_expiration_date, '%d/%m/%y') 'Data de vencimento original',
        -- DATE_FORMAT(frt.expiration_date, '%d/%m/%y') 'Data vencimento',
        -- DATE_FORMAT(frtt.receipt_date, '%d/%m/%y') 'Data de pagamento',
           frtt.amount 'Valor pago'
        -- fn.title 'Natureza Financeira'
FROM contracts c
INNER JOIN people p ON p.id = c.client_id
LEFT JOIN financial_receivable_titles frt on c.id = frt.contract_id
LEFT JOIN financial_receipt_titles frtt on frt.id = frtt.financial_receivable_title_id
left JOIN financers_natures fn on frt.financer_nature_id = fn.id
WHERE frt.deleted = 0
AND frt.bill_title_id is null
and frtt.receipt_date between '2020-01-01' and '2021-12-31'
 -- AND frt.title = 'FAT210807293122076'
and p.name like '%Rita de Cássia Dutra da Silva%'
 -- GROUP BY c.contract_number,frtt.amount;