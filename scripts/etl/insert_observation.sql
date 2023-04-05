insert into cdm_schema.observation (
	observation_id
	, person_id 
	, observation_concept_id 
	, observation_date 
	, observation_datetime 
	, observation_type_concept_id 
	, value_as_number 
	, value_as_string 
	, value_as_concept_id 
	, qualifier_concept_id 
	, unit_concept_id 
	, provider_id 
	, visit_occurrence_id 
	, visit_detail_id 
	, observation_source_value 
	, observation_source_concept_id 
	, unit_source_value 
	, qualifier_source_value 
)
select 
	row_number() over(
		order by person_id
	) as observation_id 
	, person_id 
	, observation_concept_id 
	, observation_date 
	, observation_datetime 
	, observation_type_concept_id 
	, value_as_number 
	, value_as_string 
	, value_as_concept_id 
	, qualifier_concept_id 
	, unit_concept_id 
	, provider_id 
	, visit_occurrence_id 
	, visit_detail_id 
	, observation_source_value 
	, observation_source_concept_id 
	, unit_source_value 
	, qualifier_source_value 
from (
	select
		p.person_id 							as person_id
		, srctostdvm.target_concept_id 			as observation_concept_id 
		, a."start" 							as observation_date
		, a."start" 							as observation_datetime 
		, 38000280								as observation_type_concept_id 
		, cast(null as float)					as value_as_number 
		, cast(null as varchar)					as value_as_string 
		, 0 									as value_as_concept_id 
		, 0										as qualifier_concept_id 
		, 0										as unit_concept_id 
		, cast(null as integer)					as provider_id 
		, fv.visit_occurrence_id_new 			as visit_occurrence_id 
		, fv.visit_occurrence_id_new + 1000000	as visit_detail_id 
		, a.code 								as observation_source_value 
		, srctosrcvm.source_concept_id 			as observation_source_concept_id 
		, cast(null as varchar)					as unit_source_value 
		, cast(null as varchar)					as qualifier_source_value 
	from synthea_schema.allergies a
	join cdm_schema.source_to_standard_vocab_map srctostdvm 
		on srctostdvm.source_code 				= a.code 
		and srctostdvm.target_domain_id 		= 'Observation'
		and srctostdvm.target_vocabulary_id    	= 'SNOMED'
	 	and srctostdvm.target_standard_concept 	= 'S'
	 	and srctostdvm.target_invalid_reason is null
	join cdm_schema.source_to_source_vocab_map srctosrcvm
		on srctosrcvm.source_code             	= a.code
	 	and srctosrcvm.source_vocabulary_id    	= 'SNOMED'
	 	and srctosrcvm.source_domain_id        	= 'Observation'
	left join cdm_schema.final_visit_ids fv
	  	on fv.encounter_id                    	= a.encounter
	left join synthea_schema.encounters e
	  	on a.encounter                        	= e.id
	 	and a.patient                          	= e.patient
	join cdm_schema.person p
	  	on p.person_source_value              	= a.patient
	union all 
	select
		p.person_id 							as person_id
		, srctostdvm.target_concept_id 			as observation_concept_id 
		, c."start" 							as observation_date
		, c."start" 							as observation_datetime 
		, 38000280								as observation_type_concept_id 
		, cast(null as float)					as value_as_number 
		, cast(null as varchar)					as value_as_string 
		, 0 									as value_as_concept_id 
		, 0										as qualifier_concept_id 
		, 0										as unit_concept_id 
		, cast(null as integer)					as provider_id 
		, fv.visit_occurrence_id_new 			as visit_occurrence_id 
		, fv.visit_occurrence_id_new + 1000000	as visit_detail_id 
		, c.code 								as observation_source_value 
		, srctosrcvm.source_concept_id 			as observation_source_concept_id 
		, cast(null as varchar)					as unit_source_value 
		, cast(null as varchar)					as qualifier_source_value 
	from synthea_schema.conditions c
	join cdm_schema.source_to_source_vocab_map srctostdvm
		on srctostdvm.source_code             	= c.code
	 	and srctostdvm.target_domain_id        	= 'Observation'
	 	and srctostdvm.target_vocabulary_id    	= 'SNOMED'
	 	and srctostdvm.target_standard_concept 	= 'S'
	 	and srctostdvm.target_invalid_reason is null
	join cdm_schema.source_to_source_vocab_map srctosrcvm
	  	on srctosrcvm.source_code              	= c.code
	 	and srctosrcvm.source_vocabulary_id     = 'SNOMED'
	 	and srctosrcvm.source_domain_id         = 'Observation'
	left join cdm_schema.final_visit_ids fv
	  	on fv.encounter_id                     	= c.encounter
	left join synthea_schema.encounters e
	  	on c.encounter                         	= e.id
	 	and c.patient                           = e.patient
	join cdm_schema.person p
	  	on p.person_source_value               	= c.patient
	union all
	select 
		p.person_id 							as person_id
		, srctostdvm.target_concept_id 			as observation_concept_id 
		, o."date"  							as observation_date
		, o."date"  							as observation_datetime 
		, 38000280								as observation_type_concept_id 
		, cast(null as float)					as value_as_number 
		, cast(null as varchar)					as value_as_string 
		, 0 									as value_as_concept_id 
		, 0										as qualifier_concept_id 
		, 0										as unit_concept_id 
		, cast(null as integer)					as provider_id 
		, fv.visit_occurrence_id_new 			as visit_occurrence_id 
		, fv.visit_occurrence_id_new + 1000000	as visit_detail_id 
		, o.code 								as observation_source_value 
		, srctosrcvm.source_concept_id 			as observation_source_concept_id 
		, cast(null as varchar)					as unit_source_value 
		, cast(null as varchar)					as qualifier_source_value 
	from synthea_schema.observations o
	join cdm_schema.source_to_standard_vocab_map srctostdvm
		on srctostdvm.source_code             	= o.code
	 	and srctostdvm.target_domain_id        	= 'Observation'
	 	and srctostdvm.target_vocabulary_id    	= 'LOINC'
	 	and srctostdvm.target_standard_concept 	= 'S'
	 	and srctostdvm.target_invalid_reason is null
	join cdm_schema.source_to_source_vocab_map srctosrcvm
	  	on srctosrcvm.source_code              	= o.code
	 	and srctosrcvm.source_vocabulary_id     = 'LOINC'
	 	and srctosrcvm.source_domain_id         = 'Observation'
	left join cdm_schema.final_visit_ids fv
	  	on fv.encounter_id                     	= o.encounter
	left join synthea_schema.encounters e
	  	on o.encounter                         	= e.id
	 	and o.patient                           = e.patient
	join cdm_schema.person p
	  	on p.person_source_value               	= o.patient
) as tmp;
