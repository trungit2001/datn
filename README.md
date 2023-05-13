# This repository for my graduation thesis
# 1. Data ingestion 
## (Create a database and insert data into it)
- Download data from this link: [synthea2omop.zip](https://drive.google.com/uc?id=1Zk9gppJF2BTZ7y_4ONUTHGQEpYveBpwr&export=download&confirm=t)
- Extract zip file to `data` folder
- Run container: `docker-compose up`
- Run script: `python data_ingest.py`
- Run script: `python vocab_n_constraints.py`
- Run script: `python synthea2omop.py`
