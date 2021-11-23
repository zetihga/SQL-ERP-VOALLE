select
	vu.name 'Aberto por',
	p.name 'Atendente',
	a.title 'Solicitação',
	CASE
           WHEN ac.authentication_address_list_id = 1 THEN 'Normal'
           WHEN ac.authentication_address_list_id = 2 THEN 'Bloqueado'
           WHEN ac.authentication_address_list_id = 3 THEN 'Aviso de Bloqueio'
           WHEN ac.authentication_address_list_id = 4 THEN 'Aviso de Manutencão'
       END AS 'Status Conexão',
	ac.city 'Cidade',
	it.title 'Status',
	sc.title 'Contexto',
	sp.title 'Problema',
	a.created 'Abertura',
	a.conclusion_date 'Encerramento',
	ac.complement 'CTO',
	aap.title 'OLT'
from assignments a
	left join people p on p.id = a.responsible_id
	left join assignment_incidents ai on a.id = ai.assignment_id
	left join incident_status it on ai.incident_status_id = it.id
	left join solicitation_problems sp on sp.id = ai.solicitation_problem_id
	left join solicitation_classifications sc on sc.id = ai.solicitation_classification_id
	left join contract_service_tags cst on cst.id = ai.contract_service_tag_id
	left join contracts c on c.id = cst.contract_id
	left join authentication_contracts ac on ac.contract_id = c.id
	left join incident_types tps on tps.id = ai.incident_type_id
	left join authentication_access_points aap on aap.id = ac.authentication_access_point_id
    left join v_users vu on vu.id = a.created_by
	where ai.team_id = 1119
and a.created >= date_sub(curdate(),interval 30 day)
order by a.conclusion_date desc