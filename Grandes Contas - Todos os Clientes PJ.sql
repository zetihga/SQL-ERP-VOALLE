SELECT
    sum(ci.total_amount) as 'Total Agrupador',
    (sum(ci.total_amount) - c.amount ) as 'Desmonstração',
    c.amount 'TotalContrato',
    CASE
           WHEN c.status = 1 THEN 'Normal'
           WHEN c.status = 2 THEN 'Demonstração'
           WHEN c.status = 3 THEN 'Cortesia'
           WHEN c.status = 4 THEN 'Cancelado'
           WHEN c.status = 5 THEN 'Suspenso'
           WHEN c.status = 6 THEN 'Bloqueio Financeiro'
           WHEN c.status = 7 THEN 'Bloqueio Administrativo'
           WHEN c.status = 9 THEN 'Encerrado'
        END AS 'Status',
       CASE
           WHEN c.stage = 1 THEN 'Pré-Contrato'
           WHEN c.stage = 2 THEN 'Em Aprovação'
           WHEN c.stage = 3 THEN 'Aprovado'
           WHEN c.stage = 4 THEN 'Rejeitado'
           WHEN c.stage = 5 THEN 'Cancelado'
        END AS 'Situação',
    p.name 'Nome',
    cp.description 'Local',
    c.contract_number 'N°Contrato',
    c.description 'Descrição',
    p.email 'E-mail',
    p.cell_phone_1 'Celular',
    p.phone 'Telefone',
    p.tx_id 'Documento',
    p.birth_date 'Data de Nascimento',
    p.postal_code 'CEP',
    p.street 'Rua',
    p.street_type 'Tipo',
    p.number 'Número',
    p.address_complement 'Complemento',
    p.neighborhood 'Bairro',
    p.city 'Cidade',
    p.state 'Estado',
    p.country 'Pais',
    p.address_reference 'Ponto de referencia',
    c.collection_day 'Dia de Vencimento',
    c.beginning_date 'Data de Cadastro',
    c.approval_date 'Data de Aprovação',
    c.approval_date 'Data Ativação',
    c.cancellation_date 'Data Cancelamento'
    from Contract_configuration_billings as cb
JOIN contracts AS c ON c.id = cb.contract_id
join financial_operations as fo ON fo.id = cb.financial_operation_id
  inner join people as p on p.id = c.client_id
  inner join tx_types as tt on p.type_tx_id = tt.id
  inner join contract_items as ci on ci.contract_configuration_billing_id = cb.id
  inner join financers_natures as fn ON fn.id = cb.financer_nature_id
  inner join companies_places as cp on cp.id = cb.company_place_id
  left join financial_collection_types fct on cb.financial_collection_type_id = fct.id
    where ci.deleted = 0
   and c.deleted = 0
   and c.status not in (4,9) and c.stage = 3
   and p.type_tx_id = 1
   group by c.contract_number

