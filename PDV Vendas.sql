select
    p.id 'CpdCliente',
    p.name as 'Cliente',
    p.cpf_cnpj as 'Cpf_Cnpj',
    u.id 'CodVendedor',
    case u.active
        when true then 'Ativo'
        when false then 'Inativo'
        end 'Status Vendedor',
    u.name as 'Vendedor',
    date_format(p.created_at,'%d/%m/%Y') as 'Data da Venda',
    c.id 'CodCidade',
    c.name as 'Cidade',
    c.uf 'Estado',
    r.name 'Regional Vendedor',
    pd.id 'CodPlano',
    pd.name 'Plano',
    pd.value 'Valor',
    u.channel 'CodCanal',
    case u.channel
        when 1 then 'PAP'
        when 2 then 'Representante'
        when 3 then 'Loja'
        end 'Canal'
from persons as p
join users u on p.seller_id = u.id
join cities c on p.city_id = c.id
-- join regional_users ru on u.id = ru.user_id
join regional_cities rc on c.id = rc.city_id -- join cities ao inves de users
-- join regionals r on r.id = regional_id
join regionals r on r.id = rc.regional_id -- compara com regional_id da regional cities
join products pd on pd.id = p.plan_id
where p.status = 6
and p.id = 3041

select u.id,u.name from users u
where u.active = true