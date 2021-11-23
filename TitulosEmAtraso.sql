with evt as
(select
	ct_id,
	evento,
	via,
	date(dt_ev) data_evento
from(select
ce.id idev,
max(ce.id) over (partition by ce.contract_id) mx_id,
ce.contract_id ct_id,
cet.title evento,
ce.description evdesc,
case
	when ce.description like '%tela%' then 'Tela de Atendimento'
	when ce.description like '%portal%' then 'Portal'
	when ce.description like '%recebimento%' then 'Pagamento'
	when ce.description like '%atraso%' then 'Débito'
	when ce.description like '%tele%' then 'Atendimento CSC'
	when ce.description like '%efetuou%' then 'Pagamento'
	when ce.description like '%pago%' then 'Pagamento'
	when ce.description like '%paga%' then 'Pagamento'
	when ce.description like '%conf%' then 'Desbloqueio de Confiança'
	when ce.description like '%uvidoria%' then 'Ouvidoria'
	when ce.description like '%CSC%' then 'Atendimento CSC'
	when ce.description like '%omprov%' then 'Pagamento'
	when ce.description like '%boleto%' then 'Pagamento'
	when ce.description like '%rotina de Desbloqueio PPPoE%' then 'Desbloqueio PPPoE'
	when ce.description like '%Bloqueio Financeiro%' then 'Débito'
	end via,
ce.`date` dt_ev
from contract_events ce
left join contract_event_types cet on cet.id = ce.contract_event_type_id
where contract_event_type_id in (3,40,41,43,81,162)
and ce.`date` > '2021/01/01') evs
where evs.idev = evs.mx_id)
select
p.name 'Nome',
cdg_cliente 'Cod Cliente',
c2.contract_number 'Nº Contrato',
p.cell_phone_1 'Celular',
p.phone 'Telefone',
cast(bt2.titulo  as char) 'Título Mais Antigo',
bt2.vencimento 'Vencimento',
valor 'Total em Atraso',
CASE
           WHEN c2.status = 1 THEN case WHEN stc.authentication_address_list_id = 3 THEN 'Aviso de Bloqueio' WHEN stc.authentication_address_list_id <> 3 THEN 'Normal' WHEN stc.authentication_address_list_id is null THEN 'Normal' end
           WHEN c2.status = 2 THEN 'Demonstração'
           WHEN c2.status = 3 THEN 'Cortesia'
           WHEN c2.status = 4 THEN 'Cancelado'
           WHEN c2.status = 5 THEN 'Suspenso'
           WHEN c2.status = 6 THEN 'Bloqueio Financeiro'
           WHEN c2.status = 7 THEN 'Bloqueio Administrativo'
           WHEN c2.status = 9 THEN 'Encerrado'
        END AS 'Situação Contratual',
case
	when (datediff(current_date(),bt2.vencimento)) <= 2 then '00 a 02 Dias'
	when (datediff(current_date(),bt2.vencimento)) <= 10 then '03 a 10 Dias'
	when (datediff(current_date(),bt2.vencimento)) <= 15 then '11 a 15 Dias'
	when (datediff(current_date(),bt2.vencimento)) <= 20 then '16 a 20 Dias'
	when (datediff(current_date(),bt2.vencimento)) <= 30 then '21 a 30 Dias'
	when (datediff(current_date(),bt2.vencimento)) <= 45 then '31 a 45 Dias'
	when (datediff(current_date(),bt2.vencimento)) <= 60 then '46 a 60 Dias'
	when (datediff(current_date(),bt2.vencimento)) <= 75 then '61 a 75 Dias'
	when (datediff(current_date(),bt2.vencimento)) > 75 then '76 Dias ou Mais'
	end 'Faixa de Atraso',
case
	when (datediff(current_date(), c2.created )/30) <= 6 then '00 a 06 Meses'
    when (datediff(current_date(), c2.created )/30) <= 12 then '07 a 12 Meses'
    when (datediff(current_date(), c2.created )/30) <= 18 then '13 a 18 Meses'
    when (datediff(current_date(), c2.created )/30) > 18 then '18 Meses ou Mais'
    end 'Tempo de Base',
