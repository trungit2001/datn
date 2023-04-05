-- Create schema for database and datawarehouse

CREATE SCHEMA synthea_schema;
CREATE SCHEMA cdm_schema;


-- postgresql CDM DDL Specification for Synthea 2.7.0

CREATE TABLE synthea_schema.organizations (
    id varchar(50) PRIMARY KEY,
    organization_name varchar(100),
    address varchar(80),
    city varchar(50),
    state varchar(20),
    zip varchar(20),
    lat numeric,
    lon numeric,
    phone varchar(50),
    revenue numeric,
    utilization numeric
);

CREATE TABLE synthea_schema.patients (
    id varchar(50) PRIMARY KEY,
    birthdate timestamp,
    deathdate timestamp,
    ssn varchar(11),
    drivers varchar(9),
    passport varchar(10),
    prefix varchar(5),
    first varchar(50),
    last varchar(50),
    suffix varchar(5),
    maiden varchar(30),
    marital varchar(1),
    race varchar(10),
    ethnicity varchar(20),
    gender varchar(1),
    birthplace varchar(150),
    address varchar(80),
    city varchar(50),
    state varchar(20),
    county varchar(30),
    zip varchar(20),
    lat numeric,
    lon numeric,
    healthcare_expenses numeric,
    healthcare_coverage numeric
);

CREATE TABLE synthea_schema.payers (
    id varchar(50) PRIMARY KEY,
    payer_name varchar(30),
    address varchar(80),
    city varchar(50),
    state_headquartered varchar(20),
    zip varchar(20),
    phone varchar(50),
    amount_covered numeric,
    amount_uncovered numeric,
    revenue numeric,
    covered_encounters numeric,
    uncovered_encounters numeric,
    covered_medications numeric,
    uncovered_medications numeric,
    covered_procedures numeric,
    uncovered_procedures numeric,
    covered_immunizations numeric,
    uncovered_immunizations numeric,
    unique_customers numeric,
    qols_avg numeric,
    member_months numeric
);

CREATE TABLE synthea_schema.providers (
    id varchar(50) PRIMARY KEY,
    organization varchar(50),
    provider_name varchar(50),
    gender varchar(1),
    speciality varchar(100),
    address varchar(80),
    city varchar(50),
    state varchar(20),
    zip varchar(20),
    lat numeric,
    lon numeric,
    utilization numeric,
    FOREIGN KEY (organization) REFERENCES synthea_schema.organizations (id)
);

CREATE TABLE synthea_schema.encounters (
    id varchar(50) PRIMARY KEY,
    start timestamp,
    stop timestamp,
    patient varchar(50),
    organization varchar(50),
    provider varchar(50),
    payer varchar(50),
    encounterclass varchar(30),
    code varchar(20),
    description varchar(150),
    base_encounter_cost numeric,
    total_claim_cost numeric,
    payer_coverage numeric,
    reason_code varchar(20),
    reason_description varchar(150),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (organization) REFERENCES synthea_schema.organizations (id),
    FOREIGN KEY (provider) REFERENCES synthea_schema.providers (id),
    FOREIGN KEY (payer) REFERENCES synthea_schema.payers (id)
);

CREATE TABLE synthea_schema.allergies (
    start timestamp,
    stop timestamp,
    patient varchar(50),
    encounter varchar(50),
    code varchar(20),
    description varchar(150),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);

CREATE TABLE synthea_schema.careplans (
    id varchar(50) PRIMARY KEY,
    start timestamp,
    stop timestamp,
    patient varchar(50),
    encounter varchar(50),
    code varchar(20),
    description varchar(150),
    reason_code varchar(20),
    reason_description varchar(150),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);

CREATE TABLE synthea_schema.conditions (
    start timestamp,
    stop timestamp,
    patient varchar(50),
    encounter varchar(50),
    code varchar(20),
    description varchar(200),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);

CREATE TABLE synthea_schema.devices (
    start timestamp,
    stop timestamp,
    patient varchar(50),
    encounter varchar(50),
    code varchar(20),
    description varchar(150),
    udi varchar(250),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);

