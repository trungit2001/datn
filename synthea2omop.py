import psycopg2

from configs.settings import (
    DATABASE_URL,
    ORDER_ETL,
    SCRIPT_ETL_PATH
)
from utils import execute_crud
from tqdm.auto import tqdm


def main():
    conn = psycopg2.connect(DATABASE_URL)

    iters = tqdm(ORDER_ETL)

    for file in iters:
        iters.set_description(f"Executing script '{file}'")
        stmt = open(f"{SCRIPT_ETL_PATH}/{file}.sql", encoding='utf8').read()
        execute_crud(conn, stmt)
        

if __name__ == '__main__':
    main()
