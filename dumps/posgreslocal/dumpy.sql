--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 10.0

-- Started on 2017-10-22 16:36:07

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'WIN1252';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE "DBCourse";
--
-- TOC entry 2244 (class 1262 OID 16457)
-- Name: DBCourse; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "DBCourse" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


ALTER DATABASE "DBCourse" OWNER TO postgres;

\connect "DBCourse"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'WIN1252';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2247 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 25760)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE customer (
    "customerId" integer NOT NULL,
    address text NOT NULL
);


ALTER TABLE customer OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 25758)
-- Name: customer_customerId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "customer_customerId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "customer_customerId_seq" OWNER TO postgres;

--
-- TOC entry 2248 (class 0 OID 0)
-- Dependencies: 185
-- Name: customer_customerId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "customer_customerId_seq" OWNED BY customer."customerId";


--
-- TOC entry 199 (class 1259 OID 25847)
-- Name: customer_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE customer_history (
    id integer NOT NULL,
    customer integer NOT NULL,
    product integer NOT NULL
);


ALTER TABLE customer_history OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 25845)
-- Name: customer_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE customer_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customer_history_id_seq OWNER TO postgres;

--
-- TOC entry 2249 (class 0 OID 0)
-- Dependencies: 198
-- Name: customer_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE customer_history_id_seq OWNED BY customer_history.id;


--
-- TOC entry 203 (class 1259 OID 25885)
-- Name: orderitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE orderitems (
    id integer NOT NULL,
    quantity smallint NOT NULL,
    "productId" integer NOT NULL,
    "saleId" integer NOT NULL
);


ALTER TABLE orderitems OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 25883)
-- Name: orderitems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE orderitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orderitems_id_seq OWNER TO postgres;

--
-- TOC entry 2250 (class 0 OID 0)
-- Dependencies: 202
-- Name: orderitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orderitems_id_seq OWNED BY orderitems.id;


--
-- TOC entry 193 (class 1259 OID 25802)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE product (
    price numeric NOT NULL,
    full_name character varying(50) NOT NULL,
    description text NOT NULL,
    "productId" integer NOT NULL
);


ALTER TABLE product OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 25800)
-- Name: product_productId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "product_productId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "product_productId_seq" OWNER TO postgres;

--
-- TOC entry 2251 (class 0 OID 0)
-- Dependencies: 192
-- Name: product_productId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "product_productId_seq" OWNED BY product."productId";


--
-- TOC entry 195 (class 1259 OID 25813)
-- Name: sale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sale (
    "saleId" integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    "customerId" integer NOT NULL,
    order_status character varying(2) NOT NULL
);


ALTER TABLE sale OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 25811)
-- Name: sale_saleId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "sale_saleId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "sale_saleId_seq" OWNER TO postgres;

--
-- TOC entry 2252 (class 0 OID 0)
-- Dependencies: 194
-- Name: sale_saleId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "sale_saleId_seq" OWNED BY sale."saleId";


--
-- TOC entry 197 (class 1259 OID 25827)
-- Name: stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE stock (
    id integer NOT NULL,
    quantity smallint NOT NULL,
    "productId" integer NOT NULL,
    "warehouseId" integer NOT NULL
);


ALTER TABLE stock OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 25825)
-- Name: stock_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock_id_seq OWNER TO postgres;

--
-- TOC entry 2253 (class 0 OID 0)
-- Dependencies: 196
-- Name: stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE stock_id_seq OWNED BY stock.id;


--
-- TOC entry 191 (class 1259 OID 25788)
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE supplier (
    name character varying(20) NOT NULL,
    contact_details integer
);


ALTER TABLE supplier OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 25782)
-- Name: supplier_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE supplier_contact (
    id integer NOT NULL,
    phone_no character varying(12) NOT NULL,
    address character varying(50) NOT NULL,
    email character varying(25) NOT NULL
);


ALTER TABLE supplier_contact OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 25780)
-- Name: supplier_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE supplier_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supplier_contact_id_seq OWNER TO postgres;

--
-- TOC entry 2254 (class 0 OID 0)
-- Dependencies: 189
-- Name: supplier_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE supplier_contact_id_seq OWNED BY supplier_contact.id;


--
-- TOC entry 201 (class 1259 OID 25865)
-- Name: supplierstock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE supplierstock (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    "supplierId" character varying(20) NOT NULL,
    quantity smallint NOT NULL
);


ALTER TABLE supplierstock OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 25863)
-- Name: supplierstock_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE supplierstock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supplierstock_id_seq OWNER TO postgres;

--
-- TOC entry 2255 (class 0 OID 0)
-- Dependencies: 200
-- Name: supplierstock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE supplierstock_id_seq OWNED BY supplierstock.id;


--
-- TOC entry 188 (class 1259 OID 25771)
-- Name: warehouse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE warehouse (
    address text NOT NULL,
    "warehouseId" integer NOT NULL
);