CREATE TABLE synthea_schema.imaging_studies (
    id varchar(50) PRIMARY KEY,
    date timestamp,
    patient varchar(50),
    encounter varchar(50),
    bodysite_code varchar(20),
    bodysite_description varchar(150),
    modality_code varchar(20),
    modality_description varchar(150),
    sop_code varchar(50),
    sop_description varchar(150),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);

CREATE TABLE synthea_schema.immunizations (
    date timestamp,
    patient varchar(50),
    encounter varchar(50),
    code varchar(20),
    description varchar(150),
    base_cost numeric,
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);

CREATE TABLE synthea_schema.medications (
    start timestamp,
    stop timestamp,
    patient varchar(50),
    payer varchar(50),
    encounter varchar(50),
    code varchar(20),
    description varchar(300),
    base_cost numeric,
    payer_coverage numeric,
    dispenses numeric,
    total_cost numeric,
    reason_code varchar(20),
    reason_description varchar(200),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (payer) REFERENCES synthea_schema.payers (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);

CREATE TABLE synthea_schema.observations (
    date timestamp,
    patient varchar(50),
    encounter varchar(50),
    code varchar(20),
    description varchar(300),
    value varchar(100),
    units varchar(20),
    type varchar(20),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);

CREATE TABLE synthea_schema.payer_transitions (
    patient varchar(50),
    start_year numeric,
    end_year numeric,
    payer varchar(50),
    ownership varchar(20),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (payer) REFERENCES synthea_schema.payers (id)
);

CREATE TABLE synthea_schema.procedures (
    date timestamp,
    patient varchar(50),
    encounter varchar(50),
    code varchar(20),
    description varchar(300),
    base_cost numeric,
    reason_code varchar(20),
    reason_description varchar(200),
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);

CREATE TABLE synthea_schema.supplies (
    date timestamp,
    patient varchar(50),
    encounter varchar(50),
    code varchar(20),
    description varchar(200),
    quantity numeric,
    FOREIGN KEY (patient) REFERENCES synthea_schema.patients (id),
    FOREIGN KEY (encounter) REFERENCES synthea_schema.encounters (id)
);


-- postgresql CDM DDL Specification for OMOP Common Data Model 5.3

/*****************************

Clinical Data Tables

*****************************/

CREATE TABLE cdm_schema.person (
    person_id integer NOT NULL,
    gender_concept_id integer NOT NULL,
    year_of_birth integer NOT NULL,
    month_of_birth integer NULL,
    day_of_birth integer NULL,
    birth_datetime timestamp NULL,
    race_concept_id integer NOT NULL,
    ethnicity_concept_id integer NOT NULL,
    location_id integer NULL,
    provider_id integer NULL,
    care_site_id integer NULL,
    person_source_value varchar(50) NULL,
    gender_source_value varchar(50) NULL,
    gender_source_concept_id integer NULL,
    race_source_value varchar(50) NULL,
    race_source_concept_id integer NULL,
    ethnicity_source_value varchar(50) NULL,
    ethnicity_source_concept_id integer NULL
);

CREATE TABLE cdm_schema.observation_period (
    observation_period_id integer NOT NULL,
    person_id integer NOT NULL,
    observation_period_start_date date NOT NULL,
    observation_period_end_date date NOT NULL,
    period_type_concept_id integer NOT NULL
);

CREATE TABLE cdm_schema.visit_occurrence (
    visit_occurrence_id integer NOT NULL,
    person_id integer NOT NULL,
    visit_concept_id integer NOT NULL,
    visit_start_date date NOT NULL,
    visit_start_datetime timestamp NULL,
    visit_end_date date NOT NULL,
    visit_end_datetime timestamp NULL,
    visit_type_concept_id integer NOT NULL,
    provider_id integer NULL,
    care_site_id integer NULL,
    visit_source_value varchar(50) NULL,
    visit_source_concept_id integer NULL,
    admitting_source_concept_id integer NULL,
    admitting_source_value varchar(50) NULL,
    discharge_to_concept_id integer NULL,
    discharge_to_source_value varchar(50) NULL,
    preceding_visit_occurrence_id integer NULL
);

CREATE TABLE cdm_schema.visit_detail (
    visit_detail_id integer NOT NULL,
    person_id integer NOT NULL,
    visit_detail_concept_id integer NOT NULL,
    visit_detail_start_date date NOT NULL,
    visit_detail_start_datetime timestamp NULL,
    visit_detail_end_date date NOT NULL,
    visit_detail_end_datetime timestamp NULL,
    visit_detail_type_concept_id integer NOT NULL,
    provider_id integer NULL,
    care_site_id integer NULL,
    visit_detail_source_value varchar(50) NULL,
    visit_detail_source_concept_id integer NULL,
    admitting_source_value varchar(50) NULL,
    admitting_source_concept_id integer NULL,
    discharge_to_source_value varchar(50) NULL,
    discharge_to_concept_id integer NULL,
    preceding_visit_detail_id integer NULL,
    visit_detail_parent_id integer NULL,
    visit_occurrence_id integer NOT NULL
);

CREATE TABLE cdm_schema.condition_occurrence (
    condition_occurrence_id integer NOT NULL,
    person_id integer NOT NULL,
    condition_concept_id integer NOT NULL,
    condition_start_date date NOT NULL,
    condition_start_datetime timestamp NULL,
    condition_end_date date NULL,
    condition_end_datetime timestamp NULL,
    condition_type_concept_id integer NOT NULL,
    condition_status_concept_id integer NULL,
    stop_reason varchar(20) NULL,
    provider_id integer NULL,
    visit_occurrence_id integer NULL,
    visit_detail_id integer NULL,
    condition_source_value varchar(50) NULL,
    condition_source_concept_id integer NULL,
    condition_status_source_value varchar(50) NULL
);

CREATE TABLE cdm_schema.drug_exposure(
    drug_exposure_id integer NOT NULL,
    person_id integer NOT NULL,
    drug_concept_id integer NOT NULL,
    drug_exposure_start_date date NOT NULL,
    drug_exposure_start_datetime timestamp NULL,
    drug_exposure_end_date date NOT NULL,
    drug_exposure_end_datetime timestamp NULL,
    verbatim_end_date date NULL,
    drug_type_concept_id integer NOT NULL,
    stop_reason varchar(20) NULL,
    refills integer NULL,
    quantity numeric NULL,
    days_supply integer NULL,
    sig text NULL,
    route_concept_id integer NULL,
    lot_number varchar(50) NULL,
    provider_id integer NULL,
    visit_occurrence_id integer NULL,
    visit_detail_id integer NULL,
    drug_source_value varchar(50) NULL,
    drug_source_concept_id integer NULL,
    route_source_value varchar(50) NULL,
    dose_unit_source_value varchar(50) NULL
);

CREATE TABLE cdm_schema.procedure_occurrence (
    procedure_occurrence_id integer NOT NULL,
    person_id integer NOT NULL,
    procedure_concept_id integer NOT NULL,
    procedure_date date NOT NULL,
    procedure_datetime timestamp NULL,
    procedure_type_concept_id integer NOT NULL,
    modifier_concept_id integer NULL,
    quantity integer NULL,
    provider_id integer NULL,
    visit_occurrence_id integer NULL,
    visit_detail_id integer NULL,
    procedure_source_value varchar(50) NULL,
    procedure_source_concept_id integer NULL,
    modifier_source_value varchar(50) NULL
);

CREATE TABLE cdm_schema.device_exposure(
    device_exposure_id integer NOT NULL,
    person_id integer NOT NULL,
    device_concept_id integer NOT NULL,
    device_exposure_start_date date NOT NULL,
    device_exposure_start_datetime timestamp NULL,
    device_exposure_end_date date NULL,
    device_exposure_end_datetime timestamp NULL,
    device_type_concept_id integer NOT NULL,
    unique_device_id varchar(50) NULL,
    quantity integer NULL,
    provider_id integer NULL,
    visit_occurrence_id integer NULL,
    visit_detail_id integer NULL,
    device_source_value varchar(50) NULL,
    device_source_concept_id integer NULL
);

CREATE TABLE cdm_schema.measurement (
    measurement_id integer NOT NULL,
    person_id integer NOT NULL,
    measurement_concept_id integer NOT NULL,
    measurement_date date NOT NULL,
    measurement_datetime timestamp NULL,
    measurement_time varchar(10) NULL,
    measurement_type_concept_id integer NOT NULL,
    operator_concept_id integer NULL,
    value_as_number numeric NULL,
    value_as_concept_id integer NULL,
    unit_concept_id integer NULL,
    range_low numeric NULL,
    range_high numeric NULL,
    provider_id integer NULL,
    visit_occurrence_id integer NULL,
    visit_detail_id integer NULL,
    measurement_source_value varchar(50) NULL,
    measurement_source_concept_id integer NULL,
    unit_source_value varchar(50) NULL,
    value_source_value varchar(50) NULL
);

CREATE TABLE cdm_schema.observation (
    observation_id integer NOT NULL,
    person_id integer NOT NULL,
    observation_concept_id integer NOT NULL,
    observation_date date NOT NULL,
    observation_datetime timestamp NULL,
    observation_type_concept_id integer NOT NULL,
    value_as_number numeric NULL,
    value_as_string varchar(60) NULL,
    value_as_concept_id integer NULL,
    qualifier_concept_id integer NULL,
    unit_concept_id integer NULL,
    provider_id integer NULL,
    visit_occurrence_id integer NULL,
    visit_detail_id integer NULL,
    observation_source_value varchar(50) NULL,
    observation_source_concept_id integer NULL,
    unit_source_value varchar(50) NULL,
    qualifier_source_value varchar(50) NULL
);

CREATE TABLE cdm_schema.death (
    person_id integer NOT NULL,
    death_date date NOT NULL,
    death_datetime timestamp NULL,
    death_type_concept_id integer NULL,
    cause_concept_id integer NULL,
    cause_source_value varchar(50) NULL,
    cause_source_concept_id integer NULL
);

CREATE TABLE cdm_schema.note (
    note_id integer NOT NULL,
    person_id integer NOT NULL,
    note_date date NOT NULL,
    note_datetime timestamp NULL,
    note_type_concept_id integer NOT NULL,
    note_class_concept_id integer NOT NULL,
    note_title varchar(250) NULL,
    note_text text NOT NULL,
    encoding_concept_id integer NOT NULL,
    language_concept_id integer NOT NULL,
    provider_id integer NULL,
    visit_occurrence_id integer NULL,
    visit_detail_id integer NULL,
    note_source_value varchar(50) NULL
);

CREATE TABLE cdm_schema.note_nlp (
    note_nlp_id integer NOT NULL,
    note_id integer NOT NULL,
    section_concept_id integer NULL,
    snippet varchar(250) NULL,
    "offset" varchar(50) NULL,
    lexical_variant varchar(250) NOT NULL,
    note_nlp_concept_id integer NULL,
    note_nlp_source_concept_id integer NULL,
    nlp_system varchar(250) NULL,
    nlp_date date NOT NULL,
    nlp_datetime timestamp NULL,
    term_exists varchar(1) NULL,
    term_temporal varchar(50) NULL,
    term_modifiers varchar(2000) NULL
);

CREATE TABLE cdm_schema.specimen (
    specimen_id integer NOT NULL,
    person_id integer NOT NULL,
    specimen_concept_id integer NOT NULL,
    specimen_type_concept_id integer NOT NULL,
    specimen_date date NOT NULL,
    specimen_datetime timestamp NULL,
    quantity numeric NULL,
    unit_concept_id integer NULL,
    anatomic_site_concept_id integer NULL,
    disease_status_concept_id integer NULL,
    specimen_source_id varchar(50) NULL,
    specimen_source_value varchar(50) NULL,
    unit_source_value varchar(50) NULL,
    anatomic_site_source_value varchar(50) NULL,
    disease_status_source_value varchar(50) NULL
);

CREATE TABLE cdm_schema.fact_relationship (
    domain_concept_id_1 integer NOT NULL,
    fact_id_1 integer NOT NULL,
    domain_concept_id_2 integer NOT NULL,
    fact_id_2 integer NOT NULL,
    relationship_concept_id integer NOT NULL
);

/*****************************

Health System Data Tables

*****************************/

CREATE TABLE cdm_schema.location (
    location_id integer NOT NULL,
    address_1 varchar(50) NULL,
    address_2 varchar(50) NULL,
    city varchar(50) NULL,
    state varchar(20) NULL,
    zip varchar(9) NULL,
    county varchar(20) NULL,
    location_source_value varchar(50) NULL
);

CREATE TABLE cdm_schema.care_site (
    care_site_id integer NOT NULL,
    care_site_name varchar(255) NULL,
    place_of_service_concept_id integer NULL,
    location_id integer NULL,
    care_site_source_value varchar(50) NULL,
    place_of_service_source_value varchar(50) NULL
);

CREATE TABLE cdm_schema.provider(
    provider_id integer NOT NULL,
    provider_name varchar(255) NULL,
    npi varchar(20) NULL,
    dea varchar(20) NULL,
    specialty_concept_id integer NULL,
    care_site_id integer NULL,
    year_of_birth integer NULL,
    gender_concept_id integer NULL,
    provider_source_value varchar(50) NULL,
    specialty_source_value varchar(50) NULL,
    specialty_source_concept_id integer NULL,
    gender_source_value varchar(50) NULL,
    gender_source_concept_id integer NULL
);

/*****************************

Health Economics Data Tables

*****************************/

CREATE TABLE cdm_schema.payer_plan_period (
    payer_plan_period_id integer NOT NULL,
    person_id integer NOT NULL,
    payer_plan_period_start_date date NOT NULL,
    payer_plan_period_end_date date NOT NULL,
    payer_concept_id integer NULL,
    payer_source_value varchar(50) NULL,
    payer_source_concept_id integer NULL,
    plan_concept_id integer NULL,
    plan_source_value varchar(50) NULL,
    plan_source_concept_id integer NULL,
    sponsor_concept_id integer NULL,
    sponsor_source_value varchar(50) NULL,
    sponsor_source_concept_id integer NULL,
    family_source_value varchar(50) NULL,
    stop_reason_concept_id integer NULL,
    stop_reason_source_value varchar(50) NULL,
    stop_reason_source_concept_id integer NULL
);

CREATE TABLE cdm_schema.cost (
    cost_id integer NOT NULL,
    cost_event_id integer NOT NULL,
    cost_domain_id varchar(20) NOT NULL,
    cost_type_concept_id integer NOT NULL,
    currency_concept_id integer NULL,
    total_charge numeric NULL,
    total_cost numeric NULL,
    total_paid numeric NULL,
    paid_by_payer numeric NULL,
    paid_by_patient numeric NULL,
    paid_patient_copay numeric NULL,
    paid_patient_coinsurance numeric NULL,
    paid_patient_deductible numeric NULL,
    paid_by_primary numeric NULL,
    paid_ingredient_cost numeric NULL,
    paid_dispensing_fee numeric NULL,
    payer_plan_period_id integer NULL,
    amount_allowed numeric NULL,
    revenue_code_concept_id integer NULL,
    revenue_code_source_value varchar(50) NULL,
    drg_concept_id integer NULL,
    drg_source_value varchar(3) NULL
);

/*****************************

Standardized Derived Elements

*****************************/

CREATE TABLE cdm_schema.drug_era (
    drug_era_id integer NOT NULL,
    person_id integer NOT NULL,
    drug_concept_id integer NOT NULL,
    drug_era_start_date date NOT NULL,
    drug_era_end_date date NOT NULL,
    drug_exposure_count integer NULL,
    gap_days integer NULL
);

CREATE TABLE cdm_schema.dose_era (
    dose_era_id integer NOT NULL,
    person_id integer NOT NULL,
    drug_concept_id integer NOT NULL,
    unit_concept_id integer NOT NULL,
    dose_value numeric NOT NULL,
    dose_era_start_date date NOT NULL,
    dose_era_end_date date NOT NULL
);

CREATE TABLE cdm_schema.condition_era (
    condition_era_id integer NOT NULL,
    person_id integer NOT NULL,
    condition_concept_id integer NOT NULL,
    condition_era_start_date date NOT NULL,
    condition_era_end_date date NOT NULL,
    condition_occurrence_count integer NULL
);

/*****************************

Metadata Tables

*****************************/

CREATE TABLE cdm_schema.metadata (
    metadata_concept_id integer NOT NULL,
    metadata_type_concept_id integer NOT NULL,
    name varchar(250) NOT NULL,
    value_as_string varchar(250) NULL,
    value_as_concept_id integer NULL,
    metadata_date date NULL,
    metadata_datetime timestamp NULL
);

CREATE TABLE cdm_schema.cdm_source (
    cdm_source_name varchar(255) NOT NULL,
    cdm_source_abbreviation varchar(25) NULL,
    cdm_holder varchar(255) NULL,
    source_description text NULL,
    source_documentation_reference varchar(255) NULL,
    cdm_etl_reference varchar(255) NULL,
    source_release_date date NULL,
    cdm_release_date date NULL,
    cdm_version varchar(10) NULL,
    vocabulary_version varchar(20) NULL
);

/*****************************

Vocabulary Tables

*****************************/

CREATE TABLE cdm_schema.concept (
    concept_id integer NOT NULL,
    concept_name varchar(255) NOT NULL,
    domain_id varchar(20) NOT NULL,
    vocabulary_id varchar(20) NOT NULL,
    concept_class_id varchar(20) NOT NULL,
    standard_concept varchar(1) NULL,
    concept_code varchar(50) NOT NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    invalid_reason varchar(1) NULL
);

CREATE TABLE cdm_schema.vocabulary (
    vocabulary_id varchar(20) NOT NULL,
    vocabulary_name varchar(255) NOT NULL,
    vocabulary_reference varchar(255) NOT NULL,
    vocabulary_version varchar(255) NULL,
    vocabulary_concept_id integer NOT NULL
);

CREATE TABLE cdm_schema.domain (
    domain_id varchar(20) NOT NULL,
    domain_name varchar(255) NOT NULL,
    domain_concept_id integer NOT NULL
);

CREATE TABLE cdm_schema.concept_class (
    concept_class_id varchar(20) NOT NULL,
    concept_class_name varchar(255) NOT NULL,
    concept_class_concept_id integer NOT NULL
);

CREATE TABLE cdm_schema.concept_relationship (
    concept_id_1 integer NOT NULL,
    concept_id_2 integer NOT NULL,
    relationship_id varchar(20) NOT NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    invalid_reason varchar(1) NULL
);

CREATE TABLE cdm_schema.relationship (
    relationship_id varchar(20) NOT NULL,
    relationship_name varchar(255) NOT NULL,
    is_hierarchical varchar(1) NOT NULL,
    defines_ancestry varchar(1) NOT NULL,
    reverse_relationship_id varchar(20) NOT NULL,
    relationship_concept_id integer NOT NULL
);

CREATE TABLE cdm_schema.concept_synonym (
    concept_id integer NOT NULL,
    concept_synonym_name varchar(1000) NOT NULL,
    language_concept_id integer NOT NULL
);

CREATE TABLE cdm_schema.concept_ancestor (
    ancestor_concept_id integer NOT NULL,
    descendant_concept_id integer NOT NULL,
    min_levels_of_separation integer NOT NULL,
    max_levels_of_separation integer NOT NULL
);

CREATE TABLE cdm_schema.source_to_concept_map (
    source_code varchar(50) NOT NULL,
    source_concept_id integer NOT NULL,
    source_vocabulary_id varchar(20) NOT NULL,
    source_code_description varchar(255) NULL,
    target_concept_id integer NOT NULL,
    target_vocabulary_id varchar(20) NOT NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    invalid_reason varchar(1) NULL
);

CREATE TABLE cdm_schema.drug_strength (
    drug_concept_id integer NOT NULL,
    ingredient_concept_id integer NOT NULL,
    amount_value numeric NULL,
    amount_unit_concept_id integer NULL,
    numerator_value numeric NULL,
    numerator_unit_concept_id integer NULL,
    denominator_value numeric NULL,
    denominator_unit_concept_id integer NULL,
    box_size integer NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    invalid_reason varchar(1) NULL
);

CREATE TABLE cdm_schema.cohort_definition (
    cohort_definition_id integer NOT NULL,
    cohort_definition_name varchar(255) NOT NULL,
    cohort_definition_description text NULL,
    definition_type_concept_id integer NOT NULL,
    cohort_definition_syntax text NULL,
    subject_concept_id integer NOT NULL,
    cohort_initiation_date date NULL
);

CREATE TABLE cdm_schema.attribute_definition (
    attribute_definition_id integer NOT NULL,
    attribute_name varchar(255) NOT NULL,
    attribute_description text NULL,
    attribute_type_concept_id integer NOT NULL,
    attribute_syntax text NULL
);
