DATABASE_URL = "postgresql://postgres:postgres@localhost:2023/synthea"
BASE_DATA_PATH = "./data/covid19"
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
