drop table if exists cdm_schema.final_visit_ids;

select 
	encounter_id
	, visit_occurrence_id_new
into cdm_schema.final_visit_ids
from (
	select
		*
		, row_number() over(
			partition by encounter_id
			order by priority
		) as rn
	from (
		select
			*
			, case 
				when lower(encounterclass) = 'inpatient' 
                    and lower(visit_type) = 'inpatient' 
                    and visit_occurrence_id_new is not null
					then 1
				when lower(encounterclass) in ('emergency', 'urgent')
					then (
						case 
							when lower(visit_type) = 'inpatient' 
                                and visit_occurrence_id_new is not null
								then 1
							when lower(visit_type) in ('emergency', 'urgent')  
                                and visit_occurrence_id_new is not null
								then 2
							else 99
						end
					)
				when lower(encounterclass) in ('ambulatory', 'wellness', 'outpatient') 
					then (
						case 
							when lower(visit_type) = 'inpatient' 
                                and visit_occurrence_id_new is not null
								then 1
							when lower(visit_type) in ('ambulatory', 'wellness', 'outpatient')  
                                and visit_occurrence_id_new is not null
								then 2
							else 99
						end
					)
				else 99
			end as priority
		from cdm_schema.assign_all_visit_ids
	) as t1
) as t2
where rn=1;
