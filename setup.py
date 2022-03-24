import psycopg2
import os

__setup = './setup/'
__create_tables = __setup + 'create_tables.sql'
__user = os.environ.get('USER')


def main():
    conn = psycopg2.connect(f"dbname=corrgen user={__user}")
    cur = conn.cursor()
    cur.execute(f"DROP OWNED BY {__user} CASCADE")
    with open(__create_tables) as sqlf:
        create_tables = sqlf.read()
    cur.execute(create_tables)
    #  records = cur.fetchall()
    #  print(records)


if __name__ == '__main__':
    main()
