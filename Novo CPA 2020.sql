SELECT
        cp.code 'Local',
        cp.id,
        cp.description 'Empresa',
        fpt.entry_date 'Data criação',
        fpt.expiration_date 'Data_Vencimento',
         -- DATE_FORMAT(fpt.expiration_date, '%d/%m/%y')'Data de Vencimento',
        fpt.title 'ID_Título',
        p.name 'Nome_Fornecedor',
        fpt.complement 'Complemento_Titulo',
        fn.title 'Natureza_Financeira',
         -- fcc.title 'Centro_Custos',
        fpt.title_amount 'Valor',
        fpt.balance'Saldo',
        p.city 'Cidade',
        p.tx_id 'CPF_CNPJ',
        f.payment_date 'Data_Pagamento',
       fpt.competence 'Competencia_Pagamento',
        f.total_amount 'Valor_total_Pago',
        f.discount_value 'Desconto_Aplicado',
        f.increase_amount 'Acrescimo_Aplicado',
        fdccp.amount 'Valor_Rateio',
        ba.description 'Conta_Pagamento',
        b.name 'Banco'
    FROM financial_payable_titles fpt
     LEFT JOIN financial_paid_titles f ON fpt.id = f.financial_payable_title_id AND f.deleted = 0
     LEFT JOIN financers_natures fn ON fpt.financer_nature_id = fn.id
     LEFT JOIN bank_accounts ba on f.bank_account_id = ba.id
     LEFT JOIN banks b on b.id = ba.bank_id
     LEFT JOIN companies_places cp on cp.id = fpt.company_place_id
     left JOIN financial_divide_cost_center_previsions fdccp ON fpt.id = fdccp.financial_payable_title_id
     -- left JOIN financial_cost_centers fcc ON fdccp.financial_cost_center_id = fcc.id
     JOIN people p ON fpt.supplier_id = p.id
     LEFT JOIN invoice_notes i ON fpt.invoice_note_id = i.id
     WHERE fpt.deleted = 0
            AND fpt.v_final_amount >= 0
            AND f.payment_date > '2021-02-01'
            and fpt.expiration_date BETWEEN '2021-09-23' AND '2027-12-31'
            GROUP BY fpt.id;
