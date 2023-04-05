insert into cdm_schema.procedure_occurrence (
	procedure_occurrence_id 
	, person_id 
	, procedure_concept_id 
	, procedure_date 
	, procedure_datetime 
	, procedure_type_concept_id 
	, modifier_concept_id 
	, quantity 
	, provider_id 
	, visit_occurrence_id 
	, visit_detail_id 
	, procedure_source_value 
	, procedure_source_concept_id 
	, modifier_source_value 
)
select
	row_number() over(order by p.person_id)	as procedure_occurrence_id 
	, p.person_id 							as person_id 
	, srctostdvm.target_concept_id 			as procedure_concept_id 
	, pr."date" 							as procedure_date 
	, pr."date" 							as procedure_datetime 
	, 38000267								as procedure_type_concept_id 
	, 0										as modifier_concept_id 
	, cast(null as integer)					as quantity 
	, cast(null as integer)					as provider_id 
	, fv.visit_occurrence_id_new			as visit_occurrence_id 
	, fv.visit_occurrence_id_new + 1000000	as visit_detail_id 
	, pr.code 								as procedure_source_value 
	, srctosrcvm.source_concept_id 			as procedure_source_concept_id 
	, null 									as modifier_source_value 
from synthea_schema."procedures" pr
join cdm_schema.source_to_standard_vocab_map srctostdvm
	on srctostdvm.source_code             	= pr.code
 	and srctostdvm.target_domain_id        	= 'Procedure'
 	and srctostdvm.target_vocabulary_id    	= 'SNOMED'
 	and srctostdvm.source_vocabulary_id    	= 'SNOMED'
 	and srctostdvm.target_standard_concept 	= 'S'
 	and srctostdvm.target_invalid_reason is null
join cdm_schema.source_to_source_vocab_map srctosrcvm
  	on srctosrcvm.source_code             	= pr.code
 	and srctosrcvm.source_vocabulary_id    	= 'SNOMED'
left join cdm_schema.final_visit_ids fv
  	on fv.encounter_id                    	= pr.encounter
left join synthea_schema.encounters e
  	on pr.encounter                       	= e.id
	and pr.patient                         	= e.patient
join cdm_schema.person p
  	on p.person_source_value              	= pr.patient;
