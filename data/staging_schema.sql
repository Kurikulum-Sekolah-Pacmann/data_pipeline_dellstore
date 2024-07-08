-- DROP SCHEMA staging;

CREATE SCHEMA staging AUTHORIZATION postgres;

-- DROP SEQUENCE staging.categories_category_seq;

CREATE SEQUENCE staging.categories_category_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE staging.customer_orders_history_order_id_seq;

CREATE SEQUENCE staging.customer_orders_history_order_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE staging.customer_orders_history_orderline_id_seq;

CREATE SEQUENCE staging.customer_orders_history_orderline_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE staging.customers_customerid_seq;

CREATE SEQUENCE staging.customers_customerid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE staging.orders_orderid_seq;

CREATE SEQUENCE staging.orders_orderid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE staging.products_prod_id_seq;

CREATE SEQUENCE staging.products_prod_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- staging.categories definition

-- Drop table

-- DROP TABLE staging.categories;

CREATE TABLE staging.categories (
	category serial4 NOT NULL,
	categoryname varchar(50) NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT categories_pkey PRIMARY KEY (category)
);


-- staging.customer_orders_history definition

-- Drop table

-- DROP TABLE staging.customer_orders_history;

CREATE TABLE staging.customer_orders_history (
	customer_id int4 NULL,
	customer_address1 varchar(255) NULL,
	customer_address2 varchar(255) NULL,
	customer_age int2 NULL,
	customer_city varchar(255) NULL,
	customer_country varchar(255) NULL,
	customer_creditcard varchar(255) NULL,
	customer_creditcardexpiration varchar(255) NULL,
	customer_creditcardtype varchar(255) NULL,
	customer_email varchar(255) NULL,
	customer_firstname varchar(255) NULL,
	customer_gender varchar(1) NULL,
	customer_income int4 NULL,
	customer_lastname varchar(255) NULL,
	customer_password varchar(255) NULL,
	customer_phone varchar(255) NULL,
	customer_region int2 NULL,
	customer_state varchar(255) NULL,
	customer_username varchar(255) NULL,
	customer_zip int4 NULL,
	order_customerid int4 NULL,
	order_date date NULL,
	order_id serial4 NOT NULL,
	order_netamount numeric(12, 2) NULL,
	order_tax numeric(12, 2) NULL,
	order_totalamount numeric(12, 2) NULL,
	orderline_id serial4 NOT NULL,
	orderline_orderdate date NULL,
	orderline_prod_id int4 NULL,
	orderline_quantity int2 NULL,
	product_actor varchar(255) NULL,
	product_category int4 NULL,
	product_common_prod_id int4 NULL,
	product_id int4 NULL,
	product_price numeric(12, 2) NULL,
	product_special int2 NULL,
	product_title varchar(255) NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT customer_orders_history_orderline_id_customer_id_order_id_key UNIQUE (orderline_id, customer_id, order_id)
);


-- staging.customers definition

-- Drop table

-- DROP TABLE staging.customers;

CREATE TABLE staging.customers (
	customerid serial4 NOT NULL,
	firstname varchar NOT NULL,
	lastname varchar NOT NULL,
	address1 varchar NOT NULL,
	address2 varchar(50) NULL,
	city varchar NOT NULL,
	state varchar NULL,
	zip int4 NULL,
	country varchar(50) NOT NULL,
	region int2 NOT NULL,
	email varchar NULL,
	phone varchar(50) NULL,
	creditcardtype int4 NOT NULL,
	creditcard varchar(50) NOT NULL,
	creditcardexpiration varchar(50) NOT NULL,
	username varchar NOT NULL,
	"password" varchar(50) NOT NULL,
	age int2 NULL,
	income int4 NULL,
	gender varchar(1) NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT customers_pkey PRIMARY KEY (customerid)
);
CREATE UNIQUE INDEX ix_cust_username ON staging.customers USING btree (username);


-- staging.inventory definition

-- Drop table

-- DROP TABLE staging.inventory;

CREATE TABLE staging.inventory (
	prod_id int4 NOT NULL,
	quan_in_stock int4 NOT NULL,
	sales int4 NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT inventory_pkey PRIMARY KEY (prod_id)
);


-- staging.order_status_analytic definition

-- Drop table

-- DROP TABLE staging.order_status_analytic;

CREATE TABLE staging.order_status_analytic (
	orderid int4 NOT NULL,
	sum_stock numeric(12, 2) NOT NULL,
	status varchar(50) NOT NULL,
	CONSTRAINT order_status_analytic_pkey PRIMARY KEY (orderid)
);


-- staging.cust_hist definition

-- Drop table

-- DROP TABLE staging.cust_hist;

CREATE TABLE staging.cust_hist (
	customerid int4 NOT NULL,
	orderid int4 NOT NULL,
	prod_id int4 NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT unique_id UNIQUE (customerid, orderid, prod_id),
	CONSTRAINT fk_cust_hist_customerid FOREIGN KEY (customerid) REFERENCES staging.customers(customerid) ON DELETE CASCADE
);
CREATE INDEX ix_cust_hist_customerid ON staging.cust_hist USING btree (customerid);


-- staging.orders definition

-- Drop table

-- DROP TABLE staging.orders;

CREATE TABLE staging.orders (
	orderid serial4 NOT NULL,
	orderdate date NOT NULL,
	customerid int4 NULL,
	netamount numeric(12, 2) NOT NULL,
	tax numeric(12, 2) NOT NULL,
	totalamount numeric(12, 2) NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT orders_pkey PRIMARY KEY (orderid),
	CONSTRAINT fk_customerid FOREIGN KEY (customerid) REFERENCES staging.customers(customerid) ON DELETE SET NULL
);
CREATE INDEX ix_order_custid ON staging.orders USING btree (customerid);


-- staging.products definition

-- Drop table

-- DROP TABLE staging.products;

CREATE TABLE staging.products (
	prod_id serial4 NOT NULL,
	category int4 NOT NULL,
	title varchar(50) NOT NULL,
	actor varchar(50) NOT NULL,
	price numeric(12, 2) NOT NULL,
	special int2 NULL,
	common_prod_id int4 NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT products_pkey PRIMARY KEY (prod_id),
	CONSTRAINT fk_prod_category FOREIGN KEY (category) REFERENCES staging.categories(category) ON DELETE CASCADE,
	CONSTRAINT fk_products_category FOREIGN KEY (category) REFERENCES staging.categories(category) ON DELETE CASCADE
);
CREATE INDEX ix_prod_category ON staging.products USING btree (category);
CREATE INDEX ix_prod_special ON staging.products USING btree (special);


-- staging.orderlines definition

-- Drop table

-- DROP TABLE staging.orderlines;

CREATE TABLE staging.orderlines (
	orderlineid int4 NOT NULL,
	orderid int4 NOT NULL,
	prod_id int4 NOT NULL,
	quantity int2 NOT NULL,
	orderdate date NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_orderid FOREIGN KEY (orderid) REFERENCES staging.orders(orderid) ON DELETE CASCADE,
	CONSTRAINT fk_orderlines_prod_id FOREIGN KEY (prod_id) REFERENCES staging.products(prod_id) ON DELETE CASCADE
);
CREATE UNIQUE INDEX ix_orderlines_orderid ON staging.orderlines USING btree (orderid, orderlineid);