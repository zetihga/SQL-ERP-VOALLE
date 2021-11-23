 -- CRIADO POR ZETI
 -- Todas AS solicitações encerradas pelas equipes abaixo..

SELECT ai.protocol 'Protocolo',
       p2.name 'Nome',
       t.title 'Equipe',
	   it.title 'Tipo Solicitação',
       p2.name 'Atendente',
       a.created 'Data de abertura',
	   a.conclusion_date 'Data de Encerramento',
 case
		 when ai.incident_status_id = 3 then 'Fechamento'
		 when ai.incident_status_id = 4 then 'Encerramento'
		 when ai.incident_status_id = 2 then 'Andamento'
		 when ai.incident_status_id = 10 then 'Aguardando Retorno'
		   END 'Status Solicitação',
		    it.title 'Tipo Solicitação',
            r.description 'Relatos',
            r.modified 'Data do relato',
            pp.name 'Relatante'
from assignment_incidents ai
join assignments a on ai.assignment_id = a.id
join incident_types it on ai.incident_type_id = it.id
JOIN people p2 ON a.responsible_id = p2.id
JOIN teams t ON t.id = ai.team_id
join reports r on a.id = r.assignment_id
join people pp ON pp.id = r.person_id
WHERE it.id = 1524
and a.created between '2021-08-01' and '2021-08-31'

select p.name,p.phone,p.cell_phone_1,p.city from people p
where p.city like '%Itamba%'

Select p.city,fct.title from contracts c
join people p on c.client_id = p.id
join financial_collection_types fct on c.financial_collection_type_id = fct.id
where c.status in (1,2,3,5,6,7)
and c.stage = 3
and p.code_city_id = 4111001
and fct.title like '%Caixa%'
 -- group by p.city,fct.title
