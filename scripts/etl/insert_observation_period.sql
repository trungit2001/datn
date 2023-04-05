insert into cdm_schema.observation_period (
	observation_period_id
	, person_id
	, observation_period_start_date 
	, observation_period_end_date 
	, period_type_concept_id 
)
select
	row_number() over(order by person_id)
	, person_id
	, start_date
	, stop_date
	, 44814724 as period_type_concept_id
from (
	select
		p.person_id
		, min(e."start") 	as start_date
		, max(e.stop)		as stop_date
	from synthea_schema.encounters e  
	left join cdm_schema.person p
		on e.patient = p.person_source_value
	group by p.person_id
) as tmp;
