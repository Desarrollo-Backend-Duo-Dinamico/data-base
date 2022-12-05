DROP TABLE IF EXISTS category CASCADE;

create table category (
	category_id serial PRIMARY KEY,
	category VARCHAR(50) NOT NULL,
	status INT CHECK(status BETWEEN 0 AND 1)
);

DROP TABLE IF EXISTS product CASCADE;

create table product (
	product_id serial PRIMARY KEY,
	gtin VARCHAR(15) NOT NULL,
	product VARCHAR(100) NOT NULL,
	description TEXT NOT NULL,
	price FLOAT8 CHECK( price >= 0),
	stock INT CHECK( stock >= 0) NOT NULL,
	category_id INT NOT NULL,
	status INT CHECK(status BETWEEN 0 AND 1),

	FOREIGN KEY (category_id) 	
		REFERENCES category  (category_id)
);

DROP TABLE IF EXISTS region CASCADE;

CREATE TABLE region(
	region_id SERIAL,
    region VARCHAR(100) UNIQUE NOT NULL,
    status INT CHECK(status BETWEEN 0 AND 1),
    PRIMARY KEY (region_id)
);

DROP TABLE IF EXISTS customer CASCADE;

CREATE TABLE customer(
	customer_id SERIAL,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    date_birth DATE NOT NULL,
    rfc VARCHAR(13) UNIQUE NOT NULL,
    mail VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(255),
    region_id INT NOT NULL,
    status INT CHECK(status BETWEEN 0 AND 1),
    PRIMARY KEY (customer_id),
    FOREIGN KEY (region_id) REFERENCES region(region_id)
);

DROP TABLE IF EXISTS invoice CASCADE;

CREATE TABLE invoice (
	invoice_id SERIAL,
	rfc VARCHAR(13) NOT NULL,
	subtotal FLOAT NOT NULL,
	taxes FLOAT NOT NULL,
	total FLOAT NOT NULL,
    	created_at DATE NOT NULL,
    	status INT CHECK(status BETWEEN 0 AND 1),
    PRIMARY KEY (invoice_id)
);


DROP TABLE IF EXISTS cart;

CREATE TABLE cart(
	cart_id SERIAL,
    	rfc VARCHAR(13) NOT NULL,
    	gtin CHAR(15) NOT NULL,
	quantity INT NOT NULL,
    	status INT CHECK(status BETWEEN 0 AND 1),
    PRIMARY KEY (cart_id)
);

DROP TABLE IF EXISTS item;

CREATE TABLE item(
	item_id SERIAL,
    	invoice_id INT NOT NULL,
    	gtin CHAR(15) NOT NULL,
    	quantity INT NOT NULL,
	unit_price FLOAT NOT NULL,
	subtotal FLOAT NOT NULL,
	taxes FLOAT NOT NULL,
	total FLOAT NOT NULL,
	status INT CHECK(status BETWEEN 0 AND 1),
    PRIMARY KEY (item_id),
    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
);
