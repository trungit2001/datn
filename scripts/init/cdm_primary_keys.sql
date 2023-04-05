-- postgresql CDM Primary Key Constraints for OMOP Common Data Model 5.3

/*****************************

Clinical Data Tables

*****************************/

ALTER TABLE cdm_schema.person ADD CONSTRAINT xpk_PERSON PRIMARY KEY (person_id);
ALTER TABLE cdm_schema.observation_period ADD CONSTRAINT xpk_OBSERVATION_PERIOD PRIMARY KEY (observation_period_id);
ALTER TABLE cdm_schema.visit_occurrence ADD CONSTRAINT xpk_VISIT_OCCURRENCE PRIMARY KEY (visit_occurrence_id);
ALTER TABLE cdm_schema.visit_detail ADD CONSTRAINT xpk_VISIT_DETAIL PRIMARY KEY (visit_detail_id);
ALTER TABLE cdm_schema.condition_occurrence ADD CONSTRAINT xpk_CONDITION_OCCURRENCE PRIMARY KEY (condition_occurrence_id);
ALTER TABLE cdm_schema.drug_exposure ADD CONSTRAINT xpk_DRUG_EXPOSURE PRIMARY KEY (drug_exposure_id);
ALTER TABLE cdm_schema.procedure_occurrence ADD CONSTRAINT xpk_PROCEDURE_OCCURRENCE PRIMARY KEY (procedure_occurrence_id);
ALTER TABLE cdm_schema.device_exposure ADD CONSTRAINT xpk_DEVICE_EXPOSURE PRIMARY KEY (device_exposure_id);
ALTER TABLE cdm_schema.measurement ADD CONSTRAINT xpk_MEASUREMENT PRIMARY KEY (measurement_id);
ALTER TABLE cdm_schema.observation ADD CONSTRAINT xpk_OBSERVATION PRIMARY KEY (observation_id);
ALTER TABLE cdm_schema.note ADD CONSTRAINT xpk_NOTE PRIMARY KEY (note_id);
ALTER TABLE cdm_schema.note_nlp ADD CONSTRAINT xpk_NOTE_NLP PRIMARY KEY (note_nlp_id);
ALTER TABLE cdm_schema.specimen ADD CONSTRAINT xpk_SPECIMEN PRIMARY KEY (specimen_id);

/*****************************

Health System Data Tables

*****************************/

ALTER TABLE cdm_schema.location ADD CONSTRAINT xpk_LOCATION PRIMARY KEY (location_id);
ALTER TABLE cdm_schema.care_site ADD CONSTRAINT xpk_CARE_SITE PRIMARY KEY (care_site_id);
ALTER TABLE cdm_schema.provider ADD CONSTRAINT xpk_PROVIDER PRIMARY KEY (provider_id);

/*****************************

Health Economics Data Tables

*****************************/

ALTER TABLE cdm_schema.payer_plan_period ADD CONSTRAINT xpk_PAYER_PLAN_PERIOD PRIMARY KEY (payer_plan_period_id);
ALTER TABLE cdm_schema.cost ADD CONSTRAINT xpk_COST PRIMARY KEY (cost_id);

/*****************************

Standardized Derived Elements

*****************************/

ALTER TABLE cdm_schema.drug_era ADD CONSTRAINT xpk_DRUG_ERA PRIMARY KEY (drug_era_id);
ALTER TABLE cdm_schema.dose_era ADD CONSTRAINT xpk_DOSE_ERA PRIMARY KEY (dose_era_id);
ALTER TABLE cdm_schema.condition_era ADD CONSTRAINT xpk_CONDITION_ERA PRIMARY KEY (condition_era_id);

/*****************************

Vocabulary Tables

*****************************/

ALTER TABLE cdm_schema.concept ADD CONSTRAINT xpk_CONCEPT PRIMARY KEY (concept_id);
ALTER TABLE cdm_schema.vocabulary ADD CONSTRAINT xpk_VOCABULARY PRIMARY KEY (vocabulary_id);
ALTER TABLE cdm_schema.domain ADD CONSTRAINT xpk_DOMAIN PRIMARY KEY (domain_id);
ALTER TABLE cdm_schema.concept_class ADD CONSTRAINT xpk_CONCEPT_CLASS PRIMARY KEY (concept_class_id);
ALTER TABLE cdm_schema.relationship ADD CONSTRAINT xpk_RELATIONSHIP PRIMARY KEY (relationship_id);