ALTER TABLE warehouse OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 25769)
-- Name: warehouse_warehouseId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "warehouse_warehouseId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "warehouse_warehouseId_seq" OWNER TO postgres;

--
-- TOC entry 2256 (class 0 OID 0)
-- Dependencies: 187
-- Name: warehouse_warehouseId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "warehouse_warehouseId_seq" OWNED BY warehouse."warehouseId";


--
-- TOC entry 2056 (class 2604 OID 25763)
-- Name: customer customerId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer ALTER COLUMN "customerId" SET DEFAULT nextval('"customer_customerId_seq"'::regclass);


--
-- TOC entry 2062 (class 2604 OID 25850)
-- Name: customer_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer_history ALTER COLUMN id SET DEFAULT nextval('customer_history_id_seq'::regclass);


--
-- TOC entry 2064 (class 2604 OID 25888)
-- Name: orderitems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orderitems ALTER COLUMN id SET DEFAULT nextval('orderitems_id_seq'::regclass);


--
-- TOC entry 2059 (class 2604 OID 25805)
-- Name: product productId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product ALTER COLUMN "productId" SET DEFAULT nextval('"product_productId_seq"'::regclass);


--
-- TOC entry 2060 (class 2604 OID 25816)
-- Name: sale saleId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sale ALTER COLUMN "saleId" SET DEFAULT nextval('"sale_saleId_seq"'::regclass);


--
-- TOC entry 2061 (class 2604 OID 25830)
-- Name: stock id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock ALTER COLUMN id SET DEFAULT nextval('stock_id_seq'::regclass);


--
-- TOC entry 2058 (class 2604 OID 25785)
-- Name: supplier_contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplier_contact ALTER COLUMN id SET DEFAULT nextval('supplier_contact_id_seq'::regclass);


--
-- TOC entry 2063 (class 2604 OID 25868)
-- Name: supplierstock id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplierstock ALTER COLUMN id SET DEFAULT nextval('supplierstock_id_seq'::regclass);


--
-- TOC entry 2057 (class 2604 OID 25774)
-- Name: warehouse warehouseId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY warehouse ALTER COLUMN "warehouseId" SET DEFAULT nextval('"warehouse_warehouseId_seq"'::regclass);


--
-- TOC entry 2222 (class 0 OID 25760)
-- Dependencies: 186
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2235 (class 0 OID 25847)
-- Dependencies: 199
-- Data for Name: customer_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2239 (class 0 OID 25885)
-- Dependencies: 203
-- Data for Name: orderitems; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2229 (class 0 OID 25802)
-- Dependencies: 193
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2231 (class 0 OID 25813)
-- Dependencies: 195
-- Data for Name: sale; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2233 (class 0 OID 25827)
-- Dependencies: 197
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2227 (class 0 OID 25788)
-- Dependencies: 191
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2226 (class 0 OID 25782)
-- Dependencies: 190
-- Data for Name: supplier_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2237 (class 0 OID 25865)
-- Dependencies: 201
-- Data for Name: supplierstock; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2224 (class 0 OID 25771)
-- Dependencies: 188
-- Data for Name: warehouse; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2257 (class 0 OID 0)
-- Dependencies: 185
-- Name: customer_customerId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"customer_customerId_seq"', 1, false);


--
-- TOC entry 2258 (class 0 OID 0)
-- Dependencies: 198
-- Name: customer_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('customer_history_id_seq', 1, false);


--
-- TOC entry 2259 (class 0 OID 0)
-- Dependencies: 202
-- Name: orderitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orderitems_id_seq', 1, false);


--
-- TOC entry 2260 (class 0 OID 0)
-- Dependencies: 192
-- Name: product_productId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"product_productId_seq"', 1, false);


--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 194
-- Name: sale_saleId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"sale_saleId_seq"', 1, false);


--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 196
-- Name: stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('stock_id_seq', 1, false);


--
-- TOC entry 2263 (class 0 OID 0)
-- Dependencies: 189
-- Name: supplier_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('supplier_contact_id_seq', 1, false);


--
-- TOC entry 2264 (class 0 OID 0)
-- Dependencies: 200
-- Name: supplierstock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('supplierstock_id_seq', 1, false);


--
-- TOC entry 2265 (class 0 OID 0)
-- Dependencies: 187
-- Name: warehouse_warehouseId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"warehouse_warehouseId_seq"', 1, false);


--
-- TOC entry 2085 (class 2606 OID 25852)
-- Name: customer_history customer_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer_history
    ADD CONSTRAINT customer_history_pkey PRIMARY KEY (id);


--
-- TOC entry 2066 (class 2606 OID 25768)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY ("customerId");


--
-- TOC entry 2091 (class 2606 OID 25890)
-- Name: orderitems orderitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orderitems
    ADD CONSTRAINT orderitems_pkey PRIMARY KEY (id);


--
-- TOC entry 2076 (class 2606 OID 25810)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY ("productId");


