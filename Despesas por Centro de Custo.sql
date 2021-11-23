# Despesas por Centro de Custos
SELECT `Central de Custos`, SUM(`Valor Divisor`) Total FROM
    (SELECT
       fpt.title_amount 'Valor do Título',
       f.amount 'Valor',
       fdccp.amount 'Valor Divisor',
       fpt.paid_amount 'Valor pago',
       fn.title 'Natureza',
       fcc.title 'Central de Custos'
       FROM financial_payable_titles fpt
    JOIN financial_paid_titles f ON fpt.id = f.financial_payable_title_id AND f.deleted = 0
    LEFT JOIN financers_natures fn ON fpt.financer_nature_id = fn.id
    JOIN financial_divide_cost_center_previsions fdccp ON fpt.id = fdccp.financial_payable_title_id
    JOIN financial_cost_centers fcc ON fdccp.financial_cost_center_id = fcc.id
    WHERE f.payment_date BETWEEN '2020-02-29' AND '2020-03-21'
    AND fpt.deleted = 0
    ORDER BY fpt.created DESC) base
    GROUP BY `Central de Custos`;