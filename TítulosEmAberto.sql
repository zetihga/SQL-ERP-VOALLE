SELECT
    p.city'Cidade',
    COUNT(distinct p.tx_id) 'Base',
    COUNT(frt.title)'Qtd Títulos TOTAL',
    SUM(frt.balance)'Qtd Títulos valor',
    SUM(if(frt.expiration_date < CURDATE(),1,0))'Vencido'
 -- SUM(if(DATEDIFF(CURDATE(),frt.expiration_date) < 16,1,0))'1 a 15',
      --   SUM(if(DATEDIFF(CURDATE(),frt.expiration_date) > 0 AND DATEDIFF(CURDATE(),frt.expiration_date) <= 15,1,0))'0 a 15'
 -- SUM(if(CURDATE() > frt.expiration_date ,1,0))'Em dia' */
      /* p.name 'Nome',
       p.tx_id 'CPF ou CNPJ',
       SUM(if(DATEDIFF(CURDATE(),frt.expiration_date) >= 91,1,0))'Mais de 90',
       p.city 'Cidade',
       c.contract_number 'N° Contrato',
       frt.title 'Titulo',
       frt.expiration_date '30',
       frt.balance 'Valor' */
            from financial_receivable_titles frt
            join people p on frt.client_id = p.id
            join contracts c ON c.id = frt.client_id
                where frt.balance > 0
	                and frt.deleted = 0
	                and frt.p_is_receivable = 1
	                and frt.renegotiated = 0
	                and c.status NOT IN (4,9)
	                and frt.expiration_date BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) AND CURRENT_DATE
                     -- and p.city like'%Ourinhos%'
	                and p.city IS NOT NULL
                    and frt.origin != 11
                    and frt.erp_code is NULL
	                GROUP BY p.city;

SELECT
    p.city'Cidade',
    COUNT(distinct p.tx_id) 'Base',
    COUNT(frt.title)'Qtd Títulos TOTAL',
    SUM(frt.balance)'Qtd Títulos valor',
    SUM(if(frt.expiration_date < 5,1,0))'Vencido'
 -- SUM(if(DATEDIFF(CURDATE(),frt.expiration_date) < 16,1,0))'1 a 15',
 -- SUM(if(CURDATE() > frt.expiration_date ,1,0))'Em dia' */
      /* p.name 'Nome',
       p.tx_id 'CPF ou CNPJ',
       SUM(if(DATEDIFF(CURDATE(),frt.expiration_date) >= 91,1,0))'Mais de 90',
       p.city 'Cidade',
       c.contract_number 'N° Contrato',
       frt.title 'Titulo',
       frt.expiration_date '30',
       frt.balance 'Valor' */
            from financial_receivable_titles frt
            join people p on frt.client_id = p.id
            join contracts c ON c.id = frt.client_id
                where frt.balance > 0
	                and frt.deleted = 0
	                and frt.p_is_receivable = 1
	                and frt.renegotiated = 0
	                and c.status NOT IN (4,9)
                     -- and p.city like'%Ourinhos%'
                     -- [[and frt.expiration_date BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL{{DATA_DIAS}}DAY) AND CURRENT_DATE]]
	                and p.city IS NOT NULL
                    and frt.erp_code is NULL
                    and frt.origin != 11
	                GROUP BY p.city;




 select
    cp.code 'Local',
    p.name 'Cliente',
    p.phone 'Fone',
    p.cell_phone_1 'Celular',
    frt.title 'Titulo',
    frt.parcel 'Parcela',
    frt.bank_title_number 'NN',
    ba.description 'Conta',
    frt.complement 'Complemento',
    in2.document_number 'N_Documento(NF)',
    frt.entry_date 'Emissao',
    frt.expiration_date 'Vcto',
    frt.original_expiration_date 'Vcto_Original',
    frt.title_amount 'Vlr_titulo',
    CASE WHEN DATEDIFF(current_date, frt.expiration_date) > 1 THEN
      ROUND((0.02 * frt.title_amount),2)
   ELSE
      0.0
   END AS 'Multa',
   CASE WHEN DATEDIFF(current_date, frt.expiration_date) > 1 THEN
     ROUND(((frt.title_amount/30)* 0.033),2)
   ELSE
      0.0
   END AS 'Juros',
   ROUND(frt.title_amount + (0.02 * frt.title_amount) + ((frt.title_amount/30)*0.033),2) 'Saldo',
    frt.finished,
    frt.deleted
from financial_receivable_titles frt
    join people p on frt.client_id = p.id
    join invoice_notes in2 on frt.invoice_note_id = in2.id
    join bank_accounts ba on frt.bank_account_id = ba.id
    join companies_places cp on ba.company_place_id = cp.id
