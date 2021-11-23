SELECT c.client_id 'Cod Cliente',
       p.tx_id 'Documento',
       p.name 'Nome',
       p.city 'Cidade',
       p.neighborhood 'Bairro',
       p.street 'Rua',
       p.cell_phone_1 'Celular',
       p.phone 'Telefone'
FROM people p
LEFT JOIN contracts c ON p.id = c.client_id