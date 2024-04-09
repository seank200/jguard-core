-- DROP ROLE IF EXISTS jg_core_admin;

CREATE ROLE jg_core_admin WITH
    LOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    NOBYPASSRLS
    CONNECTION LIMIT 32
    PASSWORD 'dxcv98iu7Ha23*&^$32!j092SEA';

-- DROP ROLE IF EXISTS jg_core_member;

CREATE ROLE jg_core_member WITH
    LOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    NOBYPASSRLS
    PASSWORD 'vcbju^&SIUE7efhuwe78HHEWwefi#';

-- DROP ROLE IF EXISTS jg_core_guest;

CREATE ROLE jg_core_guest WITH
    LOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    NOBYPASSRLS
    PASSWORD 'weofi&*WSEFBSDuySW908wefBV^';


-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users (
    id character(36) NOT NULL,
    group_code character(6) NOT NULL,
    display_name character varying(64),
    email character varying (256),
    photo character varying (256),
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_pk PRIMARY KEY (id),
    CONSTRAINT users_email_uk UNIQUE (email)
    );

ALTER TABLE IF EXISTS public.users
    OWNER TO jg_core_admin;
GRANT ALL ON TABLE public.users
    TO jg_core_admin;

REVOKE ALL ON TABLE public.users
    FROM jg_core_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.users
    TO jg_core_member;

REVOKE ALL ON TABLE public.users
    FROM jg_core_guest;
GRANT SELECT ON TABLE public.users
    TO jg_core_guest;


-- DROP TABLE IF EXISTS public.accounts;

CREATE TABLE IF NOT EXISTS public.accounts (
    provider character(8) NOT NULL,
    provider_id character varying (64) NOT NULL, -- ID from auth provider
    user_id character(36) NOT NULL, -- "FK" public.users.id
    credentials character varying (256), -- provider=PASSWORD only
    access_token character varying (256),
    refresh_token character varying (256),
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_auth_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_refresh_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT accounts_pk PRIMARY KEY (provider, provider_id),
    CONSTRAINT accounts_uk UNIQUE (provider, user_id)
    );

ALTER TABLE IF EXISTS public.accounts
    OWNER to jg_core_admin;
GRANT ALL ON TABLE public.accounts
    TO jg_core_admin;

REVOKE ALL ON TABLE public.accounts
    FROM jg_core_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.accounts
    TO jg_core_member;

REVOKE ALL ON TABLE public.accounts
    FROM jg_core_guest;
GRANT SELECT ON TABLE public.accounts
    TO jg_core_guest;


CREATE TABLE IF NOT EXISTS public.user_roles (
    id character(36) NOT NULL,
    label character varying (32) NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_roles_pk PRIMARY KEY (id)
);


-- DROP TABLE IF EXISTS public.entity_codes;

CREATE TABLE IF NOT EXISTS public.entity_codes (
    code character(6) NOT NULL,
    label character varying (36) NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT entity_code_pk PRIMARY KEY (code),
    CONSTRAINT entity_code_uk UNIQUE (label)
    );

ALTER TABLE IF EXISTS public.entity_codes
    OWNER to jg_core_admin;

GRANT ALL ON TABLE public.entity_codes
    TO jg_core_admin;

REVOKE ALL ON TABLE public.entity_codes
    FROM jg_core_member;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.entity_codes
    TO jg_core_member;

REVOKE ALL ON TABLE public.entity_codes
    FROM jg_core_guest;

GRANT SELECT ON TABLE public.entity_codes
    TO jg_core_guest;
