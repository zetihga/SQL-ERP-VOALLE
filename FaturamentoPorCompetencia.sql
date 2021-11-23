SELECT
cp.description 'Local',
p.name 'Nome',
frt.competence 'Competencia',
in2.financial_operation_id 'Cod Operação',
fo.title 'Operação',
DATE_FORMAT(frt.competence,'%d/%m/%Y')AS 'Data',
c.amount 'Valor plano',
 CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
frt.title_amount 'Valor Faturado',
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
c.beginning_date 'Data de Aprovação',
       case
            WHEN in2.id IS NULL THEN 'NÃO FATURADO'
            WHEN in2.id IS NOT NULL THEN 'FATURADO'
      END 'STATUS'
FROM invoice_notes in2
		LEFT JOIN financial_receivable_titles frt ON in2.id = frt.invoice_note_id
		JOIN contracts c ON c.id = frt.contract_id
		JOIN people p ON p.id = frt.client_id
		JOIN financial_operations fo ON fo.id = frt.financial_operation_id
		JOIN companies_places cp ON cp.id = c.company_place_id
	WHERE c.stage = '3'
AND frt.competence between '2021-08-01' and '2021-08-31'
 -- AND c.created <= '2021-07-31'
 -- AND frt.`type` = 2
 -- AND frt.deleted = 0
 -- AND frt.finished = 0
AND frt.bill_title_id IS NULL
and fo.title not like '%NFSE%'
and in2.id IS NOT NULL
AND c.`status` IN (1,2,3,4,5,6,7,9)
 -- AND fo.title NOT LIKE '%CIS%'
    and fo.title NOT LIKE '%Nota de%'
    and frt.finished = 0
    and frt.renegotiated = 0




