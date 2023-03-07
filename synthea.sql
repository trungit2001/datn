CREATE TABLE organizations (
  id VARCHAR(50) PRIMARY KEY,
  organization_name VARCHAR(100),
  address VARCHAR(80),
  city VARCHAR(50),
  state VARCHAR(20),
  zip VARCHAR(20),
  lat NUMERIC,
  lon NUMERIC,
  phone VARCHAR(50),
  revenue NUMERIC,
  utilization INTEGER
);

CREATE TABLE patients (
  id VARCHAR(50) PRIMARY KEY,
  birthdate TIMESTAMP,
  deathdate TIMESTAMP,
  ssn VARCHAR(20),
  drivers VARCHAR(20),
  passport VARCHAR(20),
  prefix VARCHAR(10),
  first VARCHAR(50),
  last VARCHAR(50),
  suffix VARCHAR(10),
  maiden VARCHAR(30),
  marital VARCHAR(5),
  race VARCHAR(10),
  ethnicity VARCHAR(20),
  gender VARCHAR(1),
  birthplace VARCHAR(150),
  address VARCHAR(80),
  city VARCHAR(50),
  state VARCHAR(20),
  county VARCHAR(30),
  zip VARCHAR(20),
  lat NUMERIC,
  lon NUMERIC,
  heathcare_express NUMERIC,
  heathcare_coverage NUMERIC
);

CREATE TABLE payers (
  id VARCHAR(50) PRIMARY KEY,
  payer_name VARCHAR(30),
  address VARCHAR(80),
  city VARCHAR(50),
  state_headquartered VARCHAR(20),
  zip VARCHAR(20),
  phone VARCHAR(50),
  amount_covered NUMERIC,
  amount_uncovered NUMERIC,
  revenue NUMERIC,
  covered_encounters INTEGER,
  uncovered_encounters INTEGER,
  covered_medications INTEGER,
  uncovered_medications INTEGER,
  covered_procedures INTEGER,
  uncovered_procedures INTEGER,
  covered_immunizations INTEGER,
  uncovered_immunizations INTEGER,
  unique_customers INTEGER,
  qols_avg NUMERIC,
  member_months INTEGER
);

CREATE TABLE providers (
  id VARCHAR(50) PRIMARY KEY,
  organization VARCHAR(50),
  provider_name VARCHAR(50),
  gender VARCHAR(1),
  speciality VARCHAR(100),
  address VARCHAR(80),
  city VARCHAR(50),
  state VARCHAR(20),
  zip VARCHAR(20),
  lat NUMERIC,
  lon NUMERIC,
  utilization INTEGER,
  FOREIGN KEY (organization) REFERENCES organizations (id)
);

CREATE TABLE encounters (
  id VARCHAR(50) PRIMARY KEY,
  start TIMESTAMP,
  stop TIMESTAMP,
  patient VARCHAR(50),
  organization VARCHAR(50),
  provider VARCHAR(50),
  payer VARCHAR(50),
  encounterclass VARCHAR(30),
  code INTEGER,
  description VARCHAR(150),
  base_encounter_cost NUMERIC,
  total_claim_cost NUMERIC,
  payer_coverage NUMERIC,
  reasoncode NUMERIC,
  reasondescription VARCHAR(150),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (organization) REFERENCES organizations (id),
  FOREIGN KEY (provider) REFERENCES providers (id),
  FOREIGN KEY (payer) REFERENCES payers (id)
);

CREATE TABLE allergies (
  start TIMESTAMP,
  stop TIMESTAMP,
  patient VARCHAR(50),
  encounter VARCHAR(50),
  code INTEGER,
  description VARCHAR(150),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);

CREATE TABLE careplans (
  id VARCHAR(50) PRIMARY KEY,
  start TIMESTAMP,
  stop TIMESTAMP,
  patient VARCHAR(50),
  encounter VARCHAR(50),
  code INTEGER,
  description VARCHAR(150),
  reasoncode NUMERIC,
  reasondescription VARCHAR(150),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);

CREATE TABLE conditions (
  start TIMESTAMP,
  stop TIMESTAMP,
  patient VARCHAR(50),
  encounter VARCHAR(50),
  code INTEGER,
  description VARCHAR(200),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);

CREATE TABLE devices (
  start TIMESTAMP,
  stop TIMESTAMP,
  patient VARCHAR(50),
  encounter VARCHAR(50),
  code INTEGER,
  description VARCHAR(150),
  udi VARCHAR(250),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);

CREATE TABLE imaging_studies (
  id VARCHAR(50) PRIMARY KEY,
  date TIMESTAMP,
  patient VARCHAR(50),
  encounter VARCHAR(50),
  bodysite_code INTEGER,
  bodysite_description VARCHAR(150),
  modality_code VARCHAR(10),
  modality_description VARCHAR(100),
  sop_code VARCHAR(50),
  sop_description VARCHAR(150),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);

CREATE TABLE immunizations (
  date TIMESTAMP,
  patient VARCHAR(50),
  encounter VARCHAR(50),
  code INTEGER,
  description VARCHAR(150),
  base_cost NUMERIC,
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);

CREATE TABLE medications (
  start TIMESTAMP,
  stop TIMESTAMP,
  patient VARCHAR(50),
  payer VARCHAR(50),
  encounter VARCHAR(50),
  code INTEGER,
  description VARCHAR(300),
  base_cost NUMERIC,
  payer_coverage NUMERIC,
  dispenses INTEGER,
  totalcost NUMERIC,
  reasoncode NUMERIC,
  reasondescription VARCHAR(200),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (payer) REFERENCES payers (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);

CREATE TABLE observations (
  date TIMESTAMP,
  patient VARCHAR(50),
  encounter VARCHAR(50),
  code VARCHAR(10),
  description VARCHAR(300),
  value VARCHAR (100),
  units VARCHAR(20),
  type VARCHAR(20),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);

CREATE TABLE payer_transitions (
  patient VARCHAR(50),
  start_year INTEGER,
  end_year INTEGER,
  payer VARCHAR(50),
  ownership VARCHAR(20),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (payer) REFERENCES payers (id)
);

CREATE TABLE procedures (
  date TIMESTAMP,
  patient VARCHAR(50),
  encounter VARCHAR(50),
  code INTEGER,
  description VARCHAR(300),
  base_cost NUMERIC,
  reasoncode NUMERIC,
  reasondescription VARCHAR(200),
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);

CREATE TABLE supplies (
  date TIMESTAMP,
  patient VARCHAR(50),
  encounter VARCHAR(50),
  code INTEGER,
  description VARCHAR(200),
  quantity INTEGER,
  FOREIGN KEY (patient) REFERENCES patients (id),
  FOREIGN KEY (encounter) REFERENCES encounters (id)
);