--
-- TOC entry 2079 (class 2606 OID 25818)
-- Name: sale sale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sale
    ADD CONSTRAINT sale_pkey PRIMARY KEY ("saleId");


--
-- TOC entry 2081 (class 2606 OID 25832)
-- Name: stock stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (id);


--
-- TOC entry 2072 (class 2606 OID 25794)
-- Name: supplier supplier_contact_details_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplier
    ADD CONSTRAINT supplier_contact_details_key UNIQUE (contact_details);


--
-- TOC entry 2070 (class 2606 OID 25787)
-- Name: supplier_contact supplier_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplier_contact
    ADD CONSTRAINT supplier_contact_pkey PRIMARY KEY (id);


--
-- TOC entry 2074 (class 2606 OID 25792)
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (name);


--
-- TOC entry 2087 (class 2606 OID 25870)
-- Name: supplierstock supplierstock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplierstock
    ADD CONSTRAINT supplierstock_pkey PRIMARY KEY (id);


--
-- TOC entry 2068 (class 2606 OID 25779)
-- Name: warehouse warehouse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY warehouse
    ADD CONSTRAINT warehouse_pkey PRIMARY KEY ("warehouseId");


--
-- TOC entry 2092 (class 1259 OID 25901)
-- Name: orderitems_productId_7d63fa31; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "orderitems_productId_7d63fa31" ON orderitems USING btree ("productId");


--
-- TOC entry 2093 (class 1259 OID 25902)
-- Name: orderitems_saleId_4f87df46; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "orderitems_saleId_4f87df46" ON orderitems USING btree ("saleId");


--
-- TOC entry 2077 (class 1259 OID 25824)
-- Name: sale_customerId_5c2179ea; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "sale_customerId_5c2179ea" ON sale USING btree ("customerId");


--
-- TOC entry 2082 (class 1259 OID 25843)
-- Name: stock_productId_82bd601e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "stock_productId_82bd601e" ON stock USING btree ("productId");


--
-- TOC entry 2083 (class 1259 OID 25844)
-- Name: stock_warehouseId_78bc11e5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "stock_warehouseId_78bc11e5" ON stock USING btree ("warehouseId");


--
-- TOC entry 2088 (class 1259 OID 25881)
-- Name: supplierstock_productId_dbae474f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "supplierstock_productId_dbae474f" ON supplierstock USING btree ("productId");


--
-- TOC entry 2089 (class 1259 OID 25882)
-- Name: supplierstock_supplierId_be5e875f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "supplierstock_supplierId_be5e875f" ON supplierstock USING btree ("supplierId");


--
-- TOC entry 2098 (class 2606 OID 25853)
-- Name: customer_history customer_history_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer_history
    ADD CONSTRAINT customer_history_customer_fkey FOREIGN KEY (customer) REFERENCES customer("customerId");


--
-- TOC entry 2099 (class 2606 OID 25858)
-- Name: customer_history customer_history_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customer_history
    ADD CONSTRAINT customer_history_product_fkey FOREIGN KEY (product) REFERENCES product("productId");


--
-- TOC entry 2102 (class 2606 OID 25891)
-- Name: orderitems orderitems_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orderitems
    ADD CONSTRAINT "orderitems_productId_fkey" FOREIGN KEY ("productId") REFERENCES product("productId");


--
-- TOC entry 2103 (class 2606 OID 25896)
-- Name: orderitems orderitems_saleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orderitems
    ADD CONSTRAINT "orderitems_saleId_fkey" FOREIGN KEY ("saleId") REFERENCES sale("saleId");


--
-- TOC entry 2095 (class 2606 OID 25819)
-- Name: sale sale_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sale
    ADD CONSTRAINT "sale_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES customer("customerId");


--
-- TOC entry 2096 (class 2606 OID 25833)
-- Name: stock stock_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock
    ADD CONSTRAINT "stock_productId_fkey" FOREIGN KEY ("productId") REFERENCES product("productId");


--
-- TOC entry 2097 (class 2606 OID 25838)
-- Name: stock stock_warehouseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stock
    ADD CONSTRAINT "stock_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES warehouse("warehouseId");


--
-- TOC entry 2094 (class 2606 OID 25795)
-- Name: supplier supplier_contact_details_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplier
    ADD CONSTRAINT supplier_contact_details_fkey FOREIGN KEY (contact_details) REFERENCES supplier_contact(id);


--
-- TOC entry 2100 (class 2606 OID 25871)
-- Name: supplierstock supplierstock_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplierstock
    ADD CONSTRAINT "supplierstock_productId_fkey" FOREIGN KEY ("productId") REFERENCES product("productId");


--
-- TOC entry 2101 (class 2606 OID 25876)
-- Name: supplierstock supplierstock_supplierId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplierstock
    ADD CONSTRAINT "supplierstock_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES supplier(name);


--
-- TOC entry 2246 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-10-22 16:36:08

--
-- PostgreSQL database dump complete
--

