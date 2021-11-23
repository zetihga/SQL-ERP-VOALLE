select c.contract_number 'N° Contrato',
       c.beginning_date,
       p.created,
       p.name 'Nome',
       p.city 'Cidade',
       case
           when c.invoice_type = 1 then 'Mensal'
           when c.invoice_type = 2 then 'Múltiplas Operações'
           when c.invoice_type = 3 then 'Comunicação'
           when c.invoice_type = 4 then 'Antecipado'
           when c.invoice_type = 5 then 'Não prevê faturamento'
               end 'Tipo de faturamento',
       c.invoice_type,
       ct.title 'Tipo de contrato',
       c.cut_day 'Dia de corte',
       c.observation 'Observação Contrato',
       c.amount 'Valor',
       c.beginning_date 'Faturar DE',
        -- c.observation_billing 'Observação Faturamento',
        -- p.city 'Cidade',
       DATE_FORMAT(ce.date,'%d/%m/%Y')AS 'Data'
  from contract_events ce
join contracts c on ce.contract_id = c.id
join people p on c.client_id = p.id
join contract_types ct on c.contract_type_id = ct.id
and ce.contract_event_type_id = 165
where ce.description like '%Contrato Aprovado pela Rotina de Aprovação automática Aprovado pela rotina automática%'
 -- and c.cut_day is NULL
 -- and c.amount = '89.90'
 -- group by ct.title
having Data = '29/10/2021'






    select	c.date as 'data_criacao_registro',
    c.approval_date as 'Data_aprovacao',
    c.billing_beginning_date,
    c.contract_number as 'num_contrato',
    c.description as 'descricao_contrato',
    cev.v_total_amount 'Valor_eventual',
    replace (cev.justification,'\n','') as 'Justificativa',
CASE cev.invoiced
WHEN 1 THEN 'Faturado'
WHEN 0 THEN 'Não faturado'
END 'Status_evetual',
cev.month_year as 'Competencia'
from contracts as c
join contract_eventual_values as cev on cev.contract_id = c.id
where c.stage = 3
and c.status not in (4,9)
and c.deleted = 0
AND c.approval_date BETWEEN '2021-10-27' AND '2021-10-28'
AND c.approval_date = c.billing_beginning_date
and cev.deleted = 0
and cev.v_total_amount >= '0' AND cev.v_total_amount <= '10,00';






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
and frt.expiration_date between '2021-06-01' and '2021-08-31'
 -- and p.name like '%Carlos Henrique Fernandes Gimenez%'


