select
    p.name 'Nome',
    c.client_id 'CodCliente',
    c.description,
    c.contract_number 'N° Contrato',
    p.created 'Data cadastro',
    p.phone 'Telefone1',
    p.cell_phone_1 'Telefone2',
    frt.title 'Titulo',
    frt.issue_date 'data emissão',
    inn.document_number,
    frt.expiration_date 'DT de vencimento',
    frt.balance 'Valor'
from financial_receivable_titles frt
left join people p on frt.client_id = p.id
left join contracts c ON frt.contract_id = c.id
left join invoice_notes inn on frt.invoice_note_id = inn.id
where -- p.id = 96055 and
     -- frt.balance > 0
     -- frt.expiration_date < '2021-07-06' and
      frt.renegotiated = 0
       -- and frt.bank_title_number is not null
      and frt.deleted = 0
      and frt.finished = 0
      and p.name like '%Prefeitura Municipal de Ourinhos%'
       -- and frt.title = 'FAT210505542523441'
       -- and frt.origin = 8
      and frt.p_is_receivable = 1

select * from invoice_notes inn
where inn.client_name like '%ZYXEL COMMUNICATIONS DO BRASIL LTDA.%'



select * from invoice