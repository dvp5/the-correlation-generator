CREATE TABLE Nation(
	nationkey CHAR(20) NOT NULL,
	nationname VARCHAR(64) NOT NULL,
	PRIMARY KEY(nationkey)
);

CREATE TABLE Year(
	yearkey INTEGER NOT NULL,
	PRIMARY KEY(yearkey)
);

CREATE TABLE Finances(
	nationkey CHAR(20) NOT NULL,
	yearkey INTEGER NOT NULL,
	gdp FLOAT,
	unemployment FLOAT,
	gini_coefficient FLOAT,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE NetCon(
	nationkey CHAR(20) NOT NULL,
	yearkey INTEGER NOT NULL,
	internet_users FLOAT,
	cell_users FLOAT,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE QoL(
	nationkey CHAR(20) NOT NULL,
	yearkey INTEGER NOT NULL,
	child_deaths FLOAT,
	sanitation_usage FLOAT,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Sustainability(
	nationkey CHAR(20) NOT NULL,
	yearkey INTEGER NOT NULL,
	yearly_CO2 FLOAT,
	forest_coverage FLOAT,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Energy(
	nationkey CHAR(20) NOT NULL,
	yearkey INTEGER NOT NULL,
	nuclear_electricity FLOAT,
	gas_prices FLOAT,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Population (
	nationkey CHAR(20) NOT NULL,
	yearkey INTEGER NOT NULL,
    population INTEGER,
	child_population INTEGER,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);