where frt.entry_date between '2021-07-01' and '2021-07-01'
      and frt.balance != 0
      and frt.deleted = 0
      and frt.bank_title_number is not null
      and frt.title like '%FAT%'
       -- [[and cp.code = {{Local}};]]


select * from contracts c
join authentication_contracts on c.id = authentication_contracts.contract_id
where c.contract_number = 128356

select c.contract_number, p.id, p.name,count(ac.user),count(p.name), pp.name from contracts c
join people p on p.id = c.client_id
join contract_events ce on c.contract_event_id = ce.id
join authentication_contracts ac on c.id = ac.contract_id
join people pp on pp.id = ce.person_id
where ce.description like '%Alteração de Data do Próximo Reajuste - Justificativa: Reajuste da data do próximo reajuste do contrato número%'
and DATE_FORMAT(ce.created,'2021-08-31','%d/%m/%Y')
group by p.name,ac.user




select
    c.client_id 'CodCliente',
    p.name 'Cliente',
    p.tx_id 'Documento',
    CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
    c.contract_number 'N° Contrato',
     -- ai.protocol,
     -- t.title,
    frt.expiration_date 'DT de vencimento',
    frt.balance 'Valor',
    CASE
        WHEN frt.balance = 0 THEN 'PAGO'
        WHEN frt.balance > 0 THEN 'EM ABERTO'
    END 'STATUS'
from financial_receivable_titles frt
join people p on frt.client_id = p.id
left join contracts c ON frt.contract_id = c.id
left join financers_natures fn on frt.financer_nature_id = fn.id
 -- left join assignment_incidents ai on p.id = ai.client_id
 -- left join teams t on ai.team_id = t.id
 -- join assignments a on ai.assignment_id = a.id
 -- join incident_types it on ai.incident_type_id = it.id
where -- p.id = 96055 and
      frt.balance >= 0 and
      frt.renegotiated = 0
      and frt.bank_title_number is not null
      and frt.deleted = 0
      and frt.finished = 0
       -- and t.title like '%Instalação%'
       -- and it.title like '%Instalação%'
      and fn.id = 427



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
AND fo.title NOT LIKE '%CIS%'
and fo.title NOT LIKE '%Nota de%'



select
    p.name 'Nome',
    c.client_id 'CodCliente',
    c.contract_number 'N° Contrato',
    p.created 'Data cadastro',
    p.phone 'Telefone1',
    p.cell_phone_1 'Telefone2',
    frt.title 'Titulo',
    frt.issue_date 'data emissão',
    frt.expiration_date 'DT de vencimento',
    frt.balance 'Valor'
from financial_receivable_titles frt
join people p on frt.client_id = p.id
left join contracts c ON frt.contract_id = c.id
where
        frt.balance > 0
    and frt.renegotiated = 0
    and frt.bank_title_number is not null
    and frt.deleted = 0
    and frt.finished = 0
      -- frt.expiration_date < '2021-07-06' and



select
    p.name 'Nome',
    c.client_id 'CodCliente',
    c.contract_number 'N° Contrato',
    p.created 'Data cadastro',
    p.phone 'Telefone1',
    p.cell_phone_1 'Telefone2',
    frt.title 'Titulo',
    frt.issue_date 'data emissão',
    frt.expiration_date 'DT de vencimento',
    frt.balance 'Valor'
        from financial_receivable_titles frt
        join people p on frt.client_id = p.id
        left join contracts c ON frt.contract_id = c.id
            where frt.balance > 0
                and frt.renegotiated = 0
                and frt.finished = 0
                and frt.deleted = 0
                and frt.bank_title_number is not null


select frt.title ,p.tx_id ,p.name, c.contract_number,frt.typeful_line from financial_receivable_titles frt
join contracts c on frt.contract_id = c.id
join people p on c.client_id = p.id
where frt.typeful_line = '23793.38409 40000.001095 30002.162003 1 87690000007990'

 -- 23793.38409 40000.001095 30002.162003 1 87690000007990

  -- 23793.38409 90000.001090 30002.162003 7 87690000007990


select
    p.name 'Nome',
    c.client_id 'CodCliente',
     frt.title 'Titulo',
    c.contract_number 'N° Contrato',
    frt.expiration_date 'DT de vencimento',
    frt.balance 'Valor'
from financial_receivable_titles frt
join people p on frt.client_id = p.id
left join contracts c ON frt.contract_id = c.id
where -- p.id = 96055 and
    frt.balance > 0 and
     -- frt.expiration_date < '2021-07-06' and
      frt.renegotiated = 0 and
       -- frt.bank_title_number is not null and
      frt.deleted = 0
      and frt.finished = 0
      AND frt.title like '%FAT%'
     -- and p.name like '%Adriano Luna%'