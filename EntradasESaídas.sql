select
    cp.id 'Local',
    fp.created 'Data',
    ba.description 'Conta',
    fn.title 'Natureza_Financeira',
    fp.complement 'Descricao',
    fp.amount 'Valor',
    CASE
           WHEN fp.signal = 1 THEN 'Entrada'
           WHEN fp.signal = 2 THEN 'Saida'
    END AS 'Sinal'
from financial_postings fp
    join financers_natures fn on fp.financer_nature_id = fn.id
    join bank_accounts ba on fp.bank_account_id = ba.id
    join companies_places cp on fp.company_place_id = cp.id
where fp.financia between '2021-06-26' and '2021-06-26'
     -- [[and fp.signal = {{Signal}};]]