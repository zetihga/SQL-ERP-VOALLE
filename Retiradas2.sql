WITH rep AS (
   SELECT description,
          assignment_id,
          final_date,
          beginning_date,
          seconds_worked,
          created FROM (SELECT description,
                        assignment_id,
                        created,
                        final_date,
                        beginning_date,
                        seconds_worked,
                        MAX(created) OVER (PARTITION BY assignment_id) max_created
                       FROM reports
                 ) rc
   WHERE created = rc.max_created
)
SELECT it.title STATUS,
      p.neighborhood BAIRRO,
      p.city CIDADE,
      t.title EQUIPE,
      at.name ATENDENTE,
      a.title 'TITULO DO PROTOCOLO',
      itt.title 'TIPO DE PROTOCOLO(ETIQUETA)',
      sp.title PROBLEMA,
      r.description 'ULTIMO RELATO',
      a.beginning_date 'DT ABERTURA',
      a.conclusion_date 'DT CONCLUSÃO',
      a.modified 'DT ULTIMA ALTERAÇÃO',
      p.street RUA,
      p.id 'Código Cliente',
      ac.complement CTO,
      r.beginning_date 'INICIO DO PLAY',
      r.final_date 'FIM DO PLAY'
   FROM assignments a
JOIN assignment_incidents ai ON a.id = ai.assignment_id
LEFT JOIN solicitation_problems sp ON ai.solicitation_problem_id = sp.id
LEFT JOIN incident_types itt ON ai.incident_type_id = itt.id
JOIN incident_status it ON ai.incident_status_id = it.id
JOIN people p ON a.requestor_id = p.id
LEFT JOIN rep r ON r.assignment_id = a.id
JOIN contract_service_tags cst ON ai.contract_service_tag_id = cst.id
JOIN contracts c ON cst.contract_id = c.id
LEFT JOIN people at ON a.responsible_id = at.id
LEFT JOIN teams t ON ai.team_id = t.id
LEFT JOIN authentication_contracts ac ON c.id = ac.contract_id
WHERE  t.id IN (1015)
and itt.id in (219,1051,1052,1053,1054,1055,
 1056,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1070,
 1071,1072,1073,1074,1075,1076,1077,1078,1079,1080,1230,1231,1408,1434,
 1435,1436,1437,1438,1439,1440,1441,1442,1443,1444,1445,1447,1493,1600)
AND a.beginning_date > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
ORDER BY a.beginning_date DESC;