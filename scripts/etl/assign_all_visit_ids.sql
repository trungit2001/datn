drop table if exists cdm_schema.assign_all_visit_ids;

select
	e.id 					as encounter_id
	, e.patient 			as person_source_value
	, e."start" 			as date_service
	, e.stop 				as date_service_end
	, e.encounterclass 
	, av.encounterclass 	as visit_type
	, av.visit_start_date 
	, av.visit_end_date 
	, av.visit_occurrence_id 
	, case 
		when lower(e.encounterclass) = 'inpatient' and lower(av.encounterclass) = 'inpatient'
			then av.visit_occurrence_id
		when lower(e.encounterclass) in ('emergency', 'urgent')
			then (
				case 
					when lower(av.encounterclass) = 'inpatient' and e."start" > av.visit_start_date 
						then av.visit_occurrence_id 
					when lower(av.encounterclass) in ('emergency', 'urgent') and e."start" = av.visit_start_date 
						then av.visit_occurrence_id 
					else null
				end
			)
		when lower(e.encounterclass) in ('ambulatory', 'wellness', 'outpatient')
			then (
				case
					when lower(av.encounterclass) = 'inpatient' and e."start" >= av.visit_start_date 
						then av.visit_occurrence_id 
					when lower(av.encounterclass) in ('ambulatory', 'wellness', 'outpatient')
						then av.visit_occurrence_id
					else null
				end
			)
		else null
	end as visit_occurrence_id_new
into cdm_schema.assign_all_visit_ids
from synthea_schema.encounters e 
join cdm_schema.all_visits av 
	on e.patient = av.patient 
	and e."start" >= av.visit_start_date 
	and e."start" <= av.visit_end_date;
