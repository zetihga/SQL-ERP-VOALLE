select
    c.client_id 'CodCliente',
    p.name 'Cliente',
    p.tx_id 'Documento',
    CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
    c.contract_number 'N° Contrato',
    frt.created 'Data Emissão',
    frt.expiration_date 'DT de vencimento',
    frtt.receipt_date 'Data de Pagamento',
    frt.balance 'A pagar',
    CASE
        WHEN frt.balance = 0 THEN 'PAGO'
        WHEN frt.balance > 0 THEN 'EM ABERTO'
    END 'STATUS'
from financial_receivable_titles frt
join people p on frt.client_id = p.id
left join contracts c ON frt.contract_id = c.id
left join financers_natures fn on frt.financer_nature_id = fn.id
left join financial_receipt_titles frtt on frt.id = frtt.financial_receivable_title_id
where frt.balance >= 0 and
      frt.renegotiated = 0
      and frt.bank_title_number is not null
      and frt.deleted = 0
      and frt.finished = 0
      and frtt.deleted = 0
      and fn.id in (427,312)
      and frt.expiration_date > '2021/01/01'