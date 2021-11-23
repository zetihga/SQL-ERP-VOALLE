with ultrel as (select
	id,
	assignment_id
	from (select
	r.id ,
	r.assignment_id ,
	r.created,
	max(r.created) over (partition by assignment_id) max_created
		from reports r
		join teams t on t.id =r.team_id
		join people p on p.id = r.person_id
			where r.created > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) ur
			where created = ur.max_created),
	rltec as (select
	id,
	assignment_id
	from (select
	r.id ,
	r.assignment_id ,
	r.created,
	max(r.created) over (partition by assignment_id) max_created
		from reports r
		join teams t on t.id =r.team_id
		join people p on p.id = r.person_id
		where r.title ="Atendimento Solicitação"
			and t.id in (1036,5)
			and p.technical = 1
			and r.created > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) rt
			where created = rt.max_created)
select
	it.title 'Status',
	cnx.neighborhood 'Bairro',
	cnx.city 'Cidade',
	t2.title 'Equipe',
	atd.name 'Atendente Atual',
	a.title 'Protocolo',
	itt.title 'Tipo de Solicitação',
	sp.title 'Problema',
	ru.description 'Último Relato',
	a.beginning_date 'Abertura',
	a.conclusion_date 'Encerramento',
	a.modified 'Última Interação',
	clt.street 'Rua',
	clt.id 'Cod. cliente',
	cnx.complement 'CTO',
	r.beginning_date 'Play',
	r.Final_date 'Fechamento Técnico',
	tec.name 'Técnico',
	r.description 'Conclusão técnica'
	from assignments a
	left join people atd on atd.id = a.responsible_id
	left join people clt on clt.id = a.requestor_id
	left join assignment_incidents ai on a.id = ai.assignment_id
	left join incident_status it on ai.incident_status_id = it.id
	left join teams t2 on t2.id = ai.team_id
	left join incident_types itt on itt.id = ai.incident_type_id
	left join solicitation_problems sp on sp.id = ai.solicitation_problem_id
	left join contract_service_tags etq on etq.id =ai.contract_service_tag_id
	left join contracts c on c.id = etq.contract_id
	left join authentication_contracts cnx on cnx.contract_id = c.id
	left join rltec rlt on rlt.assignment_id = a.id
	left join reports r on rlt.id = r.id
	left join people tec on tec.id = r.person_id
	left join ultrel url on url.assignment_id = a.id
	left join reports ru on url.id = ru.id
		where t2.id in (5,1006,1036,1111,1118,1202,1225,1232)
		and itt.id in (1005,1004,1028,1027,1030,1219,1096,1183,1087,1085,1088,1084,1086,1089,1082,1081,1083,
				1091,1090,1092,1196,1224,1698,245,1448,1194,1223,1195,1197,1545,1544,1212,1211,1050,1047,
				1048,1045,1049,1046,1233,1042,1205,1039,1204,1044,1041,1043,1040,1232,1215,1217,1210,1037,
				1234,1235,32,1136,240)
		and a.beginning_date > DATE_SUB(CURDATE(), interval 6 month)
	order by a.id desc