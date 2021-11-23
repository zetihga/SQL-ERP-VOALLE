Select c.id,
       c.company_place_id 'local',
       c.client_id,
       c.contract_number,
       c.beginning_date,
       c.cancellation_motive,
       c.status 'status',
       p.administrative_observation,
       p.name 'nome',
       c.cancellation_date,
       p.street
        -- c.client_id,c.contract_number,c.description --  p.name,
        -- c.contract_number,
        -- ce.description
from contracts c
LEFT join people p on c.client_id = p.id
LEFT join contract_events ce on c.contract_event_id = ce.id
left join financial_receivable_titles frt on c.id = frt.contract_id
where p.tx_id = 33164835949