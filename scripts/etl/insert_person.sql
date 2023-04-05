 insert into cdm_schema.person (
	person_id
	, gender_concept_id 
	, year_of_birth 
	, month_of_birth 
	, day_of_birth
	, birth_datetime 
	, race_concept_id 
	, ethnicity_concept_id 
	, location_id 
	, provider_id 
	, care_site_id 
	, person_source_value 
	, gender_source_value 
	, gender_source_concept_id 
	, race_source_value 
	, race_source_concept_id 
	, ethnicity_source_value 
	, ethnicity_source_concept_id 
)
select
	row_number() over(order by p.id)
	, case lower(p.gender)
		when 'm' then 8507 -- male
		when 'f' then 8532 -- female
	end
	, extract ('year' from p.birthdate)
	, extract ('month' from p.birthdate)
	, extract ('day' from p.birthdate)
	, p.birthdate 
	, case lower(p.race) 
		when 'white' then 8527
		when 'black' then 8516
		when 'asian' then 8515
		else 0
	end
	, case lower(p.ethnicity)
		when 'hispanic' then 38003563
		when 'nonhispanic' then 38003564
		else 0
	end
	, null
	, null 
	, null
	, p.id 
	, p.gender 
	, 0
	, p.race 
	, 0
	, p.ethnicity 
	, 0
from synthea_schema.patients p
where p.gender is not null;
