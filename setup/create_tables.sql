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
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	gdp FLOAT NOT NULL,
	unemployment FLOAT NOT NULL,
	gini_coefficient FLOAT NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE NetCon(
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	internet_users FLOAT NOT NULL,
	cell_users FLOAT NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE QoL(
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	child_deaths FLOAT NOT NULL,
	sanitation_usage FLOAT NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Sustainability(
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	yearly_CO2 FLOAT NOT NULL,
	forest_coverage FLOAT NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Energy(
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	nuclear_electricity FLOAT NOT NULL,
	gas_prices FLOAT NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Population (
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	child_population INTEGER NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);
