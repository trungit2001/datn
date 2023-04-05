DATABASE_URL = "postgresql://postgres:postgres@localhost:2023/thesis"
BASE_DATA_PATH = "./data/covid19"
BASE_SCRIPT_PATH = "./scripts"
SCRIPT_INIT_PATH = f"{BASE_SCRIPT_PATH}/init"
SCRIPT_ETL_PATH = f"{BASE_SCRIPT_PATH}/etl"
ORDER_TABLES_INSERT = [
    "organizations",
    "patients",
    "payers",
    "providers",
    "encounters",
    "allergies",
    "careplans",
    "conditions",
    "devices",
    "imaging_studies",
    "immunizations",
    "medications",
    "observations",
    "payer_transitions",
    "procedures",
    "supplies"
]
ORDER_STMT = [
    "load_vocab",
    "cdm_primary_keys",
    "cdm_indices",
    "cdm_constraints"
]
ORDER_ETL = [
    "create_source_to_source_vocab_map",
    "create_source_to_standard_vocab_map",
    "all_visit_table",
    "assign_all_visit_ids",
    "final_visit_ids",
    "insert_cdm_source",
    "insert_person",
    "insert_observation_period",
    "insert_visit_occurrence",
    "insert_visit_detail",
    "insert_condition_occurrence",
    "insert_drug_exposure",
    "insert_measurement",
    "insert_observation",
    "insert_procedure_occurrence",
]