bt2.ntit 'Títulos em Aberto',
p.city 'Cidade',
case
when p.city = 'Ourinhos' then 'Regional 1'
when p.city = 'Chavantes' then 'Regional 1'
when p.city = 'Canitar' then 'Regional 1'
when p.city = 'Ibirarema' then 'Regional 1'
when p.city = 'Salto Grande' then 'Regional 1'
when p.city = 'São Pedro do Turvo' then 'Regional 1'
when p.city = 'Campos Novos Paulista' then 'Regional 1'
when p.city = 'Ribeirão do Sul' then 'Regional 1'
when p.city = 'Assis' then 'Regional 2'
when p.city = 'Palmital' then 'Regional 2'
when p.city = 'Cândido Mota' then 'Regional 2'
when p.city = 'Platina' then 'Regional 2'
when p.city = 'Marília' then 'Regional 2'
when p.city = 'Presidente Prudente' then 'Regional 3'
when p.city = 'Álvares Machado' then 'Regional 3'
when p.city = 'Tupã' then 'Regional 3'
when p.city = 'Bastos' then 'Regional 3'
when p.city = 'Rinópolis' then 'Regional 3'
when p.city = 'Parapuã' then 'Regional 3'
when p.city = 'Lucélia' then 'Regional 3'
when p.city = 'Iacri' then 'Regional 3'
when p.city = 'Inúbia Paulista' then 'Regional 3'
when p.city = 'Indiana' then 'Regional 3'
when p.city = 'Martinópolis' then 'Regional 3'
when p.city = 'Caiabu' then 'Regional 3'
when p.city = 'Regente Feijó' then 'Regional 3'
when p.city = 'Pirapozinho' then 'Regional 3'
when p.city = 'Floresta do Sul' then 'Regional 3'
when p.city = 'Piraju' then 'Regional 4'
when p.city = 'Siqueira Campos' then 'Regional 4'
when p.city = 'Wenceslau Braz' then 'Regional 4'
when p.city = 'Fartura' then 'Regional 4'
when p.city = 'Carlópolis' then 'Regional 4'
when p.city = 'Sarutaiá' then 'Regional 4'
when p.city = 'Taquarituba' then 'Regional 4'
when p.city = 'Taguaí' then 'Regional 4'
when p.city = 'Timburi' then 'Regional 4'
when p.city = 'Santa Cruz do Rio Pardo' then 'Regional 4'
when p.city = 'Ipaussu' then 'Regional 4'
when p.city = 'Bernardino de Campos' then 'Regional 4'
when p.city = 'Sorocaba' then 'Regional 5'
when p.city = 'Itapeva' then 'Regional 5'
when p.city = 'Itararé' then 'Regional 5'
when p.city = 'Itapetininga' then 'Regional 5'
when p.city = 'Itaberá' then 'Regional 5'
when p.city = 'Jacarezinho' then 'Regional 6'
when p.city = 'Cambará' then 'Regional 6'
when p.city = 'Andirá' then 'Regional 6'
when p.city = 'Bandeirantes' then 'Regional 6'
when p.city = 'Santa Mariana' then 'Regional 6'
when p.city = 'Cornélio Procópio' then 'Regional 6'
when p.city = 'Itambaracá' then 'Regional 6'
when p.city = 'Santa Amélia' then 'Regional 6'
end 'Regional',
fn.title 'Natureza Financeira',
case
when c2.automatic_blocking = 0 then 'Não'
when c2.automatic_blocking = 1 then 'Sim'
end 'Bloqueio Automático',
case
when c2.contract_type_id in (1,3,4,5,7,8,9,15,100,101,102,103,104,110,111,112,113,114,115,116,117,118,119,125,126,
127,128,129,130,136,137,138,139,140,141,145,146,147,148,149,150,156,164,166,167,168,169,177,178,181,182,
183,184,186,187,189,190,192,193,194,196,198,199,200,201,203,204,205,206,207,208,209,210,212,213,214,215,
223,227,228,230,231,232,233,235,237,240,241,242) then 'PF'
when c2.contract_type_id in (6,14,16,18,105,106,107,120,121,122,131,132,133,142,143,144,
151,152,153,158,159,160,161,170,171,172,173,174,175,176,185,188,191,195,197,202,211,222,224,234,236,238,243,244) then 'PJ'
when c2.contract_type_id in (2,10,11,12,13,17,108,109,123,124,134,135,154,155,162,163,165,179,180,216,217,218,219,220,221,225,226,229,239) then 'Dedicado'
end 'Tipo de Cliente',
case
when (datediff((date(concat(year(current_date()),'-',month(current_date())+1,'-01'))),bt2.vencimento)) > 76 then 'Passível de Cancelamento'
when (datediff((date(concat(year(current_date()),'-',month(current_date())+1,'-01'))),bt2.vencimento)) > 46 then 'Passível do Próximo Mês'
when (datediff((date(concat(year(current_date()),'-',month(current_date())+1,'-01'))),bt2.vencimento)) <= 46 then 'Não Passível'
end 'Passível',
vd.name 'Vendedor',
ev.evento 'Último Evento',
ev.via 'Causa do Evento',
ev.data_evento 'Data do Evento',
cast(p.tx_id as char) 'Doc'
from
(select
frt.id minid,
frt.client_id cdg_cliente,
frt.contract_id cdg_contrato,
frt.title titulo,
min(frt.expiration_date) over (partition by frt.contract_id) vencimento,
sum(frt.title_amount) over (partition by frt.contract_id) valor,
frt.financer_nature_id cdg_natfin,
count(frt.title) over (partition by frt.contract_id) ntit,
min(frt.id) over (partition by cdg_contrato) minv
from financial_receivable_titles frt
left join contracts c on c.id = frt.contract_id
where frt.bill_title_id is null
and frt.contract_id is not null
and c.status in (1,6)
and c.deleted = 0
and c.stage = 3
and frt.financer_nature_id not in (427,140,88,303,127,312,92,320,321,431,269,315,284,313,314,324,311,103,275,146,302)
and frt.balance > 0
and frt.deleted = 0
and frt.finished = 0
and frt.renegotiated = 0
and frt.expiration_date < current_date()) bt2
left join people p on p.id = bt2.cdg_cliente
left join contracts c2 on c2.id = bt2.cdg_contrato
left join financers_natures fn on fn.id = bt2.cdg_natfin
left join contract_types ct on ct.id = c2.contract_type_id
left join people vd on vd.id = c2.seller_1_id
left join evt ev on c2.id = ev.ct_id
left join authentication_contracts stc on stc.contract_id = c2.id
where minid = minv