import os
import time
import pandas as pd

from sqlalchemy import create_engine
from configs.settings import (
    DATABASE_URL,
    BASE_DATA_PATH,
    ORDER_TABLES_INSERT
)


def main():
    if not (os.path.exists(BASE_DATA_PATH) and len(os.listdir(BASE_DATA_PATH)) > 0):
        print("Data does not exist!!! Download from the link in the file README.md")
        return

    print("Data ingestion")
    total_time = 0
    total_record = 0
    engine = create_engine(DATABASE_URL, echo=False)

    for idx, table in enumerate(ORDER_TABLES_INSERT, start=1):
        print("- Table %d:" % idx, table)
        start = time.time()
        df = pd.read_csv(f"{BASE_DATA_PATH}/{table}.csv")
        df.to_sql(
            name=table,
            con=engine,
            schema='synthea_schema',
            if_exists="append",
            index=False
        )
        end = time.time()

        number_of_record = df.shape[0]
        time_cost = end - start

        total_record += number_of_record
        total_time += time_cost

        print("\t+ Number of record(s):", number_of_record)
        print("\t+ Insert time:", round(time_cost, 2), "s", end="\n\n")

    print("- Summary data ingestion:")
    print("\t+ Total tables:", len(ORDER_TABLES_INSERT))
    print("\t+ Total records:", total_record)
    print("\t+ Total time:", round(total_time, 2), "s")


if __name__ == "__main__":
    main()
