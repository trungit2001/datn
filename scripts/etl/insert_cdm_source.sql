insert into cdm_schema.cdm_source (
	cdm_source_name
	, cdm_source_abbreviation 
	, cdm_holder 
	, source_description 
	, source_documentation_reference 
	, cdm_etl_reference 
	, source_release_date 
	, cdm_release_date 
	, cdm_version 
	, vocabulary_version 
)
select
	'@cdm_source_name'
	, '@cdm_source_abbreviation'
	, '@cdm_holder'
	, '@source_description'
	, 'https://synthetichealth.github.io/synthea/'
	, 'https://github.com/OHDSI/ETL-Synthea'
	, current_date
	, current_date
	, 'v5.3.1'
	, vocabulary_version 
from cdm_schema.vocabulary 
where vocabulary_id = 'None';
