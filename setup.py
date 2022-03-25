import psycopg2
import os
import csv
import re

__setup = './setup/'
__create_tables = __setup + 'create_tables.sql'
__user = os.environ.get('USER')
__port = 8888
__host = '/tmp'

gapminder = __setup + 'ddf--gapminder--systema_globalis/'
entries = gapminder + 'ddf--entities--geo--country.csv'


def main():
    conn = psycopg2.connect(f"dbname=corrgen user={__user} port={__port} host={__host}")
    cur = conn.cursor()
    #  cur.execute(f"DROP OWNED BY {__user} CASCADE")
    with open(__create_tables) as sqlf:
        create_tables = sqlf.read()
    cur.execute(create_tables)

    populate_nation(cur)


def populate_nation(cur):
    with open(entries) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            country = row['country']
            name = row['name'].encode("utf-8").decode("ascii", errors="backslashreplace")
            name = re.sub('\'+', '\'\'', name)

            print(country, name)
            insert_string = f'INSERT INTO NATION VALUES (\'{country}\', \'{name}\');'
            cur.execute(insert_string)


if __name__ == '__main__':
    main()
