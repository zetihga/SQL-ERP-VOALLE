SELECT c.contract_number Contrato,
       CASE
           WHEN c.status = 1 THEN 'Normal'
           WHEN c.status = 2 THEN 'Demonstração'
           WHEN c.status = 3 THEN 'Cortesia'
           WHEN c.status = 4 THEN 'Cancelado'
           WHEN c.status = 5 THEN 'Suspenso'
           WHEN c.status = 6 THEN 'Bloqueio Financeiro'
           WHEN c.status = 7 THEN 'Bloqueio Administrativo'
           WHEN c.status = 9 THEN 'Encerrado'
        END AS 'Situação - Contrato',
       CASE
           WHEN c.stage = 1 THEN 'Pré-Contrato'
           WHEN c.stage = 2 THEN 'Em Aprovação'
           WHEN c.stage = 3 THEN 'Aprovado'
           WHEN c.stage = 4 THEN 'Rejeitado'
           WHEN c.stage = 5 THEN 'Cancelado'
       END AS 'Status - Contrato',
       frt.title 'Nº Título',
       frt.title_amount Valor,
       frt.balance AS Saldo,
    CASE
        WHEN frt.balance > 0 THEN 'Em Aberto'
        WHEN frt.balance = 0 THEN 'Liquidado'
    END AS Em_aberto_liquidado,
    CASE
        WHEN frt.finished = 0 THEN 'Não Baixado'
        WHEN frt.finished = 1 THEN 'Baixado'
    END AS Baixado,
    CASE
        WHEN frt.protest = 0 THEN 'Não protestado'
        WHEN frt.protest = 1 THEN 'Em Protesto'
    END AS Protesto,
       p.name Cliente,
       p.city Cidade,
       frt.issue_date Emissão,
       frt.expiration_date Vencimento,
       DATEDIFF(CURRENT_DATE(), frt.expiration_date) 'Dias em atraso',
       fct.title 'Tipo Cobrança'
    FROM financial_receivable_titles frt
    LEFT JOIN financial_receipt_titles frr ON frt.id = frr.financial_receivable_title_id AND frt.deleted = 0
    JOIN contracts c ON frt.contract_id = c.id
    JOIN people p ON c.client_id = p.id AND p.type_tx_id = 2
    JOIN financial_collection_types fct ON frt.financial_collection_type_id = fct.id
    WHERE frr.id IS NULL
    AND frt.deleted = 0
    AND frt.renegotiated = 0
    AND frt.bill_title_id IS NULL
    AND DATEDIFF(CURRENT_DATE(), frt.expiration_date) > 0
    #AND p.name LIKE '%%Juliano Aparecido Monteiro' #Para teste
    ORDER BY `Dias em atraso` DESC;


select * from authentication_contracts ac
where ac.user like ('%adilsonfonseca%' or '%alessandrobellan%')

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
join contracts c ON frt.contract_id = c.id
where -- p.id = 96055 and
    frt.balance > 0 and
     -- frt.expiration_date < '2021-07-06' and
      frt.renegotiated = 0 and
      frt.bank_title_number is not null and
      frt.deleted = 0


SELECT COUNT(*) 'Quantidade',
       c.contract_number Contrato,
       CASE
           WHEN c.status = 1 THEN 'Normal'
           WHEN c.status = 2 THEN 'Demonstração'
           WHEN c.status = 3 THEN 'Cortesia'
           WHEN c.status = 4 THEN 'Cancelado'
           WHEN c.status = 5 THEN 'Suspenso'
           WHEN c.status = 6 THEN 'Bloqueio Financeiro'
           WHEN c.status = 7 THEN 'Bloqueio Administrativo'
           WHEN c.status = 9 THEN 'Encerrado'
        END AS 'Situação - Contrato',
       CASE
           WHEN c.stage = 1 THEN 'Pré-Contrato'
           WHEN c.stage = 2 THEN 'Em Aprovação'
           WHEN c.stage = 3 THEN 'Aprovado'
           WHEN c.stage = 4 THEN 'Rejeitado'
           WHEN c.stage = 5 THEN 'Cancelado'
       END AS 'Status - Contrato',
       frt.title 'Nº Título',
       frt.title_amount Valor,
       frt.balance AS Saldo,
    CASE
        WHEN frt.balance > 0 THEN 'Em Aberto'
        WHEN frt.balance = 0 THEN 'Liquidado'
    END AS Em_aberto_liquidado,
    CASE
        WHEN frt.finished = 0 THEN 'Não Baixado'
        WHEN frt.finished = 1 THEN 'Baixado'
    END AS Baixado,
    CASE
        WHEN frt.protest = 0 THEN 'Não protestado'
        WHEN frt.protest = 1 THEN 'Em Protesto'
    END AS Protesto,
       p.name Cliente,
       p.city Cidade,
       frt.issue_date Emissão,
       frt.expiration_date Vencimento,
       DATEDIFF(CURRENT_DATE(), frt.expiration_date) 'Dias em atraso',
       fct.title 'Tipo Cobrança'
    FROM financial_receivable_titles frt
    LEFT JOIN financial_receipt_titles frr ON frt.id = frr.financial_receivable_title_id AND frt.deleted = 0
    JOIN contracts c ON frt.contract_id = c.id
    JOIN people p ON c.client_id = p.id AND p.type_tx_id = 2
    JOIN financial_collection_types fct ON frt.financial_collection_type_id = fct.id
    WHERE frr.id IS NULL
    AND frt.deleted = 0
    AND frt.renegotiated = 0
    AND frt.bill_title_id IS NULL
    AND p.name like '%Lucia Candido%'
    AND frt.expiration_date BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 30 day) AND CURRENT_DATE+1
GROUP BY c.contract_number
HAVING Quantidade = 1







