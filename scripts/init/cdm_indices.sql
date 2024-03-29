-- postgresql OMOP CDM Indices for OMOP Common Data Model 5.3

/*****************************

Clinical Data Tables

*****************************/

CREATE INDEX idx_person_id ON cdm_schema.person (person_id ASC);
CLUSTER cdm_schema.person USING idx_person_id;
CREATE INDEX idx_gender ON cdm_schema.person (gender_concept_id);

CREATE INDEX idx_observation_period_id_1 ON cdm_schema.observation_period (person_id ASC);
CLUSTER cdm_schema.observation_period USING idx_observation_period_id_1;

CREATE INDEX idx_visit_person_id_1 ON cdm_schema.visit_occurrence (person_id ASC);
CLUSTER cdm_schema.visit_occurrence USING idx_visit_person_id_1;
CREATE INDEX idx_visit_concept_id_1 ON cdm_schema.visit_occurrence (visit_concept_id ASC);

CREATE INDEX idx_visit_det_person_id_1 ON cdm_schema.visit_detail (person_id ASC);
CLUSTER cdm_schema.visit_detail USING idx_visit_det_person_id_1;
CREATE INDEX idx_visit_det_concept_id_1 ON cdm_schema.visit_detail (visit_detail_concept_id ASC);
CREATE INDEX idx_visit_det_occ_id ON cdm_schema.visit_detail (visit_occurrence_id ASC);

CREATE INDEX idx_condition_person_id_1 ON cdm_schema.condition_occurrence (person_id ASC);
CLUSTER cdm_schema.condition_occurrence USING idx_condition_person_id_1;
CREATE INDEX idx_condition_concept_id_1 ON cdm_schema.condition_occurrence (condition_concept_id ASC);
CREATE INDEX idx_condition_visit_id_1 ON cdm_schema.condition_occurrence (visit_occurrence_id ASC);

CREATE INDEX idx_drug_person_id_1 ON cdm_schema.drug_exposure (person_id ASC);
CLUSTER cdm_schema.drug_exposure USING idx_drug_person_id_1;
CREATE INDEX idx_drug_concept_id_1 ON cdm_schema.drug_exposure (drug_concept_id ASC);
CREATE INDEX idx_drug_visit_id_1 ON cdm_schema.drug_exposure (visit_occurrence_id ASC);

CREATE INDEX idx_procedure_person_id_1 ON cdm_schema.procedure_occurrence (person_id ASC);
CLUSTER cdm_schema.procedure_occurrence USING idx_procedure_person_id_1;
CREATE INDEX idx_procedure_concept_id_1 ON cdm_schema.procedure_occurrence (procedure_concept_id ASC);
CREATE INDEX idx_procedure_visit_id_1 ON cdm_schema.procedure_occurrence (visit_occurrence_id ASC);

CREATE INDEX idx_device_person_id_1 ON cdm_schema.device_exposure (person_id ASC);
CLUSTER cdm_schema.device_exposure USING idx_device_person_id_1;
CREATE INDEX idx_device_concept_id_1 ON cdm_schema.device_exposure (device_concept_id ASC);
CREATE INDEX idx_device_visit_id_1 ON cdm_schema.device_exposure (visit_occurrence_id ASC);

CREATE INDEX idx_measurement_person_id_1 ON cdm_schema.measurement (person_id ASC);
CLUSTER cdm_schema.measurement USING idx_measurement_person_id_1;
CREATE INDEX idx_measurement_concept_id_1 ON cdm_schema.measurement (measurement_concept_id ASC);
CREATE INDEX idx_measurement_visit_id_1 ON cdm_schema.measurement (visit_occurrence_id ASC);

CREATE INDEX idx_observation_person_id_1 ON cdm_schema.observation (person_id ASC);
CLUSTER cdm_schema.observation USING idx_observation_person_id_1;
CREATE INDEX idx_observation_concept_id_1 ON cdm_schema.observation (observation_concept_id ASC);
CREATE INDEX idx_observation_visit_id_1 ON cdm_schema.observation (visit_occurrence_id ASC);

CREATE INDEX idx_death_person_id_1 ON cdm_schema.death (person_id ASC);
CLUSTER cdm_schema.death USING idx_death_person_id_1;

CREATE INDEX idx_note_person_id_1 ON cdm_schema.note (person_id ASC);
CLUSTER cdm_schema.note USING idx_note_person_id_1;
CREATE INDEX idx_note_concept_id_1 ON cdm_schema.note (note_type_concept_id ASC);
CREATE INDEX idx_note_visit_id_1 ON cdm_schema.note (visit_occurrence_id ASC);

CREATE INDEX idx_note_nlp_note_id_1 ON cdm_schema.note_nlp (note_id ASC);
CLUSTER cdm_schema.note_nlp USING idx_note_nlp_note_id_1;
CREATE INDEX idx_note_nlp_concept_id_1 ON cdm_schema.note_nlp (note_nlp_concept_id ASC);

CREATE INDEX idx_specimen_person_id_1 ON cdm_schema.specimen (person_id ASC);
CLUSTER cdm_schema.specimen USING idx_specimen_person_id_1;
CREATE INDEX idx_specimen_concept_id_1 ON cdm_schema.specimen (specimen_concept_id ASC);

CREATE INDEX idx_fact_relationship_id1 ON cdm_schema.fact_relationship (domain_concept_id_1 ASC);
CREATE INDEX idx_fact_relationship_id2 ON cdm_schema.fact_relationship (domain_concept_id_2 ASC);
CREATE INDEX idx_fact_relationship_id3 ON cdm_schema.fact_relationship (relationship_concept_id ASC);

