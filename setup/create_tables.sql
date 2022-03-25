CREATE TABLE Nation(
	nationkey CHAR(20) NOT NULL,
	nationname VARCHAR(64) NOT NULL,
	PRIMARY KEY(nationkey)
);

CREATE TABLE Year(
	yearkey INTEGER  NOT NULL,
	PRIMARY KEY(yearkey)  NOT NULL
);

CREATE TABLE Finances(
	nationkey CHAR(3)  NOT NULL,
	yearkey INTEGER  NOT NULL,
	ppp DOUBLE NOT NULL,
	unemployment DOUBLE  NOT NULL,
	gini_coefficient <datatype>  NOT NULL,
	PRIMARY KEY (nationkey, yearkey)  NOT NULL,
	FOREIGN KEY (nationkey) REFERENCES Nation
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE NetCon(
	nationkey CHAR(3)  NOT NULL,
	yearkey INTEGER  NOT NULL,
	internet_users <datatype>  NOT NULL,
	cell_subscriptions <datatype>  NOT NULL,
	PRIMARY KEY (nationkey, yearkey)  NOT NULL,
	FOREIGN KEY (nationkey) REFERENCES Nation
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE QoL(
	nationkey CHAR(3)  NOT NULL,
	yearkey INTEGER  NOT NULL,
	child_deaths <datatype>  NOT NULL,
	sanitation_usage <datatype>  NOT NULL,
	PRIMARY KEY (nationkey, yearkey)  NOT NULL,
	FOREIGN KEY (nationkey) REFERENCES Nation
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Sustainability(
	nationkey CHAR(3)  NOT NULL,
	yearkey INTEGER  NOT NULL,
	yearly_CO2 <datatype>  NOT NULL,
	tree_removal <datatype>  NOT NULL,
	PRIMARY KEY (nationkey, yearkey)  NOT NULL,
	FOREIGN KEY (nationkey) REFERENCES Nation
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Energy(
	nationkey CHAR(3)  NOT NULL,
	yearkey INTEGER  NOT NULL,
	nuclear_electricity <datatype>  NOT NULL,
	SDI <datatype>  NOT NULL,
	gas_prices <datatype> NOT NULL,
	PRIMARY KEY (nationkey, yearkey)  NOT NULL,
	FOREIGN KEY (nationkey) REFERENCES Nation
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Weather(
	nationkey CHAR(3)  NOT NULL,
	yearkey INTEGER  NOT NULL,
	extreme_heat <datatype>  NOT NULL,
	global_temperatures <datatype>  NOT NULL,
	PRIMARY KEY (nationkey, yearkey)  NOT NULL,
	FOREIGN KEY (nationkey) REFERENCES Nation
	FOREIGN KEY (yearkey) REFERENCES Year
);

CREATE TABLE Finances(
	nationkey CHAR(3)  NOT NULL,
	yearkey INTEGER  NOT NULL,
	child_population  <datatype>  NOT NULL,
	population <datatype>  NOT NULL,
	PRIMARY KEY (nationkey, yearkey)  NOT NULL,
	FOREIGN KEY (nationkey) REFERENCES Nation
	FOREIGN KEY (yearkey) REFERENCES Year
);
