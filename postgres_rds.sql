-- User: artesianproject
-- DROP USER artesianproject;

CREATE USER artesianproject WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION
  VALID UNTIL 'infinity';

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.3

-- Started on 2018-11-15 20:01:53

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 16465)
-- Name: sensors; Type: SCHEMA; Schema: -; Owner: artesianproject
--

CREATE SCHEMA sensors;


ALTER SCHEMA sensors OWNER TO artesianproject;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 16466)
-- Name: clustereddata; Type: TABLE; Schema: sensors; Owner: artesianproject
--

CREATE TABLE sensors.clustereddata (
    id bigint NOT NULL,
    clusterid integer NOT NULL,
    sensorid integer NOT NULL,
    data numeric(10,2) NOT NULL
);


ALTER TABLE sensors.clustereddata OWNER TO artesianproject;

--
-- TOC entry 198 (class 1259 OID 16469)
-- Name: clustereddata_id_seq; Type: SEQUENCE; Schema: sensors; Owner: artesianproject
--

CREATE SEQUENCE sensors.clustereddata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sensors.clustereddata_id_seq OWNER TO artesianproject;

--
-- TOC entry 3827 (class 0 OID 0)
-- Dependencies: 198
-- Name: clustereddata_id_seq; Type: SEQUENCE OWNED BY; Schema: sensors; Owner: artesianproject
--

ALTER SEQUENCE sensors.clustereddata_id_seq OWNED BY sensors.clustereddata.id;


--
-- TOC entry 199 (class 1259 OID 16471)
-- Name: clusters; Type: TABLE; Schema: sensors; Owner: artesianproject
--

CREATE TABLE sensors.clusters (
    clusterid bigint NOT NULL,
    mean numeric(10,2) NOT NULL,
    deviation numeric(10,2) NOT NULL
);


ALTER TABLE sensors.clusters OWNER TO artesianproject;

--
-- TOC entry 3828 (class 0 OID 0)
-- Dependencies: 199
-- Name: TABLE clusters; Type: COMMENT; Schema: sensors; Owner: artesianproject
--

COMMENT ON TABLE sensors.clusters IS 'Clusters of means and deviations';


--
-- TOC entry 200 (class 1259 OID 16474)
-- Name: clusters_clusterid_seq; Type: SEQUENCE; Schema: sensors; Owner: artesianproject
--

CREATE SEQUENCE sensors.clusters_clusterid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sensors.clusters_clusterid_seq OWNER TO artesianproject;

--
-- TOC entry 3829 (class 0 OID 0)
-- Dependencies: 200
-- Name: clusters_clusterid_seq; Type: SEQUENCE OWNED BY; Schema: sensors; Owner: artesianproject
--

ALTER SEQUENCE sensors.clusters_clusterid_seq OWNED BY sensors.clusters.clusterid;


--
-- TOC entry 201 (class 1259 OID 16476)
-- Name: sensors; Type: TABLE; Schema: sensors; Owner: artesianproject
--

CREATE TABLE sensors.sensors (
    sensorid integer NOT NULL,
    name character(20) NOT NULL
);


ALTER TABLE sensors.sensors OWNER TO artesianproject;

--
-- TOC entry 202 (class 1259 OID 16479)
-- Name: sensors_sensorid_seq; Type: SEQUENCE; Schema: sensors; Owner: artesianproject
--

CREATE SEQUENCE sensors.sensors_sensorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sensors.sensors_sensorid_seq OWNER TO artesianproject;

--
-- TOC entry 3830 (class 0 OID 0)
-- Dependencies: 202
-- Name: sensors_sensorid_seq; Type: SEQUENCE OWNED BY; Schema: sensors; Owner: artesianproject
--

ALTER SEQUENCE sensors.sensors_sensorid_seq OWNED BY sensors.sensors.sensorid;


--
-- TOC entry 3678 (class 2604 OID 16481)
-- Name: clustereddata id; Type: DEFAULT; Schema: sensors; Owner: artesianproject
--

ALTER TABLE ONLY sensors.clustereddata ALTER COLUMN id SET DEFAULT nextval('sensors.clustereddata_id_seq'::regclass);


--
-- TOC entry 3679 (class 2604 OID 16482)
-- Name: clusters clusterid; Type: DEFAULT; Schema: sensors; Owner: artesianproject
--

ALTER TABLE ONLY sensors.clusters ALTER COLUMN clusterid SET DEFAULT nextval('sensors.clusters_clusterid_seq'::regclass);


--
-- TOC entry 3680 (class 2604 OID 16483)
-- Name: sensors sensorid; Type: DEFAULT; Schema: sensors; Owner: artesianproject
--

