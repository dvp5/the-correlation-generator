import psycopg2
import os
import csv
import re
import collections

###############################################################################
# BEGIN SCRIPT CONFIG

__setup = './setup/'
__create_tables = __setup + 'create_tables.sql'
__user = os.environ.get('USER')
__port = 8888
__host = '/tmp'

__gapminder = __setup + 'ddf--gapminder--systema_globalis/'
__countries = __gapminder + 'countries-etc-datapoints/'

table_dict = {
    'Finances': {
        'gdp': 'total_gdp_us_inflation_adjusted',
        'unemployment': 'long_term_unemployment_rate_percent',
        'gini_coefficient': 'gapminder_gini',
    },
    'NetCon': {
        'internet_users': 'internet_users',
        'cell_users': 'cell_phones_per_100_people',
    },
    'QoL': {
        'child_deaths': 'child_mortality_0_5_year_olds_dying_per_1000_born',
        'sanitation_usage': 'at_least_basic_sanitation_overall_access_percent',
    },
    'Sustainability': {
        'yearly_CO2': 'co2_emissions_tonnes_per_person',
        'forest_coverage': 'forest_coverage_percent',
    },
    'Energy': {
        'nuclear_electricity': 'nuclear_power_generation_per_person',
        'gas_prices': 'pump_price_for_gasoline_us_per_liter',
    },
    'Population': {
        'population': 'total_population_with_projections',
        'child_population': 'population_aged_0_4_years_total_number',
    },
}

# END SCRIPT CONFIG
###############################################################################


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
    for field, entry in entries:
        path = f'{__countries}ddf--datapoints--{entry}--by--geo--time.csv'

        dictfill_from_csv(path, entry, table_dict)

    for key, values in table_dict.items():
        country, year = key
        value_string = ''
        field_string = ''
        for field, entry in entries:
            field_string += (field + ',')
            try:
                value_string += (values[entry] + ',')
            except KeyError:
                value_string += 'NULL,'

        field_string = f'(nationkey, yearkey, {field_string})'
        value_string = f'(\'{country}\', \'{year}\', {value_string})'
        insert_string = f'INSERT INTO {table_name} {field_string} VALUES {value_string};'

        cur.execute(insert_string)


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
    for table_name, entries in table_dict.items():
        populate_table(table_name, entries, cur)


if __name__ == '__main__':
    main()