/*****************************

Health System Data Tables

*****************************/

CREATE INDEX idx_location_id_1 ON cdm_schema.location (location_id ASC);
CLUSTER cdm_schema.location USING idx_location_id_1;

CREATE INDEX idx_care_site_id_1 ON cdm_schema.care_site (care_site_id ASC);
CLUSTER cdm_schema.care_site USING idx_care_site_id_1;

CREATE INDEX idx_provider_id_1 ON cdm_schema.provider (provider_id ASC);
CLUSTER cdm_schema.provider USING idx_provider_id_1;

/*****************************

Health Economics Data Tables

*****************************/

CREATE INDEX idx_period_person_id_1 ON cdm_schema.payer_plan_period (person_id ASC);
CLUSTER cdm_schema.payer_plan_period USING idx_period_person_id_1;

CREATE INDEX idx_cost_event_id ON cdm_schema.cost (cost_event_id ASC);

/*****************************

Standardized Derived Elements

*****************************/

CREATE INDEX idx_drug_era_person_id_1 ON cdm_schema.drug_era (person_id ASC);
CLUSTER cdm_schema.drug_era USING idx_drug_era_person_id_1;
CREATE INDEX idx_drug_era_concept_id_1 ON cdm_schema.drug_era (drug_concept_id ASC);

CREATE INDEX idx_dose_era_person_id_1 ON cdm_schema.dose_era (person_id ASC);
CLUSTER cdm_schema.dose_era USING idx_dose_era_person_id_1;
CREATE INDEX idx_dose_era_concept_id_1 ON cdm_schema.dose_era (drug_concept_id ASC);

CREATE INDEX idx_condition_era_person_id_1 ON cdm_schema.condition_era (person_id ASC);
CLUSTER cdm_schema.condition_era USING idx_condition_era_person_id_1;
CREATE INDEX idx_condition_era_concept_id_1 ON cdm_schema.condition_era (condition_concept_id ASC);

/*****************************

Metadata Tables

*****************************/

CREATE INDEX idx_metadata_concept_id_1 ON cdm_schema.metadata (metadata_concept_id ASC);
CLUSTER cdm_schema.metadata USING idx_metadata_concept_id_1;

/*****************************

Vocabulary Tables

*****************************/

CREATE INDEX idx_concept_concept_id ON cdm_schema.concept (concept_id ASC);
CLUSTER cdm_schema.concept USING idx_concept_concept_id;
CREATE INDEX idx_concept_code ON cdm_schema.concept (concept_code ASC);
CREATE INDEX idx_concept_vocabluary_id ON cdm_schema.concept (vocabulary_id ASC);
CREATE INDEX idx_concept_domain_id ON cdm_schema.concept (domain_id ASC);
CREATE INDEX idx_concept_class_id ON cdm_schema.concept (concept_class_id ASC);

CREATE INDEX idx_vocabulary_vocabulary_id ON cdm_schema.vocabulary (vocabulary_id ASC);
CLUSTER cdm_schema.vocabulary USING idx_vocabulary_vocabulary_id;

CREATE INDEX idx_domain_domain_id ON cdm_schema.domain (domain_id ASC);
CLUSTER cdm_schema.domain USING idx_domain_domain_id;

CREATE INDEX idx_concept_class_class_id ON cdm_schema.concept_class (concept_class_id ASC);
CLUSTER cdm_schema.concept_class USING idx_concept_class_class_id;

CREATE INDEX idx_concept_relationship_id_1 ON cdm_schema.concept_relationship (concept_id_1 ASC);
CLUSTER cdm_schema.concept_relationship USING idx_concept_relationship_id_1;
CREATE INDEX idx_concept_relationship_id_2 ON cdm_schema.concept_relationship (concept_id_2 ASC);
CREATE INDEX idx_concept_relationship_id_3 ON cdm_schema.concept_relationship (relationship_id ASC);

CREATE INDEX idx_relationship_rel_id ON cdm_schema.relationship (relationship_id ASC);
CLUSTER cdm_schema.relationship USING idx_relationship_rel_id;

CREATE INDEX idx_concept_synonym_id ON cdm_schema.concept_synonym (concept_id ASC);
CLUSTER cdm_schema.concept_synonym USING idx_concept_synonym_id;

CREATE INDEX idx_concept_ancestor_id_1 ON cdm_schema.concept_ancestor (ancestor_concept_id ASC);
CLUSTER cdm_schema.concept_ancestor USING idx_concept_ancestor_id_1;
CREATE INDEX idx_concept_ancestor_id_2 ON cdm_schema.concept_ancestor (descendant_concept_id ASC);

CREATE INDEX idx_source_to_concept_map_3 ON cdm_schema.source_to_concept_map (target_concept_id ASC);
CLUSTER cdm_schema.source_to_concept_map USING idx_source_to_concept_map_3;
CREATE INDEX idx_source_to_concept_map_1 ON cdm_schema.source_to_concept_map (source_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_2 ON cdm_schema.source_to_concept_map (target_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_c ON cdm_schema.source_to_concept_map (source_code ASC);

CREATE INDEX idx_drug_strength_id_1 ON cdm_schema.drug_strength (drug_concept_id ASC);
CLUSTER cdm_schema.drug_strength USING idx_drug_strength_id_1;
CREATE INDEX idx_drug_strength_id_2 ON cdm_schema.drug_strength (ingredient_concept_id ASC);