ALTER TABLE ONLY sensors.sensors ALTER COLUMN sensorid SET DEFAULT nextval('sensors.sensors_sensorid_seq'::regclass);



--
-- TOC entry 3831 (class 0 OID 0)
-- Dependencies: 198
-- Name: clustereddata_id_seq; Type: SEQUENCE SET; Schema: sensors; Owner: artesianproject
--

SELECT pg_catalog.setval('sensors.clustereddata_id_seq', 1085, true);


--
-- TOC entry 3832 (class 0 OID 0)
-- Dependencies: 200
-- Name: clusters_clusterid_seq; Type: SEQUENCE SET; Schema: sensors; Owner: artesianproject
--

SELECT pg_catalog.setval('sensors.clusters_clusterid_seq', 14, true);


--
-- TOC entry 3833 (class 0 OID 0)
-- Dependencies: 202
-- Name: sensors_sensorid_seq; Type: SEQUENCE SET; Schema: sensors; Owner: artesianproject
--

SELECT pg_catalog.setval('sensors.sensors_sensorid_seq', 2, true);


--
-- TOC entry 3682 (class 2606 OID 16485)
-- Name: clustereddata clustereddata_pkey; Type: CONSTRAINT; Schema: sensors; Owner: artesianproject
--

ALTER TABLE ONLY sensors.clustereddata
    ADD CONSTRAINT clustereddata_pkey PRIMARY KEY (id);


--
-- TOC entry 3687 (class 2606 OID 16489)
-- Name: clusters clusters_pkey; Type: CONSTRAINT; Schema: sensors; Owner: artesianproject
--

ALTER TABLE ONLY sensors.clusters
    ADD CONSTRAINT clusters_pkey PRIMARY KEY (clusterid);


--
-- TOC entry 3692 (class 2606 OID 16491)
-- Name: sensors sensors_pkey; Type: CONSTRAINT; Schema: sensors; Owner: artesianproject
--

ALTER TABLE ONLY sensors.sensors
    ADD CONSTRAINT sensors_pkey PRIMARY KEY (sensorid);


--
-- TOC entry 3683 (class 1259 OID 16492)
-- Name: fki_clusterid; Type: INDEX; Schema: sensors; Owner: artesianproject
--

CREATE INDEX fki_clusterid ON sensors.clustereddata USING btree (clusterid);


--
-- TOC entry 3684 (class 1259 OID 16493)
-- Name: fki_sensorid; Type: INDEX; Schema: sensors; Owner: artesianproject
--

CREATE INDEX fki_sensorid ON sensors.clustereddata USING btree (sensorid);

ALTER TABLE sensors.clustereddata CLUSTER ON fki_sensorid;


--
-- TOC entry 3685 (class 1259 OID 16494)
-- Name: idx_data; Type: INDEX; Schema: sensors; Owner: artesianproject
--

CREATE INDEX idx_data ON sensors.clustereddata USING btree (data);


--
-- TOC entry 3688 (class 1259 OID 16495)
-- Name: idx_deviation; Type: INDEX; Schema: sensors; Owner: artesianproject
--

CREATE INDEX idx_deviation ON sensors.clusters USING btree (deviation);


--
-- TOC entry 3689 (class 1259 OID 16496)
-- Name: idx_mean; Type: INDEX; Schema: sensors; Owner: artesianproject
--

CREATE INDEX idx_mean ON sensors.clusters USING btree (mean);


--
-- TOC entry 3690 (class 1259 OID 16497)
-- Name: idx_name; Type: INDEX; Schema: sensors; Owner: artesianproject
--

CREATE INDEX idx_name ON sensors.sensors USING btree (name);


--
-- TOC entry 3693 (class 2606 OID 16498)
-- Name: clustereddata clustereddata_clusterid_fkey; Type: FK CONSTRAINT; Schema: sensors; Owner: artesianproject
--

ALTER TABLE ONLY sensors.clustereddata
    ADD CONSTRAINT clustereddata_clusterid_fkey FOREIGN KEY (clusterid) REFERENCES sensors.clusters(clusterid) ON UPDATE CASCADE;


--
-- TOC entry 3694 (class 2606 OID 16503)
-- Name: clustereddata clustereddata_sensorid_fkey; Type: FK CONSTRAINT; Schema: sensors; Owner: artesianproject
--

ALTER TABLE ONLY sensors.clustereddata
    ADD CONSTRAINT clustereddata_sensorid_fkey FOREIGN KEY (sensorid) REFERENCES sensors.sensors(sensorid) ON UPDATE CASCADE;


-- Completed on 2018-11-15 20:01:58

--
-- PostgreSQL database dump complete
--


