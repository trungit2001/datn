drop table if exists cdm_schema.source_to_standard_vocab_map;

with cte_vocab_map as (
	select
		c.concept_code 			as source_code
		, c.concept_id 			as source_concept_id
		, c.concept_name 		as source_code_description
		, c.vocabulary_id 		as source_vocabulary_id
		, c.domain_id 			as source_domain_id
		, c.concept_class_id 	as source_concept_class_id
		, c.valid_start_date 	as source_valid_start_date
		, c.valid_end_date 		as source_valid_end_date
		, c.invalid_reason 		as source_invalid_reason
		, c1.concept_id 		as target_concept_id
		, c1.concept_name 		as target_concept_name
		, c1.vocabulary_id 		as target_vocabulary_id
		, c1.domain_id 			as target_domain_id
		, c1.concept_class_id 	as target_concept_class_id
		, c1.invalid_reason 	as target_invalid_reason
		, c1.standard_concept 	as target_standard_concept
	from cdm_schema.concept c
	join cdm_schema.concept_relationship cr 
		on c.concept_id = cr.concept_id_1
		and cr.invalid_reason is null
		and lower(cr.relationship_id) = 'maps to'
	join cdm_schema.concept c1
		on cr.concept_id_2 = c1.concept_id 
		and c1.invalid_reason is null
	union
	select
		stcm.source_code 
		, stcm.source_concept_id 
		, stcm.source_code_description 
		, stcm.source_vocabulary_id 
		, c1.domain_id 				as source_domain_id
		, c2.concept_class_id 		as source_concept_class_id
		, c1.valid_start_date 		as source_valid_start_date
		, c1.valid_end_date 		as source_valid_end_date
		, stcm.invalid_reason 		as source_invalid_reason
		, stcm.target_concept_id 
		, c2.concept_name 			as target_concept_name
		, stcm.target_vocabulary_id 
		, c2.domain_id 				as target_domain_id
		, c2.concept_class_id 		as target_concept_class_id
		, c2.invalid_reason 		as target_invalid_reason
		, c2.standard_concept 		as target_standard_concept
	from cdm_schema.source_to_concept_map stcm 
	left join cdm_schema.concept c1
		on c1.concept_id = stcm.source_concept_id 
	left join cdm_schema.concept c2
		on c2.concept_id = stcm.target_concept_id 
	where stcm.invalid_reason is null
)
select * into cdm_schema.source_to_standard_vocab_map
from cte_vocab_map;

create index idx_vocab_map_source_code 
	on cdm_schema.source_to_standard_vocab_map (source_code);

create index idx_vocab_map_source_vocab_id 
	on cdm_schema.source_to_standard_vocab_map (source_vocabulary_id);
