select aap.id 'id_pontoDeacesso',
       aap.code 'code_pontoDeacesso',
       aap.title 'descrição_pontoDeacesso',
       ac.id 'id_concentrador',
       ac.code 'code_concentrador',
       ac.title 'descrição_concentrador'
from authentication_access_points aap
JOIN authentication_concentrators ac on aap.authentication_concentrator_id = ac.id
where aap.code in ('28.7','28.11','28.4','28.1','28.6','28.5','28.9','28.8','28.9','28.3')
and aap.deleted = 0


SELECT * FROM teams t
where t.title like '%Retira%'