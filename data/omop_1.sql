-- OMOP CDM v3.0

CREATE TABLE vocabulary (
    vocabulary_id serial PRIMARY KEY NOT NULL,
    vocabulary_name varchar(256) NOT NULL
);

CREATE TABLE concept (
    concept_id serial PRIMARY KEY NOT NULL,
    concept_name varchar(256) NOT NULL,
    concept_level integer NOT NULL,
    concept_class varchar(60) NOT NULL,
    vocabulary_id integer NOT NULL,
    concept_code varchar(20) NOT NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    invalid_reason varchar(1) NULL,
    FOREIGN KEY (vocabulary_id) REFERENCES vocabulary (vocabulary_id)
);

CREATE TABLE concept_synonym (
    concept_synonym_id serial PRIMARY KEY NOT NULL,
    concept_id integer NOT NULL,
    concept_synonym_name TEXT NOT NULL,
    FOREIGN KEY (concept_id) REFERENCES concept (concept_id)
);

CREATE TABLE source_to_concept_map (
    source_code varchar(20) NOT NULL,
    source_vocabulary_id integer NOT NULL,
    source_code_description varchar(256) NULL,
    target_concept_id integer NOT NULL,
    target_vocabulary_id integer NOT NULL,
    mapping_type varchar(20) NULL,
    primary_map varchar(1) NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    invalid_reason varchar(1) NULL,
    PRIMARY KEY (source_code, source_vocabulary_id, target_concept_id, valid_start_date),
    FOREIGN KEY (source_vocabulary_id) REFERENCES vocabulary (vocabulary_id),
    FOREIGN KEY (target_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (target_vocabulary_id) REFERENCES vocabulary (vocabulary_id)
);

CREATE TABLE relationship (
    relationship_id serial PRIMARY KEY NOT NULL,
    relationship_name varchar(256) NOT NULL,
    is_hierarchical varchar(1) NULL,
    defines_ancestry varchar(1) NULL
);

CREATE TABLE concept_relationship (
    concept_id_1 integer NOT NULL,
    concept_id_2 integer NOT NULL,
    relationship_id integer NOT NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    invalid_reason varchar(1) NULL,
    PRIMARY KEY (concept_id_1, concept_id_2, relationship_id),
    FOREIGN KEY (concept_id_1) REFERENCES concept (concept_id),
    FOREIGN KEY (concept_id_2) REFERENCES concept (concept_id),
    FOREIGN KEY (relationship_id) REFERENCES relationship (relationship_id)
);

CREATE TABLE concept_ancestor (
    ancestor_concept_id integer NOT NULL,
    descendant_concept_id integer NOT NULL,
    min_levels_of_separation integer NULL,
    max_levels_of_separation integer NULL,
    PRIMARY KEY (ancestor_concept_id, descendant_concept_id),
    FOREIGN KEY (ancestor_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (descendant_concept_id) REFERENCES concept (concept_id)
);

CREATE TABLE location (
    location_id serial PRIMARY KEY NOT NULL,
    address_1 varchar(50) NULL,
    address_2 varchar(50) NULL,
    city varchar(50) NULL,
    state varchar(2) NULL,
    zip varchar(9) NULL,
    county varchar(20) NULL,
    location_source_value varchar(50) NULL
);

CREATE TABLE organization (
    organization_id serial PRIMARY KEY NOT NULL,
    place_of_service_concept_id integer NULL,
    location_id integer NULL,
    organization_source_value varchar(50) NOT NULL,
    place_of_service_source_value varchar(50) NULL,
    FOREIGN KEY (place_of_service_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (location_id) REFERENCES location (location_id)
);

CREATE TABLE care_site (
    care_site_id serial PRIMARY KEY NOT NULL,
    location_id integer NULL,
    organization_id integer NULL,
    place_of_service_concept_id integer NULL,
    care_site_source_value varchar(50) NULL,
    place_of_service_source_value varchar(50) NULL,
    FOREIGN KEY (location_id) REFERENCES location (location_id),
    FOREIGN KEY (organization_id) REFERENCES organization (organization_id),
    FOREIGN KEY (place_of_service_concept_id) REFERENCES concept (concept_id)
);

CREATE TABLE provider (
    provider_id serial PRIMARY KEY NOT NULL,
    npi varchar(20) NULL,
    dea varchar(20) NULL,
    specialty_concept_id integer NULL,
    care_site_id integer NULL,
    provider_source_value varchar(50) NOT NULL,
    specialty_source_value varchar(50) NULL,
    FOREIGN KEY (specialty_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (care_site_id) REFERENCES care_site (care_site_id)
);

CREATE TABLE person (
    person_id serial PRIMARY KEY NOT NULL,
    gender_concept_id integer NOT NULL,
    year_of_birth integer NOT NULL,
    month_of_birth integer NULL,
    day_of_birth integer NULL,
    race_concept_id integer NULL,
    ethnicity_concept_id integer NULL,
    location_id integer NULL,
    provider_id integer NULL,
    care_site_id integer NULL,
    person_source_value varchar(50) NULL,
    gender_source_value varchar(50) NULL,
    race_source_value varchar(50) NULL,
    ethnicity_source_value varchar(50) NULL,
    FOREIGN KEY (gender_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (race_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (ethnicity_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (location_id) REFERENCES location (location_id),
    FOREIGN KEY (provider_id) REFERENCES provider (provider_id),
    FOREIGN KEY (care_site_id) REFERENCES care_site (care_site_id)
);

CREATE TABLE visit_occurrence (
    visit_occurrence_id serial PRIMARY KEY NOT NULL,
    person_id integer NOT NULL,
    visit_start_date date NOT NULL,
    visit_end_date date NOT NULL,
    place_of_service_concept_id integer NOT NULL,
    care_site_id integer NULL,
    place_of_service_source_value varchar(50) NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (place_of_service_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (care_site_id) REFERENCES care_site (care_site_id)
);

CREATE TABLE drug_exposure (
    drug_exposure_id serial PRIMARY KEY NOT NULL,
    person_id integer NOT NULL,
    drug_concept_id integer NOT NULL,
    drug_exposure_start_date date NOT NULL,
    drug_exposure_end_date date NULL,
    drug_type_concept_id integer NOT NULL,
    stop_reason varchar(20) NULL,
    refills integer NULL,
    quantity NUMERIC NULL,
    days_supply integer NULL,
    sig TEXT NULL,
    prescribing_provider_id integer NULL,
    visit_occurrence_id integer NULL,
    relevant_condition_concept_id integer NULL,
    drug_source_value varchar(50) NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (drug_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (drug_type_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (prescribing_provider_id) REFERENCES provider (provider_id),
    FOREIGN KEY (visit_occurrence_id) REFERENCES visit_occurrence (visit_occurrence_id),
    FOREIGN KEY (relevant_condition_concept_id) REFERENCES concept (concept_id)
);

CREATE TABLE drug_era (
    drug_era_id serial PRIMARY KEY NOT NULL,
    person_id integer NOT NULL,
    drug_concept_id integer NOT NULL,
    drug_era_start_date date NOT NULL,
    drug_era_end_date date NOT NULL,
    drug_type_concept_id integer NOT NULL,
    drug_exposure_count integer NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (drug_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (drug_type_concept_id) REFERENCES concept (concept_id)
);

CREATE TABLE condition_occurrence (
    condition_occurrence_id serial PRIMARY KEY NOT NULL,
    person_id integer NOT NULL,
    condition_concept_id integer NOT NULL,
    condition_start_date date NOT NULL,
    condition_end_date date NULL,
    condition_type_concept_id integer NOT NULL,
    stop_reason varchar(20) NULL,
    associated_provider_id integer NULL,
    visit_occurrence_id integer NULL,
    condition_source_value varchar(50) NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (condition_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (condition_type_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (associated_provider_id) REFERENCES provider (provider_id),
    FOREIGN KEY (visit_occurrence_id) REFERENCES visit_occurrence (visit_occurrence_id)
);

CREATE TABLE condition_era (
    condition_era_id serial PRIMARY KEY NOT NULL,
    person_id integer NOT NULL,
    condition_concept_id integer NOT NULL,
    condition_era_start_date date NOT NULL,
    condition_era_end_date date NOT NULL,
    condition_type_concept_id integer NOT NULL,
    condition_occurrence_count integer NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (condition_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (condition_type_concept_id) REFERENCES concept (concept_id)
);

CREATE TABLE procedure_occurrence (
    procedure_occurrence_id serial PRIMARY KEY NOT NULL,
    person_id integer NOT NULL,
    procedure_concept_id integer NOT NULL,
    procedure_date date NOT NULL,
    procedure_type_concept_id integer NOT NULL,
    associated_provider_id integer NULL,
    visit_occurrence_id integer NULL,
    relevant_condition_concept_id integer NOT NULL,
    procedure_source_value varchar(50) NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (procedure_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (procedure_type_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (associated_provider_id) REFERENCES provider (provider_id),
    FOREIGN KEY (visit_occurrence_id) REFERENCES visit_occurrence (visit_occurrence_id),
    FOREIGN KEY (relevant_condition_concept_id) REFERENCES concept (concept_id)
);

CREATE TABLE observation (
    observation_id serial PRIMARY KEY NOT NULL,
    person_id integer NOT NULL,
    observation_concept_id integer NOT NULL,
    observation_date date NOT NULL,
    observation_time integer NULL,
    value_as_number NUMERIC NULL,
    value_as_string varchar(60) NULL,
    value_as_concept_id integer NULL,
    unit_concept_id integer NULL,
    range_low integer NULL,
    range_high integer NULL,
    observation_type_concept_id integer NOT NULL,
    associated_provider_id integer NULL,
    visit_occurrence_id integer NULL,
    relevant_condition_concept_id integer NULL,
    observation_source_value varchar(50) NULL,
    unit_source_value varchar(50) NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (observation_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (value_as_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (unit_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (observation_type_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (associated_provider_id) REFERENCES provider (provider_id),
    FOREIGN KEY (visit_occurrence_id) REFERENCES visit_occurrence (visit_occurrence_id),
    FOREIGN KEY (relevant_condition_concept_id) REFERENCES concept (concept_id)
);

CREATE TABLE observation_period (
    observation_period_id serial PRIMARY KEY NOT NULL,
    person_id integer NOT NULL,
    observation_period_start_date date NOT NULL,
    observation_period_end_date date NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id)
);

CREATE TABLE death (
    person_id integer PRIMARY KEY NOT NULL,
    death_date date NOT NULL,
    death_type_concept_id integer NOT NULL,
    cause_of_death_concept_id integer NULL,
    cause_of_death_source_value varchar(50) NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (death_type_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (cause_of_death_concept_id) REFERENCES concept (concept_id)
);

CREATE TABLE payer_plan_period (
    payer_plan_period_id serial PRIMARY KEY NOT NULL,
    person_id integer NOT NULL,
    payer_plan_period_start_date date NOT NULL,
    payer_plan_period_end_date date NOT NULL,
    payer_source_value varchar(50) NULL,
    plan_source_value varchar(50) NULL,
    family_source_value varchar(50) NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id)
);

CREATE TABLE drug_cost (
    drug_cost_id serial PRIMARY KEY NOT NULL,
    drug_exposure_id integer NOT NULL,
    paid_copay NUMERIC NULL,
    paid_coinsurance NUMERIC NULL,
    paid_toward_deductible NUMERIC NULL,
    paid_by_payer NUMERIC NULL,
    paid_by_coordination_benefits NUMERIC NULL,
    total_out_of_pocket NUMERIC NULL,
    total_paid NUMERIC NULL,
    ingredient_cost NUMERIC NULL,
    dispending_fee NUMERIC NULL,
    average_wholesale_price NUMERIC NULL,
    payer_plan_period_id integer NULL,
    FOREIGN KEY (drug_exposure_id) REFERENCES drug_exposure (drug_exposure_id),
    FOREIGN KEY (payer_plan_period_id) REFERENCES payer_plan_period (payer_plan_period_id)
);

CREATE TABLE procedure_cost (
    procedure_cost_id integer NOT NULL,
    procedure_occurrence_id integer NOT NULL,
    paid_copay NUMERIC NULL,
    paid_coinsurance NUMERIC NULL,
    paid_toward_deductible NUMERIC NULL,
    paid_by_payer NUMERIC NULL,
    paid_by_coordination_benefits NUMERIC NULL,
    total_out_of_pocket NUMERIC NULL,
    total_paid NUMERIC NULL,
    disease_class_concept_id integer NULL,
    revenue_code_concept_id integer NULL,
    payer_plan_period_id integer NULL,
    disease_class_source_value varchar(50) NULL,
    revenue_code_source_value varchar(50) NULL,
    FOREIGN KEY (procedure_occurrence_id) REFERENCES procedure_occurrence (procedure_occurrence_id),
    FOREIGN KEY (disease_class_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (revenue_code_concept_id) REFERENCES concept (concept_id),
    FOREIGN KEY (payer_plan_period_id) REFERENCES payer_plan_period (payer_plan_period_id)
);

CREATE TABLE cohort (
    cohort_id integer NOT NULL,
    cohort_concept_id integer NOT NULL,
    cohort_start_date date NOT NULL,
    cohort_end_date date NULL,
    subject_id integer NOT NULL,
    stop_reason varchar(20) NULL
);
