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
	ppp DOUBLE NOT NULL,
	unemployment DOUBLE NOT NULL,
	gini_coefficient DOUBLE NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE NetCon(
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	internet_users DOUBLE NOT NULL,
	cell_subscriptions INTEGER NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE QoL(
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	child_deaths DOUBLE NOT NULL,
	sanitation_usage DOUBLE NOT NULL,
	PRIMARY KEY (nationkey, yearkey)  NOT NULL,
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Sustainability(
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	yearly_CO2 DOUBLE NOT NULL,
	forest_coverage DOUBLE NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Energy(
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	nuclear_electricity DOUBLE NOT NULL,
	gas_prices DOUBLE NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Population (
	nationkey CHAR(3) NOT NULL,
	yearkey INTEGER NOT NULL,
	child_population  <datatype> NOT NULL,
	population <datatype> NOT NULL,
	PRIMARY KEY (nationkey, yearkey),
	FOREIGN KEY (nationkey) REFERENCES Nation,
	FOREIGN KEY (yearkey) REFERENCES Year
);
