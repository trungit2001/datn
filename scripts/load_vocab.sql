-- host machine
-- COPY cdm_schema.concept FROM 'E:\DATN\data\cdmVocab\CONCEPT.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
-- COPY cdm_schema.vocabulary FROM 'E:\DATN\data\cdmVocab\VOCABULARY.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
-- COPY cdm_schema.domain FROM 'E:\DATN\data\cdmVocab\DOMAIN.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
-- COPY cdm_schema.concept_class FROM 'E:\DATN\data\cdmVocab\CONCEPT_CLASS.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
-- COPY cdm_schema.concept_relationship FROM 'E:\DATN\data\cdmVocab\CONCEPT_RELATIONSHIP.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
-- COPY cdm_schema.relationship FROM 'E:\DATN\data\cdmVocab\RELATIONSHIP.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
-- COPY cdm_schema.concept_synonym FROM 'E:\DATN\data\cdmVocab\CONCEPT_SYNONYM.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
-- COPY cdm_schema.concept_ancestor FROM 'E:\DATN\data\cdmVocab\CONCEPT_ANCESTOR.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
-- COPY cdm_schema.drug_strength FROM 'E:\DATN\data\cdmVocab\DRUG_STRENGTH.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';

-- inside container
COPY cdm_schema.concept FROM '/home/CONCEPT.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
COPY cdm_schema.vocabulary FROM '/home/VOCABULARY.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
COPY cdm_schema.domain FROM '/home/DOMAIN.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
COPY cdm_schema.concept_class FROM '/home/CONCEPT_CLASS.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
COPY cdm_schema.concept_relationship FROM '/home/CONCEPT_RELATIONSHIP.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
COPY cdm_schema.relationship FROM '/home/RELATIONSHIP.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
COPY cdm_schema.concept_synonym FROM '/home/CONCEPT_SYNONYM.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
COPY cdm_schema.concept_ancestor FROM '/home/CONCEPT_ANCESTOR.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
COPY cdm_schema.drug_strength FROM '/home/DRUG_STRENGTH.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b';
