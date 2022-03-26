import psycopg2
import os
import csv
import re
import collections


__setup = './setup/'
__create_tables = __setup + 'create_tables.sql'
__user = os.environ.get('USER')
__port = 8888
__host = '/tmp'

__gapminder = __setup + 'ddf--gapminder--systema_globalis/'
__countries = __gapminder + 'countries-etc-datapoints/'

table_dict = {
    'Finances': [
        'total_gdp_us_inflation_adjusted',
        'long_term_unemployment_rate_percent',
        'gapminder_gini'
    ],
    'NetCon': [
        'internet_users',
        'cell_users'
    ],
    'QoL': [
        ''
    ]
}


def main():
    conn = psycopg2.connect(
        f"dbname=corrgen user={__user} port={__port} host={__host}")
    cur = conn.cursor()
    #  cur.execute(f"DROP OWNED BY {__user} CASCADE")
    with open(__create_tables) as sqlf:
        create_tables = sqlf.read()
    cur.execute(create_tables)

    populate_nation(cur)
    populate_year(cur)
    populate_finances(cur)
    populate_netcon(cur)
    populate_qol(cur)
    populate_sustainablility(cur)
    populate_energy(cur)


def dictfill_from_csv(path, entry, db_dict, alias=None):
    if alias is None:
        alias = entry

    with open(path) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            country = row['geo']
            year = row['time']
            var = row[entry]
            cytuple = (country, year,)
            db_dict[cytuple][alias] = var


def populate_nation(cur):
    entries = __gapminder + 'ddf--entities--geo--country.csv'
    with open(entries) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            country = row['country']
            name = row['name']\
                .encode("utf-8")\
                .decode("ascii", errors="backslashreplace")
            name = re.sub('\'+', '\'\'', name)

            insert_string = f'INSERT INTO Nation VALUES (\'{country}\', \'{name}\');'
            cur.execute(insert_string)


def populate_year(cur):
    for i in range(1600, 2100):
        insert_string = f'INSERT INTO Year VALUES ({i});'
        cur.execute(insert_string)


def populate_table(table_name, entries, cur):
    table_dict = collections.defaultdict(dict)
    for entry in entries:
        path = __countries + 'ddf--datapoints--' + entry + '--by--geo--time.csv'
        dictfill_from_csv(path, entry, table_dict)

    for key, values in table_dict.items():
        country, year = key
        value_string = ''.join([',' + values[entry] for entry in entries])
        insert_string = f'INSERT INTO {table_name} VALUES (\'{country}\', {year} {value_string});'
        cur.execute(insert_string)


def populate_finances(cur):
    gini_path = __countries + 'ddf--datapoints--gapminder_gini--by--geo--time.csv'
    gdp_path = __countries + \
        'ddf--datapoints--total_gdp_us_inflation_adjusted--by--geo--time.csv'
    unemployment_path = __countries + \
        'ddf--datapoints--long_term_unemployment_rate_percent--by--geo--time.csv'

    finances_dict = collections.defaultdict(dict)

    dictfill_from_csv(gini_path, 'gapminder_gini', finances_dict, alias='gini')
    dictfill_from_csv(gdp_path, 'total_gdp_us_inflation_adjusted',
                      finances_dict, alias='gdp')
    dictfill_from_csv(unemployment_path, 'long_term_unemployment_rate_percent',
                      finances_dict, alias='unemployment')

    for key, values in finances_dict.items():
        country, year = key
        gini = values['gini']
        gdp = values['gdp']
        unemployment = values['unemployment']

        insert_string = f"INSERT INTO finances VALUES (\'{country}\', {year}, {gdp}, {unemployment}, {gini});"
        cur.execute(insert_string)


def populate_netcon(cur):
    internet_path = __countries + 'ddf--datapoints--internet_users--by--geo--time.csv'
    cell_path = __countries + \
        'ddf--datapoints--cell_phones_per_100_people--by--geo--time.csv'

    netcon_dict = collections.defaultdict(dict)

    dictfill_from_csv(internet_path, )
    pass


def populate_qol(cur):
    pass


def populate_sustainablility(cur):
    pass


def populate_energy(cur):
    pass


def populate_population(cur):
    pass


if __name__ == '__main__':
    main()
