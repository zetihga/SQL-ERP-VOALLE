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
            left join financial_receipt_titles ON frt.id = financial_receipt_titles.financial_receivable_title_id
            join people p on frt.client_id = p.id
            left join contracts c ON frt.contract_id = c.id
                where -- p.id = 96055 and
                    frt.balance > 0
   -- and frt.expiration_date < '2021-07-06'
                    and frt.renegotiated = 0
                    and frt.entry_date <= '2020/12/31'
                    and frt.bank_title_number is not null
                    and frt.deleted = 0

    /*títulos emitidos até 31/12/20
    -- títulos pagos e abertos em 2020 fica
    -- títulos emitidos em 2020 pago em 2021 fica*/

