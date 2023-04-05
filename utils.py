import psycopg2

def execute_crud(conn, stmt: str):
    try:
        cur = conn.cursor()
        cur.execute(stmt)
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error: %s" % error)
        conn.rollback()
    finally:
        cur.close()
