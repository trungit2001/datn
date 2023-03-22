import psycopg2

from configs.settings import DATABASE_URL, ORDER_STMT
from tqdm.auto import tqdm


def execute_crud(conn, stmt: str):
    try:
        cur = conn.cursor()
        cur.execute(stmt)
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error: %s" % error)
        conn.rollback()
        cur.close()
    finally:
        cur.close()


def main():
    conn = psycopg2.connect(DATABASE_URL)

    iters = tqdm(ORDER_STMT)

    for file in iters:
        iters.set_description(f"Executing script '{file}'")
        stmt = open(f"./scripts/{file}.sql", encoding='utf8').read()
        execute_crud(conn, stmt)
        

if __name__ == '__main__':
    main()
