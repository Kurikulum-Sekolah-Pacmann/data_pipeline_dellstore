CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE public.etl_log (
	id uuid NOT NULL DEFAULT uuid_generate_v4(),
	step varchar(255) NULL,
	process varchar(255) NULL,
	status varchar(255) NULL,
	source varchar(255),
	table_name varchar(255) NULL,
	error_msg text NULL,
	etl_date timestamp NULL,
	create_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT etl_log_pkey PRIMARY KEY (id)
);
