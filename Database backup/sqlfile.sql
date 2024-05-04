--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_assets (
    id integer NOT NULL,
    fetch_name character varying(500),
    asset_type character varying(20) NOT NULL,
    holding_type character varying(20) NOT NULL,
    current_price numeric(10,5) NOT NULL,
    show_name character varying(500),
    CONSTRAINT api_assets_id_check CHECK ((id >= 0))
);


ALTER TABLE public.api_assets OWNER TO postgres;

--
-- Name: api_userholdings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_userholdings (
    id bigint NOT NULL,
    date timestamp with time zone NOT NULL,
    quantity integer NOT NULL,
    action character varying(5) NOT NULL,
    price numeric(50,10) NOT NULL,
    asset_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT api_userholdings_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.api_userholdings OWNER TO postgres;

--
-- Name: api_userholdings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.api_userholdings ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_userholdings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Data for Name: api_assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_assets (id, fetch_name, asset_type, holding_type, current_price, show_name) FROM stdin;
12	NESTLEIND	equity	stock	2526.70000	Nestle India Limited
119835	SBI CONTRA FUND - DIRECT PLAN - GROWTH	equity	mutual_fund	377.13360	SBI CONTRA FUND - DIRECT PLAN - GROWTH
120847	quant ELSS Tax Saver Fund - Growth Option - Direct Plan	equity	mutual_fund	410.30450	quant ELSS Tax Saver Fund - Growth Option - Direct Plan
130498	HDFC Large and Mid Cap Fund - Growth Option - Direct Plan	equity	mutual_fund	310.29000	HDFC Large and Mid Cap Fund - Growth Option - Direct Plan
118632	Nippon India Large Cap Fund - Direct Plan Growth Plan - Growth Option	equity	mutual_fund	88.64870	Nippon India Large Cap Fund - Direct Plan Growth Plan - Growth Option
119723	SBI LONG TERM EQUITY FUND - DIRECT PLAN -GROWTH	equity	mutual_fund	418.29440	SBI LONG TERM EQUITY FUND - DIRECT PLAN -GROWTH
130050	Nippon India Strategic Debt Fund - Direct Plan - Growth Option	debt	mutual_fund	15.06190	Nippon India Strategic Debt Fund - Direct Plan - Growth Option
1	HDFCBANK	equity	stock	1533.00000	HDFC Bank Ltd
120586	ICICI Prudential Bluechip Fund - Direct Plan - Growth	equity	mutual_fund	106.26000	ICICI Prudential Bluechip Fund - Direct Plan - Growth
4	NHPC	equity	stock	92.87000	NHPC Ltd
5	IRCTC	equity	stock	1022.80000	Indian Railway Ctrng nd Trsm Corp Ltd
6	ITC	equity	stock	436.90000	ITC Ltd
7	SBIN	equity	stock	779.00000	State Bank of India
8	CEATLTD	equity	stock	2626.35010	CEAT Ltd
9	PAYTM	equity	stock	400.50000	One 97 Communications Ltd
119382	BANK OF INDIA Short Term Income Fund-Direct Plan- Growth	debt	mutual_fund	25.90100	BANK OF INDIA Short Term Income Fund-Direct Plan- Growth
119798	SBI CREDIT RISK FUND - DIRECT PLAN -GROWTH	debt	mutual_fund	44.15970	SBI CREDIT RISK FUND - DIRECT PLAN -GROWTH
119075	HDFC Dynamic Debt Fund - Growth Option - Direct Plan	debt	mutual_fund	88.92350	HDFC Dynamic Debt Fund - Growth Option - Direct Plan
128006	Kotak Medium Term Fund - Direct Growth	debt	mutual_fund	22.48330	Kotak Medium Term Fund - Direct Growth
115127	Aditya Birla Sun Life Gold ETF	gold	etf	64.05660	Aditya Birla Sun Life Gold ETF
113434	Axis Gold ETF	gold	etf	60.62550	Axis Gold ETF
113076	ICICI Prudential Gold ETF	gold	etf	62.36320	ICICI Prudential Gold ETF
10	ZOMATO	equity	stock	196.80000	Zomato Ltd
11	TATAMOTORS	equity	stock	1013.15000	Tata Motors Ltd
107693	Quantum Gold Fund	gold	etf	60.54770	Quantum Gold Fund
119539	Aditya Birla Sun Life Medium Term Plan - Growth - Direct Plan	debt	mutual_fund	37.03120	Aditya Birla Sun Life Medium Term Plan - Growth - Direct Plan
150714	UTI Gold ETF Fund of Fund - Direct Plan - Growth Option	gold	etf	13.99000	UTI Gold ETF Fund of Fund - Direct Plan - Growth Option
111954	SBI Gold ETF	gold	etf	62.37470	SBI Gold ETF
100177	Quant Small Cap Fund - Growth - Regular Plan	equity	mutual_fund	246.77270	Quant Small Cap Fund - Growth - Regular Plan
2	TCS	equity	stock	3982.55000	Tata Consultancy Services Ltd
3	IRFC	equity	stock	146.65000	Indian Railway Finance Corp Ltd
\.


--
-- Data for Name: api_userholdings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_userholdings (id, date, quantity, action, price, asset_id, user_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add user holdings	7	add_userholdings
26	Can change user holdings	7	change_userholdings
27	Can delete user holdings	7	delete_userholdings
28	Can view user holdings	7	view_userholdings
29	Can add assets	8	add_assets
30	Can change assets	8	change_assets
31	Can delete assets	8	delete_assets
32	Can view assets	8	view_assets
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
6	pbkdf2_sha256$720000$x8dEFyARA0NsxMCMGnDPGF$Y+Cp5YUaI6gawhgIwY7608uHORIBfaAPJhsQtJfqhrE=	\N	f	nikhil				f	t	2024-04-12 14:55:51.308182+05:30
7	pbkdf2_sha256$720000$btoIKuDEii4RjPUJdz0zMI$pB5D/KIs44Y8iyhl2maGFjKwiY8FVXrCtxVrkSU36Mc=	\N	f	nikhil931				f	t	2024-04-23 00:30:35.729097+05:30
18	pbkdf2_sha256$720000$shtVEi96yriDnuXRhIPrUU$fpWVfuCYqm7WppwegBT+qdwJ5Uh9bE9LZHIfV5kMvlo=	\N	f	kalsdfjksla	asdfasf	asdfasdf	kalsdfjs@gmasid.com	f	t	2024-04-26 16:32:01.188469+05:30
19	pbkdf2_sha256$720000$lIredj2ZJXP8Mha3mmp9Cz$I6DgRJy+WUhsIFhtuyEQS95zIODQxBlH4/Ci1JDx2A0=	\N	f	manav	Manav	Sharma	manavsharma2139@gmail.com	f	t	2024-04-26 18:59:45.685986+05:30
1	pbkdf2_sha256$720000$38UITcdTFd3fsGFww1HGL3$R2Ryw0m1g+frvRO0Rat+2VxvbrK6MsK1BGyU5XIWi5g=	2024-05-01 15:48:07.191173+05:30	t	admin			admin@sa.com	t	t	2024-04-12 00:26:07.344525+05:30
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2024-04-12 01:15:49.439963+05:30	2	nikhil931	3		4	1
2	2024-04-12 01:15:49.448098+05:30	3	nikhil9312	3		4	1
3	2024-04-12 01:15:49.449058+05:30	4	nikhil93121	3		4	1
4	2024-04-12 13:17:32.338954+05:30	1	Assets object (1)	1	[{"added": {}}]	8	1
5	2024-04-12 13:25:50.077303+05:30	1	GOOG | stock | equity	3		8	1
6	2024-04-12 13:36:43.225522+05:30	1	HDFCBANK | stock | equity	1	[{"added": {}}]	8	1
7	2024-04-12 13:38:55.377613+05:30	2	TCS | stock | equity	1	[{"added": {}}]	8	1
8	2024-04-12 13:39:50.842247+05:30	3	IRFC | stock | equity	1	[{"added": {}}]	8	1
9	2024-04-12 13:41:24.062227+05:30	4	NHPC | stock | equity	1	[{"added": {}}]	8	1
10	2024-04-12 13:42:20.279248+05:30	5	IRCTC | stock | equity	1	[{"added": {}}]	8	1
11	2024-04-12 13:43:05.117114+05:30	6	ITC | stock | equity	1	[{"added": {}}]	8	1
12	2024-04-12 13:43:52.976759+05:30	7	SBIN | stock | equity	1	[{"added": {}}]	8	1
13	2024-04-12 13:45:08.281744+05:30	8	CEATLTD | stock | equity	1	[{"added": {}}]	8	1
14	2024-04-12 13:46:08.586423+05:30	9	PAYTM | stock | equity	1	[{"added": {}}]	8	1
15	2024-04-12 13:47:04.524359+05:30	10	ZOMATO | stock | equity	1	[{"added": {}}]	8	1
16	2024-04-12 13:48:06.662734+05:30	11	TATAMOTORS | stock | equity	1	[{"added": {}}]	8	1
17	2024-04-12 13:48:48.548807+05:30	12	NESTLEIND | stock | equity	1	[{"added": {}}]	8	1
18	2024-04-12 13:54:44.544436+05:30	100177	Quant Small Cap Fund - Growth - Regular Plan | mutual_fund | equity	1	[{"added": {}}]	8	1
19	2024-04-12 14:03:26.329684+05:30	119835	SBI CONTRA FUND - DIRECT PLAN - GROWTH | mutual_fund | equity	1	[{"added": {}}]	8	1
20	2024-04-12 14:04:18.91349+05:30	119723	SBI LONG TERM EQUITY FUND - DIRECT PLAN -GROWTH | mutual_fund | equity	1	[{"added": {}}]	8	1
21	2024-04-12 14:05:28.424885+05:30	120847	quant ELSS Tax Saver Fund - Growth Option - Direct Plan | mutual_fund | equity	1	[{"added": {}}]	8	1
22	2024-04-12 14:06:35.156718+05:30	130498	HDFC Large and Mid Cap Fund - Growth Option - Direct Plan | mutual_fund | equity	1	[{"added": {}}]	8	1
23	2024-04-12 14:07:19.538082+05:30	118632	Nippon India Large Cap Fund - Direct Plan Growth Plan - Growth Option | mutual_fund | equity	1	[{"added": {}}]	8	1
24	2024-04-12 14:07:53.196887+05:30	120586	ICICI Prudential Bluechip Fund - Direct Plan - Growth | mutual_fund | equity	1	[{"added": {}}]	8	1
25	2024-04-12 14:10:11.167323+05:30	130050	Nippon India Strategic Debt Fund - Direct Plan - Growth Option | mutual_fund | debt	1	[{"added": {}}]	8	1
26	2024-04-12 14:11:06.294213+05:30	119382	BANK OF INDIA Short Term Income Fund-Direct Plan- Growth | mutual_fund | debt	1	[{"added": {}}]	8	1
27	2024-04-12 14:11:50.956823+05:30	119539	Aditya Birla Sun Life Medium Term Plan - Growth - Direct Plan | mutual_fund | debt	1	[{"added": {}}]	8	1
28	2024-04-12 14:12:32.132536+05:30	119798	SBI CREDIT RISK FUND - DIRECT PLAN -GROWTH | mutual_fund | debt	1	[{"added": {}}]	8	1
29	2024-04-12 14:14:04.604176+05:30	119075	HDFC Dynamic Debt Fund - Growth Option - Direct Plan | mutual_fund | debt	1	[{"added": {}}]	8	1
30	2024-04-12 14:15:03.80504+05:30	128006	Kotak Medium Term Fund - Direct Growth | mutual_fund | debt	1	[{"added": {}}]	8	1
31	2024-04-12 14:15:52.717297+05:30	115127	Aditya Birla Sun Life Gold ETF | etf | gold	1	[{"added": {}}]	8	1
32	2024-04-12 14:16:29.087649+05:30	113434	Axis Gold ETF | etf | gold	1	[{"added": {}}]	8	1
33	2024-04-12 14:17:02.54737+05:30	113076	ICICI Prudential Gold ETF | etf | gold	1	[{"added": {}}]	8	1
34	2024-04-12 14:17:36.265685+05:30	150714	UTI Gold ETF Fund of Fund - Direct Plan - Growth Option | etf | gold	1	[{"added": {}}]	8	1
35	2024-04-12 14:18:05.119747+05:30	107693	Quantum Gold Fund | etf | gold	1	[{"added": {}}]	8	1
36	2024-04-12 14:18:41.20573+05:30	111954	SBI Gold ETF | etf | debt	1	[{"added": {}}]	8	1
37	2024-04-12 14:18:58.572026+05:30	111954	SBI Gold ETF | etf | gold	2	[{"changed": {"fields": ["Asset type"]}}]	8	1
38	2024-04-26 00:11:01.931043+05:30	8	klsadjfslka	3		4	1
39	2024-04-26 00:24:00.802501+05:30	9	klsadjfslka	3		4	1
40	2024-04-26 00:24:16.507377+05:30	10	klsadjfslka	3		4	1
41	2024-04-26 00:45:17.009948+05:30	11	klsadjfslka	3		4	1
42	2024-04-26 00:49:57.247387+05:30	12	klsadjfslka	3		4	1
43	2024-04-26 01:17:11.603454+05:30	17	kls12ad1jfsl21ka	3		4	1
44	2024-04-26 01:17:11.607454+05:30	16	klsad1jfsl21ka	3		4	1
45	2024-04-26 01:17:11.609453+05:30	15	klsadjfsl21ka	3		4	1
46	2024-04-26 01:17:11.610454+05:30	14	klsadjfsl2ka	3		4	1
47	2024-04-26 01:17:11.612454+05:30	13	klsadjfslka	3		4	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	api	userholdings
8	api	assets
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-04-12 00:19:23.632526+05:30
2	auth	0001_initial	2024-04-12 00:19:24.380985+05:30
3	admin	0001_initial	2024-04-12 00:19:24.512338+05:30
4	admin	0002_logentry_remove_auto_add	2024-04-12 00:19:24.52343+05:30
5	admin	0003_logentry_add_action_flag_choices	2024-04-12 00:19:24.53943+05:30
6	contenttypes	0002_remove_content_type_name	2024-04-12 00:19:24.571488+05:30
7	auth	0002_alter_permission_name_max_length	2024-04-12 00:19:24.589128+05:30
8	auth	0003_alter_user_email_max_length	2024-04-12 00:19:24.606177+05:30
9	auth	0004_alter_user_username_opts	2024-04-12 00:19:24.618173+05:30
10	auth	0005_alter_user_last_login_null	2024-04-12 00:19:24.640302+05:30
11	auth	0006_require_contenttypes_0002	2024-04-12 00:19:24.643342+05:30
12	auth	0007_alter_validators_add_error_messages	2024-04-12 00:19:24.654351+05:30
13	auth	0008_alter_user_username_max_length	2024-04-12 00:19:24.70385+05:30
14	auth	0009_alter_user_last_name_max_length	2024-04-12 00:19:24.726167+05:30
15	auth	0010_alter_group_name_max_length	2024-04-12 00:19:24.743002+05:30
16	auth	0011_update_proxy_permissions	2024-04-12 00:19:24.762997+05:30
17	auth	0012_alter_user_first_name_max_length	2024-04-12 00:19:24.774866+05:30
18	sessions	0001_initial	2024-04-12 00:19:24.937334+05:30
19	api	0001_initial	2024-04-12 00:20:36.121908+05:30
20	api	0002_assets_show_name	2024-04-12 13:26:32.453401+05:30
21	api	0003_rename_name_assets_fetch_name	2024-04-12 13:28:29.920563+05:30
22	api	0004_alter_assets_fetch_name	2024-04-12 13:53:30.126821+05:30
23	api	0005_alter_assets_holding_type	2024-04-12 23:22:56.995238+05:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
m2my6dh2wu5l4nkt7f4ix3opali4oqrq	.eJxVjMEOwiAQRP-FsyELUgSP3vsNhGVZqRpISnsy_rtt0oPeJvPezFuEuC4lrD3PYSJxFUqcfjuM6ZnrDugR673J1OoyTyh3RR60y7FRft0O9--gxF62NURPRKDZbIEdWHaDdfYCKeqktM0ZjTes0bjsGFgNCGfUzrIi9grF5wvxpDg3:1ruzb6:8zORkfaQKX-XuaM0gNlLlaIRtBjJWPUCrgn5-dXltcs	2024-04-26 00:26:32.591729+05:30
n58q3mvlmdpnqcfpsgzb8evdjxgdkuq0	.eJxVjMEOwiAQRP-FsyELUgSP3vsNhGVZqRpISnsy_rtt0oPeJvPezFuEuC4lrD3PYSJxFUqcfjuM6ZnrDugR673J1OoyTyh3RR60y7FRft0O9--gxF62NURPRKDZbIEdWHaDdfYCKeqktM0ZjTes0bjsGFgNCGfUzrIi9grF5wvxpDg3:1rvBn4:C6sCzMLHF7ygM_3hyUjzYt3J1gLCNyvWAg87Zb6UfZg	2024-04-26 13:27:42.760904+05:30
njzyt49ts0r1a5ar6wyw70m9aovsgi51	.eJxVjMEOwiAQRP-FsyELUgSP3vsNhGVZqRpISnsy_rtt0oPeJvPezFuEuC4lrD3PYSJxFUqcfjuM6ZnrDugR673J1OoyTyh3RR60y7FRft0O9--gxF62NURPRKDZbIEdWHaDdfYCKeqktM0ZjTes0bjsGFgNCGfUzrIi9grF5wvxpDg3:1rvBqr:YZbQoif7WYzRufSamx1QCRBi_x_m-fFigLJPlcZjpEY	2024-04-26 13:31:37.717495+05:30
7l6xno8wzd1m37g9cqmj0erju7z0j55q	.eJxVjMEOwiAQRP-FsyELUgSP3vsNhGVZqRpISnsy_rtt0oPeJvPezFuEuC4lrD3PYSJxFUqcfjuM6ZnrDugR673J1OoyTyh3RR60y7FRft0O9--gxF62NURPRKDZbIEdWHaDdfYCKeqktM0ZjTes0bjsGFgNCGfUzrIi9grF5wvxpDg3:1s040v:FlXcE0d9p9iV2UP4L_xApQCRrMmjEQJleq59QtJS8HM	2024-05-10 00:10:09.794737+05:30
grw80f5h8umt1aio6nk760na1ro19jt1	.eJxVjMEOwiAQRP-FsyELUgSP3vsNhGVZqRpISnsy_rtt0oPeJvPezFuEuC4lrD3PYSJxFUqcfjuM6ZnrDugR673J1OoyTyh3RR60y7FRft0O9--gxF62NURPRKDZbIEdWHaDdfYCKeqktM0ZjTes0bjsGFgNCGfUzrIi9grF5wvxpDg3:1s272N:hr80Mf7nG9FjXKj1Zi_apHFesC_wXcc5vGfhteNgoN4	2024-05-15 15:48:07.258672+05:30
\.


--
-- Name: api_userholdings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_userholdings_id_seq', 70, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 32, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 19, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 47, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 8, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);


--
-- Name: api_assets api_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_assets
    ADD CONSTRAINT api_assets_pkey PRIMARY KEY (id);


--
-- Name: api_userholdings api_userholdings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_userholdings
    ADD CONSTRAINT api_userholdings_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: api_userholdings_asset_id_16516de2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_userholdings_asset_id_16516de2 ON public.api_userholdings USING btree (asset_id);


--
-- Name: api_userholdings_user_id_d428b3c2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_userholdings_user_id_d428b3c2 ON public.api_userholdings USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: api_userholdings api_userholdings_asset_id_16516de2_fk_api_assets_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_userholdings
    ADD CONSTRAINT api_userholdings_asset_id_16516de2_fk_api_assets_id FOREIGN KEY (asset_id) REFERENCES public.api_assets(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_userholdings api_userholdings_user_id_d428b3c2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_userholdings
    ADD CONSTRAINT api_userholdings_user_id_d428b3c2_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--
