-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE public.orders_order_nk_seq;

CREATE SEQUENCE public.orders_order_nk_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.products_product_nk_seq;

CREATE SEQUENCE public.products_product_nk_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.categories definition

-- Drop table

-- DROP TABLE categories;

CREATE TABLE categories (
	category_id uuid NOT NULL DEFAULT uuid_generate_v4(),
	category_nk int4 NOT NULL,
	category_name varchar(50) NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT categories_category_nk_key UNIQUE (category_nk),
	CONSTRAINT categories_pkey PRIMARY KEY (category_id)
);


-- public.customers definition

-- Drop table

-- DROP TABLE customers;

CREATE TABLE customers (
	customer_id uuid NOT NULL DEFAULT uuid_generate_v4(),
	customer_nk int4 NOT NULL,
	first_name varchar NOT NULL,
	last_name varchar NOT NULL,
	address1 varchar NOT NULL,
	address2 varchar(50) NULL,
	city varchar NOT NULL,
	state varchar NULL,
	zip int4 NULL,
	country varchar(50) NOT NULL,
	region int2 NOT NULL,
	email varchar NULL,
	phone varchar(50) NULL,
	credit_card_type int4 NOT NULL,
	credit_card varchar(50) NOT NULL,
	credit_card_expiration varchar(50) NOT NULL,
	username varchar NOT NULL,
	"password" varchar(50) NOT NULL,
	age int2 NULL,
	income int4 NULL,
	gender varchar(1) NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT customers_customer_nk_key UNIQUE (customer_nk),
	CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
);
CREATE UNIQUE INDEX ix_cust_username ON public.customers USING btree (username);


-- public.inventory definition

-- Drop table

-- DROP TABLE inventory;

CREATE TABLE inventory (
	product_id uuid NOT NULL DEFAULT uuid_generate_v4(),
	product_nk int4 NOT NULL,
	quantity_stock int4 NOT NULL,
	sales int4 NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT inventory_pkey PRIMARY KEY (product_id),
	CONSTRAINT inventory_product_nk_key UNIQUE (product_nk)
);


-- public.order_status_analytic definition

-- Drop table

-- DROP TABLE order_status_analytic;

CREATE TABLE order_status_analytic (
	order_id uuid NOT NULL DEFAULT uuid_generate_v4(),
	order_nk int4 NOT NULL,
	sum_stock numeric(12, 2) NOT NULL,
	status varchar(50) NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT order_status_analytic_order_nk_key UNIQUE (order_nk),
	CONSTRAINT order_status_analytic_pkey PRIMARY KEY (order_id)
);


-- public.cust_hist definition

-- Drop table

-- DROP TABLE cust_hist;

CREATE TABLE cust_hist (
	customer_id uuid NOT NULL,
	order_id uuid NOT NULL,
	product_id uuid NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT unique_id UNIQUE (customer_id, order_id, product_id),
	CONSTRAINT fk_cust_hist_customerid FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);


-- public.orders definition

-- Drop table

-- DROP TABLE orders;

CREATE TABLE orders (
	order_id uuid NOT NULL DEFAULT uuid_generate_v4(),
	order_nk serial4 NOT NULL,
	order_date date NOT NULL,
	customer_id uuid NULL,
	net_amount numeric(12, 2) NOT NULL,
	tax numeric(12, 2) NOT NULL,
	total_amount numeric(12, 2) NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT orders_pkey PRIMARY KEY (order_id),
	CONSTRAINT orders_un UNIQUE (order_nk),
	CONSTRAINT fk_customerid FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL
);
CREATE INDEX ix_order_custid ON public.orders USING btree (customer_id);


-- public.products definition

-- Drop table

-- DROP TABLE products;

CREATE TABLE products (
	product_id uuid NOT NULL DEFAULT uuid_generate_v4(),
	product_nk serial4 NOT NULL,
	category_id uuid NOT NULL,
	title varchar NOT NULL,
	actor varchar(50) NOT NULL,
	price numeric(12, 2) NOT NULL,
	special int4 NULL,
	common_prod_id int4 NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT products_pkey PRIMARY KEY (product_id),
	CONSTRAINT products_product_nk_key UNIQUE (product_nk),
	CONSTRAINT fk_prod_category FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);
CREATE INDEX ix_prod_category ON public.products USING btree (category_id);
CREATE INDEX ix_prod_special ON public.products USING btree (special);


-- public.orderlines definition

-- Drop table

-- DROP TABLE orderlines;

CREATE TABLE orderlines (
	orderline_id uuid NOT NULL DEFAULT uuid_generate_v4(),
	orderline_nk int4 NOT NULL,
	order_id uuid NOT NULL,
	product_id uuid NOT NULL,
	quantity int2 NOT NULL,
	order_date date NOT NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT orderlines_pkey PRIMARY KEY (orderline_id),
	CONSTRAINT orderlines_un UNIQUE (orderline_nk, order_id, product_id, quantity),
	CONSTRAINT fk_orderid FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
	CONSTRAINT fk_orderlines_prod_id FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
CREATE UNIQUE INDEX ix_orderlines_orderid ON public.orderlines USING btree (order_id, orderline_id);



-- DROP FUNCTION public.uuid_generate_v1();

CREATE OR REPLACE FUNCTION public.uuid_generate_v1()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1$function$
;

-- DROP FUNCTION public.uuid_generate_v1mc();

CREATE OR REPLACE FUNCTION public.uuid_generate_v1mc()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1mc$function$
;

-- DROP FUNCTION public.uuid_generate_v3(uuid, text);

CREATE OR REPLACE FUNCTION public.uuid_generate_v3(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v3$function$
;

-- DROP FUNCTION public.uuid_generate_v4();

CREATE OR REPLACE FUNCTION public.uuid_generate_v4()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v4$function$
;

-- DROP FUNCTION public.uuid_generate_v5(uuid, text);

CREATE OR REPLACE FUNCTION public.uuid_generate_v5(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v5$function$
;

-- DROP FUNCTION public.uuid_nil();

CREATE OR REPLACE FUNCTION public.uuid_nil()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_nil$function$
;

-- DROP FUNCTION public.uuid_ns_dns();

CREATE OR REPLACE FUNCTION public.uuid_ns_dns()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_dns$function$
;

-- DROP FUNCTION public.uuid_ns_oid();

CREATE OR REPLACE FUNCTION public.uuid_ns_oid()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_oid$function$
;

-- DROP FUNCTION public.uuid_ns_url();

CREATE OR REPLACE FUNCTION public.uuid_ns_url()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_url$function$
;

-- DROP FUNCTION public.uuid_ns_x500();

CREATE OR REPLACE FUNCTION public.uuid_ns_x500()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_x500$function$
;