--
-- PostgreSQL database cluster dump
--

-- Started on 2025-01-08 08:52:18

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2025-01-08 08:52:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2025-01-08 08:52:20

--
-- PostgreSQL database dump complete
--

--
-- Database "consecutivo" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2025-01-08 08:52:20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4756 (class 1262 OID 16591)
-- Name: consecutivo; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE consecutivo WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';


ALTER DATABASE consecutivo OWNER TO postgres;

\connect consecutivo

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2025-01-08 08:52:22

--
-- PostgreSQL database dump complete
--

--
-- Database "consecutivos" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2025-01-08 08:52:22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4756 (class 1262 OID 16574)
-- Name: consecutivos; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE consecutivos WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';


ALTER DATABASE consecutivos OWNER TO postgres;

\connect consecutivos

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2025-01-08 08:52:22

--
-- PostgreSQL database dump complete
--

--
-- Database "local_consecutivos" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2025-01-08 08:52:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4837 (class 1262 OID 16387)
-- Name: local_consecutivos; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE local_consecutivos WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';


ALTER DATABASE local_consecutivos OWNER TO postgres;

\connect local_consecutivos

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16388)
-- Name: consecutivo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA consecutivo;


ALTER SCHEMA consecutivo OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16389)
-- Name: f_trg_hist_consecutivo(); Type: FUNCTION; Schema: consecutivo; Owner: postgres
--

CREATE FUNCTION consecutivo.f_trg_hist_consecutivo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare v_fecha_generacion timestamp;
	declare v_hash_key numeric(10,0);
	declare v_consecutivo bigint;
begin
	v_fecha_generacion := current_timestamp;  
	v_hash_key := ceiling(random()*1000000000);	

	insert into consecutivo.gestion_consecutivo(hash_key,fecha_genera_consecutivo) 
	values (v_hash_key, v_fecha_generacion);

	select consecutivo into v_consecutivo
	from consecutivo.gestion_consecutivo
	where hash_key = v_hash_key and fecha_genera_consecutivo = v_fecha_generacion;

	update consecutivo.historia_consecutivo
	set consecutivo=v_consecutivo
	where consecutivo_id = new.consecutivo_id;

	return new;
end;
$$;


ALTER FUNCTION consecutivo.f_trg_hist_consecutivo() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: gestion_consecutivo; Type: TABLE; Schema: consecutivo; Owner: postgres
--

CREATE TABLE consecutivo.gestion_consecutivo (
    consecutivo bigint NOT NULL,
    hash_key integer,
    fecha_genera_consecutivo timestamp without time zone
);


ALTER TABLE consecutivo.gestion_consecutivo OWNER TO postgres;

--
-- TOC entry 4838 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN gestion_consecutivo.consecutivo; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.gestion_consecutivo.consecutivo IS 'Consecutivo generado asociado al hash aleatorio';


--
-- TOC entry 4839 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN gestion_consecutivo.hash_key; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.gestion_consecutivo.hash_key IS 'identificador del último evento de generación de consecutivo.';


--
-- TOC entry 219 (class 1259 OID 16393)
-- Name: gestion_consecutivo_consecutivo_seq; Type: SEQUENCE; Schema: consecutivo; Owner: postgres
--

CREATE SEQUENCE consecutivo.gestion_consecutivo_consecutivo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivo.gestion_consecutivo_consecutivo_seq OWNER TO postgres;

--
-- TOC entry 4840 (class 0 OID 0)
-- Dependencies: 219
-- Name: gestion_consecutivo_consecutivo_seq; Type: SEQUENCE OWNED BY; Schema: consecutivo; Owner: postgres
--

ALTER SEQUENCE consecutivo.gestion_consecutivo_consecutivo_seq OWNED BY consecutivo.gestion_consecutivo.consecutivo;


--
-- TOC entry 220 (class 1259 OID 16394)
-- Name: historia_consecutivo; Type: TABLE; Schema: consecutivo; Owner: postgres
--

CREATE TABLE consecutivo.historia_consecutivo (
    consecutivo_id bigint NOT NULL,
    consecutivo bigint,
    usuario_id bigint NOT NULL,
    prefijo_id bigint NOT NULL,
    descripcion character varying(512) NOT NULL,
    fecha_generacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    num_consecutivo integer
);


ALTER TABLE consecutivo.historia_consecutivo OWNER TO postgres;

--
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE historia_consecutivo; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON TABLE consecutivo.historia_consecutivo IS 'almacena cada uno de los consecutivos que los usuarios han solicitado a la aplicación asociado a un prefijo específico. Estos consecutivos numeran especificamente documentos que genera la Cooperativa a nivel de correspondencia.';


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN historia_consecutivo.consecutivo_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.historia_consecutivo.consecutivo_id IS 'identificador único del consecutivo';


--
-- TOC entry 4843 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN historia_consecutivo.consecutivo; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.historia_consecutivo.consecutivo IS 'Número consecutivo generado por el sistema para un usuario y un prefijo en una fecha específica';


--
-- TOC entry 4844 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN historia_consecutivo.usuario_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.historia_consecutivo.usuario_id IS 'usuario que solicita la creación del consecutivo';


--
-- TOC entry 4845 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN historia_consecutivo.prefijo_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.historia_consecutivo.prefijo_id IS 'identificador del prefijo seleccionado por el usuario al momento de generar un consecutivo';


--
-- TOC entry 4846 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN historia_consecutivo.descripcion; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.historia_consecutivo.descripcion IS 'Breve descripción de la razón de generación del consecutivo. La digita el usuario que lo está solicitando. Debe estar en mayúscula siempre';


--
-- TOC entry 4847 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN historia_consecutivo.fecha_generacion; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.historia_consecutivo.fecha_generacion IS 'Fecha en la que se genera el consecutivo solicitado por el usuario';


--
-- TOC entry 221 (class 1259 OID 16400)
-- Name: historia_consecutivo_consecutivo_id_seq; Type: SEQUENCE; Schema: consecutivo; Owner: postgres
--

CREATE SEQUENCE consecutivo.historia_consecutivo_consecutivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivo.historia_consecutivo_consecutivo_id_seq OWNER TO postgres;

--
-- TOC entry 4848 (class 0 OID 0)
-- Dependencies: 221
-- Name: historia_consecutivo_consecutivo_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivo; Owner: postgres
--

ALTER SEQUENCE consecutivo.historia_consecutivo_consecutivo_id_seq OWNED BY consecutivo.historia_consecutivo.consecutivo_id;


--
-- TOC entry 222 (class 1259 OID 16401)
-- Name: opcion_por_perfil; Type: TABLE; Schema: consecutivo; Owner: postgres
--

CREATE TABLE consecutivo.opcion_por_perfil (
    opcion_id bigint NOT NULL,
    perfil_id bigint NOT NULL,
    descripcion character varying(512),
    descripcion_corta character varying(30),
    activa bit(1)
);


ALTER TABLE consecutivo.opcion_por_perfil OWNER TO postgres;

--
-- TOC entry 4849 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE opcion_por_perfil; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON TABLE consecutivo.opcion_por_perfil IS 'Opciones de cada uno de los perfiles. Una opción es una tarea relacionada a un perfil y que los usuarios inscritos a un perfil pueden ejecutar. Usualmente las opciones de un perfil están atadas a la implementación de un menú de opciones en la herramienta';


--
-- TOC entry 4850 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN opcion_por_perfil.opcion_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.opcion_por_perfil.opcion_id IS 'Identificador único de una opción';


--
-- TOC entry 4851 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN opcion_por_perfil.perfil_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.opcion_por_perfil.perfil_id IS 'Identificador único de un perfil en la aplicación';


--
-- TOC entry 4852 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN opcion_por_perfil.descripcion; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.opcion_por_perfil.descripcion IS 'Descripción de la tarea que indica la acción de la opción. Esta descripción puede hacerse visible como una ayuda cuando un usuario se encuentre en la selección de la opción en el menú.';


--
-- TOC entry 4853 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN opcion_por_perfil.descripcion_corta; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.opcion_por_perfil.descripcion_corta IS 'Descripción que usualmente es la que debe aparecer visualmente en un menú.';


--
-- TOC entry 4854 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN opcion_por_perfil.activa; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.opcion_por_perfil.activa IS 'Indica si la opción está activa.\n\nActiva = 1\nInactiva =0';


--
-- TOC entry 223 (class 1259 OID 16406)
-- Name: opcion_por_perfil_opcion_id_seq; Type: SEQUENCE; Schema: consecutivo; Owner: postgres
--

CREATE SEQUENCE consecutivo.opcion_por_perfil_opcion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivo.opcion_por_perfil_opcion_id_seq OWNER TO postgres;

--
-- TOC entry 4855 (class 0 OID 0)
-- Dependencies: 223
-- Name: opcion_por_perfil_opcion_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivo; Owner: postgres
--

ALTER SEQUENCE consecutivo.opcion_por_perfil_opcion_id_seq OWNED BY consecutivo.opcion_por_perfil.opcion_id;


--
-- TOC entry 224 (class 1259 OID 16407)
-- Name: opcion_por_perfil_perfil_id_seq; Type: SEQUENCE; Schema: consecutivo; Owner: postgres
--

CREATE SEQUENCE consecutivo.opcion_por_perfil_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivo.opcion_por_perfil_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 224
-- Name: opcion_por_perfil_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivo; Owner: postgres
--

ALTER SEQUENCE consecutivo.opcion_por_perfil_perfil_id_seq OWNED BY consecutivo.opcion_por_perfil.perfil_id;


--
-- TOC entry 225 (class 1259 OID 16408)
-- Name: perfil; Type: TABLE; Schema: consecutivo; Owner: postgres
--

CREATE TABLE consecutivo.perfil (
    perfil_id bigint NOT NULL,
    perfil character varying(20),
    activo bit(1),
    perfil_defecto bit(1)
);


ALTER TABLE consecutivo.perfil OWNER TO postgres;

--
-- TOC entry 4857 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE perfil; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON TABLE consecutivo.perfil IS 'Listado de perfiles que tiene la aplicación';


--
-- TOC entry 4858 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN perfil.perfil_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.perfil.perfil_id IS 'Identificador único de un perfil en la aplicación';


--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN perfil.perfil; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.perfil.perfil IS 'Descripcion del perfil. Texto que describe el perfil';


--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN perfil.activo; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.perfil.activo IS 'Indica si un perfil está activo o no lo está,\n\nActivo = 1\nNo Activo = 0';


--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN perfil.perfil_defecto; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.perfil.perfil_defecto IS 'En el modelo existe un único perfil que toma por defecto un usuario cuando es creado en la tabla de usuarios. El perfil por defecto será inicialmente el de generador de consecutivo.\n\nSi el perfil tiene como valor en perfil_defecto = 1  es el perfil por defecto\nSi el perfil tiene como valor en perfil_defecto = 0  NO es el perfil por defecto';


--
-- TOC entry 226 (class 1259 OID 16411)
-- Name: perfil_perfil_id_seq; Type: SEQUENCE; Schema: consecutivo; Owner: postgres
--

CREATE SEQUENCE consecutivo.perfil_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivo.perfil_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 4862 (class 0 OID 0)
-- Dependencies: 226
-- Name: perfil_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivo; Owner: postgres
--

ALTER SEQUENCE consecutivo.perfil_perfil_id_seq OWNED BY consecutivo.perfil.perfil_id;


--
-- TOC entry 227 (class 1259 OID 16412)
-- Name: usuario; Type: TABLE; Schema: consecutivo; Owner: postgres
--

CREATE TABLE consecutivo.usuario (
    usuario_id integer NOT NULL,
    usuario_nombre character varying(128),
    usuario_ldap character varying(64),
    pasword character varying(128)
);


ALTER TABLE consecutivo.usuario OWNER TO postgres;

--
-- TOC entry 4863 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE usuario; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON TABLE consecutivo.usuario IS 'maestra de usuarios que generan consecutivos.';


--
-- TOC entry 4864 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN usuario.usuario_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.usuario.usuario_id IS 'identificador único de un usuario en la aplicación de consecutivo';


--
-- TOC entry 4865 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN usuario.usuario_nombre; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.usuario.usuario_nombre IS 'Nombre del usuario, debe corresponder al mismo que se tiene en el sistema fuente que administra los funcionarios (actualmente linix)';


--
-- TOC entry 4866 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN usuario.usuario_ldap; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.usuario.usuario_ldap IS 'Usuario del directorio activo';


--
-- TOC entry 228 (class 1259 OID 16415)
-- Name: usuario_usuario_id_seq; Type: SEQUENCE; Schema: consecutivo; Owner: postgres
--

CREATE SEQUENCE consecutivo.usuario_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivo.usuario_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 228
-- Name: usuario_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivo; Owner: postgres
--

ALTER SEQUENCE consecutivo.usuario_usuario_id_seq OWNED BY consecutivo.usuario.usuario_id;


--
-- TOC entry 229 (class 1259 OID 16416)
-- Name: perfil_usuario; Type: TABLE; Schema: consecutivo; Owner: postgres
--

CREATE TABLE consecutivo.perfil_usuario (
    fecha_asociacion_perfil date DEFAULT now(),
    perfil_id bigint NOT NULL,
    usuario_id integer DEFAULT nextval('consecutivo.usuario_usuario_id_seq'::regclass)
);


ALTER TABLE consecutivo.perfil_usuario OWNER TO postgres;

--
-- TOC entry 4868 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE perfil_usuario; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON TABLE consecutivo.perfil_usuario IS 'Almacena cada uno de los perfiles que tiene activo un usuario';


--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN perfil_usuario.fecha_asociacion_perfil; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.perfil_usuario.fecha_asociacion_perfil IS 'Fecha en la que se asocia el perfil al usuario';


--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN perfil_usuario.perfil_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.perfil_usuario.perfil_id IS 'Identificador único de un perfil en la aplicación';


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN perfil_usuario.usuario_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.perfil_usuario.usuario_id IS 'identificador único de un usuario en la aplicación de consecutivo';


--
-- TOC entry 230 (class 1259 OID 16421)
-- Name: perfil_usuario_perfil_id_seq; Type: SEQUENCE; Schema: consecutivo; Owner: postgres
--

CREATE SEQUENCE consecutivo.perfil_usuario_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivo.perfil_usuario_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 230
-- Name: perfil_usuario_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivo; Owner: postgres
--

ALTER SEQUENCE consecutivo.perfil_usuario_perfil_id_seq OWNED BY consecutivo.perfil_usuario.perfil_id;


--
-- TOC entry 231 (class 1259 OID 16422)
-- Name: prefijo; Type: TABLE; Schema: consecutivo; Owner: postgres
--

CREATE TABLE consecutivo.prefijo (
    prefijo_id bigint NOT NULL,
    prefijo character varying(5) NOT NULL,
    descripcion_prefijo character varying(256) NOT NULL
);


ALTER TABLE consecutivo.prefijo OWNER TO postgres;

--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE prefijo; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON TABLE consecutivo.prefijo IS 'Almacena los prefijos (que pueden ser áreas de la empresa, cargos, ...).  Los prefijos son administrados por fuera de la dirección de tics';


--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN prefijo.prefijo_id; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.prefijo.prefijo_id IS 'identificador único del prefijo';


--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN prefijo.prefijo; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.prefijo.prefijo IS 'Prefijo utilizado para la generación de un consecutivo. Deben ser proveídos por un área misional.';


--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN prefijo.descripcion_prefijo; Type: COMMENT; Schema: consecutivo; Owner: postgres
--

COMMENT ON COLUMN consecutivo.prefijo.descripcion_prefijo IS 'Descripción corta del significado del prefijo';


--
-- TOC entry 232 (class 1259 OID 16425)
-- Name: prefijo_prefijo_id_seq; Type: SEQUENCE; Schema: consecutivo; Owner: postgres
--

CREATE SEQUENCE consecutivo.prefijo_prefijo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivo.prefijo_prefijo_id_seq OWNER TO postgres;

--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 232
-- Name: prefijo_prefijo_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivo; Owner: postgres
--

ALTER SEQUENCE consecutivo.prefijo_prefijo_id_seq OWNED BY consecutivo.prefijo.prefijo_id;


--
-- TOC entry 4644 (class 2604 OID 16592)
-- Name: gestion_consecutivo consecutivo; Type: DEFAULT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.gestion_consecutivo ALTER COLUMN consecutivo SET DEFAULT nextval('consecutivo.gestion_consecutivo_consecutivo_seq'::regclass);


--
-- TOC entry 4645 (class 2604 OID 16593)
-- Name: historia_consecutivo consecutivo_id; Type: DEFAULT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.historia_consecutivo ALTER COLUMN consecutivo_id SET DEFAULT nextval('consecutivo.historia_consecutivo_consecutivo_id_seq'::regclass);


--
-- TOC entry 4647 (class 2604 OID 16594)
-- Name: opcion_por_perfil opcion_id; Type: DEFAULT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.opcion_por_perfil ALTER COLUMN opcion_id SET DEFAULT nextval('consecutivo.opcion_por_perfil_opcion_id_seq'::regclass);


--
-- TOC entry 4648 (class 2604 OID 16595)
-- Name: opcion_por_perfil perfil_id; Type: DEFAULT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.opcion_por_perfil ALTER COLUMN perfil_id SET DEFAULT nextval('consecutivo.opcion_por_perfil_perfil_id_seq'::regclass);


--
-- TOC entry 4649 (class 2604 OID 16596)
-- Name: perfil perfil_id; Type: DEFAULT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.perfil ALTER COLUMN perfil_id SET DEFAULT nextval('consecutivo.perfil_perfil_id_seq'::regclass);


--
-- TOC entry 4652 (class 2604 OID 16597)
-- Name: perfil_usuario perfil_id; Type: DEFAULT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.perfil_usuario ALTER COLUMN perfil_id SET DEFAULT nextval('consecutivo.perfil_usuario_perfil_id_seq'::regclass);


--
-- TOC entry 4654 (class 2604 OID 16598)
-- Name: prefijo prefijo_id; Type: DEFAULT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.prefijo ALTER COLUMN prefijo_id SET DEFAULT nextval('consecutivo.prefijo_prefijo_id_seq'::regclass);


--
-- TOC entry 4650 (class 2604 OID 16599)
-- Name: usuario usuario_id; Type: DEFAULT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.usuario ALTER COLUMN usuario_id SET DEFAULT nextval('consecutivo.usuario_usuario_id_seq'::regclass);


--
-- TOC entry 4817 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: gestion_consecutivo; Type: TABLE DATA; Schema: consecutivo; Owner: postgres
--

COPY consecutivo.gestion_consecutivo (consecutivo, hash_key, fecha_genera_consecutivo) FROM stdin;
2548	439920283	2023-09-19 07:28:00.881121
2550	722727592	2023-09-19 11:57:16.235557
2552	355651774	2023-09-19 12:01:57.723997
2554	835737957	2023-09-19 15:07:29.5598
2556	644541186	2023-09-19 15:09:05.37446
2558	101107736	2023-09-19 16:51:31.931787
2560	691560505	2023-09-19 17:56:12.973964
2562	96106182	2023-09-19 17:57:24.805596
2564	557936779	2023-09-19 17:58:13.447464
2566	928857282	2023-09-20 11:44:10.241709
2568	747901087	2023-09-20 11:54:21.984673
2570	322485201	2023-09-20 11:55:08.194504
2572	442246903	2023-09-20 15:58:29.552611
2574	662549041	2023-09-20 16:00:09.926952
2576	519956744	2023-09-20 17:22:53.089001
2578	222915032	2023-09-21 11:31:28.608655
2580	695320423	2023-09-21 14:10:41.91859
2582	705460244	2023-09-21 15:19:40.454316
2584	516667682	2023-09-22 08:53:46.261248
2586	75853888	2023-09-22 11:42:13.744517
2588	332600792	2023-09-22 11:54:26.951276
2590	422717194	2023-09-22 12:31:40.803593
2592	572118388	2023-09-22 15:00:35.430664
2594	919905701	2023-09-22 15:01:53.640011
2596	665942946	2023-09-22 15:02:42.839809
2598	526546681	2023-09-22 15:31:47.05433
2600	337103060	2023-09-22 16:51:19.687941
2602	828768839	2023-09-25 10:41:02.174582
2604	847238979	2023-09-25 11:16:43.376009
2606	666652960	2023-09-25 14:30:06.069485
2608	168963956	2023-09-25 17:14:08.651001
2610	617304983	2023-09-25 17:15:16.742114
2612	485516418	2023-09-26 08:35:39.86497
2614	68576380	2023-09-26 09:28:37.917882
2616	899625697	2023-09-26 10:07:01.118662
2618	371836887	2023-09-26 11:11:53.759048
2620	839006257	2023-09-26 11:42:22.164977
2622	953249679	2023-09-26 11:43:44.597808
2624	141630789	2023-09-26 11:44:46.848245
2626	406127100	2023-09-26 11:48:31.707886
2628	944961156	2023-09-26 15:35:29.116009
2630	527597560	2023-09-26 15:47:06.462511
2632	566270958	2023-09-26 17:33:43.928233
2634	641224343	2023-09-27 15:07:41.991771
2636	399005287	2023-09-28 08:26:55.841217
2638	667563896	2023-09-28 08:53:52.893985
2640	821889686	2023-09-28 09:37:44.571798
2642	287658579	2023-09-28 10:13:32.409188
2644	231636522	2023-09-28 11:51:45.142658
2646	957186665	2023-09-28 14:48:58.552514
2648	892317235	2023-09-28 15:18:58.67462
2650	447450043	2023-09-28 17:16:45.234091
2652	842040016	2023-09-28 17:18:22.987628
2654	923572481	2023-09-28 17:20:48.774252
2656	14865987	2023-09-28 17:21:28.756563
2658	498122695	2023-09-28 17:22:16.052239
2660	671417057	2023-09-28 17:23:04.42201
2662	208393582	2023-09-29 08:59:44.568447
2664	549871685	2023-09-29 09:13:38.273783
2666	863165703	2023-09-29 10:24:25.472336
2668	128773918	2023-09-29 13:34:42.806579
2670	182389863	2023-09-29 14:17:48.905782
2671	652267604	2023-09-29 14:18:02.938225
2672	769137326	2023-09-29 14:18:14.093607
2673	205311060	2023-09-29 14:18:24.883724
2674	340064911	2023-09-29 14:18:34.653475
2675	533268961	2023-09-29 14:18:44.404246
2676	420124246	2023-09-29 14:18:49.995543
2677	483753150	2023-09-29 14:18:55.808876
2678	716102018	2023-09-29 14:19:00.909341
2679	809136111	2023-09-29 14:19:06.571095
2681	306027209	2023-09-29 16:04:21.805839
2683	263981363	2023-10-02 10:29:45.852449
2685	312729891	2023-10-02 12:16:43.979824
2687	972940800	2023-10-02 14:18:09.932696
2689	58759826	2023-10-02 15:03:17.560619
2691	391475621	2023-10-02 15:04:14.319021
2693	33888737	2023-10-02 15:05:38.758079
2695	477264352	2023-10-02 15:46:15.542514
2697	705147291	2023-10-02 15:47:56.906599
2699	534577583	2023-10-02 16:16:47.809053
2701	838849433	2023-10-03 08:30:25.959019
2703	333787034	2023-10-03 08:33:24.76454
2705	643812185	2023-10-03 08:35:45.845542
2707	850474757	2023-10-03 10:06:29.176469
2709	668877869	2023-10-03 10:20:20.856952
2711	877493956	2023-10-03 10:31:15.19421
2713	414403676	2023-10-03 10:32:01.402052
2715	465389551	2023-10-03 10:32:43.011885
2717	405651711	2023-10-03 12:00:33.026179
2719	894018564	2023-10-03 15:44:50.923484
2721	83188984	2023-10-03 17:41:24.628418
2725	472792324	2023-10-03 17:42:22.738393
2727	637595188	2023-10-04 09:01:38.920363
2729	535868788	2023-10-04 12:26:33.334571
2731	184066539	2023-10-04 12:34:55.106381
2733	973273752	2023-10-04 15:23:26.243783
2735	369768536	2023-10-04 15:31:00.006383
2737	233034822	2023-10-05 08:53:28.30589
2739	605920028	2023-10-05 08:55:28.714636
2741	134669173	2023-10-05 08:57:22.618611
2743	340609629	2023-10-05 09:05:35.902369
2745	293984808	2023-10-05 09:08:08.280196
2747	811934675	2023-10-05 09:10:24.756062
2749	174385096	2023-10-05 09:11:36.018156
2751	323651191	2023-10-05 10:03:20.390364
2753	658452064	2023-10-05 11:20:47.895633
2755	440636078	2023-10-05 11:52:18.40051
2757	408862746	2023-10-05 12:43:46.662807
2759	360244868	2023-10-05 15:11:14.44663
2761	888684855	2023-10-05 17:32:33.58875
2763	70468916	2023-10-05 17:33:21.520416
2765	830919676	2023-10-06 09:05:53.890208
2767	650048542	2023-10-06 09:28:49.994296
2769	207450778	2023-10-06 10:07:45.316998
2771	828248056	2023-10-06 17:01:05.20562
2773	714731226	2023-10-06 22:24:27.398594
2775	995638550	2023-10-09 08:08:03.869807
2777	553184284	2023-10-09 09:27:42.268392
2779	438284821	2023-10-09 12:02:55.401287
2782	893520810	2023-10-10 07:35:19.892522
2784	132439782	2023-10-10 09:46:22.432476
2786	769906070	2023-10-10 14:00:55.098329
2788	854887669	2023-10-11 08:50:40.157063
2790	606094719	2023-10-11 09:33:19.310299
2792	464227366	2023-10-11 09:38:20.077915
2794	841712599	2023-10-11 09:53:07.898533
2796	256345060	2023-10-11 09:59:40.006674
2798	708560134	2023-10-11 10:18:37.557257
2800	809359435	2023-10-11 10:23:01.498683
2802	690136505	2023-10-11 11:53:20.74491
2804	954704273	2023-10-11 11:56:03.195734
2806	139140989	2023-10-11 11:57:08.040007
2808	579140729	2023-10-11 15:24:49.728465
2810	155412795	2023-10-11 15:26:07.917937
2812	158258661	2023-10-11 17:14:46.346458
2814	689012664	2023-10-11 17:54:02.789385
2816	890595751	2023-10-11 18:14:46.677396
2818	714688708	2023-10-12 09:37:51.38018
2820	270345324	2023-10-12 16:07:06.826625
2822	526288592	2023-10-12 17:27:05.626897
2824	684200004	2023-10-13 07:53:05.372501
2826	576148486	2023-10-13 09:57:15.416009
2828	793881113	2023-10-13 11:42:09.182448
2830	907384102	2023-10-13 14:51:25.457025
2832	583539877	2023-10-17 09:15:12.047987
2834	454745989	2023-10-17 14:13:07.52044
2836	107919738	2023-10-17 15:04:02.709721
2838	65718060	2023-10-17 15:05:13.581553
2840	948174487	2023-10-17 15:15:42.834261
2842	600992009	2023-10-17 15:37:56.658427
2844	255117286	2023-10-18 08:05:13.053682
2846	535737757	2023-10-18 08:17:40.270334
2848	195364492	2023-10-18 09:07:02.256131
2850	495419915	2023-10-18 09:09:53.587871
2852	554545705	2023-10-18 09:11:58.051871
2854	186450729	2023-10-18 09:28:18.8529
2549	543740367	2023-09-19 11:06:50.458719
2551	303063597	2023-09-19 11:59:58.554428
2553	18389021	2023-09-19 14:35:19.597211
2555	297271368	2023-09-19 15:08:18.78149
2557	147678382	2023-09-19 15:55:04.790704
2559	460741510	2023-09-19 17:55:40.78893
2561	641553355	2023-09-19 17:56:59.879523
2563	648797955	2023-09-19 17:57:49.941902
2565	289806896	2023-09-19 17:58:32.175704
2567	742775105	2023-09-20 11:53:24.055415
2569	541105536	2023-09-20 11:54:48.684158
2571	442953797	2023-09-20 11:55:54.493154
2573	71538376	2023-09-20 15:59:34.673285
2575	900420292	2023-09-20 17:01:19.628694
2577	418755549	2023-09-21 08:37:16.306399
2579	729496679	2023-09-21 11:52:15.349602
2581	926922741	2023-09-21 14:58:21.252399
2583	305246918	2023-09-21 16:41:24.722035
2585	46429428	2023-09-22 09:33:28.709336
2587	798727407	2023-09-22 11:53:54.521173
2589	331805781	2023-09-22 12:29:33.18992
2591	781243602	2023-09-22 14:37:58.666263
2593	128409062	2023-09-22 15:01:23.797936
2595	323179038	2023-09-22 15:02:18.311253
2597	942468454	2023-09-22 15:14:24.174729
2599	51703152	2023-09-22 15:49:03.348437
2601	704974073	2023-09-25 10:40:16.623997
2603	188077115	2023-09-25 11:14:45.80869
2605	877525286	2023-09-25 14:10:05.466702
2607	791278745	2023-09-25 16:58:25.689812
2609	129046619	2023-09-25 17:14:39.672348
2611	797171036	2023-09-25 18:28:45.910648
2613	883738479	2023-09-26 09:26:11.461369
2615	196141586	2023-09-26 10:06:20.914327
2617	796570909	2023-09-26 10:07:47.911794
2619	314461868	2023-09-26 11:15:25.782574
2621	816904156	2023-09-26 11:43:01.118442
2623	177194087	2023-09-26 11:44:25.132884
2625	500306261	2023-09-26 11:45:20.854385
2627	287961602	2023-09-26 11:50:00.18448
2629	834191520	2023-09-26 15:46:29.83212
2631	909364882	2023-09-26 17:33:08.003033
2633	453866582	2023-09-27 13:53:11.31469
2635	984250901	2023-09-27 15:16:26.489093
2637	176169262	2023-09-28 08:52:52.48193
2639	230924428	2023-09-28 08:54:33.246637
2641	456080878	2023-09-28 09:43:09.280797
2643	983868406	2023-09-28 10:36:32.23611
2645	579304011	2023-09-28 11:52:12.707233
2647	690893006	2023-09-28 14:50:26.058303
2649	914243532	2023-09-28 15:40:34.84561
2651	771509859	2023-09-28 17:17:57.01799
2653	355856097	2023-09-28 17:19:12.617753
2655	416985854	2023-09-28 17:21:08.614074
2657	695920982	2023-09-28 17:21:49.839619
2659	609568381	2023-09-28 17:22:39.611501
2661	641501631	2023-09-29 08:18:21.190715
2663	98223740	2023-09-29 09:10:54.435984
2665	457724297	2023-09-29 10:20:43.540107
2667	768829118	2023-09-29 10:40:59.769448
2669	675697125	2023-09-29 13:50:32.814562
2680	771271355	2023-09-29 15:13:28.829746
2682	202303586	2023-10-02 09:58:17.934654
2684	688240600	2023-10-02 11:36:12.364197
2686	696150154	2023-10-02 12:22:32.958471
2688	200225289	2023-10-02 14:52:26.546508
2690	529043780	2023-10-02 15:03:49.093587
2692	151548342	2023-10-02 15:05:18.284341
2694	426948682	2023-10-02 15:45:32.090092
2696	459452230	2023-10-02 15:47:19.176837
2698	306308652	2023-10-02 16:03:53.654406
2700	74672803	2023-10-03 08:12:33.26645
2702	542484414	2023-10-03 08:32:52.321213
2704	58477812	2023-10-03 08:35:19.906233
2706	599414631	2023-10-03 09:40:07.034556
2708	889830216	2023-10-03 10:19:46.278288
2710	463091008	2023-10-03 10:30:51.595534
2712	701826016	2023-10-03 10:31:36.120286
2714	811691149	2023-10-03 10:32:22.999814
2716	883523792	2023-10-03 11:00:09.537395
2718	174611404	2023-10-03 15:42:49.386368
2720	899737092	2023-10-03 16:19:14.25609
2722	983272000	2023-10-03 17:41:50.766659
2723	724699637	2023-10-03 17:41:58.580425
2724	482447940	2023-10-03 17:42:06.011493
2726	538857543	2023-10-04 08:30:36.578211
2728	583571327	2023-10-04 11:34:27.010243
2730	840510078	2023-10-04 12:27:11.986505
2732	15632818	2023-10-04 14:51:34.980959
2734	984834791	2023-10-04 15:24:21.65605
2736	207805609	2023-10-04 15:57:46.172458
2738	920979605	2023-10-05 08:54:42.399704
2740	359871345	2023-10-05 08:56:21.517708
2742	661806640	2023-10-05 09:04:28.664061
2744	389787536	2023-10-05 09:07:33.413134
2746	657329027	2023-10-05 09:08:45.737308
2748	260371569	2023-10-05 09:11:01.583734
2750	888674723	2023-10-05 09:37:54.354144
2752	199741614	2023-10-05 10:40:29.939319
2754	253597321	2023-10-05 11:45:11.095657
2756	427408105	2023-10-05 12:43:06.942956
2758	275863092	2023-10-05 15:09:56.330303
2760	993135027	2023-10-05 16:59:00.212247
2762	132590231	2023-10-05 17:33:02.443368
2764	505884941	2023-10-05 19:26:39.685974
2766	841511192	2023-10-06 09:12:23.793648
2768	139752557	2023-10-06 10:04:30.336402
2770	269936834	2023-10-06 14:39:21.799817
2772	4361475	2023-10-06 17:40:30.195045
2774	551734269	2023-10-09 07:56:38.890353
2776	445305186	2023-10-09 08:26:48.073028
2778	174825882	2023-10-09 10:47:40.692651
2780	195546338	2023-10-09 13:48:53.78472
2781	16929649	2023-10-09 13:49:08.226317
2783	533020935	2023-10-10 09:14:55.380958
2785	284695882	2023-10-10 10:55:50.294132
2787	465399113	2023-10-11 07:51:08.978997
2789	834117984	2023-10-11 09:02:22.549796
2791	675843013	2023-10-11 09:35:48.961967
2793	346213152	2023-10-11 09:48:34.334168
2795	119059967	2023-10-11 09:56:04.858425
2797	304024876	2023-10-11 10:08:46.456126
2799	826394006	2023-10-11 10:22:32.960385
2801	328582745	2023-10-11 10:35:46.685693
2803	412595818	2023-10-11 11:54:14.882261
2805	881983658	2023-10-11 11:56:35.797374
2807	160340463	2023-10-11 15:19:15.220244
2809	898134427	2023-10-11 15:25:16.4775
2811	955795600	2023-10-11 15:50:40.306458
2813	466101600	2023-10-11 17:21:38.140833
2815	853799552	2023-10-11 18:09:17.529823
2817	806391200	2023-10-11 18:21:36.205067
2819	975435199	2023-10-12 09:44:48.323744
2821	86688232	2023-10-12 16:08:03.009172
2823	658196450	2023-10-12 17:32:43.46658
2825	324784494	2023-10-13 08:39:29.556955
2827	847305137	2023-10-13 10:50:03.849369
2829	476619437	2023-10-13 11:47:09.278863
2831	203947910	2023-10-17 08:32:57.197144
2833	353614396	2023-10-17 10:33:01.193849
2835	263901896	2023-10-17 15:03:02.034372
2837	181426787	2023-10-17 15:04:32.686808
2839	998477117	2023-10-17 15:05:52.696656
2841	260911180	2023-10-17 15:16:45.365703
2843	778536818	2023-10-17 16:20:00.305409
2845	891418368	2023-10-18 08:17:04.789434
2847	751092051	2023-10-18 08:18:07.346109
2849	39949929	2023-10-18 09:09:05.456547
2851	80970979	2023-10-18 09:11:14.960928
2853	491360662	2023-10-18 09:12:48.546624
2855	427768398	2023-10-18 11:53:00.746234
2856	200143545	2023-10-18 11:53:28.503592
2857	956876045	2023-10-18 11:53:54.31208
2858	527453697	2023-10-18 11:54:19.826468
2859	996770030	2023-10-18 11:54:43.521602
2860	506845838	2023-10-18 11:55:14.191761
2861	734910449	2023-10-18 11:55:44.226357
2862	575123343	2023-10-18 14:29:56.29144
2863	374447401	2023-10-18 14:32:09.23239
2864	290993411	2023-10-18 14:32:52.840656
2865	343736049	2023-10-18 14:34:52.4227
2866	725103231	2023-10-18 15:04:31.321729
2867	928771623	2023-10-18 15:04:58.50169
2868	750196169	2023-10-19 08:51:03.899112
2869	948442701	2023-10-19 08:51:39.697931
2870	359479957	2023-10-19 08:53:20.049641
2871	39849689	2023-10-19 10:10:55.371873
2872	374913123	2023-10-19 10:11:20.166472
2873	493145870	2023-10-19 11:22:01.859882
2874	251014867	2023-10-19 11:23:55.724125
2875	652779302	2023-10-19 11:57:31.113172
2876	515016875	2023-10-19 13:46:08.962483
2877	819692620	2023-10-19 13:58:57.749157
2878	661064730	2023-10-19 14:07:33.049553
2879	164740057	2023-10-19 14:38:59.358144
2880	476920298	2023-10-19 14:44:15.560599
2881	394751490	2023-10-19 15:38:22.65839
2882	192072341	2023-10-19 15:44:10.479417
2883	684694441	2023-10-19 15:45:02.368427
2884	835863171	2023-10-19 15:45:42.79184
2885	19842944	2023-10-19 16:01:30.453954
2886	279219444	2023-10-19 16:13:31.293631
2887	379592530	2023-10-19 17:45:46.690256
2888	758502670	2023-10-19 17:52:13.733958
2889	468491277	2023-10-19 18:01:57.268349
2890	491311023	2023-10-20 07:39:10.870386
2891	543706772	2023-10-20 08:01:21.071381
2892	777544188	2023-10-20 08:23:28.2297
2893	613816360	2023-10-20 08:27:28.27937
2894	449402429	2023-10-20 08:27:52.160154
2895	32366955	2023-10-20 08:29:24.420736
2896	896870613	2023-10-20 08:30:31.510132
2897	852586133	2023-10-20 08:40:58.454304
2898	80865827	2023-10-20 09:01:44.070916
2899	49204545	2023-10-20 09:10:44.33387
2900	344906882	2023-10-20 09:15:28.091934
2901	857253699	2023-10-20 09:26:43.88103
2902	959802136	2023-10-20 09:35:42.24901
2903	256887673	2023-10-20 10:44:03.052093
2904	711449829	2023-10-20 11:47:17.714192
2905	634170080	2023-10-20 11:48:09.053049
2906	284596429	2023-10-20 11:48:53.740069
2907	885233766	2023-10-20 11:49:25.575206
2908	798783811	2023-10-20 15:05:07.958327
2909	221720282	2023-10-20 17:21:42.87584
2910	146689464	2023-10-20 18:07:12.85837
2911	867104938	2023-10-23 10:37:04.796482
2912	954152433	2023-10-23 11:56:04.576996
2913	215947463	2023-10-23 12:17:46.929404
2914	807698564	2023-10-23 13:32:15.013501
2915	183700536	2023-10-23 13:34:04.019551
2916	899182838	2023-10-23 13:34:51.393291
2917	170495858	2023-10-23 14:22:26.575612
2918	929327899	2023-10-23 14:32:24.942059
2919	133778122	2023-10-23 16:55:03.105012
2920	535987765	2023-10-24 09:09:27.181898
2921	594617678	2023-10-24 10:06:18.922464
2922	910294933	2023-10-24 10:06:48.97752
2923	712489618	2023-10-24 15:13:52.306133
2924	889173623	2023-10-24 15:14:19.26818
2925	776678048	2023-10-24 15:27:23.198528
2926	360276314	2023-10-24 16:12:12.873087
2927	562522546	2023-10-24 16:13:05.660153
2928	868416064	2023-10-24 16:13:37.494125
2929	139338010	2023-10-24 16:14:14.306268
2930	954457900	2023-10-24 16:15:02.868988
2931	42761588	2023-10-24 16:15:26.17683
2932	891991682	2023-10-24 16:16:23.430125
2933	649780849	2023-10-24 16:16:49.250392
2934	447444129	2023-10-24 16:17:22.613426
2935	698216726	2023-10-24 16:17:52.813271
2936	300388386	2023-10-25 08:10:33.168572
2937	781539256	2023-10-25 11:49:19.013969
2938	848916984	2023-10-25 11:50:41.118212
2939	736484010	2023-10-25 11:55:59.693579
2940	21966326	2023-10-25 11:56:39.22568
2941	411737893	2023-10-25 11:57:41.252455
2942	698781190	2023-10-25 11:58:28.193457
2943	606450108	2023-10-25 11:58:54.056052
2944	55365027	2023-10-25 11:59:03.307851
2945	799850665	2023-10-25 11:59:32.172456
2946	729203677	2023-10-25 12:00:18.904114
2947	327737072	2023-10-25 12:01:37.910366
2948	607550142	2023-10-25 12:02:21.215619
2949	701853929	2023-10-25 12:02:45.831816
2950	537867974	2023-10-25 12:03:07.077947
2951	363075306	2023-10-25 12:03:29.542248
2952	661446996	2023-10-25 12:03:55.473292
2953	336456156	2023-10-25 12:05:03.326435
2954	319466354	2023-10-25 12:11:43.45781
2955	369397638	2023-10-25 12:12:04.317588
2956	271365519	2023-10-25 12:12:27.066357
2957	783957066	2023-10-25 12:12:49.186244
2958	854785667	2023-10-25 12:15:28.804845
2959	411510164	2023-10-25 12:16:01.6174
2960	632848762	2023-10-25 12:33:49.357605
2961	645487098	2023-10-25 15:17:32.820475
2962	481921289	2023-10-25 15:27:34.387231
2963	740271437	2023-10-26 08:43:35.555836
2964	279963370	2023-10-26 10:49:53.638086
2965	738923249	2023-10-26 10:50:42.704823
2966	189752603	2023-10-26 10:58:09.023498
2967	822834431	2023-10-26 11:26:26.117002
2968	933769312	2023-10-26 11:52:24.513525
2969	791250843	2023-10-26 14:34:49.892233
2970	497913078	2023-10-26 15:50:56.128528
2971	520958207	2023-10-27 08:55:58.563876
2972	409056185	2023-10-27 09:03:32.047891
2973	136715058	2023-10-27 09:16:14.944924
2974	651546027	2023-10-27 09:27:10.71687
2975	153599391	2023-10-27 09:32:57.344451
2976	542831166	2023-10-27 09:33:44.520823
2977	250065586	2023-10-27 09:59:50.036182
2978	250643295	2023-10-27 10:00:23.706144
2979	760410162	2023-10-27 10:00:52.476183
2980	989609812	2023-10-27 10:01:30.515634
2981	308535117	2023-10-27 10:01:52.357826
2982	158188521	2023-10-27 10:02:23.651047
2983	113971110	2023-10-27 11:14:16.380108
2984	479902549	2023-10-27 11:15:33.983688
2985	541108630	2023-10-27 15:00:17.871197
2986	126278589	2023-10-27 15:39:04.441504
2987	257116913	2023-10-27 15:45:01.49129
2988	904227816	2023-10-27 16:44:11.610253
2989	607503587	2023-10-27 16:47:47.826348
2990	638700654	2023-10-27 16:48:47.516168
2991	264882083	2023-10-27 16:50:32.3491
2992	549527305	2023-10-27 17:00:43.380199
2993	349053494	2023-10-27 17:01:29.272298
2994	1840206	2023-10-27 17:01:53.342269
2995	791785953	2023-10-27 17:02:11.813661
2996	479016261	2023-10-27 17:02:34.63137
2997	622592725	2023-10-27 17:02:55.866288
2998	396777654	2023-10-27 17:03:19.726372
2999	977690435	2023-10-27 18:18:16.024804
3000	279859948	2023-10-30 10:03:57.447805
3001	592592320	2023-10-30 10:06:49.749638
3002	727539729	2023-10-30 14:06:14.34277
3003	172727191	2023-10-30 16:31:26.0772
3004	105973934	2023-10-30 16:32:07.6587
3005	324949982	2023-10-30 16:32:57.549776
3006	117290869	2023-10-30 16:33:30.329197
3007	689381390	2023-10-30 16:33:56.348406
3008	7105361	2023-10-30 18:16:26.29838
3009	394967460	2023-10-30 18:21:04.930463
3010	917694623	2023-10-31 09:09:06.36968
3011	44613568	2023-10-31 10:21:59.371851
3012	72002663	2023-10-31 10:55:11.23667
3013	637060730	2023-10-31 11:11:14.624412
3014	710212579	2023-10-31 11:26:27.819242
3015	699317288	2023-10-31 11:31:47.334559
3016	913290488	2023-10-31 11:31:59.005466
3017	365324455	2023-10-31 11:32:14.546845
3018	106059347	2023-10-31 11:32:21.306072
3019	336231502	2023-10-31 11:32:26.94485
3020	704355105	2023-10-31 11:32:33.02991
3021	572664558	2023-10-31 11:32:39.525139
3022	675338592	2023-10-31 11:33:11.549625
3023	979684549	2023-10-31 11:33:23.285032
3024	560937355	2023-10-31 11:33:34.28678
3025	332257341	2023-10-31 11:33:45.554754
3026	216363396	2023-10-31 11:33:58.145637
3027	92489659	2023-10-31 11:34:12.046164
3028	520612883	2023-10-31 11:34:17.550633
3029	400267901	2023-10-31 12:06:05.13502
3030	324571188	2023-10-31 12:48:28.146587
3031	730711527	2023-10-31 12:55:57.1549
3032	174851848	2023-10-31 12:56:38.950496
3033	990352630	2023-10-31 14:08:58.578077
3034	307322270	2023-10-31 15:47:07.8427
3035	657716411	2023-10-31 16:55:36.460215
3036	266861032	2023-10-31 16:57:12.961
3037	756106027	2023-11-01 08:20:04.355386
3038	344334312	2023-11-01 08:28:29.465449
3039	822259842	2023-11-01 08:37:53.332045
3040	484793668	2023-11-01 10:02:42.931658
3041	124736982	2023-11-01 10:05:45.825941
3042	989035841	2023-11-01 10:06:15.60721
3043	787279427	2023-11-01 10:06:39.868253
3044	473658552	2023-11-01 10:07:01.856781
3045	628440780	2023-11-01 10:07:32.12971
3046	631396916	2023-11-01 10:46:29.694479
3047	813861389	2023-11-01 11:15:22.705144
3048	183515810	2023-11-01 14:31:17.33153
3049	994153498	2023-11-01 17:19:44.447741
3050	976595176	2023-11-01 17:20:18.456484
3051	222617023	2023-11-01 17:20:43.040166
3052	814240740	2023-11-01 17:21:08.058925
3053	277235694	2023-11-01 17:21:35.092135
3054	626165136	2023-11-02 07:40:20.871803
3055	64105389	2023-11-02 08:50:54.266182
3056	877821190	2023-11-02 10:20:46.241484
3057	700593230	2023-11-02 11:28:41.404449
3058	210690818	2023-11-02 11:29:13.326372
3059	601368183	2023-11-02 15:01:51.364028
3060	568782443	2023-11-02 15:02:29.924583
3061	62899070	2023-11-02 15:02:55.435745
3062	224670571	2023-11-02 15:56:17.007824
3063	700593273	2023-11-02 16:04:00.508452
3064	80527891	2023-11-03 08:18:01.83911
3065	119458714	2023-11-03 10:11:39.49
3066	347279168	2023-11-03 16:59:26.355102
3067	230745288	2023-11-07 08:05:39.294734
3068	510907349	2023-11-07 08:18:40.874278
3069	411045382	2023-11-07 09:53:59.768872
3070	954584465	2023-11-07 09:58:11.026173
3071	526428843	2023-11-07 10:08:36.315701
3072	975766756	2023-11-07 11:41:14.123078
3073	444377551	2023-11-07 11:53:47.746714
3074	175575171	2023-11-07 11:54:16.01534
3075	456768526	2023-11-07 11:54:35.469759
3076	37108732	2023-11-07 11:54:51.874317
3077	710286121	2023-11-07 11:55:09.562515
3078	386405949	2023-11-07 11:55:35.427678
3079	797988220	2023-11-07 13:45:49.737735
3080	128931222	2023-11-07 14:58:03.571928
3081	741911624	2023-11-07 14:58:53.193077
3082	72677004	2023-11-07 14:59:40.207122
3083	415597958	2023-11-08 08:16:54.102177
3084	543460804	2023-11-08 08:17:56.822761
3085	322432793	2023-11-08 08:18:28.991213
3086	170066599	2023-11-08 08:19:05.569197
3087	703170774	2023-11-08 08:43:58.56123
3088	445216727	2023-11-08 09:34:31.867146
3089	119930209	2023-11-08 10:26:50.445503
3090	726714187	2023-11-08 12:26:28.505727
3091	627103647	2023-11-08 15:21:51.666368
3092	758904187	2023-11-08 15:22:32.556671
3093	729161165	2023-11-08 15:57:36.009224
3094	977020625	2023-11-08 15:58:16.052922
3095	710176165	2023-11-08 16:51:33.169897
3096	668985148	2023-11-08 17:03:42.320436
3097	551527183	2023-11-09 08:32:37.551756
3098	373300470	2023-11-09 09:33:33.722858
3099	118515946	2023-11-09 10:04:18.110571
3100	204015021	2023-11-09 10:44:38.793982
3101	730404943	2023-11-09 10:50:58.27117
3102	406890924	2023-11-09 10:52:56.022782
3103	842600212	2023-11-09 11:13:41.998201
3104	84337934	2023-11-09 11:23:18.281296
3105	816280710	2023-11-09 11:36:09.368145
3106	967488109	2023-11-09 11:51:53.213385
3107	509054197	2023-11-09 11:52:22.267124
3108	392619203	2023-11-09 14:54:33.269674
3109	618302812	2023-11-09 15:28:05.195376
3110	330311575	2023-11-09 16:24:11.023895
3111	777788058	2023-11-09 16:25:00.107082
3112	501484101	2023-11-09 17:21:07.294848
3113	907958490	2023-11-09 17:41:04.979362
3114	656036895	2023-11-10 09:21:51.992215
3115	869067451	2023-11-10 12:31:09.64264
3116	988638974	2023-11-10 12:36:07.245283
3117	199566729	2023-11-10 12:37:08.559539
3118	974228958	2023-11-10 12:37:44.137371
3119	499531797	2023-11-10 12:47:22.528186
3120	178825009	2023-11-10 13:47:36.826506
3121	842574344	2023-11-10 14:02:34.134555
3122	856386436	2023-11-10 14:11:46.817514
3123	876350751	2023-11-10 15:16:58.193399
3124	738346847	2023-11-10 15:37:12.365821
3125	437885175	2023-11-10 15:51:34.556731
3126	329673693	2023-11-10 15:52:56.205823
3127	339882274	2023-11-10 15:54:33.367681
3128	52209429	2023-11-10 15:55:54.218946
3129	36793749	2023-11-10 16:10:59.189385
3130	224225032	2023-11-10 16:11:42.723691
3131	898505492	2023-11-10 16:19:14.495752
3132	721383582	2023-11-14 08:41:34.625007
3133	412195447	2023-11-14 09:32:08.571341
3134	8655527	2023-11-14 10:34:53.486195
3135	419608040	2023-11-14 15:18:47.653545
3136	95597396	2023-11-14 15:19:49.934933
3137	950179429	2023-11-14 16:27:45.882552
3138	142368782	2023-11-14 17:08:22.13612
3139	924649189	2023-11-14 17:08:56.973287
3140	724107197	2023-11-14 17:09:28.569332
3141	708687885	2023-11-14 17:10:27.870151
3142	795051111	2023-11-14 17:11:01.463259
3143	970523384	2023-11-14 17:11:36.315974
3144	924999512	2023-11-14 17:12:06.12267
3145	203585373	2023-11-14 17:20:54.699798
3146	343810211	2023-11-14 17:34:24.990858
3147	959562682	2023-11-15 08:11:18.18697
3148	876460536	2023-11-15 08:16:19.811982
3149	510166216	2023-11-15 10:19:25.642644
3150	601562648	2023-11-15 14:43:51.368047
3151	362672104	2023-11-15 17:06:05.154901
3152	421891100	2023-11-15 17:07:05.402115
3153	637391954	2023-11-15 17:07:40.409084
3154	810296666	2023-11-15 17:41:56.886669
3155	44123240	2023-11-16 09:03:07.175686
3156	45656456	2023-11-16 09:03:33.667627
3157	197477433	2023-11-16 09:03:57.536385
3158	312720806	2023-11-16 09:04:19.327361
3159	383907806	2023-11-16 09:04:37.874901
3160	729284234	2023-11-16 09:05:10.35324
3161	315479905	2023-11-16 09:07:17.392221
3162	172178492	2023-11-16 09:39:47.420334
3163	136929049	2023-11-16 10:27:23.185536
3164	73529204	2023-11-16 12:00:55.693863
3165	49892644	2023-11-16 14:47:18.786701
3166	526221201	2023-11-16 14:57:20.951849
3167	417153598	2023-11-16 15:06:43.407792
3168	275107731	2023-11-16 15:12:12.47481
3169	247235553	2023-11-16 15:12:55.143707
3170	621351459	2023-11-16 15:16:50.381877
3171	529671521	2023-11-16 15:39:40.772962
3172	596888711	2023-11-16 15:50:15.358471
3173	200151289	2023-11-16 16:03:11.069774
3174	531754466	2023-11-17 09:18:44.386096
3175	360213942	2023-11-17 09:36:23.737773
3176	412654492	2023-11-17 10:18:30.861577
3177	272994799	2023-11-17 14:25:08.555834
3178	387245311	2023-11-17 16:59:06.142212
3179	894606871	2023-11-20 09:12:24.38517
3180	466833176	2023-11-20 09:20:24.969094
3181	116026948	2023-11-20 09:36:03.993517
3182	194914128	2023-11-20 09:37:26.632034
3183	665549766	2023-11-20 09:38:15.004171
3184	449088864	2023-11-20 09:38:59.865084
3185	130074990	2023-11-20 09:39:38.99694
3186	892392806	2023-11-20 11:43:04.204823
3187	752857286	2023-11-20 11:45:30.263457
3188	453071395	2023-11-20 12:31:45.137372
3189	80058182	2023-11-20 16:37:28.433733
3190	969721196	2023-11-20 16:38:10.646097
3191	389365868	2023-11-20 16:39:48.600866
3192	910938545	2023-11-20 16:40:24.547919
3193	999337098	2023-11-20 16:41:07.555752
3194	283455612	2023-11-20 16:42:00.364245
3195	299495276	2023-11-20 16:48:10.547699
3196	110852450	2023-11-21 08:15:05.58019
3197	337000812	2023-11-21 08:16:57.306939
3198	837336919	2023-11-21 09:40:02.95334
3199	369445979	2023-11-21 15:35:03.86836
3200	568933756	2023-11-22 08:28:12.834078
3201	623890069	2023-11-22 08:28:57.993085
3202	458956866	2023-11-22 08:29:55.108911
3203	411352068	2023-11-22 08:30:21.009057
3204	251748077	2023-11-22 08:30:49.331394
3205	127311262	2023-11-22 08:31:31.418936
3206	251446882	2023-11-22 08:47:13.99551
3207	49138753	2023-11-22 10:05:31.053031
3208	251497387	2023-11-22 10:06:59.234549
3209	350578887	2023-11-22 10:07:53.032777
3210	294126324	2023-11-22 10:08:52.835889
3211	936700875	2023-11-22 10:10:31.203666
3212	702907431	2023-11-22 10:12:26.804264
3213	251658786	2023-11-22 10:12:54.187188
3214	781728330	2023-11-22 10:13:42.748206
3215	780829215	2023-11-22 10:14:23.715897
3216	295049336	2023-11-22 10:15:02.39828
3217	288226117	2023-11-22 10:16:11.527407
3218	560669094	2023-11-22 10:18:25.961507
3219	222217575	2023-11-22 10:20:49.083341
3220	273390423	2023-11-22 11:07:10.396007
3221	252982241	2023-11-22 14:46:49.796429
3222	488485273	2023-11-22 15:23:22.286184
3223	394924793	2023-11-22 15:31:53.702864
3224	741769731	2023-11-22 15:32:38.096441
3225	534068628	2023-11-22 15:33:02.356849
3226	820696335	2023-11-22 15:33:30.701018
3227	143591919	2023-11-22 15:33:56.186161
3228	156677289	2023-11-22 15:34:32.19662
3229	534647344	2023-11-22 15:35:18.532433
3230	687983778	2023-11-22 15:35:51.251627
3231	944110053	2023-11-22 15:36:36.978791
3232	12166421	2023-11-22 15:54:35.853598
3233	263933796	2023-11-22 15:55:01.461727
3234	592011622	2023-11-22 15:55:25.520841
3235	171220175	2023-11-22 16:35:37.515554
3236	244985754	2023-11-22 16:56:46.75712
3237	833298300	2023-11-23 08:43:10.176323
3238	695064366	2023-11-23 08:43:38.439018
3239	803792415	2023-11-23 08:44:03.824495
3240	915078019	2023-11-23 09:47:02.36477
3241	181755493	2023-11-23 09:49:40.680741
3242	479539658	2023-11-23 14:18:44.48974
3243	908390817	2023-11-24 10:38:20.63472
3244	171370536	2023-11-24 10:38:55.361017
3245	641248486	2023-11-24 10:39:20.676444
3246	889408435	2023-11-24 10:39:44.416658
3247	318218557	2023-11-24 15:34:38.455278
3248	965318456	2023-11-24 15:55:00.571681
3249	16929660	2023-11-24 15:55:32.859676
3250	175587928	2023-11-24 15:56:03.162959
3251	654902881	2023-11-24 15:56:31.403383
3252	192847629	2023-11-24 15:57:05.878099
3253	726066243	2023-11-24 15:57:28.270543
3254	704789506	2023-11-24 15:57:52.72093
3255	858290514	2023-11-24 16:00:43.995517
3256	654083346	2023-11-24 16:01:23.744588
3257	914178567	2023-11-24 16:30:50.150499
3258	964051207	2023-11-27 08:09:10.16989
3259	819039457	2023-11-27 08:46:16.220632
3260	867284333	2023-11-27 08:56:26.997893
3261	845269762	2023-11-27 09:09:54.032821
3262	819295546	2023-11-27 11:27:19.573694
3263	349373558	2023-11-27 12:16:42.836955
3264	878163266	2023-11-27 12:17:10.093398
3265	608193100	2023-11-27 13:44:31.480425
3266	3474848	2023-11-27 13:45:22.699937
3267	429313294	2023-11-27 14:19:10.381715
3268	725495926	2023-11-27 16:49:32.701924
3269	776031213	2023-11-27 16:50:40.657113
3270	478347919	2023-11-27 16:51:04.735468
3271	797670029	2023-11-27 16:51:47.695387
3272	335216024	2023-11-27 16:52:13.232448
3273	574257325	2023-11-27 16:52:47.306873
3274	469157649	2023-11-27 16:53:11.8305
3275	820630027	2023-11-27 20:32:15.598714
3276	184590144	2023-11-28 08:22:20.415458
3277	585363286	2023-11-28 08:48:02.31274
3278	973865349	2023-11-28 08:51:46.498693
3279	87539211	2023-11-28 08:58:35.895969
3280	651989322	2023-11-28 09:00:19.030628
3281	775299985	2023-11-28 09:38:08.507348
3282	392845722	2023-11-28 14:22:36.516919
3283	623994131	2023-11-28 18:02:57.524734
3284	76978687	2023-11-29 08:09:49.200931
3285	686481428	2023-11-29 09:08:11.27783
3286	954560451	2023-11-29 10:27:31.042513
3287	468224119	2023-11-29 10:28:29.580802
3288	6432234	2023-11-29 10:28:51.61096
3289	513247894	2023-11-29 10:29:15.592198
3290	444165142	2023-11-29 10:29:39.622343
3291	389291532	2023-11-29 10:30:06.103706
3292	83288342	2023-11-29 10:30:30.221913
3293	670477421	2023-11-29 10:32:06.448551
3294	935492781	2023-11-29 10:32:52.19547
3295	840288544	2023-11-29 10:33:26.672432
3296	875978749	2023-11-29 10:33:50.59299
3297	866675036	2023-11-29 10:40:24.891067
3298	622172942	2023-11-29 11:46:31.016452
3299	839238743	2023-11-29 11:47:07.296429
3300	19895923	2023-11-29 11:47:38.00766
3301	884980111	2023-11-29 11:48:10.956874
3302	90750107	2023-11-29 13:48:12.92525
3303	819457329	2023-11-29 15:30:57.62659
3304	115523892	2023-11-29 16:23:39.056826
3305	577210920	2023-11-30 12:40:09.536545
3306	289692103	2023-12-01 08:13:51.653797
3307	336194243	2023-12-01 08:14:43.024421
3308	265666384	2023-12-01 08:15:24.308571
3309	948930794	2023-12-01 08:15:42.117289
3310	160145026	2023-12-01 08:16:09.871565
3311	463530345	2023-12-01 08:16:56.373377
3312	781880385	2023-12-01 08:17:15.108255
3313	225762139	2023-12-01 08:17:35.675209
3314	606647477	2023-12-01 08:17:53.074582
3315	843008925	2023-12-01 08:18:14.269422
3316	497300039	2023-12-01 08:18:45.518526
3317	586797553	2023-12-01 08:19:17.007958
3318	773721645	2023-12-01 08:19:38.898083
3319	705014360	2023-12-01 08:19:54.783101
3320	648663638	2023-12-01 08:20:11.897463
3321	940038877	2023-12-01 08:20:28.57794
3322	667977302	2023-12-01 09:39:55.617627
3323	160987773	2023-12-01 09:40:15.871109
3324	15202804	2023-12-01 09:40:23.069748
3325	688077422	2023-12-01 09:40:29.346248
3326	654764388	2023-12-01 09:40:48.150328
3327	72302542	2023-12-01 09:40:54.396756
3328	774733546	2023-12-01 09:40:59.932285
3329	453003613	2023-12-01 09:41:13.753619
3330	496840841	2023-12-01 09:41:18.928225
3331	537440339	2023-12-01 09:41:24.270729
3332	284105613	2023-12-01 09:41:42.428475
3333	585883740	2023-12-01 09:41:53.92433
3334	457147257	2023-12-01 09:41:58.629044
3335	715842665	2023-12-01 09:42:03.489988
3336	311784407	2023-12-01 09:42:08.138979
3337	925984292	2023-12-01 10:06:53.185623
3338	73348133	2023-12-01 14:49:53.925035
3339	639352293	2023-12-01 15:40:51.459849
3340	780954049	2023-12-01 16:08:04.332686
3341	215378603	2023-12-01 16:35:02.128486
3342	784177470	2023-12-04 08:01:31.163385
3343	56136707	2023-12-04 08:01:53.719772
3344	433626738	2023-12-04 08:02:18.444167
3345	83171418	2023-12-04 08:02:40.005043
3346	908662940	2023-12-04 08:02:58.348707
3347	778311268	2023-12-04 08:03:15.78263
3348	534385607	2023-12-04 08:03:48.398187
3349	650735416	2023-12-04 08:04:05.85885
3350	484482191	2023-12-04 08:04:12.821917
3351	481450016	2023-12-04 08:58:40.213947
3352	478474608	2023-12-04 10:11:33.442184
3353	344688031	2023-12-04 11:07:32.219708
3354	910271098	2023-12-04 11:20:55.650129
3355	182082529	2023-12-04 11:29:28.108051
3356	669230644	2023-12-04 11:33:22.045484
3357	612073231	2023-12-04 11:44:53.049403
3358	677301330	2023-12-04 14:26:00.773428
3359	79026365	2023-12-04 14:33:45.639469
3360	281281950	2023-12-04 14:58:00.540808
3361	331075742	2023-12-04 17:22:25.354176
3362	602141186	2023-12-04 17:33:45.320923
3363	360375590	2023-12-05 09:00:04.154493
3364	352365900	2023-12-05 11:49:24.144762
3365	740915911	2023-12-05 11:49:55.125583
3366	736473320	2023-12-05 11:50:27.889611
3367	511076069	2023-12-05 13:14:39.049888
3368	922152229	2023-12-05 14:29:31.155149
3369	691985443	2023-12-05 14:46:55.55301
3370	112178939	2023-12-05 14:47:19.271585
3371	959677286	2023-12-05 14:47:36.313645
3372	265130400	2023-12-05 14:47:53.568473
3373	851109012	2023-12-05 14:48:09.310806
3374	293181584	2023-12-05 14:48:26.345696
3375	848756169	2023-12-05 14:48:43.552742
3376	852103292	2023-12-05 15:03:38.738853
3377	552656447	2023-12-05 15:13:56.290094
3378	133707833	2023-12-05 15:19:51.729403
3379	868029325	2023-12-05 15:23:35.547445
3380	399468660	2023-12-05 17:28:15.690281
3381	446382499	2023-12-05 18:26:36.577345
3382	612115016	2023-12-06 07:39:05.473456
3383	870220443	2023-12-06 09:22:16.544681
3384	727989994	2023-12-06 10:02:46.83411
3385	850701653	2023-12-06 10:33:30.418414
3386	791859005	2023-12-06 10:39:39.585583
3387	933870150	2023-12-06 11:36:15.614702
3388	282685120	2023-12-06 11:45:31.714065
3389	784545801	2023-12-06 15:41:20.538309
3390	466839905	2023-12-06 15:56:42.193912
3391	752724790	2023-12-06 15:57:44.927694
3392	288407766	2023-12-06 15:58:56.99337
3393	691524714	2023-12-06 15:59:39.346657
3394	73685296	2023-12-06 16:00:20.60242
3395	365985343	2023-12-06 16:01:26.586458
3396	48765823	2023-12-07 10:26:06.995126
3397	495004492	2023-12-07 10:26:31.955285
3398	536367234	2023-12-07 12:24:45.239497
3399	850880282	2023-12-07 14:19:16.068727
3400	933709769	2023-12-07 14:37:13.477134
3401	759288931	2023-12-07 16:26:10.785655
3402	632674622	2023-12-11 09:05:17.977535
3403	441615319	2023-12-11 09:27:19.302869
3404	644207753	2023-12-11 09:27:51.630856
3405	732122854	2023-12-11 09:28:19.03228
3406	302249855	2023-12-11 09:28:51.884954
3407	493562041	2023-12-11 09:29:07.885651
3408	646584587	2023-12-11 09:29:50.302854
3409	449457637	2023-12-11 09:30:14.730522
3410	389160937	2023-12-11 09:30:39.351722
3411	604119327	2023-12-11 09:31:20.166961
3412	776080941	2023-12-11 09:36:31.579911
3413	575117186	2023-12-11 09:42:10.78168
3414	849111096	2023-12-11 09:42:41.476371
3415	114111568	2023-12-11 09:44:04.38749
3416	81011822	2023-12-11 09:44:29.029849
3417	191051227	2023-12-11 09:44:55.677309
3418	637051072	2023-12-11 09:45:53.555574
3419	804636615	2023-12-11 09:46:17.603115
3420	15226577	2023-12-11 09:47:26.843961
3421	539666307	2023-12-11 10:13:12.581168
3422	593867287	2023-12-11 10:45:10.003529
3423	216854643	2023-12-11 11:08:17.434942
3424	790955361	2023-12-11 11:17:16.503367
3425	822835342	2023-12-11 11:40:06.493533
3426	203243668	2023-12-11 11:58:30.194558
3427	71216774	2023-12-11 13:08:01.147737
3428	40119697	2023-12-11 15:05:47.360132
3429	713956464	2023-12-11 15:06:07.638835
3430	733256580	2023-12-11 15:06:36.349493
3431	761150735	2023-12-11 15:35:34.364003
3432	806305493	2023-12-11 15:51:41.153243
3433	616738354	2023-12-11 16:58:17.617353
3434	990064355	2023-12-11 17:36:15.203213
3435	231848273	2023-12-11 17:44:42.063687
3436	253217617	2023-12-11 17:45:10.991136
3437	342218850	2023-12-11 17:45:37.522434
3438	303610283	2023-12-11 17:46:08.107784
3439	81747032	2023-12-11 17:46:35.829314
3440	315424856	2023-12-11 17:46:55.845621
3441	840276267	2023-12-12 08:51:37.869941
3442	238668342	2023-12-12 09:06:12.714846
3443	964467936	2023-12-12 09:19:03.254847
3444	863384431	2023-12-12 10:12:22.049819
3445	561869625	2023-12-12 10:30:40.764628
3446	207378484	2023-12-12 10:32:36.987475
3447	419059055	2023-12-12 10:33:47.512713
3448	751624737	2023-12-12 10:40:26.117841
3449	873966081	2023-12-12 10:40:48.66199
3450	335794460	2023-12-12 10:41:07.861271
3451	955514312	2023-12-12 10:41:23.593638
3452	917251448	2023-12-12 10:41:40.385979
3453	20365936	2023-12-12 10:41:57.224585
3454	107105275	2023-12-12 10:42:13.463761
3455	85031172	2023-12-12 10:42:28.610242
3456	35776633	2023-12-12 10:42:46.458151
3457	970600972	2023-12-12 10:43:02.639159
3458	883813845	2023-12-12 10:43:17.274662
3459	717474547	2023-12-12 11:03:49.803504
3460	742670173	2023-12-13 09:17:28.455579
3461	889943683	2023-12-13 09:17:54.484734
3462	645987841	2023-12-13 09:18:26.403825
3463	817498116	2023-12-13 09:19:01.733705
3464	698833337	2023-12-13 09:19:29.999177
3465	863095586	2023-12-13 09:19:52.662564
3466	74441131	2023-12-13 09:22:54.701884
3467	809318455	2023-12-13 11:13:41.237713
3468	755913170	2023-12-13 15:29:04.623203
3469	127237399	2023-12-13 15:45:40.101494
3470	969819591	2023-12-13 16:39:03.246791
3471	705204775	2023-12-13 16:39:46.447363
3472	245748912	2023-12-13 16:40:12.739676
3473	267833836	2023-12-13 16:40:42.636851
3474	730962878	2023-12-13 16:50:31.351842
3475	289915617	2023-12-13 23:33:13.187017
3476	510169208	2023-12-13 23:33:36.45723
3477	466623797	2023-12-13 23:34:14.292823
3478	700354827	2023-12-13 23:34:54.101169
3479	432150095	2023-12-13 23:35:15.424371
3480	276769368	2023-12-13 23:35:34.124111
3481	185819524	2023-12-13 23:35:52.681447
3482	954998381	2023-12-13 23:36:12.577471
3483	539339645	2023-12-14 09:16:31.13575
3484	965009295	2023-12-14 09:54:09.85779
3485	978406955	2023-12-14 10:54:53.073685
3486	64055869	2023-12-14 11:19:38.005382
3487	521751802	2023-12-14 11:20:27.315068
3488	35842400	2023-12-14 11:21:15.796798
3489	369216192	2023-12-14 11:21:51.619854
3490	626313353	2023-12-14 11:22:23.494478
3491	519251955	2023-12-14 11:47:38.498932
3492	62862902	2023-12-14 16:09:14.278963
3493	615570555	2023-12-14 16:32:07.993154
3494	101181614	2023-12-14 17:10:31.651144
3495	62256747	2023-12-14 17:26:24.897506
3496	78776238	2023-12-14 17:27:25.201018
3497	278220424	2023-12-14 17:28:01.092501
3498	793240517	2023-12-14 17:28:45.503594
3499	475716036	2023-12-15 09:12:13.12594
3500	997243677	2023-12-15 09:15:03.591835
3501	759003013	2023-12-15 09:26:39.57739
3502	654566049	2023-12-15 15:27:01.867904
3503	176494339	2023-12-15 15:49:51.7502
3504	578674904	2023-12-15 15:50:38.829096
3505	961722280	2023-12-15 15:51:23.27535
3506	905046747	2023-12-15 16:15:18.337713
3507	765397238	2023-12-15 17:08:50.742683
3508	168078652	2023-12-15 17:17:11.689724
3509	283964770	2023-12-15 17:27:51.449148
3510	825440422	2023-12-18 07:51:25.051485
3511	92323432	2023-12-18 09:01:22.561031
3512	798258777	2023-12-18 09:49:49.102372
3513	39296080	2023-12-18 09:50:25.290379
3514	513337902	2023-12-18 09:51:07.06557
3515	414688775	2023-12-18 09:51:40.362531
3516	730510661	2023-12-18 09:52:07.303307
3517	618690072	2023-12-18 09:58:02.812285
3518	281354947	2023-12-18 10:23:20.704651
3519	426905998	2023-12-18 11:21:13.61956
3520	926949578	2023-12-18 11:48:38.787301
3521	275859266	2023-12-18 11:50:53.230536
3522	999531638	2023-12-18 12:37:02.727259
3523	487447807	2023-12-18 12:37:29.901384
3524	521102510	2023-12-18 12:37:47.61471
3525	846671395	2023-12-18 12:38:05.772685
3526	7681868	2023-12-18 12:38:23.680139
3527	606371695	2023-12-18 12:38:38.77487
3528	490762665	2023-12-18 12:39:00.076364
3529	299007853	2023-12-18 13:18:10.149404
3530	610650596	2023-12-18 13:22:03.814614
3531	293343709	2023-12-18 17:06:38.636867
3532	119307398	2023-12-18 17:45:41.105933
3533	766055568	2023-12-18 17:46:26.23096
3534	810803597	2023-12-18 17:46:53.615499
3535	67499178	2023-12-18 17:47:15.218585
3536	601103793	2023-12-18 17:47:41.522338
3537	497742318	2023-12-18 18:18:41.681128
3538	910367252	2023-12-19 10:45:28.645208
3539	228343344	2023-12-19 13:45:11.817721
3540	361168940	2023-12-19 17:16:12.058452
3541	4969705	2023-12-19 17:16:52.321044
3542	651162911	2023-12-20 09:39:05.892222
3543	946077079	2023-12-20 11:30:57.216376
3544	266059949	2023-12-20 11:31:32.858201
3545	430059263	2023-12-20 11:32:01.323459
3546	217163972	2023-12-20 11:32:31.976318
3547	364207279	2023-12-20 11:32:54.484592
3548	315663135	2023-12-20 11:33:19.213892
3549	975639441	2023-12-20 11:34:30.407859
3550	134754976	2023-12-20 11:34:55.565385
3551	536225155	2023-12-20 16:00:28.865794
3552	562673424	2023-12-20 16:13:36.256669
3553	981854228	2023-12-20 16:14:14.117984
3554	976800470	2023-12-21 08:49:48.034005
3555	283501979	2023-12-21 08:51:37.174221
3556	410854566	2023-12-21 09:21:51.333856
3557	495962754	2023-12-21 09:43:43.736347
3558	128162239	2023-12-21 09:58:18.942358
3559	916055990	2023-12-21 09:58:33.945367
3560	813330521	2023-12-21 09:58:54.210229
3561	4230081	2023-12-21 11:25:13.462184
3562	620718548	2023-12-21 12:40:30.665924
3563	798896316	2023-12-21 16:08:28.132746
3564	716325355	2023-12-21 16:10:32.29133
3565	717507598	2023-12-21 16:10:33.897695
3566	242014708	2023-12-21 16:11:52.614053
3567	661356528	2023-12-22 08:38:22.568786
3568	169634020	2023-12-22 14:22:49.868639
3569	47255035	2023-12-22 16:35:05.408701
3570	595969557	2023-12-22 17:47:34.777544
3571	850034720	2023-12-26 10:46:07.331961
3572	857607378	2023-12-26 10:46:35.303217
3573	706155425	2023-12-26 10:46:58.881756
3574	867459400	2023-12-26 10:49:27.773888
3575	1430345	2023-12-26 10:49:51.307554
3576	495228600	2023-12-26 10:50:15.205836
3577	196620395	2023-12-26 10:50:44.776433
3578	867122338	2023-12-26 10:51:09.088145
3579	602193663	2023-12-26 10:51:33.878033
3580	142360189	2023-12-26 10:52:01.620366
3581	297096396	2023-12-26 10:52:27.928709
3582	740811929	2023-12-26 10:52:51.566116
3583	596311890	2023-12-26 10:53:18.080148
3584	905701226	2023-12-26 10:58:22.288032
3585	693910852	2023-12-26 11:08:20.182237
3586	752411954	2023-12-26 11:08:56.079819
3587	374944383	2023-12-26 11:09:52.872919
3588	197712219	2023-12-26 11:11:04.251124
3589	350006909	2023-12-26 11:13:13.945947
3590	78162504	2023-12-26 11:27:09.760405
3591	71010928	2023-12-26 15:54:28.021134
3592	490961995	2023-12-26 17:27:27.254045
3593	442323767	2023-12-27 07:28:53.780456
3594	24212688	2023-12-27 08:14:04.187184
3595	14956712	2023-12-27 10:30:28.25407
3596	421447459	2023-12-27 10:55:29.877872
3597	181518760	2023-12-27 10:56:20.272195
3598	415939465	2023-12-27 10:57:03.697229
3599	75952373	2023-12-27 10:57:32.357858
3600	694878664	2023-12-27 10:58:02.190461
3601	934702296	2023-12-27 10:58:37.407579
3602	491652245	2023-12-27 10:59:09.845833
3603	658239529	2023-12-27 10:59:47.665747
3604	94505838	2023-12-27 11:00:18.737435
3605	755021624	2023-12-27 11:00:50.092054
3606	618749110	2023-12-27 11:01:19.742286
3607	544827229	2023-12-28 08:31:32.199643
3608	765284595	2023-12-28 08:40:03.907832
3609	686850584	2023-12-28 08:52:54.584528
3610	941878634	2023-12-28 09:34:50.310215
3611	196917512	2023-12-28 09:35:19.797901
3612	955424527	2023-12-28 09:35:43.268417
3613	634239388	2023-12-28 09:36:40.129665
3614	373281064	2023-12-28 09:37:07.835347
3615	646217025	2023-12-28 09:37:26.479776
3616	357454362	2023-12-28 09:37:46.872984
3617	824434326	2023-12-28 09:38:11.183947
3618	586728603	2023-12-28 09:38:47.449989
3619	168433769	2023-12-28 10:40:32.430767
3620	151076507	2023-12-28 11:52:45.262833
3621	775506197	2023-12-29 08:10:16.606131
3622	640203368	2023-12-29 08:10:36.387751
3623	652943849	2023-12-29 08:10:50.417315
3624	242493190	2023-12-29 08:11:04.817114
3625	722860635	2023-12-29 08:11:21.824861
3626	780720990	2023-12-29 08:11:42.265157
3627	881561723	2023-12-29 08:45:27.394046
3628	704704566	2023-12-29 09:05:41.509503
3629	414569032	2023-12-29 10:17:43.571116
3630	249475884	2023-12-29 10:27:46.155952
3631	484639002	2023-12-29 11:31:18.924866
3632	292615374	2023-12-29 11:31:54.601903
3633	782289502	2023-12-29 11:32:05.666538
3634	546541932	2023-12-29 11:32:16.116773
3635	548285748	2023-12-29 11:32:26.736136
3636	719956623	2023-12-29 11:32:35.370677
3637	12690294	2023-12-29 11:32:48.594861
3638	859509975	2023-12-29 11:33:03.607939
3639	449755346	2023-12-29 11:33:19.354656
3640	703575791	2023-12-29 11:33:29.473025
3641	337361127	2023-12-29 11:33:40.785296
3642	672785691	2023-12-29 11:33:54.31365
3643	63673945	2023-12-29 11:34:08.6799
3644	602960088	2023-12-29 11:34:20.025789
3645	82314988	2023-12-29 11:34:29.137342
3646	531829986	2023-12-29 11:34:39.506007
3647	808829415	2023-12-29 11:34:52.050961
3648	514806948	2023-12-29 11:35:06.249084
3649	739303375	2023-12-29 11:35:16.849777
3650	241739792	2023-12-29 11:35:27.585555
3651	573497315	2023-12-29 11:35:36.835547
3652	575165445	2023-12-29 11:35:49.611054
3653	514652891	2023-12-29 11:35:57.277105
3654	781200537	2023-12-29 11:36:07.676421
3655	234493070	2023-12-29 11:36:16.92437
3656	170554192	2023-12-29 11:36:27.604034
3657	824199343	2023-12-29 11:36:36.131283
3658	986449131	2023-12-29 11:36:51.019316
3659	724975177	2023-12-29 11:37:00.893264
3660	478550570	2023-12-29 13:38:45.158684
3661	686057541	2023-12-29 13:39:10.011936
3662	23409475	2023-12-29 13:39:28.207908
3663	477540701	2023-12-29 13:39:44.259757
3664	522519063	2023-12-29 13:40:01.074334
3665	771145386	2023-12-29 13:40:15.930531
3666	934378420	2023-12-29 13:40:34.289902
3667	208311240	2023-12-29 15:56:54.794559
3668	524564981	2023-12-29 16:20:36.817864
3669	121828454	2023-12-29 16:58:52.937101
3670	703916163	2023-12-31 17:56:29.689477
3671	953545512	2023-12-31 17:57:20.351417
1	742909062	2024-01-02 14:22:47.446646
2	234675337	2024-01-02 14:23:29.550078
3	273685841	2024-01-02 14:29:31.164921
4	878970833	2024-01-03 08:59:25.031293
5	351749442	2024-01-03 10:42:07.354766
6	755520011	2024-01-03 14:24:46.092924
7	996634874	2024-01-03 14:26:11.406527
8	552070932	2024-01-03 14:26:34.359052
9	810406514	2024-01-03 14:26:57.849986
10	841256534	2024-01-03 17:20:18.692888
11	116406715	2024-01-03 17:20:38.801759
12	463720461	2024-01-04 08:32:21.694684
13	91780678	2024-01-04 10:47:10.546629
14	313053424	2024-10-08 16:30:10.266104
\.


--
-- TOC entry 4819 (class 0 OID 16394)
-- Dependencies: 220
-- Data for Name: historia_consecutivo; Type: TABLE DATA; Schema: consecutivo; Owner: postgres
--

COPY consecutivo.historia_consecutivo (consecutivo_id, consecutivo, usuario_id, prefijo_id, descripcion, fecha_generacion, num_consecutivo) FROM stdin;
436	2770	16	4	Aprobación cr GOMEZ PAVA VILMA AMPARO	2023-10-06 14:39:21.799817	\N
443	2777	125	7	Radicado Work-Manager 449274, solicitud del señor BARBOSA QUIMBAY HORACIO, (Cancelación pólizas, retiro cooperativa).	2023-10-09 09:27:42.268392	\N
451	2785	38	4	Certificado JORGE ENRIQUE ROJAS OTALORA cc: 19181093 credito 10- 211001141 	2023-10-10 10:55:50.294132	\N
458	2792	16	4	Aprobación cr APONTE MOTTA JORGE MARIO	2023-10-11 09:38:20.077915	\N
398	2732	16	5	APROBACIÓN CR RODRIGUEZ BALLEN OSCAR DAVID	2023-10-04 14:51:34.980959	\N
403	2737	119	6	CARTA DE RETIRO MARCELINO JAIME PRATS SALAS	2023-10-05 08:53:28.30589	\N
408	2742	119	6	CARTA DE APROBACIÓN DE RETIRO JOHN FITZGERALD LOZANO PAZ	2023-10-05 09:04:28.664061	\N
413	2747	119	6	CARTA DE APROBACIÓN DE RETIRO BERTHA ROMERO ROMERO	2023-10-05 09:10:24.756062	\N
418	2752	37	4	PAZ Y SALVO  HOUGHTON PEREZ JOSE MARIA	2023-10-05 10:40:29.939319	\N
423	2757	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-10-05 12:43:46.662807	\N
428	2762	29	6	CARTA DE BIENVENIDA COY SILVA DIANA JAZMIN	2023-10-05 17:33:02.443368	\N
433	2767	17	7	TRASLADO COOPCENTRAL AH UPCR A CTE AFINIDAD	2023-10-06 09:28:49.994296	\N
347	2681	16	4	APROBACIÓN CR IAC	2023-09-29 16:04:21.805839	\N
351	2685	32	4	REDENCION CDT 58269 DAVIVIENDA ABONO A CUENTA DE AHORROS	2023-10-02 12:16:43.979824	\N
355	2689	29	6	CARTA DE BIENVENIDA  BRAVO SANCHEZ ANDREA LUCIA	2023-10-02 15:03:17.560619	\N
359	2693	29	6	CARTA DE BIENVENIDA ESPINOSA SANCHEZ JEREMIAS	2023-10-02 15:05:38.758079	\N
363	2697	16	4	APROBACIÓN CR MORA MARTINEZ DIANA MILENA 	2023-10-02 15:47:56.906599	\N
367	2701	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-10-03 08:30:25.959019	\N
371	2705	30	5	ACEPTACIÓN DE RENUNCIA 	2023-10-03 08:35:45.845542	\N
375	2709	16	4	APROBACIÓN CR PÉREZ HOYOS GUSTAVO	2023-10-03 10:20:20.856952	\N
379	2713	29	6	CARTA DE BIENVENIDA ESCALANTE MARQUEZ BRUNO RICARDO	2023-10-03 10:32:01.402052	\N
465	2799	16	4	Aprobación cr GARCIA REYES LUZ FANNY	2023-10-11 10:22:32.960385	\N
472	2806	119	6	CARTA DE BIENVENIDA ASOCIADO RAUL ALBERTO RUIZ GARCIA 	2023-10-11 11:57:08.040007	\N
479	2813	16	4	Aprobación cr DELGADO GOMEZ OMAR OSWALDO	2023-10-11 17:21:38.140833	\N
486	2820	16	4	Aprobación Lozano Marquez Harvey 	2023-10-12 16:07:06.826625	\N
493	2827	16	4	Aprobación cr GARZON GOMEZ YASMINA 	2023-10-13 10:50:03.849369	\N
500	2834	7	9	Respuesta derecho de petición ANA YAMILE PINEDA TORRES	2023-10-17 14:13:07.52044	\N
506	2840	7	7	Respuesta derecho de petición asociado TEOFRASTO ANTONIO TATIS	2023-10-17 15:15:42.834261	\N
512	2846	16	4	Aprobación cr LOZANO GUARNIZO JAIRO ALBERTO	2023-10-18 08:17:40.270334	\N
518	2852	119	6	CARTA DE APROBACIÓN DE RETIRO- ROBERTO GARCÍA PIEDRAHITA 	2023-10-18 09:11:58.051871	\N
524	2858	119	6	CARTA DEBIENVENIDA- ROJAS OSPINA JULIO CESAR 	2023-10-18 11:54:19.826468	\N
383	2717	120	4	PAZ Y SALVO CARMEN TULIA BARRIOS DE CHAPARRO	2023-10-03 12:00:33.026179	\N
386	2720	16	4	APROBACIÓN CR SEPULVEDA CACERES WILLIAM HUMBERTO	2023-10-03 16:19:14.25609	\N
392	2726	37	4	CERTIFICADO DE DEUDA CREDITO AL DIA  CORREDOR RUIZ ALEJANDRA	2023-10-04 08:30:36.578211	\N
395	2729	32	4	CANCELACION CDT COOPCENTRAL FL NO 1991473	2023-10-04 12:26:33.334571	\N
272	2606	5	4	CERTIFICADO ANA CARMENZA CASTRO SALCEDO	2023-09-25 14:30:06.069485	\N
275	2609	16	4	APROBACIÓN CR RINCÓN LEURO OMAR 	2023-09-25 17:14:39.672348	\N
278	2612	5	4	CERTIFICADO HECTOR JOSE GALLEGO MARTINEZ	2023-09-26 08:35:39.86497	\N
281	2615	16	4	APROBACIÓN CR CORTES MORENO DIANA CLEMENCIA 	2023-09-26 10:06:20.914327	\N
284	2618	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-26 11:11:53.759048	\N
218	2552	32	4	PROVISION EFECTIVO TESORERIA	2023-09-19 12:01:57.723997	\N
318	2652	29	6	CARTA DE BIENVENIDA DUARTE MARTINEZ LUZ ANGELICA	2023-09-28 17:18:22.987628	\N
321	2655	29	6	CARTA DE BIENVENIDA FLOREZ PINZON JONATHAN ESTIBEN	2023-09-28 17:21:08.614074	\N
324	2658	29	6	CARTA DE BIENVENIDA BARRERA MOJICA KATHERINE	2023-09-28 17:22:16.052239	\N
327	2661	32	4	SOLICITUD CH GERENCIA SOCIEDAD GANLANTE RENDON Y CIA PAGO CASA PCR	2023-09-29 08:18:21.190715	\N
330	2664	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-29 09:13:38.273783	\N
333	2667	30	5	CONCESIÓN DE VACACIONES	2023-09-29 10:40:59.769448	\N
336	2670	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:17:48.905782	\N
337	2671	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:02.938225	\N
338	2672	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:14.093607	\N
530	2864	16	4	Aprobación cr DUEÑAS BOHORQUEZ SERGIO 	2023-10-18 14:32:52.840656	\N
533	2867	16	4	RPTA CONTROL INTERNO CRÉDITOS DIRECTIVOS 	2023-10-18 15:04:58.50169	\N
538	2872	5	4	CERTIFICADO MARIA AMPARO IBAÑEZ DE MONTAÑA	2023-10-19 10:11:20.166472	\N
544	2878	32	7	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-19 14:07:33.049553	\N
549	2883	16	4	Aprobación cr GARZÓN BOLIVAR MARCELA 	2023-10-19 15:45:02.368427	\N
554	2888	121	4	Carta reporte de pagos Ramón Moisés García Piment,y otros mes de julio de 2023	2023-10-19 17:52:13.733958	\N
559	2893	121	4	Carta Reporte de Pagos Mercedes Duarte de Navas y otros  P. No. 43227	2023-10-20 08:27:28.27937	\N
560	2894	32	7	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-20 08:27:52.160154	\N
565	2899	5	4	CERTIFICADO NILSON EVELIO LOPEZ SOTO	2023-10-20 09:10:44.33387	\N
570	2904	16	4	Aprobación cr DUARTE JARAMILLO DIANA CAROLINA	2023-10-20 11:47:17.714192	\N
575	2909	16	4	Aprobación cr NIETO PINTO MANUEL ANTONIO	2023-10-20 17:21:42.87584	\N
580	2914	16	4	aprobación cr Rubio León Clara Melisa	2023-10-23 13:32:15.013501	\N
585	2919	5	4	CERTIFICADO JOSE DARIO SALAZAR RAMOS	2023-10-23 16:55:03.105012	\N
590	2924	32	4	TRASL A CREDICORP DE BB RENTA YA	2023-10-24 15:14:19.26818	\N
595	2929	16	4	Aprobación cr ARIAS MARTINEZ SANDRA BIBIANA	2023-10-24 16:14:14.306268	\N
600	2934	16	4	Aprobación cr ARIZA RIAÑO PABLO ENRIQUE	2023-10-24 16:17:22.613426	\N
605	2939	16	7	Aprobación cr VANOY LUQUE IVAN GIOVANNI 	2023-10-25 11:55:59.693579	\N
437	2771	7	7	Solicitud de prorroga reporte del margen operacional septiembre 2023.	2023-10-06 17:01:05.20562	\N
444	2778	15	7	SOLICITUD PRORROGA PROYECCIONES FINANCIERAS SES	2023-10-09 10:47:40.692651	\N
452	2786	13	4	CARTA DE AUTORIZACION CHEQUERA EXCENTA	2023-10-10 14:00:55.098329	\N
459	2793	32	4	CIRCULARIZACION INVERSIONES-FED NAL DE COOP EDUCATIVO	2023-10-11 09:48:34.334168	\N
466	2800	16	4	Aprobación cr Torres Hernandez Carmelo 	2023-10-11 10:23:01.498683	\N
473	2807	32	7	CIRCULARIZACION INVERSIONES-IAC	2023-10-11 15:19:15.220244	\N
480	2814	16	4	Aprobación cr PALACIOS HOLGUIN LAURENCIO	2023-10-11 17:54:02.789385	\N
487	2821	16	4	Aprobación cr Pinto Nolla Jorge	2023-10-12 16:08:03.009172	\N
494	2828	37	4	PAZ Y SALVO MORENO ROMERO CESAR EDUARDO	2023-10-13 11:42:09.182448	\N
501	2835	16	4	Aprobación cr sacristan vega leslie 	2023-10-17 15:03:02.034372	\N
399	2733	16	4	APROBACIÓN CR ACERO BAENA JUAN PABLO 	2023-10-04 15:23:26.243783	\N
404	2738	119	6	CARTA DE APROBACIÓN DE RETIRO AURA ROSARIO GUTIERREZ AFRICANO	2023-10-05 08:54:42.399704	\N
409	2743	119	6	CARTA DE APROBACIÓN DE RETIRO OLGA LUCIA RODRIGUEZ CUELLAR	2023-10-05 09:05:35.902369	\N
507	2841	7	7	Respuesta derecho de petición LUZ YOLANDA ACUÑA GONZALEZ	2023-10-17 15:16:45.365703	\N
513	2847	16	4	Aprobación cr JAIMEZ SANCHEZ JEANET	2023-10-18 08:18:07.346109	\N
519	2853	119	6	CARTA DE APROBACIÓN DE RETIRO- LUZ MERY BOHORQUEZ FORERO	2023-10-18 09:12:48.546624	\N
525	2859	119	6	GOMEZ MORENO MARIBEL	2023-10-18 11:54:43.521602	\N
531	2865	16	4	Aprobación Garcia de \r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nAprobación cr Garcia de Achury Flora Helena\r\n\r\n\r\n\r\n\r\n\r\n	2023-10-18 14:34:52.4227	\N
534	2868	16	4	Aprobación cr SENCIAL GOMEZ CIRCE URANIA	2023-10-19 08:51:03.899112	\N
539	2873	38	4	Paz y salvo ESTEFANIA ARTEAGA NAVARRO  cc 1019004307  crédito 10-211001809  	2023-10-19 11:22:01.859882	\N
545	2879	7	7	Respuesta derecho de petición BRAYAN ANDRÉS MALDONADO PERDOMO - apoderado de EDDNY TATIANA PACHON RAMIREZ	2023-10-19 14:38:59.358144	\N
550	2884	16	4	Aprobación cr HENRIQUEZ HERNANDEZ CECILIA 	2023-10-19 15:45:42.79184	\N
555	2889	121	4	Carta Reporte de Pagos, caso Jorge Mario Méndez Morales y otros P. 1386-40716	2023-10-19 18:01:57.268349	\N
561	2895	16	4	Aprobación Blue Card Guevara Molano Elías 	2023-10-20 08:29:24.420736	\N
414	2748	119	6	CARTA DE APROBACIÓN DE RETIRO CESAR ARTURO PUERTAS CÉSPEDES	2023-10-05 09:11:01.583734	\N
419	2753	16	4	APROBACIÓN CR NOGUERA SIERRA JOAN LUIS	2023-10-05 11:20:47.895633	\N
424	2758	16	4	APROBACIÓN CR MARTINEZ PAEZ JOSE JESUS FERNANDO	2023-10-05 15:09:56.330303	\N
429	2763	29	6	CARTA DE BIENVENIDA PÉREZ CORREDOR VICTOR SANTIAGO	2023-10-05 17:33:21.520416	\N
434	2768	32	4	PROVISION EFECTIVO TESORERIA\r\n	2023-10-06 10:04:30.336402	\N
287	2621	16	4	APROBACIÓN CR MÉDINA AMARIS ALVARO LUIS 	2023-09-26 11:43:01.118442	\N
290	2624	29	6	CARTA DE BIENVENIDA FANDIÑO VALDERRAMA  CAMILO ARTURO	2023-09-26 11:44:46.848245	\N
293	2627	29	6	CARTA DE BIENVENIDA GUEVARA PEÑALOZA LAURA XIMENA	2023-09-26 11:50:00.18448	\N
296	2630	16	4	APROBACIÓN CR CABALLERO GALINDO LUZ OMAIRA 	2023-09-26 15:47:06.462511	\N
264	2598	16	4	APROBACIÓN MARTINEZ PULIDO PAOLA 	2023-09-22 15:31:47.05433	\N
215	2549	16	4	APROBACIÓN CRÉDITO VERGARA NAVARRO ERIKA VALENTINA KRUPSKAYA	2023-09-19 11:06:50.458719	\N
221	2555	15	7	GODOY & HOYOS ABOGADOS-SERVICIOS PROFESIONALES DECLARACIÓN DE RENTA 2019	2023-09-19 15:08:18.78149	\N
224	2558	15	7	SOLICITUD PRORROGA REPORTES UIAF (SES)	2023-09-19 16:51:31.931787	\N
227	2561	29	6	CARTA DE BIENVENIDA CABARCAS ALVAREZ JUAN PABLO	2023-09-19 17:56:59.879523	\N
230	2564	29	6	CARTA DE BIENVENIDA CLAVIJO BUSTOS PEDRO JULIO	2023-09-19 17:58:13.447464	\N
233	2567	119	6	RETIRO	2023-09-20 11:53:24.055415	\N
566	2900	121	4	Carta reporte abonos P.  48101 Myriam Roa De Barreto y otros	2023-10-20 09:15:28.091934	\N
571	2905	16	4	Aprobación cr CAMARGO SANCHEZ JESUS 	2023-10-20 11:48:09.053049	\N
576	2910	119	6	CARTA DE APROBACIÓN DE RETIRO- MARIN DELGADO ARIEL CARLOS	2023-10-20 18:07:12.85837	\N
581	2915	16	4	Aprobación cr Peñaranda Supelano Daniel ricardo 	2023-10-23 13:34:04.019551	\N
586	2920	32	4	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-24 09:09:27.181898	\N
591	2925	16	4	Aprobación cr CORREDOR PARDO DARIO	2023-10-24 15:27:23.198528	\N
596	2930	16	4	Aprobación cr ROJAS GUZMÁN LEIDY JULIET	2023-10-24 16:15:02.868988	\N
601	2935	16	4	Aprobación cr TAMAYO OSORIO RICARDO MAURICIO 	2023-10-24 16:17:52.813271	\N
606	2940	16	4	Aprobación cr HERRERA CORTES SERGIO ALBERTO	2023-10-25 11:56:39.22568	\N
611	2945	29	6	CARTA DE BIENVENIDA RAMOS JOVEL ANDRES ENRIQUE\r\n	2023-10-25 11:59:32.172456	\N
615	2949	29	6	CARTA DE BIENVENIDA MENDEZ RAMIREZ OLGA LUCIA	2023-10-25 12:02:45.831816	\N
619	2953	29	6	CARTA DE BIENVENIDA GOMEZ CASTAÑEDA ELVIS	2023-10-25 12:05:03.326435	\N
624	2958	29	6	CARTA DE BIENVENIDA RODRIGUEZ CASTAÑO JHON EDWIN	2023-10-25 12:15:28.804845	\N
628	2962	128	5	Solicitud Radicación Novedades Masivas	2023-10-25 15:27:34.387231	\N
632	2966	16	4	Aprobación Blue Card OJEDA MUÑOZ CAMILO	2023-10-26 10:58:09.023498	\N
635	2969	16	4	Aprobación cr MORENO MONROY ANTONIO 	2023-10-26 14:34:49.892233	\N
638	2972	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA SALAMANCA GONZALEZ LUIS GUILLERMO\r\n	2023-10-27 09:03:32.047891	\N
641	2975	16	4	Aprobación cr ZAMBRANO PARDO LILIANA 	2023-10-27 09:32:57.344451	\N
644	2978	29	6	CARTA DE BIENVENIDA ZARATE LUGO SYLVIA BIBIANA	2023-10-27 10:00:23.706144	\N
647	2981	29	6	CARTA DE BIENVENIDA CAICEDO BERDUGO ANDRES FELIPE	2023-10-27 10:01:52.357826	\N
649	2983	32	4	TRASL INTERNO BB RENTA YA A EXENTA BB	2023-10-27 11:14:16.380108	\N
651	2985	29	6	CARTA DE BIENVENIDA MARTINEZ BERNAL MARIA MARGARITA	2023-10-27 15:00:17.871197	\N
653	2987	37	4	PAZ Y SALVO SUAREZ QUICENO MONICA	2023-10-27 15:45:01.49129	\N
655	2989	119	6	CARTA DE BIENVENIDA- MURILLO SENCIAL ZAKIK	2023-10-27 16:47:47.826348	\N
438	2772	121	7	Certificación solicitada por la señora Mercedes Duarte para su declaración de Renta	2023-10-06 17:40:30.195045	\N
445	2779	32	4	TRASL INTERNO DE FIDUBBVA A BB AHO RENTA YA 	2023-10-09 12:02:55.401287	\N
453	2787	32	4	TRASL DE COLPATRIA AHO A CREDICORP	2023-10-11 07:51:08.978997	\N
460	2794	32	4	CIRCULARIZACION INVERSIONES-INCUBADORA EMP COLOMBIANA	2023-10-11 09:53:07.898533	\N
467	2801	32	7	CIRCULARIZACION INVERSIONES-IAC	2023-10-11 10:35:46.685693	\N
474	2808	32	7	\tCIRCULARIZACION INVERSIONES-BANCO COOPCENTRAL	2023-10-11 15:24:49.728465	\N
217	2551	32	4	TRASL INTERNO BANCO BOGOTA 	2023-09-19 11:59:58.554428	\N
481	2815	16	4	Aprobación cr TORRES MORENO BERTHA LILIANA	2023-10-11 18:09:17.529823	\N
488	2822	16	4	Aprobación cr GIRALDO GOMEZ JUAN ALEJANDRO	2023-10-12 17:27:05.626897	\N
495	2829	37	4	PAZ Y SALVO COMPRA VEHICULO  MORENO ROMERO CESAR EDUARDO	2023-10-13 11:47:09.278863	\N
502	2836	16	4	Aprobación cr RIVERA BARBOSA MARÍA ALEJANDRA  	2023-10-17 15:04:02.709721	\N
508	2842	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA CORREDOR RUIZ ALEJANDRA	2023-10-17 15:37:56.658427	\N
514	2848	119	6	CARTA APROBACIÓN DE RETIRO- MARTHA LUCÍA MINA RODRIGUEZ 	2023-10-18 09:07:02.256131	\N
520	2854	119	6	CARTA DE APROBACIÓN DE RETIRO- GABRIELA LUCIA SALAMANCA LEMOS 	2023-10-18 09:28:18.8529	\N
526	2860	119	6	CARTA DE BIENVENIDA- LOPEZ RODRIGUEZ JUAN CARLOS	2023-10-18 11:55:14.191761	\N
535	2869	16	4	Aprobación cr ARDILA GONZALEZ ANTONIO ALBERTO 	2023-10-19 08:51:39.697931	\N
540	2874	32	4	TRASL INTERNO DE COLPATRIA AHO A CREDICORP	2023-10-19 11:23:55.724125	\N
400	2734	16	4	APROBACIÓN BLUE CARD JAIME CORREA JAIRO	2023-10-04 15:24:21.65605	\N
405	2739	119	6	CARTA DE APROBACIÓN DE RETIRO YOLANDA CASTRO SALCEDO 	2023-10-05 08:55:28.714636	\N
410	2744	119	6	CARTA DE APROBACIÓN DE RETIRO SILVINO MARTIN MENDOZA 	2023-10-05 09:07:33.413134	\N
415	2749	119	6	CARTA DE APROBACIÓN DE RETIRO JOSE ANDRES ORDOÑEZ GUAQUETA	2023-10-05 09:11:36.018156	\N
420	2754	16	4	APROBACIÓN CR VANEGAS GARZON KAORY DANIELA	2023-10-05 11:45:11.095657	\N
425	2759	16	4	APROBACIÓN CR BRAVO SANCHEZ ANDREA LUCIA 	2023-10-05 15:11:14.44663	\N
430	2764	7	10	RESPUESTA DERECHO DE PETICIÓN ANA YAMILE PINEDA 	2023-10-05 19:26:39.685974	\N
435	2769	32	4	TRASL DE COLPATRIA AHO A CREDICORP	2023-10-06 10:07:45.316998	\N
396	2730	32	4	APERTURA CDT BANCOOMEVA FDO L	2023-10-04 12:27:11.986505	\N
267	2601	16	4	APROBACIÓN CR RAMIREZ MORENO BIBIANA	2023-09-25 10:40:16.623997	\N
270	2604	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-25 11:16:43.376009	\N
299	2633	30	5	SOLICITUD EXAMEN MEDICO OCUPACIONAL DE INGRESO	2023-09-27 13:53:11.31469	\N
302	2636	17	7	TRASLADO DE PSE A CTA AFINIDAD COOPCENTRAL	2023-09-28 08:26:55.841217	\N
305	2639	16	4	APROBACIÓN CR FLORES RONCANCIO VÍCTOR JULIO 	2023-09-28 08:54:33.246637	\N
308	2642	16	4	APROBACIÓN CR URREGO CASTIBLANCO FABIAN 	2023-09-28 10:13:32.409188	\N
311	2645	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-28 11:52:12.707233	\N
314	2648	16	4	APROBACIÓN CR ESTRADA ÁLVAREZ JAIRO HERNANDO  	2023-09-28 15:18:58.67462	\N
317	2651	29	6	CARTA DE BIENVENIDA INSTITUCION AUXILIAR DEL COOPERATIVISMO PARA EL BIENESTAR DE LOS ASOCIADOS DE COOPROFESORESUN	2023-09-28 17:17:57.01799	\N
320	2654	29	6	CARTA DE BIENVENIDA SANCHEZ HEREDIA ANA IMELDA	2023-09-28 17:20:48.774252	\N
323	2657	29	6	CARTA DE BIENVENIDA BARRERA MOJICA PIEDAD CONSTANZA	2023-09-28 17:21:49.839619	\N
326	2660	29	6	CARTA DE BIENVENIDA JARAMILLO TOCANCHON DAVID	2023-09-28 17:23:04.42201	\N
329	2663	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-29 09:10:54.435984	\N
349	2683	16	4	APROBACIÓN BLUE CARD CAMARGO CORTES GUILLERMO ARTURO	2023-10-02 10:29:45.852449	\N
353	2687	32	4	PROVISION EFECTIVO TESORERIA	2023-10-02 14:18:09.932696	\N
357	2691	29	6	CARTA DE BIENVENIDA CARRASCAL HERRERA ANA MARIA	2023-10-02 15:04:14.319021	\N
388	2722	10	3	SOLICITUD DE INFORMACIÓN	2023-10-03 17:41:50.766659	\N
546	2880	7	7	Respuesta derecho de petición Luz Yolanda Acuña González	2023-10-19 14:44:15.560599	\N
551	2885	14	4	Respuesta Derecho de petición Profesora Norma Chavarro	2023-10-19 16:01:30.453954	\N
556	2890	121	4	Carta reporte de abonos Hernán Javier Morales y otros Pagaré No.1315- 437	2023-10-20 07:39:10.870386	\N
562	2896	16	4	Aprobación cr Ibáñez Rincón Carolina 	2023-10-20 08:30:31.510132	\N
567	2901	121	4	Carta Reporte abonos P.7624 Lilia Stella Tarazona Romero y Diva Yanira Criollo Vargas	2023-10-20 09:26:43.88103	\N
572	2906	16	4	Aprobación cr PIMIENTO NELSON 	2023-10-20 11:48:53.740069	\N
577	2911	16	4	Aprobación cr RUIZ IZQUIERDO MARIA ALEJANDRA	2023-10-23 10:37:04.796482	\N
582	2916	16	4	Aprobación cr Riveros Riveros Sandra Rocio 	2023-10-23 13:34:51.393291	\N
587	2921	5	4	CERTIFICADO P.C.R.	2023-10-24 10:06:18.922464	\N
592	2926	16	4	Aprobación cr Tores Torres Libardo	2023-10-24 16:12:12.873087	\N
597	2931	16	4	Aprobación cr MORENO SOSA MARIBEL 	2023-10-24 16:15:26.17683	\N
602	2936	8	1	ORDEN DE COMPRA	2023-10-25 08:10:33.168572	\N
607	2941	16	4	Aprobación cr PEÑA DE TAMAYO TERESA DE JESUS 	2023-10-25 11:57:41.252455	\N
612	2946	29	6	CARTA DE BIENVENIDA HUERTAS MILLAN LUCIA	2023-10-25 12:00:18.904114	\N
616	2950	29	6	CARTA DE BIENVENIDA PERICO PULIDO HERNAN	2023-10-25 12:03:07.077947	\N
620	2954	29	6	CARTA DE BIENVENIDA MEDRANO BERMUDEZ JORGE ALFONSO	2023-10-25 12:11:43.45781	\N
625	2959	29	6	CARTA DE BIENVENIDA SMART FACTORING S.A.	2023-10-25 12:16:01.6174	\N
629	2963	37	4	CERTIFICADO DE DEUDA CREDITO AL DIA MATIZ MELO GERMAN EDUARDO	2023-10-26 08:43:35.555836	\N
633	2967	7	9	Solicitud de prorroga SANDRA PATRICIA BOHORQUEZ PIÑA	2023-10-26 11:26:26.117002	\N
636	2970	119	6	CERTIFICACIÓN DE NO ASOCIADOS COOPROFESORES	2023-10-26 15:50:56.128528	\N
639	2973	29	6	CARTA DE BIENVENIDA LEON NIETO DIEGO ISMAEL	2023-10-27 09:16:14.944924	\N
642	2976	16	4	Aprobación cr GOMEZ GUERRERO MANUEL EDUARDO	2023-10-27 09:33:44.520823	\N
645	2979	29	6	CARTA DE BIENVENIDA MORA TORRES SONIA GERALDINE	2023-10-27 10:00:52.476183	\N
439	2773	120	7	MEDICION Y SEGUIMIENTO CARTERA CON CORTE A SEPTIEMBRE DE 2023	2023-10-06 22:24:27.398594	\N
446	2780	8	1	Orden de Compra	2023-10-09 13:48:53.78472	\N
447	2781	8	1	Orden de Compra	2023-10-09 13:49:08.226317	\N
236	2570	119	6	RETIRO	2023-09-20 11:55:08.194504	\N
239	2573	16	7	APROBACIÓN CR MEJIA ACEVEDO MIGUEL ANGEL	2023-09-20 15:59:34.673285	\N
242	2576	16	7	APROBACIÓN CR RIVERA MORATO CLAUDIA PATRICIA	2023-09-20 17:22:53.089001	\N
245	2579	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA MONROY RODRIGUEZ CAMILO ANDRES 80873954	2023-09-21 11:52:15.349602	\N
248	2582	16	4	APROBACIÓN CR GALINDO CUERVO FLOR 	2023-09-21 15:19:40.454316	\N
251	2585	5	4	CERTIFICADO GERARDO RODRIGO IBAÑEZ FONSECA	2023-09-22 09:33:28.709336	\N
254	2588	32	4	CONSTITUCION CDT BANCOOMEVA	2023-09-22 11:54:26.951276	\N
257	2591	38	4	CERTIFICADO HIPOTECARIO 2022 - JORGE MARTINEZ CC 7226897  10-191008992 	2023-09-22 14:37:58.666263	\N
260	2594	29	6	CARTA DE BIENVENIDA ROLDAN GARCIA TULIA CONSTANZA	2023-09-22 15:01:53.640011	\N
263	2597	13	4	CARTA CHEQUE DE GERENCIA UNIVERSIDAD NACIONAL	2023-09-22 15:14:24.174729	\N
348	2682	16	4	ENTREGA DE PAGARÉ IAC A TESORERÍA 	2023-10-02 09:58:17.934654	\N
352	2686	38	4	CERTIFICADO CREDITO HIPOTECARIO COMERCIAL 10-211001792  BARBARA DE LAS MERCEDES MORENO MURILLO CC 41406699	2023-10-02 12:22:32.958471	\N
356	2690	29	6	CARTA DE BIENVENIDA DIAZ CASTILLO URIEL	2023-10-02 15:03:49.093587	\N
360	2694	16	4	APROBACIÓN CR BERMUDEZ NUR MIRABAI 	2023-10-02 15:45:32.090092	\N
364	2698	15	5	RESPUESTA SERVIDUMBRE PANDI. ÁREA DE INMUEBLES	2023-10-02 16:03:53.654406	\N
368	2702	30	5	CARTA RETIRO DE CESANTIAS	2023-10-03 08:32:52.321213	\N
372	2706	38	4	PAZ Y SALVO  ANIVERSARIO COOPROFESORESUN NO. 10– 211001723  DIANA MILENA GOMEZ MORENO  CC 1023910993 	2023-10-03 09:40:07.034556	\N
376	2710	29	6	CARTA DE BIENVENIDA GARZON SANTOS JUAN PABLO	2023-10-03 10:30:51.595534	\N
380	2714	29	6	CARTA DE BIENVENIDA CARDENAS LOBOGUERRERO DAMIAN	2023-10-03 10:32:22.999814	\N
384	2718	16	4	APROBACIÓN CR PACHÓN VALERO LIDA CAROLINA	2023-10-03 15:42:49.386368	\N
387	2721	10	3	SOLICITUD DE INFORMACION	2023-10-03 17:41:24.628418	\N
393	2727	37	4	CERTIFICADO CREDITO HIPOTECARIO CORTE 31 DE DICIEMBRE BAENA DOELLO JUAN DOMINGO AREA DE CARTERA	2023-10-04 09:01:38.920363	\N
361	2695	16	4	APROBACIÓN CR CARRERO ACEVEDO URIEL ANCIZAR	2023-10-02 15:46:15.542514	\N
365	2699	38	4	PAZ Y SALVO 11– 211000181  VILMA AMPARO GOMEZ PAVA  CC 36176946 	2023-10-02 16:16:47.809053	\N
369	2703	30	5	CARTA SOLICITUD EXÁMENES MÉDICOS DE EGRESO	2023-10-03 08:33:24.76454	\N
373	2707	5	4	CERTIFICADO DAVID ERNESTO PUENTES LAGOS	2023-10-03 10:06:29.176469	\N
377	2711	29	6	CARTA DE BIENVENIDA PABON  LEIDY OMAIRA	2023-10-03 10:31:15.19421	\N
381	2715	29	6	CARTA DE BIENVENIDA ZAMBRANO ACOSTA INGRID	2023-10-03 10:32:43.011885	\N
385	2719	16	4	APROBACIÓN CR JARAMILLO TOCANCHON DAVID	2023-10-03 15:44:50.923484	\N
389	2723	10	3	SOLICITUD DE INFORMACIÓN	2023-10-03 17:41:58.580425	\N
390	2724	10	3	SOLICITUD DE INFORMACIÓN	2023-10-03 17:42:06.011493	\N
394	2728	16	4	APROBACIÓN CR RINCON NOGUERA DIANA CAROLINA	2023-10-04 11:34:27.010243	\N
401	2735	126	7	CARTA APOYO  FESTIVAL FOLCLORICO "DEJANDO HUELLA"	2023-10-04 15:31:00.006383	\N
406	2740	119	7	CARTA DE APROBACIÓN DE RETIRO NANCY MOGOLLON CADENA	2023-10-05 08:56:21.517708	\N
411	2745	119	6	CARTA DE APROBACIÓN DE RETIRO LUIS ENRIQUE FLOREZ ALARCON	2023-10-05 09:08:08.280196	\N
416	2750	37	4	CERTIFICADO CREDITO HIPOTECARIO CORTE 31 DE DICIEMBRE VARGAS SANCHEZ JENNY ASTRID	2023-10-05 09:37:54.354144	\N
421	2755	120	4	CERTIFICACION PAGO SEPTIEMBRE 27 GLORIA LIGIA CUELLAR	2023-10-05 11:52:18.40051	\N
426	2760	16	4	APROBACIÓN CR MESA CARO LAURA VICTORIA	2023-10-05 16:59:00.212247	\N
431	2765	16	4	APROBACIÓN CR DUARTE MARTINEZ LUZ ANGELICA	2023-10-06 09:05:53.890208	\N
312	2646	5	4	CERTIFICADO CAMILO ANTONIO MONROY PEÑA	2023-09-28 14:48:58.552514	\N
332	2666	16	4	APROBACIÓN CR RODRIGUEZ SIERRA DORA ALBA 	2023-09-29 10:24:25.472336	\N
335	2669	16	4	APROBACIÓN CR  VASQUEZ MENDOZA ALMA RAQUEL	2023-09-29 13:50:32.814562	\N
273	2607	15	7	CARTA A AVIA SEGRUOS	2023-09-25 16:58:25.689812	\N
276	2610	16	4	APROBACIÓN CR NAVARRO DE MORALES AMPARO 	2023-09-25 17:15:16.742114	\N
279	2613	37	7	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA CORREDOR ESPINEL VLADIMIR	2023-09-26 09:26:11.461369	\N
282	2616	16	4	APROBACIÓN CR BERNAL POVEDA CAMPO ELIAS  	2023-09-26 10:07:01.118662	\N
285	2619	32	4	TRASLADO A FONVAL CREDICORP FIC	2023-09-26 11:15:25.782574	\N
397	2731	125	4	RESPUESTA PQR LUIS ROBERTO MARTINEZ MUÑOZ	2023-10-04 12:34:55.106381	\N
288	2622	29	6	CARTA DE BIENVENIDA RODRIGUEZ BLANCO ANDREA LUCERO	2023-09-26 11:43:44.597808	\N
291	2625	29	6	CARTA DE BIENVENIDA SOLANO CARDENAS JANETH TATIANA	2023-09-26 11:45:20.854385	\N
294	2628	29	6	CARTA DE BIENVENIDA LEYTON BASTIDAS JULIO WILFREDO	2023-09-26 15:35:29.116009	\N
265	2599	16	4	APROBACIÓN CR VASQUEZ MENDOZA EVELYN 	2023-09-22 15:49:03.348437	\N
454	2788	16	4	Aprobación cr DIAZ ORTEGON JOHN ALEXANDER	2023-10-11 08:50:40.157063	\N
461	2795	32	7	CIRCULARIZACION INVERSIONES-ASOCIACION COLOMBIANA DE COOPERATIVAS-ASCOOP	2023-10-11 09:56:04.858425	\N
468	2802	119	6	CARTA DE BIENVENIDA ASOCIADO JUAN SEBASTIAN GUTIERREZ RAMOS 	2023-10-11 11:53:20.74491	\N
475	2809	32	7	CIRCULARIZACION INVERSIONES-COOPERACION VERDE SA	2023-10-11 15:25:16.4775	\N
482	2816	16	4	Aprobación cr MARTINEZ CASTRO JOSE ORLANDO	2023-10-11 18:14:46.677396	\N
489	2823	16	4	Aprobación cr PABON  LEIDY OMAIRA	2023-10-12 17:32:43.46658	\N
496	2830	32	4	PROVISION EFECTIVO	2023-10-13 14:51:25.457025	\N
503	2837	16	4	Aprobación cr TORRES CARDENAS ALICIA 	2023-10-17 15:04:32.686808	\N
509	2843	42	7	Terminación del contrato de aprendizaje por vencimiento del término pactado.	2023-10-17 16:20:00.305409	\N
515	2849	119	6	CARTA DE APROBACIÓN DE RETIRO-FABIAN ENRIQUE VILAR RUBIANO	2023-10-18 09:09:05.456547	\N
521	2855	119	6	CARTA DE BIENVENIDA- RIVEROS RIVEROS SANDRA ROCIO\r\n	2023-10-18 11:53:00.746234	\N
541	2875	32	4	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-19 11:57:31.113172	\N
440	2774	13	7	CARTA CHEQUE DE GERENCIA U. NACIONAL 	2023-10-09 07:56:38.890353	\N
448	2782	42	5	Solicitud examen médico de ingreso.	2023-10-10 07:35:19.892522	\N
455	2789	16	4	Aprobación cr GUEVARA PEÑALOZA LAURA XIMENA	2023-10-11 09:02:22.549796	\N
462	2796	32	7	\tCIRCULARIZACION INVERSIONES-BANCO COOPCENTRAL	2023-10-11 09:59:40.006674	\N
469	2803	119	6	CARTA DE BIENVENIDA ASOCIADO VANOY LUQUE IVAN GIOVANNI	2023-10-11 11:54:14.882261	\N
476	2810	32	7	CIRCULARIZACION INVERSIONES-PROMOTORA DE PROYECTOS AMBIENTALES	2023-10-11 15:26:07.917937	\N
483	2817	16	4	Aprobación cr TOLOZA AYALA ZEGELLA	2023-10-11 18:21:36.205067	\N
490	2824	16	7	Aprobación cr CHARA CALVACHE MARLYN ALEXANDRA	2023-10-13 07:53:05.372501	\N
497	2831	5	4	CERTIFICADO PEDRO CALIXTO ROBERTO PATARROYO GAMA	2023-10-17 08:32:57.197144	\N
504	2838	16	4	Aprobación cr APONTE MOTTA JORGE MARIO 	2023-10-17 15:05:13.581553	\N
510	2844	5	4	CERTIFICADO FANNY HERNANDEZ GARCIA	2023-10-18 08:05:13.053682	\N
516	2850	119	6	CARTA DE APROBACIÓN DE RETIRO- ROBERTO FERNANDO BECERRA TORRES 	2023-10-18 09:09:53.587871	\N
522	2856	119	6	CARTA DE BIENVENIDA- BELTRAN ALFONSO MANUEL JOSE 	2023-10-18 11:53:28.503592	\N
527	2861	119	6	CARTA DE BIENVENIDA-BALLESTEROS CELIS BRIGITH DAYANA 	2023-10-18 11:55:44.226357	\N
536	2870	16	4	Aprobación cr Dueñas Pinto Ramiro Javier	2023-10-19 08:53:20.049641	\N
542	2876	32	7	CARTA CANCELACION CUENTA BBVA AHORROS	2023-10-19 13:46:08.962483	\N
547	2881	42	5	RESPUESTA A DERECHO DE PETICIÓN.	2023-10-19 15:38:22.65839	\N
552	2886	13	7	CARTA CHEQUE DE GERENCIA COMPENSAR	2023-10-19 16:13:31.293631	\N
557	2891	121	4	Carta Reporte de Pago José Vicente Cruz García P. 37673 	2023-10-20 08:01:21.071381	\N
563	2897	121	4	Carta Reporte de Abonos Luis Felipe Cruz Rodríguez  P. 1697-3196	2023-10-20 08:40:58.454304	\N
568	2902	121	4	Carta Reporte de Pago P. 6915 GIOVANNI ROMERO PEREZ	2023-10-20 09:35:42.24901	\N
573	2907	16	4	Aprobación cr SANTOS SAENZ GUILLERMO ARTURO	2023-10-20 11:49:25.575206	\N
578	2912	10	3	ENTREGA DE ESCRITURAS- UNION A CARTERA	2023-10-23 11:56:04.576996	\N
583	2917	129	2	Respuesta memorando Solicitud información SARLAFT III Trimestre 2023	2023-10-23 14:22:26.575612	\N
588	2922	5	4	CERTIFICADO GLADYS ARIZA CUBIDES	2023-10-24 10:06:48.97752	\N
593	2927	16	4	Aprobación cr PARRA MARTINEZ CLARA INES 	2023-10-24 16:13:05.660153	\N
598	2932	16	4	Aprobación cr URREGO ARIAS ELIZABETH 	2023-10-24 16:16:23.430125	\N
603	2937	32	4	REDENCION CDT FL 1991512 COOPCENTRAL\r\n	2023-10-25 11:49:19.013969	\N
608	2942	16	4	Aprobación cr RODRÍGUEZ ESPINOSA PABLO	2023-10-25 11:58:28.193457	\N
613	2947	29	6	CARTA DE BIENVENIDA GUERRERO CASTELLANOS CAMILA 	2023-10-25 12:01:37.910366	\N
617	2951	29	6	CARTA DE BIENVENIDA MEZA CASTILLO MIGUEL JACINTO	2023-10-25 12:03:29.542248	\N
621	2955	29	6	CARTA DE BIENVENIDA RODRIGUEZ OLIVERA ALDERSON	2023-10-25 12:12:04.317588	\N
622	2956	29	6	CARTA DE BIENVENIDA BECERRA OSTOS LUISA FERNANDA	2023-10-25 12:12:27.066357	\N
626	2960	7	7	Respuesta solicitud de auxilio JAIRO ANTONIO GARCÍA SUESCA	2023-10-25 12:33:49.357605	\N
630	2964	16	4	Aprobación Blue card GUEVARA PEÑALOZA LAURA XIMENA	2023-10-26 10:49:53.638086	\N
634	2968	121	4	Carta de Cobro William Amílcar Daza 26/10/2023	2023-10-26 11:52:24.513525	\N
637	2971	37	4	PAZ Y SALVO SALAMANCA GONZALEZ LUIS GUILLERMO	2023-10-27 08:55:58.563876	\N
640	2974	16	4	Aprobación cr ANTOLINEZ CACERES ANA ISBELIA	2023-10-27 09:27:10.71687	\N
643	2977	29	6	CARTA DE BIENVENIDA TORRES PINZÓN MICHAEL NICOLÁS	2023-10-27 09:59:50.036182	\N
646	2980	29	6	CARTA DE BIENVENIDA SERRANO SANABRIA SANDRA LILIANA	2023-10-27 10:01:30.515634	\N
648	2982	29	6	CARTA DE BIENVENIDA JARA GUTIERREZ NICOLAS	2023-10-27 10:02:23.651047	\N
650	2984	38	4	certificado de deuda MONICA SUAREZ QUICENO cc 30330343 crédito 10- 231000285 	2023-10-27 11:15:33.983688	\N
652	2986	120	4	respuesta solicitud periodo de gracia Adriana Alder 	2023-10-27 15:39:04.441504	\N
654	2988	119	6	CARTA DE BIENVENIDA- RAMOS JOVEL ANDRES ENRIQUE 	2023-10-27 16:44:11.610253	\N
656	2990	119	6	CARTA DE BIENVENIDA- HUERTAS MILLAN LUCIA 	2023-10-27 16:48:47.516168	\N
657	2991	119	6	CARTA DE BIENVENIDA- GUERRERO CASTELLANOS CAMILA 	2023-10-27 16:50:32.3491	\N
658	2992	16	4	Aprobación cr BELTRÁN ALFONSO MANUEL  	2023-10-27 17:00:43.380199	\N
659	2993	16	4	Aprobación cr VILLATE BOLIVAR OROMACIO	2023-10-27 17:01:29.272298	\N
660	2994	16	4	Aprobación cr RODRIGUEZ MUÑOZ EDUARDO	2023-10-27 17:01:53.342269	\N
661	2995	16	4	Aprobación cr MOJICA CARDOZO CLARA	2023-10-27 17:02:11.813661	\N
662	2996	16	4	Aprobación cr CORREA HERRAN ALBERTO	2023-10-27 17:02:34.63137	\N
663	2997	16	4	Aprobación cr ZARATE MARTINEZ ALBERTO	2023-10-27 17:02:55.866288	\N
664	2998	16	4	Aprobación cr HERNANDEZ CORTES MARGARITA 	2023-10-27 17:03:19.726372	\N
665	2999	16	4	Aprobación cr CELY RODRIGUEZ ALEXANDER	2023-10-27 18:18:16.024804	\N
666	3000	130	4	CARTA CRÉDITO COMERCIAL	2023-10-30 10:03:57.447805	\N
667	3001	32	4	PROVISION EFECTIVO	2023-10-30 10:06:49.749638	\N
668	3002	37	4	CERTIFICADO DE DEUDA CREDITO AL DIA PINEDA TORRES NORHA ESPERANZA	2023-10-30 14:06:14.34277	\N
669	3003	16	4	Aprobación cr MALAMBO LILIANA	2023-10-30 16:31:26.0772	\N
670	3004	16	4	Aprobación cr VANEGAS DE AHOGADO BLANCA CECILIA 	2023-10-30 16:32:07.6587	\N
671	3005	16	4	Aprobación cr RODRIGUEZ CASTAÑO JHON EDWIN	2023-10-30 16:32:57.549776	\N
672	3006	16	4	Aprobación cr FONSECA GARZÓN PATRICIA 	2023-10-30 16:33:30.329197	\N
673	3007	16	4	Aprobación cr BALLESTEROS PEREZ JUAN DAVID	2023-10-30 16:33:56.348406	\N
674	3008	121	7	Atención derecho de petición Clarita Franco de Machado y Luis Eduardo Machado, 9 de octubre de 2023	2023-10-30 18:16:26.29838	\N
675	3009	7	7	Carta de compromiso de desembolso Helber De Jesús Barbosa 	2023-10-30 18:21:04.930463	\N
676	3010	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-31 09:09:06.36968	\N
441	2775	125	4	Radicado Work-manager 449657, no aplicación de cobros de póliza año 2021	2023-10-09 08:08:03.869807	\N
449	2783	127	5	Carta Solicitud Radiación Novedades Masivas Sanitas	2023-10-10 09:14:55.380958	\N
456	2790	32	4	CIRCULARIZACION INVERSIONES-LA EQUIDAD S O.C.	2023-10-11 09:33:19.310299	\N
463	2797	32	7	CIRCULARIZACION INVERSIONES-PROMOTORA DE PROYECTOS AMBIENTALES	2023-10-11 10:08:46.456126	\N
470	2804	119	6	CARTA DE BIENVENIDA ASOCIADA LUZ MARINA LEON MONTENEGRO	2023-10-11 11:56:03.195734	\N
477	2811	5	4	CERTIFICADO NOHORA STELLA DIAZ CUBILLOS	2023-10-11 15:50:40.306458	\N
484	2818	16	4	Aprobación cr GONZALEZ TIQUE SERGIO LEONARDO	2023-10-12 09:37:51.38018	\N
491	2825	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-13 08:39:29.556955	\N
498	2832	37	4	CERTIFICADO CREDITO HIPOTECARIO CORTE 31 DE DICIEMBRE PERILLA BURBANO SOLVEY JANETH	2023-10-17 09:15:12.047987	\N
505	2839	16	4	Aprobación cr MALDONADO PACHÓN HERNANDO 	2023-10-17 15:05:52.696656	\N
511	2845	16	7	Aprobación cr GARCIA CASTAÑEDA AMAURY	2023-10-18 08:17:04.789434	\N
517	2851	119	6	CARTA DE APROBACIÓN DE RETIRO-LENYN ALEJANDRO URUEÑA LÓPEZ\r\n	2023-10-18 09:11:14.960928	\N
523	2857	119	6	CARTA DE BIENVENIDA- ORTEGA QUICASAN CLAUDIA MARCELA 	2023-10-18 11:53:54.31208	\N
528	2862	16	4	Aprobación cr RINCON QUIJANO EDGARD 	2023-10-18 14:29:56.29144	\N
532	2866	16	4	RPTA CONTROL INTERNO PAGARÉS 	2023-10-18 15:04:31.321729	\N
537	2871	5	4	CERTIFICADO MARIA AMPARO IBAÑEZ DE MONTAÑA	2023-10-19 10:10:55.371873	\N
543	2877	32	7	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-19 13:58:57.749157	\N
548	2882	16	4	Aprobación cr VELANDIA UYABAN ADERSON DUBAN	2023-10-19 15:44:10.479417	\N
553	2887	121	4	Carta reporte de honorarios Daniel Alberto Libreros Caicedo,  julio y agosto 2023	2023-10-19 17:45:46.690256	\N
216	2550	42	7	PREVENCIÓN SOBRE ACOSO SEXUAL	2023-09-19 11:57:16.235557	\N
219	2553	16	4	ENTREGA DE PAGARÉS A TESORERÍA 	2023-09-19 14:35:19.597211	\N
222	2556	15	7	BUITRAGO Y ASOCIADOS - SERVICIOS PROFESIONALES DECLARACIÓN DE RENTA 2019	2023-09-19 15:09:05.37446	\N
225	2559	29	6	CARTA DE BIENVENIDA AREVALO QUIÑONES WILLIAM FERNANDO	2023-09-19 17:55:40.78893	\N
228	2562	29	6	CARTA DE BIENVENIDA LEGUZAMON CARDENAS LUIS GERMAN	2023-09-19 17:57:24.805596	\N
231	2565	29	6	CARTA DE BIENVENIDA ANGEL DAVILA JUAN CARLOS	2023-09-19 17:58:32.175704	\N
234	2568	119	6	RETIRO	2023-09-20 11:54:21.984673	\N
237	2571	119	6	RETIRO	2023-09-20 11:55:54.493154	\N
240	2574	16	7	APROBACIÓN CR BAQUERO ZAMUDIO JUAN DAVID	2023-09-20 16:00:09.926952	\N
243	2577	38	4	PAZ Y SALVO MARIA GLORIA ZGAIBA CC: 20565540 -  CRÉDITO ORDINARIO DE INVERSION LIBRE NO. 10– 231000492	2023-09-21 08:37:16.306399	\N
246	2580	16	7	APROBACIÓN CR MARTINEZ PULIDO PAOLA	2023-09-21 14:10:41.91859	\N
249	2583	16	4	APROBACIÓN CR PEREA SABOGAL JUAN FRANCISCO	2023-09-21 16:41:24.722035	\N
252	2586	32	4	REDENCION CDT FALABELLA 433004	2023-09-22 11:42:13.744517	\N
255	2589	30	5	CONCESIÓN DE VACACIONES	2023-09-22 12:29:33.18992	\N
258	2592	29	6	CARTA DE BIENVENIDA ACOSTA MALAGON JOSE ELVER	2023-09-22 15:00:35.430664	\N
261	2595	29	6	CARTA DE BIENVENIDA DIAZ ORTEGON JOHN ALEXANDER	2023-09-22 15:02:18.311253	\N
268	2602	16	4	APROBACIÓN CR RAMIREZ GUARIN OLGA LUCIA 	2023-09-25 10:41:02.174582	\N
271	2605	13	4	CARTA CHEQUE DE GERENCIA COMPENSAR	2023-09-25 14:10:05.466702	\N
297	2631	16	4	APROBACIÓN CR CHAPPE CHAPPE ANGELICA 	2023-09-26 17:33:08.003033	\N
300	2634	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-27 15:07:41.991771	\N
303	2637	16	4	APROBACIÓN CR MORENO RODRIGUEZ MARIA CRISTINA	2023-09-28 08:52:52.48193	\N
306	2640	32	4	PROVISION EFECTIVO TESORERIA\r\n	2023-09-28 09:37:44.571798	\N
309	2643	122	8	RESPUESTA A DERECHO DE PETICIÓN MIGUEL ANGEL VERA	2023-09-28 10:36:32.23611	\N
315	2649	5	4	CERTIFICADO AURELIANO HERNANDEZ VASQUEZ	2023-09-28 15:40:34.84561	\N
247	2581	30	5	SOLICITUD EXAMEN MEDICO OCUPACIONAL DE INGRESO	2023-09-21 14:58:21.252399	\N
250	2584	16	4	APROBACIÓN CR ORTIZ GOMEZ ISABEL CRISTINA	2023-09-22 08:53:46.261248	\N
253	2587	17	7	TRASLADO DE RENTAYA A EXENTA	2023-09-22 11:53:54.521173	\N
256	2590	30	5	SOLICITUD EXAMEN MEDICO OCUPACIONAL DE INGRESO	2023-09-22 12:31:40.803593	\N
259	2593	29	6	CARTA DE BIENVENIDA CRUZ IBAÑEZ ANGELA VIVIANA	2023-09-22 15:01:23.797936	\N
262	2596	29	6	CARTA DE BIENVENIDA DAVIA CASTILLO MARIA TERESA CLEMENCIA	2023-09-22 15:02:42.839809	\N
269	2603	32	4	PROVISION EFECTIVO TESORERIA	2023-09-25 11:14:45.80869	\N
558	2892	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-20 08:23:28.2297	\N
564	2898	121	4	Carta reporte de abonos P. 1943-2568, Herbert Giraldo Gómez y otro	2023-10-20 09:01:44.070916	\N
569	2903	119	6	CARTA DE BIENVENIDA- BAYUELO SIERRA ALFREDO JOSE \r\n	2023-10-20 10:44:03.052093	\N
574	2908	7	7	Derecho de petición dirigido a EMPRESA DE ACUEDUCTO Y ALCANTARILLADO DE BOGOTA E.S.P.	2023-10-20 15:05:07.958327	\N
579	2913	16	4	Aprobación cr PATARROYO MURILLO MANUEL ELKIN	2023-10-23 12:17:46.929404	\N
584	2918	32	4	\tPROVISION EFECTIVO	2023-10-23 14:32:24.942059	\N
589	2923	32	4	TRASLADO ENTRE CTAS BB	2023-10-24 15:13:52.306133	\N
594	2928	16	4	Aprobación cr SÁNCHEZ PALOMINO PEDRO 	2023-10-24 16:13:37.494125	\N
599	2933	16	4	Aprobación cr LOZANO GUARNIZO JAIRO	2023-10-24 16:16:49.250392	\N
604	2938	32	4	CONST CDT FINANDINA VIENE DE COOPCENTRAL	2023-10-25 11:50:41.118212	\N
609	2943	29	6	CARTA DE BIENVENIDA GOMEZ GUERRERO MANUEL EDUARDO	2023-10-25 11:58:54.056052	\N
610	2944	16	4	Aprobación BLUE CARD VERGARA NAVARRO ERIKA	2023-10-25 11:59:03.307851	\N
614	2948	29	6	CARTA DE BIENVENIDA MURILLO SENCIAL ZAKIK	2023-10-25 12:02:21.215619	\N
618	2952	29	6	CARTA DE BIENVENIDA SABOYA CORTES GINA PAOLA	2023-10-25 12:03:55.473292	\N
623	2957	29	6	CARTA DE BIENVENIDA BECERRA OSTOS LUISA FERNANDA	2023-10-25 12:12:49.186244	\N
627	2961	42	5	Inscripción empresa a proceso masivo de radicación de novedades	2023-10-25 15:17:32.820475	\N
631	2965	16	4	Aprobación cr RESTREPO FORERO GABRIEL	2023-10-26 10:50:42.704823	\N
339	2673	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:24.883724	\N
340	2674	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:34.653475	\N
341	2675	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:44.404246	\N
342	2676	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:49.995543	\N
343	2677	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:55.808876	\N
344	2678	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:19:00.909341	\N
345	2679	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:19:06.571095	\N
274	2608	16	4	APROBACIÓN CR CUBILLOS LEAL CARLOS ALBERTO	2023-09-25 17:14:08.651001	\N
277	2611	16	4	APROBACIÓN CR ZUÑIGA REYES  DAGHELY GIOVANNA	2023-09-25 18:28:45.910648	\N
280	2614	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA CORREDOR ESPINEL VLADIMIR (SE CORRIGE DEPENDENCIA)	2023-09-26 09:28:37.917882	\N
283	2617	16	4	APROBACIÓN GUERRERO FAJARDO CARLOS ALBERTO	2023-09-26 10:07:47.911794	\N
286	2620	16	4	APROBACIÓN CR CHICA ARIAS CARLOS ALBERTO	2023-09-26 11:42:22.164977	\N
289	2623	29	6	CARTA DE BIENVENIDA URREGO BARRETO GUSTAVO	2023-09-26 11:44:25.132884	\N
292	2626	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-26 11:48:31.707886	\N
295	2629	16	4	APROBACIÓN CR HERRERA GONZALEZ GUSTAVO	2023-09-26 15:46:29.83212	\N
298	2632	16	4	APROBACIÓN CR GARCIA OROZCO FERNANDO MANUEL 	2023-09-26 17:33:43.928233	\N
214	2548	32	4	RESPUESTA REQUERIMIENTO CONTROL INTERNO DCI 2314	2023-09-19 07:28:00.881121	\N
220	2554	15	7	TRIBUTAR ASESORES SAS-SERVICIOS PROFESIONALES DECLARACIÓN DE RENTA 2019	2023-09-19 15:07:29.5598	\N
223	2557	5	4	CERTIFICADO ALVARO DUARTE RUIZ	2023-09-19 15:55:04.790704	\N
226	2560	29	6	CARTA DE BIENVENIDA CASTELBLANCO RAMOS MANUEL ANTONIO	2023-09-19 17:56:12.973964	\N
229	2563	29	6	CARTA DE BIENVENIDA MURCIA DE MARTINEZ CONSTANZA ROSA	2023-09-19 17:57:49.941902	\N
232	2566	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-20 11:44:10.241709	\N
235	2569	119	6	RETIRO	2023-09-20 11:54:48.684158	\N
238	2572	16	7	APROBACIÓN CR CASTILLO REINA JOSE FERNANDO	2023-09-20 15:58:29.552611	\N
241	2575	15	7	ADJUDICACIÓN COLECTIVA DE AUTOMÓVILES ZURICH	2023-09-20 17:01:19.628694	\N
244	2578	16	7	APROBACIÓN CRÉDITO QUEVEDO BLANCO JOSE DAVID	2023-09-21 11:31:28.608655	\N
266	2600	120	7	PODER RECLAMACIÓN TITULOS JUDICIALES HERBERT GIRALDO GÓMEZ, ROSA MILENA DIAZ BOBADILLA Y LUIS ENRIQUE GIL TORRES 201600348	2023-09-22 16:51:19.687941	\N
301	2635	16	4	APROBACIÓN CR PÉREZ CRISTANCHO LUZ ANGELA	2023-09-27 15:16:26.489093	\N
304	2638	16	4	APROBACIÓN CR RODRÍGUEZ NÚÑEZ ANDRÉS FELIPE 	2023-09-28 08:53:52.893985	\N
307	2641	38	4	PAZ Y SALVO LEVANTAMIENTO DE HIPOTECA JAIRO JAIME CORREA  CC 7223613  CRÉDITO 10– 12112007131 	2023-09-28 09:43:09.280797	\N
310	2644	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-28 11:51:45.142658	\N
313	2647	16	4	APROBACIÓN CR BAQUERO GARCIA CARLOS MAURICIO	2023-09-28 14:50:26.058303	\N
316	2650	29	6	CARTA DE BIENVENIDA VASQUEZ MENDOZA ALMA RAQUEL	2023-09-28 17:16:45.234091	\N
319	2653	29	6	CARTA DE BIENVENIDA MANCERA RODRIGUEZ  MATEO	2023-09-28 17:19:12.617753	\N
322	2656	29	6	CARTA DE BIENVENIDA ROJAS LOPEZ MARTA LUCIA	2023-09-28 17:21:28.756563	\N
325	2659	29	6	CARTA DE BIENVENIDA BARRERA MOJICA LINA PATRICIA	2023-09-28 17:22:39.611501	\N
328	2662	38	4	CERTIFICADO HIPOTECARIO 2022 MELLIZO ROJAS WILSON HERNEY CC 79649177 CRÉDITO 10- 221000288 	2023-09-29 08:59:44.568447	\N
331	2665	16	4	APROBACIÓN BLUE CARD PEREZ CRISTANCHO LUZ ANGELA	2023-09-29 10:20:43.540107	\N
334	2668	16	4	APROBACIÓN CR AREVALO QUIÑONES WILLIAM FERNANDO	2023-09-29 13:34:42.806579	\N
346	2680	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-29 15:13:28.829746	\N
350	2684	16	4	APROBACIÓN BLUE CARD MAHECHA ESPINOSA YANETH ISABEL	2023-10-02 11:36:12.364197	\N
354	2688	16	4	APROBACIÓN CR BASTO MERCADO JOSE ORMINSO	2023-10-02 14:52:26.546508	\N
358	2692	29	6	CARTA DE BIENVENIDA PINZON BUSTAMANTE MARIA ALEJANDRA	2023-10-02 15:05:18.284341	\N
362	2696	16	4	APROBACIÓN BLUE CARD AREVALO QUIÑONES WILLIAM FERNANDO 	2023-10-02 15:47:19.176837	\N
366	2700	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-03 08:12:33.26645	\N
370	2704	30	5	REMISIÓN DE APORTES	2023-10-03 08:35:19.906233	\N
374	2708	16	4	APROBACIÓN CR ROJAS CORREAL LUISA INES	2023-10-03 10:19:46.278288	\N
378	2712	29	6	CARTA DE BIENVENIDA RUIZ IZQUIERDO MARIA ALEJANDRA	2023-10-03 10:31:36.120286	\N
382	2716	29	6	CARTA DE BIENVENIDA MORENO CORTES FANNY JULYANNA	2023-10-03 11:00:09.537395	\N
391	2725	10	3	SOLICITUD DE INFORMACIÓN	2023-10-03 17:42:22.738393	\N
402	2736	5	4	CERTIFICADO P.C.R.	2023-10-04 15:57:46.172458	\N
407	2741	119	6	CARTA DE APROBACIÓN DE RETIRO LUZ MARY PRADA HERNANDEZ	2023-10-05 08:57:22.618611	\N
412	2746	119	6	CARTA DE APROBACIÓN DE RETIRO DIANA ZULIMA URREGO MENDOZA	2023-10-05 09:08:45.737308	\N
417	2751	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GOMEZ PADILLA MIGUEL JESUS	2023-10-05 10:03:20.390364	\N
422	2756	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-10-05 12:43:06.942956	\N
427	2761	29	6	CARTA DE BIENVENIDA CARVAJAL CAMACHO SORAYA ANDREA	2023-10-05 17:32:33.58875	\N
432	2766	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-06 09:12:23.793648	\N
442	2776	32	4	TRASL DE COLPATRIA AHO A CREDICORP	2023-10-09 08:26:48.073028	\N
450	2784	127	5	Carta Inscripción Empresa a Proceso Masivo de Radicación Novedades EPS Sanitas	2023-10-10 09:46:22.432476	\N
457	2791	32	4	CIRCULARIZACION INVERSIONES-LA EQUIDAD SG O.C.	2023-10-11 09:35:48.961967	\N
464	2798	32	7	CIRCULARIZACION INVERSIONES-COOPERACION VERDE SA	2023-10-11 10:18:37.557257	\N
471	2805	119	6	CARTA DE BIENVENIDA ASOCIADO NELSON PIMIENTO	2023-10-11 11:56:35.797374	\N
478	2812	5	4	CERTIFICADO MARIA CAROLINA MEJIA HERNANDEZ	2023-10-11 17:14:46.346458	\N
485	2819	119	6	CARTA DE BIENVENIDA ASOCIADO VELANDIA UYABAN ADERSON DUBAN	2023-10-12 09:44:48.323744	\N
492	2826	32	4	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-13 09:57:15.416009	\N
499	2833	37	4	PAZ Y SALVO ARTEAGA NAVARRO ESTEFANIA	2023-10-17 10:33:01.193849	\N
529	2863	16	4	Aprobación cr VERGARA NAVARRO ERIKA	2023-10-18 14:32:09.23239	\N
677	3011	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA PERILLA BURBANO SOLVEY JANETH	2023-10-31 10:21:59.371851	\N
678	3012	37	4	CERTIFICADO DE DEUDA CREDITO AL DIA  SPATIUM VC S.A.S	2023-10-31 10:55:11.23667	\N
679	3013	7	7	Respuesta derecho de petición LUIS EDUARDO MACHADO HÉRNANDEZ y \r\nCLARITA FRANCO LEÓN DE MACHADO\r\n	2023-10-31 11:11:14.624412	\N
680	3014	13	7	CARTA CHEQUE DE GERENCIA COMPENSAR	2023-10-31 11:26:27.819242	\N
681	3015	10	3	Solicitud de información 	2023-10-31 11:31:47.334559	\N
682	3016	10	3	Solicitud de información	2023-10-31 11:31:59.005466	\N
683	3017	10	3	Solicitud de información	2023-10-31 11:32:14.546845	\N
684	3018	10	3	Solicitud de información	2023-10-31 11:32:21.306072	\N
685	3019	10	3	Solicitud de información	2023-10-31 11:32:26.94485	\N
686	3020	10	3	Solicitud de información	2023-10-31 11:32:33.02991	\N
687	3021	10	3	Solicitud de información	2023-10-31 11:32:39.525139	\N
688	3022	10	3	Solicitud de información	2023-10-31 11:33:11.549625	\N
689	3023	10	3	Solicitud de información	2023-10-31 11:33:23.285032	\N
690	3024	10	3	Solicitud de información	2023-10-31 11:33:34.28678	\N
691	3025	10	3	Solicitud de información	2023-10-31 11:33:45.554754	\N
692	3026	10	3	Solicitud de información	2023-10-31 11:33:58.145637	\N
693	3027	10	3	Solicitud de información	2023-10-31 11:34:12.046164	\N
694	3028	10	3	Solicitud de información	2023-10-31 11:34:17.550633	\N
695	3029	16	4	Aprobación cr MORA RODRIGUEZ FELIPE EDUARDO	2023-10-31 12:06:05.13502	\N
696	3030	119	6	CARTA DE APROBACIÓN DE RETIRO- MARGARITA GIRALDO MONTEALEGRE 	2023-10-31 12:48:28.146587	\N
697	3031	119	6	CARTA DE APROBACIÓN DE RETIRO POR FALLECIMIENTO- LINDA ROCÍO GARCÍA JIMENEZ	2023-10-31 12:55:57.1549	\N
698	3032	119	6	CARTA DE RETIRO POR FALLECIMIENTO- LUIS ARNALDO SANTOS VELASQUEZ	2023-10-31 12:56:38.950496	\N
699	3033	16	4	Aprobación cr GARZON PEREZ DORA ELSIE	2023-10-31 14:08:58.578077	\N
700	3034	16	4	Aprobación cr MENDEZ BUENAVENTURA FERNANDO	2023-10-31 15:47:07.8427	\N
701	3035	16	4	Aprobación cr MEZA CASTILLO MIGUEL JACINTO	2023-10-31 16:55:36.460215	\N
702	3036	16	4	Aprobación cr LOPEZ ROMERO DIEGO FERNANDO	2023-10-31 16:57:12.961	\N
703	3037	32	4	CERTIFICADO NO INGRESO DE COMPRA, ADQUIRENCIA	2023-11-01 08:20:04.355386	\N
704	3038	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA RODRIGUEZ TORRES OMAR ROLANDO	2023-11-01 08:28:29.465449	\N
705	3039	16	4	Aprobación cr Sarmiento Garzón Leidy Janeth 	2023-11-01 08:37:53.332045	\N
706	3040	29	6	CARTA DE BIENVENIDA RINCÓN NOGUERA CARLA PAOLA	2023-11-01 10:02:42.931658	\N
707	3041	29	6	CARTA DE BIENVENIDA TORO TAMAYO JULIAN DAVID	2023-11-01 10:05:45.825941	\N
708	3042	29	6	CARTA DE BIENVENIDA MEJIA CARRION GERARDO ANDRES	2023-11-01 10:06:15.60721	\N
709	3043	29	6	CARTA DE BIENVENIDA MEJIA CARRION LUISA MARIA	2023-11-01 10:06:39.868253	\N
710	3044	29	6	CARTA DE BIENVENIDA INGENIERIA GEOTECNIA Y RIESGOS S.A.S	2023-11-01 10:07:01.856781	\N
711	3045	37	4	PAZ Y SALVO GIRALDO GALLO JOSE JAIRO	2023-11-01 10:07:32.12971	\N
712	3046	121	4	Solicitud de terminación del proceso únicamente en cabeza de Giobanny Prieto, por cumplimiento de acuerdo de pago parcial 	2023-11-01 10:46:29.694479	\N
713	3047	32	4	COMUNICADO A FINANDINA FONDO LIQUIDEZ	2023-11-01 11:15:22.705144	\N
714	3048	32	4	\tPROVISION EFECTIVO	2023-11-01 14:31:17.33153	\N
715	3049	119	6	CARTA APROBACIÓN DE RETIRO- MIGUEL ANGEL CONTRERAS GARCIA 	2023-11-01 17:19:44.447741	\N
716	3050	119	6	CARTA DE APROBACIÓN DE RETIRO- PETRONILA ESNEDA PARRA DE MAYO	2023-11-01 17:20:18.456484	\N
717	3051	119	6	CARTA DE APROBACIÓN DE RETIRO- ANA ISABEL SANABRIA DE AREVALO	2023-11-01 17:20:43.040166	\N
718	3052	119	6	CARTA DE APROBACIÓN DE RETIRO-JORGE EDUARDO AYA RODRIGUEZ	2023-11-01 17:21:08.058925	\N
719	3053	119	6	CARTA DE APROBACIÓN DE RETIRO- JUAN CARLOS GÓMEZ BECERRA	2023-11-01 17:21:35.092135	\N
720	3054	16	4	Aprobación cr TORRES CASTELLANOS GILMA VIRGINIA 	2023-11-02 07:40:20.871803	\N
721	3055	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-11-02 08:50:54.266182	\N
722	3056	16	4	Memorando entrega de pagarés a tesorería	2023-11-02 10:20:46.241484	\N
723	3057	29	6	CARTA DE BIENVENIDA DUITAMA BORDA MARIA STELLA	2023-11-02 11:28:41.404449	\N
724	3058	29	6	CARTA DE BIENVENIDA GALVAN VILLAMARIN JOSE FERNANDO	2023-11-02 11:29:13.326372	\N
725	3059	16	4	Aprobación cr CASTILLO CAICEDO DIRLEY	2023-11-02 15:01:51.364028	\N
726	3060	16	4	Aprobación cr ORTEGA QUICASAN CLAUDIA 	2023-11-02 15:02:29.924583	\N
727	3061	16	4	Aprobación cr ORTEGA ROA NESTOR 	2023-11-02 15:02:55.435745	\N
728	3062	42	7	APROBACIÓN PROPUESTA DE COMPRA DEL APARTAMENTO 503 DEL EDIFICIO ADOLFO SALAMANCA CORREA	2023-11-02 15:56:17.007824	\N
729	3063	16	4	Aprobación cr MARTINEZ BECERRA CARLOS JULIO 	2023-11-02 16:04:00.508452	\N
730	3064	5	4	CERTIFICADO MARIA TERESA DE JESUS PARDO VALENCIA	2023-11-03 08:18:01.83911	\N
731	3065	16	4	Aprobación cr PEREZ GARCIA MARIA TERESA	2023-11-03 10:11:39.49	\N
732	3066	5	4	CERTIFICADO BLANCA YANETH GONZALEZ PINZON	2023-11-03 16:59:26.355102	\N
733	3067	37	4	PAZ Y SALVO OVALLE SANCHEZ YOLANDA	2023-11-07 08:05:39.294734	\N
734	3068	37	4	PAZ Y SALVO PINEDA MORENO DANIEL	2023-11-07 08:18:40.874278	\N
735	3069	37	4	CERTIFICADO CREDITO COMPRA DE CARTERA CORTE 31 DE DICIEMBRE ACHURY GARCIA CRISTINA	2023-11-07 09:53:59.768872	\N
736	3070	120	4	RESPUESTA SOLICITUD JULIO 5 DE 2023 - HELGA DUARTE	2023-11-07 09:58:11.026173	\N
737	3071	120	7	RESPUESTA PQRSD JOHANA HAYDEE FORERO RODRIGUEZ	2023-11-07 10:08:36.315701	\N
738	3072	37	4	PAZ Y SALVO CASTRO PAEZ GLORIA EUGENIA	2023-11-07 11:41:14.123078	\N
739	3073	29	6	CARTA DE BIENVENIDA BLANCO NUÑEZ ANA GEORGINA	2023-11-07 11:53:47.746714	\N
740	3074	29	6	CARTA DE BIENVENIDA LONDOÑO LONDOÑO ANDRES EDUARDO	2023-11-07 11:54:16.01534	\N
741	3075	29	6	CARTA DE BIENVENIDA RODRIGUEZ BLANCO CAROLINA	2023-11-07 11:54:35.469759	\N
1340	3	8	1	Prueba	2024-01-02 14:29:31.164921	\N
742	3076	29	6	CARTA DE BIENVENIDA JUNCO ROMERO JOHANNA PAOLA	2023-11-07 11:54:51.874317	\N
743	3077	29	6	CARTA DE BIENVENIDA MORA GRACIA YENNY PAOLA	2023-11-07 11:55:09.562515	\N
744	3078	29	6	CARTA DE BIENVENIDA AVILA CORTES ERIKA JULIETH	2023-11-07 11:55:35.427678	\N
745	3079	37	4	PAZ Y SALVO SAIZ ESPITIA ESPERANZA	2023-11-07 13:45:49.737735	\N
746	3080	16	4	Aprobación Blue Card Rodriguez Olivera Alderson	2023-11-07 14:58:03.571928	\N
747	3081	16	4	Aprobación cr Castillo Castillo Edith Yuliana	2023-11-07 14:58:53.193077	\N
748	3082	16	4	Aprobación cr Ceicmo Ingeniería SAS	2023-11-07 14:59:40.207122	\N
749	3083	16	4	Aprobación Cr Rodríguez Olivera Alderson  	2023-11-08 08:16:54.102177	\N
750	3084	16	4	Aprobación Cr López Rodríguez Juan Carlos 	2023-11-08 08:17:56.822761	\N
751	3085	16	4	Aprobación Cr Noguera Ortiz Luis Eduardo	2023-11-08 08:18:28.991213	\N
752	3086	16	4	Aprobación Cr Ibañez Sastoque Sandra Milena  	2023-11-08 08:19:05.569197	\N
753	3087	123	4	Traslado Coopcentral	2023-11-08 08:43:58.56123	\N
754	3088	16	4	Aprobación Cr Guerrero Fajardo Carlos Alberto	2023-11-08 09:34:31.867146	\N
755	3089	37	4	 PAZ Y SALVO GIRALDO GALLO JOSE JAIRO 	2023-11-08 10:26:50.445503	\N
756	3090	32	4	REDENCION CDT NO FL 1991529-1991530 COOPCENTRAL	2023-11-08 12:26:28.505727	\N
757	3091	29	6	CARTA DE BIENVENIDA BUENO RAMIREZ JOSE CARLOS HUMBERTO	2023-11-08 15:21:51.666368	\N
758	3092	29	6	CARTA DE BIENVENIDA DUARTE CARDONA EDWIN	2023-11-08 15:22:32.556671	\N
759	3093	16	4	Aprobación Blue Card Aristizabal Gutierrez Fabio Ancizar	2023-11-08 15:57:36.009224	\N
760	3094	16	4	Aprobación Cr Sotelo Suarez William 	2023-11-08 15:58:16.052922	\N
761	3095	120	7	INFORME MENSUAL DE CARTERA SUPERSOLIDARIA OCTUBRE 2023	2023-11-08 16:51:33.169897	\N
762	3096	13	7	CARTA AUTORIZACION RECLAMAR CHEQUERA  EXENTA	2023-11-08 17:03:42.320436	\N
763	3097	123	7	Traslado	2023-11-09 08:32:37.551756	\N
764	3098	16	4	Aprobación Cr Perez Barragan Monica	2023-11-09 09:33:33.722858	\N
765	3099	5	4	CERTIFICADO PCR	2023-11-09 10:04:18.110571	\N
766	3100	119	6	CARTA DE RETIRO- BENÍTEZ SANCHEZ SANDRA 	2023-11-09 10:44:38.793982	\N
767	3101	119	6	CARTA DE APROBACIÓN DE RETIRO- GALLEGO MARTINEZ HECTOR JOSÉ	2023-11-09 10:50:58.27117	\N
768	3102	119	6	CARTA DE APROBACIÓN DE RETIRO- ANA CARMENZA CASTRO SALCEDO	2023-11-09 10:52:56.022782	\N
769	3103	32	4	TRASL INTERNO DE COOPCENTRAL AHO A CREDICORP	2023-11-09 11:13:41.998201	\N
770	3104	16	4	Aprobación Cr. Herrera Bedoya John Jairo	2023-11-09 11:23:18.281296	\N
771	3105	32	4	PROVISION EFECTIVO	2023-11-09 11:36:09.368145	\N
772	3106	32	4	REDENCION CDT FL 947227 BANCOOMEVA	2023-11-09 11:51:53.213385	\N
773	3107	32	4	CONST CDT FINANDINA VIENE DE BANCOOMEVA	2023-11-09 11:52:22.267124	\N
774	3108	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA ANDREA ISABEL FORERO RUIZ	2023-11-09 14:54:33.269674	\N
775	3109	15	7	Solicitud permiso de integración y desarrollo para la experta Lucia Pardo Garcia y Santos.	2023-11-09 15:28:05.195376	\N
776	3110	16	4	Aprobación Cr Tamayo Osorio Ricardo Mauricio 	2023-11-09 16:24:11.023895	\N
777	3111	16	4	Aprobación Cr. Perdomo Bahamon Melba	2023-11-09 16:25:00.107082	\N
778	3112	32	4	COMUNICADO A FINANDINA FONDO LIQUIDEZ	2023-11-09 17:21:07.294848	\N
779	3113	16	4	Aprobación Cr. ROZO BELLO JUAN CARLOS	2023-11-09 17:41:04.979362	\N
780	3114	121	4	Paz y Salvo Giobanny Prieto Moreno Proceso 2017-548	2023-11-10 09:21:51.992215	\N
781	3115	120	4	ENTREGA PROCESO JURIDICO KATHERINE YULIETH SALCEDO SANABRIA 	2023-11-10 12:31:09.64264	\N
782	3116	29	6	CARTA DE BIENVENIDA BERMUDEZ CUBIDES RENE	2023-11-10 12:36:07.245283	\N
783	3117	29	6	CARTA DE BIENVENIDA RODRIGUEZ BLANCO EDWIN ANDRES	2023-11-10 12:37:08.559539	\N
784	3118	29	6	CARTA DE BIENVENIDA RUIZ HERNANDEZ YESMIHC	2023-11-10 12:37:44.137371	\N
785	3119	120	4	ENTREGA COBRO JURIDICO OBLIGACION NIÑO MORALES FREDY ALEXANDER	2023-11-10 12:47:22.528186	\N
786	3120	120	4	ENTREGA INICIO PROCESO JURIDICO RODRIGUEZ PRIETO EDWARD ANTONIO 	2023-11-10 13:47:36.826506	\N
787	3121	120	4	ENTREGA COBRO JURIDICO VARELA ROJAS DIEGO AGUSTIN	2023-11-10 14:02:34.134555	\N
788	3122	120	4	ENTREGA COBRO JURIDICO PALACIO REBOLLEDO ANGELICA DEL PILAR	2023-11-10 14:11:46.817514	\N
789	3123	16	4	Aprobación Cr García de Achury Flora Helena	2023-11-10 15:16:58.193399	\N
790	3124	16	4	Aprobación Cr Ortiz de Ortiz Ana Guillermina  	2023-11-10 15:37:12.365821	\N
791	3125	4	6	CERTIFICACION DE AFILIACION	2023-11-10 15:51:34.556731	\N
792	3126	4	6	CERTIFICACION DE AFILIACION CC:1052393904 	2023-11-10 15:52:56.205823	\N
793	3127	4	6	CERTIFICACION DE AFILIACION CC 52821423	2023-11-10 15:54:33.367681	\N
794	3128	4	6	CERTIFICACION DE AFILIACION CC:79984170	2023-11-10 15:55:54.218946	\N
795	3129	16	4	Aprobación Cr Florez Guzmán Glaether  Yhon	2023-11-10 16:10:59.189385	\N
796	3130	16	4	Aprobación Cr León Nieto Diego Ismael 	2023-11-10 16:11:42.723691	\N
797	3131	4	6	CERTIFICACION DE AFILIACION CC 79952470	2023-11-10 16:19:14.495752	\N
798	3132	37	4	 PAZ Y SALVO JIMENEZ PALOMO GABRIEL STEFAN	2023-11-14 08:41:34.625007	\N
799	3133	4	6	Certificación de afiliación cc 1020734337	2023-11-14 09:32:08.571341	\N
800	3134	32	7	COMUNICADO A FINANDINA FONDO LIQUIDEZ	2023-11-14 10:34:53.486195	\N
801	3135	16	4	Aprobación Cr. QUESADA DE CLAVIJO DORIS	2023-11-14 15:18:47.653545	\N
802	3136	16	4	Aprobación Cr. Rodríguez Blanco Andrea Lucero	2023-11-14 15:19:49.934933	\N
803	3137	120	4	Inicio cobro jurídico pagarés #10661254 y # 11194094 - DIAZ CHAUX JOAN MANUEL	2023-11-14 16:27:45.882552	\N
804	3138	119	6	CARTA DE APROBACIÓN DE RETIRO- BEATRIZ ELENA DELGADO GOMEZ	2023-11-14 17:08:22.13612	\N
805	3139	119	6	CARTA DE APROBACIÓN  DE RETIRO POR FALLECIMIENTO- LUIS JORGE BONILLA CAMACHO	2023-11-14 17:08:56.973287	\N
806	3140	119	6	CARTA DE APROBACIÓN DE RETIRO- ROSALIA HURTADO MONTEALEGRE 	2023-11-14 17:09:28.569332	\N
807	3141	119	6	CARTA DE APROBACIÓN DE RETIRO- MARTHA ELENA MORALES VELA 	2023-11-14 17:10:27.870151	\N
808	3142	119	6	CARTA DE APROBACIÓN DE RETIRO- DEYANIRA PEREZ CASTRO	2023-11-14 17:11:01.463259	\N
809	3143	119	6	CARTA DE APROBACIÓN DE RETIRO - CARLOS ENRIQUE HERNANDEZ CAMPOS	2023-11-14 17:11:36.315974	\N
810	3144	119	6	CARTA DE APROBACIÓN DE RETIRO- PATRICIA SIMONSON	2023-11-14 17:12:06.12267	\N
811	3145	14	7	Respuesta asociada BARRETO OSORIO RUTH VIVIAN	2023-11-14 17:20:54.699798	\N
812	3146	13	7	CARTA CHEQUE DE GERENCIA  CDAT	2023-11-14 17:34:24.990858	\N
813	3147	16	4	Aprobación Cr. MEDINA FUENTES CRISTIAN ALEXANDER	2023-11-15 08:11:18.18697	\N
814	3148	32	4	CHEQ GERENCIA COMPRA CASA PCR AUT GERENCIA	2023-11-15 08:16:19.811982	\N
815	3149	16	4	Aprobación Cr. LIZCANO EUGENIO JOSEFINA	2023-11-15 10:19:25.642644	\N
816	3150	14	4	Respuesta comunicado asociada CHAVARRO CASAS MARIA NORMA	2023-11-15 14:43:51.368047	\N
817	3151	16	4	Aprobación Cr Acosta Cuesta María del Carmelo 	2023-11-15 17:06:05.154901	\N
818	3152	16	4	Aprobación Cr Rodríguez Pinilla María del Pilar  	2023-11-15 17:07:05.402115	\N
819	3153	16	7	Aprobación Cr Talavera Davila Henry Valdemar 	2023-11-15 17:07:40.409084	\N
820	3154	37	4	 PAZ Y SALVO FORERO RODRIGUEZ SANDRA ISABEL	2023-11-15 17:41:56.886669	\N
821	3155	29	6	CARTA DE BIENVENIDA MUÑOZ SABA MIGUEL ÁNGEL	2023-11-16 09:03:07.175686	\N
822	3156	29	6	CARTA DE BIENVENIDA RUBIANO DE REYES GLADYS DEL SOCORRO	2023-11-16 09:03:33.667627	\N
823	3157	29	6	CARTA DE BIENVENIDA GARCÍA VALDIVIESO MARÍA ANGÉLICA	2023-11-16 09:03:57.536385	\N
824	3158	29	6	CARTA DE BIENVENIDA SILVA PATIÑO BLANCA MARÍA	2023-11-16 09:04:19.327361	\N
825	3159	29	6	CARTA DE BIENVENIDA PARDO GONZÁLEZ CARLOS ALBERTO	2023-11-16 09:04:37.874901	\N
826	3160	29	6	CARTA DE BIENVENIDA MARTÍNEZ MARTÍNEZ ANA CONZUELO	2023-11-16 09:05:10.35324	\N
827	3161	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA MATIZ CUERVO JIMMY 	2023-11-16 09:07:17.392221	\N
828	3162	32	4	TRASL DE FIDUBBVA A RENTA YA BB	2023-11-16 09:39:47.420334	\N
829	3163	123	7	TRASLADO 	2023-11-16 10:27:23.185536	\N
830	3164	7	9	Respuesta derecho de petición SANDRA PATRICIA BOHÓRQUEZ PIÑA 	2023-11-16 12:00:55.693863	\N
831	3165	126	6	Carta patrocinio	2023-11-16 14:47:18.786701	\N
832	3166	126	6	Carta Patrocinio	2023-11-16 14:57:20.951849	\N
833	3167	126	6	Carta Patrocinio	2023-11-16 15:06:43.407792	\N
834	3168	16	4	Aprobación Cr Cáceres Corrales Pablo Julio 	2023-11-16 15:12:12.47481	\N
835	3169	16	4	Aprobación Cr Castiblanco Rozo Ernesto	2023-11-16 15:12:55.143707	\N
836	3170	126	6	Carta Patrocinio	2023-11-16 15:16:50.381877	\N
837	3171	126	6	Carta patrocinio	2023-11-16 15:39:40.772962	\N
838	3172	126	6	Carta Patrocinio	2023-11-16 15:50:15.358471	\N
839	3173	126	6	Carta Patrocinio	2023-11-16 16:03:11.069774	\N
840	3174	32	4	TRASL DE COOPCENTRAL A CREDICORP	2023-11-17 09:18:44.386096	\N
841	3175	120	4	Respuesta requerimiento periodo de gracia ADRIANA MUÑOZ ALDER	2023-11-17 09:36:23.737773	\N
842	3176	8	1	Diagnóstico y configuración de DNS servidor\r\ndominio y priorización de enrutamiento para\r\nbúsqueda interna de página web en red 	2023-11-17 10:18:30.861577	\N
843	3177	120	4	paz y salvo FAJARDO TOLOSA FABIO ENRIQUE 	2023-11-17 14:25:08.555834	\N
844	3178	32	4	RESPUESTA REQUERIMIENTO CONTROL INTERNO	2023-11-17 16:59:06.142212	\N
845	3179	16	4	Aprobación Cr MALDONADO CONTRERAS JULIO ERNESTO	2023-11-20 09:12:24.38517	\N
846	3180	16	4	Aprobación Cr Ariza Riaño Pablo Enrique 	2023-11-20 09:20:24.969094	\N
847	3181	16	4	Aprobación Cr DUARTE CARDONA EDWIN	2023-11-20 09:36:03.993517	\N
848	3182	16	4	Aprobación Cr Mosquera Meza Ricardo 	2023-11-20 09:37:26.632034	\N
849	3183	16	4	Aprobación Cr Cepeda Carranza Nelson Eduardo	2023-11-20 09:38:15.004171	\N
850	3184	16	4	Aprobación Cr Centanaro Lerch María Elizabeth  	2023-11-20 09:38:59.865084	\N
851	3185	16	4	Aprobación Cr Reina González Germán 	2023-11-20 09:39:38.99694	\N
852	3186	32	4	PROVISION EFECTIVO	2023-11-20 11:43:04.204823	\N
853	3187	7	9	Respuesta derecho de petición Martha Helena Bustos. 	2023-11-20 11:45:30.263457	\N
854	3188	7	7	Respuesta comunicación JAS Asesores & Consultores	2023-11-20 12:31:45.137372	\N
855	3189	16	4	Aprobación Cr Romero Fernandez Juan sebastian 	2023-11-20 16:37:28.433733	\N
856	3190	16	4	Aprobación Cr Sabogal Cancino Jairo Alberto 	2023-11-20 16:38:10.646097	\N
857	3191	16	4	Aprobación Cr Castro Cortés Andrés Alejandro 	2023-11-20 16:39:48.600866	\N
858	3192	16	4	Aprobación Cr Salamanca López Martha	2023-11-20 16:40:24.547919	\N
859	3193	16	4	Aprobación Blue Card Alvarado Florez Liliana	2023-11-20 16:41:07.555752	\N
860	3194	16	4	Aprobación Cr Pineda Delgado Victor Manuel  	2023-11-20 16:42:00.364245	\N
861	3195	16	4	Aprobación Cr Alvarado Florez Liliana	2023-11-20 16:48:10.547699	\N
862	3196	37	4	PAZ Y SALVO GOMEZ PRADA YANNETH MARCELA	2023-11-21 08:15:05.58019	\N
863	3197	13	7	CARTA CHEQUE DE GERENCIA FIDUBOGOTA	2023-11-21 08:16:57.306939	\N
864	3198	32	4	TRASL DE COOPCENTRAL A CREDICORP	2023-11-21 09:40:02.95334	\N
865	3199	38	4	certificado hipotecario al día MARIA ANGELICA HERRERA FONSECA  cc 52410153 10-211001962 	2023-11-21 15:35:03.86836	\N
866	3200	16	4	Aprobación Cr MENDEZ BUENAVENTURA FERNANDO	2023-11-22 08:28:12.834078	\N
867	3201	16	4	Aprobación Cr ALVAREZ CUADROS RAMIRO 	2023-11-22 08:28:57.993085	\N
868	3202	16	4	Aprobación Cr PARDO MORA DOLLY	2023-11-22 08:29:55.108911	\N
869	3203	16	4	Aprobación Cr SARMIENTO PEREZ GUSTAVO 	2023-11-22 08:30:21.009057	\N
870	3204	16	4	Aprobación Cr LIZARAZO VILLARREAL TATIANA	2023-11-22 08:30:49.331394	\N
871	3205	16	4	Aprobación Cr CADAVID MOJICA LUISA ALEJANDRA	2023-11-22 08:31:31.418936	\N
872	3206	5	4	CERTIFICADO MIRYAM STELLA VARGAS RODRIGUEZ	2023-11-22 08:47:13.99551	\N
873	3207	29	6	CARTA DE BIENVENIDA SAMACA SUAREZ JENNY PATRICIA	2023-11-22 10:05:31.053031	\N
874	3208	29	6	CARTA DE BIENVENIDA NAIZAQUE RAMOS MANUEL ALFREDO	2023-11-22 10:06:59.234549	\N
875	3209	29	6	CARTA DE BIENVENIDA MONTAÑO BELLO ALFREDO	2023-11-22 10:07:53.032777	\N
876	3210	29	6	CARTA DE BIENVENIDA CARDONA HOYOS JESUS FRANCISCO	2023-11-22 10:08:52.835889	\N
877	3211	29	6	CARTA DE BIENVENIDA TORRES CAYCEDO NICOLAS	2023-11-22 10:10:31.203666	\N
878	3212	29	6	CARTA DE BIENVENIDA MARTINEZ ALBARRACIN CARLOS JAIR	2023-11-22 10:12:26.804264	\N
879	3213	29	6	CARTA DE BIENVENIDA ESPINOSA MUÑOZ CHARICK MILADY	2023-11-22 10:12:54.187188	\N
880	3214	29	6	CARTA DE BIENVENIDA PICHOT ELLES MAURICIO RENE	2023-11-22 10:13:42.748206	\N
881	3215	29	6	CARTA DE BIENVENIDA ROA ORDOÑEZ DIEGO HERNAN	2023-11-22 10:14:23.715897	\N
882	3216	29	6	CARTA DE BIENVENIDA GOYENECHE TRIANA JOHN JAIRO	2023-11-22 10:15:02.39828	\N
883	3217	29	6	CARTA DE BIENVENIDA LUQUE MARTINEZ LUZ YAMILE	2023-11-22 10:16:11.527407	\N
884	3218	29	6	CARTA DE BIENVENIDA MUNEVAR VIANCHA JOHAN SEBASTIAN	2023-11-22 10:18:25.961507	\N
885	3219	29	6	CARTA DE BIENVENIDA VALLEJO YEPES ANA ROCIO	2023-11-22 10:20:49.083341	\N
886	3220	122	8	Memorando envío escritura pública firmada a COOTRADECUN 	2023-11-22 11:07:10.396007	\N
887	3221	32	4	PROVISION EFECTIVO	2023-11-22 14:46:49.796429	\N
888	3222	16	4	Aprobación Cr SILVA GOMEZ EDELBERTO	2023-11-22 15:23:22.286184	\N
889	3223	16	4	Aprobación Cr HERNANDEZ CORTES MARGARITA 	2023-11-22 15:31:53.702864	\N
890	3224	16	4	Aprobación Cr ALCARCEL CEPEDA NOHORA ALICIA 	2023-11-22 15:32:38.096441	\N
891	3225	16	4	Aprobación Cr MEDINA TORRES CARLOS 	2023-11-22 15:33:02.356849	\N
892	3226	16	4	Aprobación Cr TORRES TOVAR CARLOS ALBERTO 	2023-11-22 15:33:30.701018	\N
893	3227	16	4	Aprobación Cr TRUJILLO CARLOS ALEXANDER 	2023-11-22 15:33:56.186161	\N
894	3228	16	4	Aprobación Cr HOYOS URREA LEANDRO 	2023-11-22 15:34:32.19662	\N
895	3229	16	4	Aprobación Cr GALVIS VANEGAS JESÚS 	2023-11-22 15:35:18.532433	\N
896	3230	16	4	Aprobación Cr CONTRERAS GARCIA MIGUEL ANGEL 	2023-11-22 15:35:51.251627	\N
897	3231	16	4	Aprobación Cr SARMIENTO GALVIZ RONALD ALEXANDER 	2023-11-22 15:36:36.978791	\N
898	3232	29	6	CARTA DE BIENVENIDA CARDOZO SUAREZ YINNETH	2023-11-22 15:54:35.853598	\N
899	3233	29	6	CARTA DE BIENVENIDA CARDOZO GONZALEZ BENIGNO	2023-11-22 15:55:01.461727	\N
900	3234	29	6	CARTA DE BIENVENIDA GIA CONSULTORES LTDA	2023-11-22 15:55:25.520841	\N
901	3235	15	7	Autorización a Ascoop-aportes parafiscales Sena	2023-11-22 16:35:37.515554	\N
902	3236	29	6	CARTA DE BIENVENIDA DIAZ GAITAN CLARA INES	2023-11-22 16:56:46.75712	\N
903	3237	16	4	Aprobación Cr CACERES GAITAN MYRIAM  	2023-11-23 08:43:10.176323	\N
904	3238	16	4	Aprobación Cr SILVA PATIÑO BLANCA MARÍA 	2023-11-23 08:43:38.439018	\N
905	3239	16	4	Aprobación Cr QUEVEDO BLANCO JOSE DAVID	2023-11-23 08:44:03.824495	\N
906	3240	32	4	CONST CDT FINANDINA VIENE DE FALABELLA	2023-11-23 09:47:02.36477	\N
907	3241	32	4	CANCELAR CDT  FALABELLA	2023-11-23 09:49:40.680741	\N
908	3242	128	5	Respuesta SENA	2023-11-23 14:18:44.48974	\N
909	3243	16	4	Aprobación Cr SANABRIA SILVA ANDREA NATALIA 	2023-11-24 10:38:20.63472	\N
910	3244	16	4	Aprobación Cr GARZON GOMEZ NIVIA CRISTINA 	2023-11-24 10:38:55.361017	\N
911	3245	16	4	Aprobación Cr BARON GUAQUETA ANA FABIOLA 	2023-11-24 10:39:20.676444	\N
912	3246	16	4	Aprobación Cr RUBIO LEON CLARA MELISSA	2023-11-24 10:39:44.416658	\N
913	3247	16	4	Aprobación Blue Card Rubio León Clara Melisa	2023-11-24 15:34:38.455278	\N
914	3248	16	4	Aprobación Cr BAUTISTA ROMERO EDGAR 	2023-11-24 15:55:00.571681	\N
915	3249	16	4	Aprobación Cr SANTAMARIA ROJAS DIANA MILENA 	2023-11-24 15:55:32.859676	\N
916	3250	16	4	Aprobación Cr PIÑEROS SOSA YENNY ARBILIA 	2023-11-24 15:56:03.162959	\N
917	3251	16	4	Aprobación Cr TORRES TOVAR CARLOS ALBERTO 	2023-11-24 15:56:31.403383	\N
918	3252	16	4	Aprobación Cr VÉLEZ BOLAÑOS RICARDO ALONSO 	2023-11-24 15:57:05.878099	\N
919	3253	16	4	Aprobación Cr GONZALEZ GONZALEZ FERNANDO 	2023-11-24 15:57:28.270543	\N
920	3254	16	4	Aprobación Cr DAZA DE OROZCO MATILDE MARIA 	2023-11-24 15:57:52.72093	\N
921	3255	16	4	Aprobación Cr COLMENARES MONTAÑEZ JULIO ESTEBAN 	2023-11-24 16:00:43.995517	\N
922	3256	16	4	Aprobación Cr SÁNCHEZ DE ABELLA MARTHA INES 	2023-11-24 16:01:23.744588	\N
923	3257	42	7	Segunda notificación terminación unilateral del contrato de arrendamiento de vivienda urbana por parte del ARRENDADOR	2023-11-24 16:30:50.150499	\N
924	3258	37	4	 PAZ Y SALVO VARGAS AVILA NICOLLE	2023-11-27 08:09:10.16989	\N
925	3259	37	4	 PAZ Y SALVO MUÑOZ CADENA CAMILO AUGUSTO	2023-11-27 08:46:16.220632	\N
926	3260	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA MUÑOZ CADENA CAMILO AUGUSTO	2023-11-27 08:56:26.997893	\N
927	3261	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GOMEZ PRADA YANNETH MARCELA	2023-11-27 09:09:54.032821	\N
928	3262	7	7	Respuesta radicado No. 20232120558311 “relación de solvencia según radicado 20234400345262 Informe de revisor fiscal – III trim	2023-11-27 11:27:19.573694	\N
929	3263	29	6	CARTA DE BIENVENIDA CABEZA BARRETO JORGE ELIECER	2023-11-27 12:16:42.836955	\N
930	3264	29	7	CARTA DE BIENVENIDA REAL RUEDA MAGDA MILENA	2023-11-27 12:17:10.093398	\N
931	3265	8	1	Mantenimiento preventivo aires acondicionados	2023-11-27 13:44:31.480425	\N
932	3266	8	1	Mantenimiento preventivo UPS	2023-11-27 13:45:22.699937	\N
933	3267	7	7	Respuesta requerimiento radicado No. 20232120543951 evaluación de la cartera de créditos 2022.	2023-11-27 14:19:10.381715	\N
934	3268	16	4	Aprobación Cr FONSECA CARDONA RAFAEL 	2023-11-27 16:49:32.701924	\N
935	3269	16	4	Aprobación Cr MARTINEZ MARTINEZ ANA CONSUELO 	2023-11-27 16:50:40.657113	\N
936	3270	16	4	Aprobación Cr PEÑA PACHECO EDUARDO	2023-11-27 16:51:04.735468	\N
937	3271	16	4	Aprobación Cr MONTOYA GAVIRIA GERARDO  	2023-11-27 16:51:47.695387	\N
938	3272	16	4	Aprobación Cr RODRÍGUEZ BLANCO EDWIN 	2023-11-27 16:52:13.232448	\N
939	3273	16	4	Aprobación Cr BERMUDEZ CUBIDES RENE 	2023-11-27 16:52:47.306873	\N
940	3274	16	4	DUEÑAS PINTO NELSON	2023-11-27 16:53:11.8305	\N
941	3275	16	4	Aprobación Cr Gutierrez Moreno William 	2023-11-27 20:32:15.598714	\N
942	3276	123	7	Traslado	2023-11-28 08:22:20.415458	\N
943	3277	32	7	TRASL INTERNO DE BB SERVICIOS A BB RENTA YA	2023-11-28 08:48:02.31274	\N
944	3278	32	7	TRASL DE BB RENTA YA A CREDICORP CAPITAL 	2023-11-28 08:51:46.498693	\N
945	3279	32	7	TRASL DE BB RENTA YA A EXENTA	2023-11-28 08:58:35.895969	\N
946	3280	32	7	PROVISION EFECTIVO	2023-11-28 09:00:19.030628	\N
947	3281	32	7	COMUNICADO FINANDINA CDT FL	2023-11-28 09:38:08.507348	\N
948	3282	29	6	CARTA DE BIENVENIDA ROJAS BELTRAN ANGELA MARÍA	2023-11-28 14:22:36.516919	\N
949	3283	16	4	Aprobación Cr. Valero Cely Fernando 	2023-11-28 18:02:57.524734	\N
950	3284	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA QUINTERO APONTE NATALIA	2023-11-29 08:09:49.200931	\N
951	3285	16	4	Aprobación Cr DUEÑAS BARRETO DAVID	2023-11-29 09:08:11.27783	\N
952	3286	16	4	Aprobación Cr. BOFFET MAGALI	2023-11-29 10:27:31.042513	\N
953	3287	16	4	Aprobación Cr SAMACA SUAREZ JENNY 	2023-11-29 10:28:29.580802	\N
954	3288	16	4	Aprobación Cr RINCON PACHON FAVIO 	2023-11-29 10:28:51.61096	\N
955	3289	16	4	Aprobación Cr LOZANO MARQUEZ EYNER 	2023-11-29 10:29:15.592198	\N
956	3290	16	4	Aprobación Cr GOMEZ OCHOA ANA	2023-11-29 10:29:39.622343	\N
957	3291	16	4	Aprobación Cr ORTIZ ROJAS WILSON 	2023-11-29 10:30:06.103706	\N
958	3292	16	4	Aprobación Cr DIAZ LEGUIZAMON MARTHA 	2023-11-29 10:30:30.221913	\N
959	3293	16	4	Aprobación Cr GOMEZ RUGE PABLO 	2023-11-29 10:32:06.448551	\N
960	3294	16	4	Aprobación Cr MEJIA ALFARO JORGE 	2023-11-29 10:32:52.19547	\N
961	3295	16	4	Aprobación Cr CABEZA BARRETO JORGE 	2023-11-29 10:33:26.672432	\N
962	3296	16	4	Aprobación Cr MUÑOZ SABA MIGUEL ANGEL 	2023-11-29 10:33:50.59299	\N
963	3297	32	7	PROVISION EFECTIVO	2023-11-29 10:40:24.891067	\N
964	3298	119	6	CARTA DE APROBACIÓN DE RETIRO- TEOFRASTO ANTONIO TATIS CANCHILA \r\n\r\n	2023-11-29 11:46:31.016452	\N
965	3299	119	6	CARTA DE APROBACIÓN DE RETIRO- WILMAR ESTEVE ROLDÁN SOLANO	2023-11-29 11:47:07.296429	\N
966	3300	119	6	CARTA DE APROBACIÓN DE RETIRO-GABRIEL IGNACIO PATRÓN LÓPEZ	2023-11-29 11:47:38.00766	\N
967	3301	119	6	CARTA DE APROBACIÓN DE RETIRO - YEIMY ALEXANDRA PINZÓN GUTIÉRREZ	2023-11-29 11:48:10.956874	\N
968	3302	37	4	OBLIGACION AL DIA PALACIOS ESPITIA MARCOLINO	2023-11-29 13:48:12.92525	\N
969	3303	126	6	Carta legalización anticipo	2023-11-29 15:30:57.62659	\N
970	3304	15	7	CERTIFICACION ZURICH CONVENIO	2023-11-29 16:23:39.056826	\N
971	3305	123	7	TRASLADO	2023-11-30 12:40:09.536545	\N
972	3306	29	6	CARTA DE BIENVENIDA DAVID AMAYA HAZBLEIDY	2023-12-01 08:13:51.653797	\N
973	3307	29	6	CARTA DE BIENVENIDA  ZULUAGA HERNANDEZ DIANA MERCEDES	2023-12-01 08:14:43.024421	\N
974	3308	29	6	CARTA DE BIENVENIDA  BARRIOS ORDOÑEZ JESUS FERNANDO	2023-12-01 08:15:24.308571	\N
975	3309	29	6	CARTA DE BIENVENIDA  PAVAJEAU HERMES FRANCISCO	2023-12-01 08:15:42.117289	\N
976	3310	29	6	CARTA DE BIENVENIDA  GOYES BUSTOS MARIO FERNANDO	2023-12-01 08:16:09.871565	\N
977	3311	29	6	CARTA DE BIENVENIDA  AUSIQUE GAMEZ GERARDO ARTURO	2023-12-01 08:16:56.373377	\N
978	3312	29	6	CARTA DE BIENVENIDA  GAMBOA SUAREZ HENRY	2023-12-01 08:17:15.108255	\N
979	3313	29	6	CARTA DE BIENVENIDA  GARCIA NUNEZ JESUS RAFAEL	2023-12-01 08:17:35.675209	\N
980	3314	29	6	CARTA DE BIENVENIDA  BOHORQUEZ RIOS LUCY	2023-12-01 08:17:53.074582	\N
981	3315	29	6	CARTA DE BIENVENIDA  QUINTANA MURCIA CLAUDIA CECILIA	2023-12-01 08:18:14.269422	\N
982	3316	29	6	CARTA DE BIENVENIDA FLORIDO ARTEAGA JUAN FRANCISCO	2023-12-01 08:18:45.518526	\N
983	3317	29	6	CARTA DE BIENVENIDA  GUARNIZO CARDENAS ANGELA PATRICIA	2023-12-01 08:19:17.007958	\N
984	3318	29	6	CARTA DE BIENVENIDA  BERNAL LUGO SANTIAGO	2023-12-01 08:19:38.898083	\N
985	3319	29	6	CARTA DE BIENVENIDA  PRADO ARANGO BENJAMIN	2023-12-01 08:19:54.783101	\N
986	3320	29	6	CARTA DE BIENVENIDA CLAVIJO NARANJO MARYLIN STELLA	2023-12-01 08:20:11.897463	\N
987	3321	29	6	CARTA DE BIENVENIDA  GALVAN SANCHEZ OFELIA ROSA	2023-12-01 08:20:28.57794	\N
988	3322	10	3	mes de diciembre-2023	2023-12-01 09:39:55.617627	\N
989	3323	10	3	mes de diciembre-2023	2023-12-01 09:40:15.871109	\N
990	3324	10	3	mes de diciembre-2023	2023-12-01 09:40:23.069748	\N
991	3325	10	3	mes de diciembre-2023	2023-12-01 09:40:29.346248	\N
992	3326	10	3	mes de diciembre-2023	2023-12-01 09:40:48.150328	\N
993	3327	10	3	mes de diciembre-2023	2023-12-01 09:40:54.396756	\N
994	3328	10	3	mes de diciembre-2023	2023-12-01 09:40:59.932285	\N
995	3329	10	3	mes de diciembre-2023	2023-12-01 09:41:13.753619	\N
996	3330	10	3	mes de diciembre-2023	2023-12-01 09:41:18.928225	\N
997	3331	10	3	mes de diciembre-2023	2023-12-01 09:41:24.270729	\N
998	3332	10	3	mes de diciembre-2023	2023-12-01 09:41:42.428475	\N
999	3333	10	3	mes de diciembre-2023	2023-12-01 09:41:53.92433	\N
1000	3334	10	3	mes de diciembre-2023	2023-12-01 09:41:58.629044	\N
1001	3335	10	3	mes de diciembre-2023	2023-12-01 09:42:03.489988	\N
1002	3336	10	3	mes de diciembre-2023	2023-12-01 09:42:08.138979	\N
1003	3337	32	4	PROVISION EFECTIVO	2023-12-01 10:06:53.185623	\N
1004	3338	16	4	Certificación Coopserfun	2023-12-01 14:49:53.925035	\N
1005	3339	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE PRENDA PACHON PAGOTES JAIRO FRANCISCO	2023-12-01 15:40:51.459849	\N
1006	3340	15	7	LEVANTAMIENTO DE PRENDA ZYO570-JAIRO FRANCISCO PACHON PAGOTES	2023-12-01 16:08:04.332686	\N
1007	3341	37	4	 PAZ Y SALVO BARAJAS ORDOÑEZ SANDRA LILIANA	2023-12-01 16:35:02.128486	\N
1008	3342	29	6	CARTA DE BIENVENIDA ARIZA ARDILA HECTOR RAUL	2023-12-04 08:01:31.163385	\N
1009	3343	29	6	CARTA DE BIENVENIDA VIDAL GONZALEZ DAVID ORLANDO	2023-12-04 08:01:53.719772	\N
1010	3344	29	6	CARTA DE BIENVENIDA HUESO SARMIENTO MARCO ALFONSO	2023-12-04 08:02:18.444167	\N
1011	3345	29	6	CARTA DE BIENVENIDA RODRIGUEZ NIETO MARIA VICTORIA	2023-12-04 08:02:40.005043	\N
1012	3346	29	6	CARTA DE BIENVENIDA BARATO MORENO JUAN PAUBLO	2023-12-04 08:02:58.348707	\N
1013	3347	29	6	CARTA DE BIENVENIDA MARTINEZ MARIN GUSTAVO ADOLFO	2023-12-04 08:03:15.78263	\N
1014	3348	29	6	CARTA DE BIENVENIDA SANCHEZ VALENCIA OLGA LUCIA	2023-12-04 08:03:48.398187	\N
1015	3349	29	6	CARTA DE BIENVENIDA ORJUELA PARRA MIGUEL ANGEL	2023-12-04 08:04:05.85885	\N
1016	3350	37	4	 PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA CHAVARRO ORJUELA ISABEL	2023-12-04 08:04:12.821917	\N
1017	3351	37	4	PAZ Y SALVO SIN OBLIGACION IDENTIFICADA CHAVARRO ORJUELA ISABEL	2023-12-04 08:58:40.213947	\N
1018	3352	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-04 10:11:33.442184	\N
1019	3353	14	4	Carta de aprobación CAICEDO ESCOBAR CARLOS HERNAN	2023-12-04 11:07:32.219708	\N
1020	3354	14	4	Carta aprobación GOMEZ BERNAL JUAN MANUEL	2023-12-04 11:20:55.650129	\N
1021	3355	14	4	Carta aprobación MORALES  GABRIEL	2023-12-04 11:29:28.108051	\N
1022	3356	14	4	Carta aprobación FLOREZ PINZON JONATHAN ESTIBEN	2023-12-04 11:33:22.045484	\N
1023	3357	14	4	Aprobación crédito BARRIOS ORDOÑEZ JESUS FERNANDO	2023-12-04 11:44:53.049403	\N
1024	3358	37	4	 PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA SILVA LOPEZ OLGA LILIA	2023-12-04 14:26:00.773428	\N
1025	3359	37	4	PAZ Y SALVO HERRERA CASTIBLANCO SAMUEL ALBERTO	2023-12-04 14:33:45.639469	\N
1026	3360	37	4	 PAZ Y SALVO ROBAYO RODRIGUEZ JUAN MANUEL	2023-12-04 14:58:00.540808	\N
1027	3361	120	7	COMPENSACIÓN SALDOS JOSE ENRIQUE CORRALES ENCISO (Q.E.P.D)	2023-12-04 17:22:25.354176	\N
1028	3362	14	4	Aprobación crédito DUEÑAS PINTO RAMIRO JAVIER	2023-12-04 17:33:45.320923	\N
1029	3363	38	4	Respuesta periodo de gracia Henry Aragón cc: 19261689 	2023-12-05 09:00:04.154493	\N
1030	3364	119	6	CARTA DE APROBACIÓN DE RETIRO- AMERICO PEREA VALOYES 	2023-12-05 11:49:24.144762	\N
1031	3365	119	6	CARTA DE APROBACIÓN DE RETIRO- MARIA NORMA CHAVARRO CASAS 	2023-12-05 11:49:55.125583	\N
1032	3366	119	6	CARTA DE APROBACIÓN DE RETIRO- NADIA CATALINA SEGURA SARMIENTO	2023-12-05 11:50:27.889611	\N
1033	3367	119	6	CARTA RESPUESTA DE RETIRO- FEIBER ANTONIO CHAVEZ CASTRO	2023-12-05 13:14:39.049888	\N
1034	3368	16	4	Aprobación Cr Mejía Alfaro Jorge 	2023-12-05 14:29:31.155149	\N
1035	3369	29	6	CARTA DE BIENVENIDA CASTRO PINEDA MARCIA JOHANNA	2023-12-05 14:46:55.55301	\N
1036	3370	29	6	CARTA DE BIENVENIDA CORREDOR SILVA  DANA KAMILA 	2023-12-05 14:47:19.271585	\N
1037	3371	29	6	CARTA DE BIENVENIDA TRIANA HORTA OSCAR GERMAN	2023-12-05 14:47:36.313645	\N
1038	3372	29	6	CARTA DE BIENVENIDA GUACANEME GUTIERREZ JULIO ALBERTO	2023-12-05 14:47:53.568473	\N
1039	3373	29	6	CARTA DE BIENVENIDA JIMENEZ PINZON ALISON VIVIANA	2023-12-05 14:48:09.310806	\N
1040	3374	29	6	CARTA DE BIENVENIDA ROMERO BUITRAGO MARTHA CECILIA	2023-12-05 14:48:26.345696	\N
1041	3375	29	6	CARTA DE BIENVENIDA BENAVIDES DIAZ DANIEL ALEJANDRO	2023-12-05 14:48:43.552742	\N
1042	3376	29	6	CARTA DE BIENVENIDA RODRIGUEZ MEJIA KARLA GERALDINE	2023-12-05 15:03:38.738853	\N
1043	3377	16	4	Aprobación Cr MURILLO SENCIAL ZAKIK	2023-12-05 15:13:56.290094	\N
1044	3378	14	4	Carta aprobación NAVA SERRANO MARIA FANNY	2023-12-05 15:19:51.729403	\N
1045	3379	16	4	Aprobación cr PEREZ ORTIZ PAULA ANDREA	2023-12-05 15:23:35.547445	\N
1046	3380	14	4	Carta aprobación BERNAL POVEDA CAMPO ELIAS	2023-12-05 17:28:15.690281	\N
1047	3381	16	4	Aprobación Cr GUTIERREZ GUTIERREZ JOHN JAIRO	2023-12-05 18:26:36.577345	\N
1048	3382	14	4	Certificación ALVAREZ BERMUDEZ ZORAYA XIMENA 	2023-12-06 07:39:05.473456	\N
1049	3383	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-06 09:22:16.544681	\N
1050	3384	32	4	PROVISION EFECTIVO	2023-12-06 10:02:46.83411	\N
1051	3385	32	7	CANCELACION CTA BBVA	2023-12-06 10:33:30.418414	\N
1052	3386	32	7	CANCELACION FONDO FIC BBVA No 192-0000-56	2023-12-06 10:39:39.585583	\N
1053	3387	32	7	\tCANCELACION FONDO FIC BBVA No 182-5000-03	2023-12-06 11:36:15.614702	\N
1054	3388	32	7	DISMINUCION FL CTA AHORROS COOPCENTRAL A COOPCENTRAL AHO-PSE	2023-12-06 11:45:31.714065	\N
1055	3389	16	4	Aprobación Cr Muñoz Martínez Elvia 	2023-12-06 15:41:20.538309	\N
1056	3390	39	4	Aprobación Cr Real Rueda Magda	2023-12-06 15:56:42.193912	\N
1057	3391	39	4	Aprobación Cr Ruiz García Raul	2023-12-06 15:57:44.927694	\N
1058	3392	39	4	Aprobación Cr López Arévalo Hugo  	2023-12-06 15:58:56.99337	\N
1059	3393	39	4	Aprobación Vélez Sánchez Juan 	2023-12-06 15:59:39.346657	\N
1060	3394	39	4	Aprobación Salazar Pulido Luz Mary	2023-12-06 16:00:20.60242	\N
1061	3395	37	7	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA RODRIGUEZ TORRES OMAR ROLANDO	2023-12-06 16:01:26.586458	\N
1062	3396	14	4	Carta aprobación HUESO SARMIENTO MARCO ALFONSO	2023-12-07 10:26:06.995126	\N
1063	3397	14	4	Carta aprobación Aniversario HUESO SARMIENTO MARCO ALFONSO	2023-12-07 10:26:31.955285	\N
1064	3398	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-07 12:24:45.239497	\N
1065	3399	120	7	INFORME CATERA SUPERSOLIDARIA MES DE NOVIEMBRE DE 2023	2023-12-07 14:19:16.068727	\N
1066	3400	32	4	TRASLADO INT A CREDICORP DE BB RENTA YA	2023-12-07 14:37:13.477134	\N
1067	3401	120	4	COMPENSACIÓN SALDOS POR RETIRO VOLUNTARIO NELSON OLIVEROS	2023-12-07 16:26:10.785655	\N
1068	3402	4	7	Auxilio para la adquisición de mausoleos, osarios o lotes en parques cementerios.	2023-12-11 09:05:17.977535	\N
1069	3403	16	4	Aprobación Cr LÓPEZ ARÉVALO HUGO 	2023-12-11 09:27:19.302869	\N
1070	3404	16	4	Aprobación Cr RUIZ GARCÍA RAUL 	2023-12-11 09:27:51.630856	\N
1071	3405	16	4	Aprobación Cr VELEZ SANCHEZ JUAN CARLOS 	2023-12-11 09:28:19.03228	\N
1072	3406	16	4	Aprobación Cr SALAZAR PULIDO LUZ MARY 	2023-12-11 09:28:51.884954	\N
1073	3407	16	4	Aprobación Cr 	2023-12-11 09:29:07.885651	\N
1074	3408	16	4	Aprobación Cr TORRES HERNANDEZ ANA MARÍA 	2023-12-11 09:29:50.302854	\N
1075	3409	16	4	Aprobación Cr TELLEZ PEREZ MARTHA 	2023-12-11 09:30:14.730522	\N
1076	3410	16	4	Aprobación Cr OROZCO PARDO CLARA 	2023-12-11 09:30:39.351722	\N
1077	3411	16	4	Aprobación Cr CHICO RODRIGUEZ SANTIAGO 	2023-12-11 09:31:20.166961	\N
1078	3412	32	4	REDENCION CDT FINANDINA ABONO CTA AHORROS	2023-12-11 09:36:31.579911	\N
1079	3413	16	4	Aprobación Cr ARIAS FORERO ELCIA MARINA 	2023-12-11 09:42:10.78168	\N
1080	3414	16	4	Aprobación Cr BUSTAMANTE BUSTAMANTE MARTHA 	2023-12-11 09:42:41.476371	\N
1081	3415	16	4	Aprobación Cr CHICO DÍAZ RAFAEL 	2023-12-11 09:44:04.38749	\N
1082	3416	16	4	Aprobación Cr CORTEZ BARRERO CARLOS 	2023-12-11 09:44:29.029849	\N
1083	3417	16	4	Aprobación Cr DIAZ ORTEGON OSCAR 	2023-12-11 09:44:55.677309	\N
1084	3418	16	4	Aprobación Cr CAICEDO BERDUGO  ANDRÉS 	2023-12-11 09:45:53.555574	\N
1085	3419	32	4	PROVISION DE EFECTIVO CAJA	2023-12-11 09:46:17.603115	\N
1086	3420	119	6	RESPUESTA DERECHO DE PETICIÓN- AMERICO PEREA VALOYES 	2023-12-11 09:47:26.843961	\N
1087	3421	32	4	CHEQUE GERENCIA ULTIMO PAGO CASA PCR-SOCIEDAD GALANTE	2023-12-11 10:13:12.581168	\N
1088	3422	42	7	Terminación del contrato de aprendizaje por vencimiento del término pactado.	2023-12-11 10:45:10.003529	\N
1089	3423	32	4	TRASLADO INT A CREDICORP DE AHO FINANDINA	2023-12-11 11:08:17.434942	\N
1090	3424	42	7	TERMINACIÓN DEL CONTRATO DE PASANTÍA O PRÁCTICA UNIVERSITARIA.	2023-12-11 11:17:16.503367	\N
1091	3425	32	4	REDENCION CDT COOPCENTRAL ABONO CTA AHORROS	2023-12-11 11:40:06.493533	\N
1092	3426	32	4	TRASLADO INT A CREDICORP DE AHO COOPCENTRAL	2023-12-11 11:58:30.194558	\N
1093	3427	38	4	paz y salvo ROJAS MELO ROSALBA cc 41609121 10-221000521 	2023-12-11 13:08:01.147737	\N
1094	3428	32	7	CANCELACION FONDO FIC BBVA No 192-0000-56 de nuevo	2023-12-11 15:05:47.360132	\N
1095	3429	32	7	CANCELACION FONDO FIC BBVA No 182-5000-03 de nuevo 	2023-12-11 15:06:07.638835	\N
1096	3430	32	7	CANCELA CTA AHORROS BBVA	2023-12-11 15:06:36.349493	\N
1097	3431	37	4	PAZ Y SALVO TORRES BAZURTO JAIME	2023-12-11 15:35:34.364003	\N
1098	3432	37	4	OBLIGACION AL DIA MONROY ARIAS MARIA CONSTANZA	2023-12-11 15:51:41.153243	\N
1099	3433	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GARCIA VARGAS MERY CONSTANZA	2023-12-11 16:58:17.617353	\N
1100	3434	37	4	 PAZ Y SALVO SOTO RUEDA LEIDY MILENA	2023-12-11 17:36:15.203213	\N
1101	3435	16	4	Aprobación Cr GARZÓN GÓMEZ YASMINA 	2023-12-11 17:44:42.063687	\N
1102	3436	16	4	Aprobación Cr DUEÑAS TRIANA FERNANDO 	2023-12-11 17:45:10.991136	\N
1103	3437	16	4	Aprobación Cr ARIAS MARTINEZ SANDRA 	2023-12-11 17:45:37.522434	\N
1104	3438	16	4	Aprobación Cr COLMENARES MONTAÑEZ GERMAN 	2023-12-11 17:46:08.107784	\N
1105	3439	16	7	Aprobación Cr ORTIZ SANCHEZ SANDRA JUDITH 	2023-12-11 17:46:35.829314	\N
1106	3440	16	7	Aprobación Cr NIETO CRUZ DIEGO 	2023-12-11 17:46:55.845621	\N
1107	3441	4	7	Auxilio de incapacidad. Elvia Ortiz cc: 52106788	2023-12-12 08:51:37.869941	\N
1108	3442	4	7	Auxilio de incapacidad cc: 3046783  PATARROYO MURILLO MANUEL ELKIN	2023-12-12 09:06:12.714846	\N
1109	3443	16	4	Aprobación Blue Card MORA MARTINEZ DIANA MILENA	2023-12-12 09:19:03.254847	\N
1110	3444	16	4	Entrega de pagarés a tesorería 	2023-12-12 10:12:22.049819	\N
1111	3445	29	6	CARTA DE BIENVENIDA RUBIANO VINUEZA JAIME RAMON	2023-12-12 10:30:40.764628	\N
1112	3446	16	4	Aprobación Cr AMAYA PINTO SARA LUCIA 	2023-12-12 10:32:36.987475	\N
1113	3447	16	4	Aprobación Cr RAMOS RODRIGUEZ ZOILA INES 	2023-12-12 10:33:47.512713	\N
1114	3448	29	6	CARTA DE BIENVENIDA GONZALEZ CAMPOS STELLA	2023-12-12 10:40:26.117841	\N
1115	3449	29	6	CARTA DE BIENVENIDA MOYA DE GARCIA MARTHA CECILIA	2023-12-12 10:40:48.66199	\N
1116	3450	29	6	CARTA DE BIENVENIDA LEMUS GARCIA HUMBERTO	2023-12-12 10:41:07.861271	\N
1117	3451	29	6	CARTA DE BIENVENIDA JIMENEZ ESCALANTE CESAR AUGUSTO	2023-12-12 10:41:23.593638	\N
1118	3452	29	6	CARTA DE BIENVENIDA GRACIA RUBIO JULIA ELVIRA	2023-12-12 10:41:40.385979	\N
1119	3453	29	6	CARTA DE BIENVENIDA GUEVARA CASTRO LENDY VALERIA	2023-12-12 10:41:57.224585	\N
1120	3454	29	6	CARTA DE BIENVENIDA MARTIN JAIMES ANDRES FELIPE	2023-12-12 10:42:13.463761	\N
1121	3455	29	6	CARTA DE BIENVENIDA TRIANA PERDOMO LILANA ANDREA	2023-12-12 10:42:28.610242	\N
1122	3456	29	6	CARTA DE BIENVENIDA BARRIOS LADINO IRMA YORYAN DEL ROSARIO	2023-12-12 10:42:46.458151	\N
1123	3457	29	6	CARTA DE BIENVENIDA MEDINA CASTAÑEDA ELVA YOLANDA	2023-12-12 10:43:02.639159	\N
1124	3458	29	6	CARTA DE BIENVENIDA LADINO RODRIGUEZ MYRIAM ELVIA	2023-12-12 10:43:17.274662	\N
1125	3459	120	7	CREDITO CONSUMO TARJETA COOPCENTRAL 12- 161009061 	2023-12-12 11:03:49.803504	\N
1126	3460	16	4	Aprobación Cr CORTES LUNA JORGE ALBERTO	2023-12-13 09:17:28.455579	\N
1127	3461	16	4	Aprobación Cr FORERO DIAZ MONICA	2023-12-13 09:17:54.484734	\N
1128	3462	16	4	Aprobación Cr BERNAL CAMPO ELÍAS 	2023-12-13 09:18:26.403825	\N
1129	3463	16	4	Aprobación Cr ALFONSO RIOS DANIEL 	2023-12-13 09:19:01.733705	\N
1130	3464	16	4	Aprobación Cr ALFONSO ROA RAFAEL 	2023-12-13 09:19:29.999177	\N
1131	3465	16	4	Aprobación Cr MEJIA PIÑERES FERNANDO 	2023-12-13 09:19:52.662564	\N
1132	3466	37	4	 PAZ Y SALVO SOTO RUEDA LEIDY MILENA	2023-12-13 09:22:54.701884	\N
1133	3467	32	4	PROVISION DE EFECTIVO CAJA	2023-12-13 11:13:41.237713	\N
1134	3468	119	6	CERTIFICACIÓN PAZ Y SALVO- LUZ STELLA TALERO CORDOBA 	2023-12-13 15:29:04.623203	\N
1135	3469	120	7	COMPENSACIÓN SALDOS Gonzalo Rafael Villada Londoño  (Q.E.P.D)	2023-12-13 15:45:40.101494	\N
1136	3470	16	4	Aprobación Cr JIMÉNEZ VARGAS ANA CAROLINA 	2023-12-13 16:39:03.246791	\N
1137	3471	16	4	Aprobación Cr RUBIANO VINUEZA JAIME RAMÓN 	2023-12-13 16:39:46.447363	\N
1138	3472	16	4	Aprobación Cr  PAVAJEAU HERMES FRANCISCO 	2023-12-13 16:40:12.739676	\N
1139	3473	16	4	Aprobación Cr RIVERA MONTEALEGRE ENID	2023-12-13 16:40:42.636851	\N
1140	3474	13	4	CARTA AUTORIZACION CHEQUERAS	2023-12-13 16:50:31.351842	\N
1141	3475	29	6	CARTA DE BIENVENIDA LATORRE SUAREZ ALBA PATRICIA	2023-12-13 23:33:13.187017	\N
1142	3476	29	6	CARTA DE BIENVENIDA TIBOCHE GARCIA ARLENSIU	2023-12-13 23:33:36.45723	\N
1143	3477	29	6	CARTA DE BIENVENIDA CORTES RUEDA MARIA CLEMENCIA	2023-12-13 23:34:14.292823	\N
1144	3478	29	6	CARTA DE BIENVENIDA MONCADA CASTIBLANCO YASMI	2023-12-13 23:34:54.101169	\N
1145	3479	29	6	CARTA DE BIENVENIDA ROMERO LARRAHONDO PAULO ANDRES	2023-12-13 23:35:15.424371	\N
1146	3480	29	6	CARTA DE BIENVENIDA CASTAÑO LARA EMERSON	2023-12-13 23:35:34.124111	\N
1147	3481	29	6	CARTA DE BIENVENIDA CHACON SIERRA GIOVANNI ALEXANDER	2023-12-13 23:35:52.681447	\N
1148	3482	29	6	CARTA DE BIENVENIDA RUNCERA ROA LADY MARCELA	2023-12-13 23:36:12.577471	\N
1149	3483	37	4	PAZ Y SALVO POR TODO CONCEPTO TORRES BAZURTO JAIME	2023-12-14 09:16:31.13575	\N
1150	3484	5	4	CERTIFICADO PCR	2023-12-14 09:54:09.85779	\N
1151	3485	16	4	Aprobación Cr MARTINEZ SARMIENTO EVER	2023-12-14 10:54:53.073685	\N
1152	3486	119	6	CARTA DE APROBACIÓN DE RETIRO- LILIANA VALENCIA RODRIGUEZ 	2023-12-14 11:19:38.005382	\N
1153	3487	119	6	CARTA DE APROBACIÓN DE RETIRO- SONIA ZAMBRANO HERNANDEZ 	2023-12-14 11:20:27.315068	\N
1154	3488	119	6	CARTA DE APROBACIÓN DE RETIRO- LUZ MYRIAM AVECEDO HERNÁNDEZ	2023-12-14 11:21:15.796798	\N
1155	3489	119	6	CARTA DE APROBACIÓN DE RETIRO- MILDRED FARIDE HERNÁNDEZ QUINTERO	2023-12-14 11:21:51.619854	\N
1156	3490	119	6	CARTA DE APROBACIÓN DE RETIRO- SEBASTIAN GÓMEZ LÓPEZ	2023-12-14 11:22:23.494478	\N
1157	3491	120	7	COMPENSACIÓN SALDOS GONZALO RAFAEL VILLADA LONDOÑO (Q.E.P.D)	2023-12-14 11:47:38.498932	\N
1158	3492	13	4	CARTA CHEQUE DE GERENCIA PONTIFICIA U. JAVERIANA	2023-12-14 16:09:14.278963	\N
1159	3493	120	4	certificacion afiliacion RAMIREZ CELIS MARIA ELVIRA	2023-12-14 16:32:07.993154	\N
1160	3494	120	4	entrega cobro juridico RAMIREZ CELIS MARIA ELVIRA 	2023-12-14 17:10:31.651144	\N
1161	3495	16	4	Aprobación Cr  MARTINEZ NIÑO JHON ALEXANDER 	2023-12-14 17:26:24.897506	\N
1162	3496	16	4	Aprobación Cr NAIZAQUE RAMOS MANUEL ALFREDO 	2023-12-14 17:27:25.201018	\N
1163	3497	16	4	Aprobación Cr QUINTERO GALINDO SANDRA 	2023-12-14 17:28:01.092501	\N
1164	3498	16	4	Aprobación Cr BELTRÁN PARDO LUIS CARLOS 	2023-12-14 17:28:45.503594	\N
1165	3499	32	4	TRASL INTERNO COOPCENTRAL AHO A CORRIENTE	2023-12-15 09:12:13.12594	\N
1166	3500	32	4	PROVISION DE EFECTIVO CAJA	2023-12-15 09:15:03.591835	\N
1167	3501	32	4	REDENCION CDT FINANDINA ABONO CTA AHORROS FINANDINA	2023-12-15 09:26:39.57739	\N
1168	3502	122	8	Respuesta requerimento Supersolidaria	2023-12-15 15:27:01.867904	\N
1169	3503	16	4	Aprobación Cr SEPULVEDA MOLINA NADIA CATALINA 	2023-12-15 15:49:51.7502	\N
1170	3504	16	4	Aprobación Cr URREGO ARIAS JHOAN DAVID	2023-12-15 15:50:38.829096	\N
1171	3505	16	4	Aprobación Cr GOYENECHE TRIANA JOHN JAIRO 	2023-12-15 15:51:23.27535	\N
1172	3506	37	4	CERTIFICADO PATRICIA MARTINEZ	2023-12-15 16:15:18.337713	\N
1173	3507	16	4	Aprobación Cr Puyana Villamizar Yolanda	2023-12-15 17:08:50.742683	\N
1174	3508	16	4	Entrega Pagaré a Tesorería 	2023-12-15 17:17:11.689724	\N
1175	3509	16	4	Aprobación Cr Jaimes Sanchez Jeaneth 	2023-12-15 17:27:51.449148	\N
1176	3510	37	4	 PAZ Y SALVO LEON RODRIGUEZ NOHRA	2023-12-18 07:51:25.051485	\N
1177	3511	120	4	respuesta solicitud Elizabeth Bernal	2023-12-18 09:01:22.561031	\N
1178	3512	16	4	Aprobación Cr  DIAZ GAITAN CLARA INES 	2023-12-18 09:49:49.102372	\N
1179	3513	16	4	Aprobación Cr  PIÑEROS BUSTAMANTE VIVIANA MARCELA 	2023-12-18 09:50:25.290379	\N
1180	3514	16	4	Aprobación Cr  BRICEÑO AMARILLO OSCAR 	2023-12-18 09:51:07.06557	\N
1181	3515	16	4	Aprobación Cr  TALERO URREGO CESAR \r\n	2023-12-18 09:51:40.362531	\N
1182	3516	16	4	Aprobación Cr  GONZALEZ RUBIANO DAVID 	2023-12-18 09:52:07.303307	\N
1183	3517	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GARCIA VARGAS MERY CONSTANZA	2023-12-18 09:58:02.812285	\N
1184	3518	37	4	 PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GALINDO RAMIREZ MARTHA LILIANA	2023-12-18 10:23:20.704651	\N
1185	3519	37	4	 PARA LEVANTAMIENTO DE PRENDA GERENA USECHE BARBARA EMILSE	2023-12-18 11:21:13.61956	\N
1186	3520	32	4	PROVISION DE EFECTIVO CAJA	2023-12-18 11:48:38.787301	\N
1187	3521	37	4	PAZ Y SALVO SANTIESTEBAN QUINTERO ROSA ELVIA	2023-12-18 11:50:53.230536	\N
1188	3522	29	6	CARTA DE BIENVENIDAMURCIA DE QUINTANA MARIA CECILIA	2023-12-18 12:37:02.727259	\N
1189	3523	29	6	CARTA DE BIENVENIDA CASAS GAONA LUZ IMELDA	2023-12-18 12:37:29.901384	\N
1190	3524	29	6	CARTA DE BIENVENIDABERNAL LUGO JUAN DAVID	2023-12-18 12:37:47.61471	\N
1191	3525	29	6	CARTA DE BIENVENIDA ALARCON RUIZ LUIS FERNANDO 	2023-12-18 12:38:05.772685	\N
1192	3526	29	6	CARTA DE BIENVENIDA PAEZ GARZON JENNY PAOLA	2023-12-18 12:38:23.680139	\N
1193	3527	29	6	CARTA DE BIENVENIDA CUTIVA PEREZ YERMAIN ANDRES	2023-12-18 12:38:38.77487	\N
1194	3528	29	6	CARTA DE BIENVENIDA AROCA PERDOMO ELDA MARIA	2023-12-18 12:39:00.076364	\N
1195	3529	32	4	TRASLADO INT DE AHO RENTAYA A CREDICORP FIC	2023-12-18 13:18:10.149404	\N
1196	3530	32	4	TRASLADO INT DE BB SERVICIOS A BB RENTAYA 	2023-12-18 13:22:03.814614	\N
1197	3531	8	1	COMPRA DE COMPUTADORES	2023-12-18 17:06:38.636867	\N
1198	3532	16	4	Aprobación Cr   SARMIENTO ORJUELA LINA MARIA 	2023-12-18 17:45:41.105933	\N
1199	3533	16	4	Aprobación Cr   NAGLES GALEANO LEIDY JOHANA	2023-12-18 17:46:26.23096	\N
1200	3534	16	4	Aprobación Cr   LEON PARRA ANDREA 	2023-12-18 17:46:53.615499	\N
1201	3535	16	4	Aprobación Cr   PERDOMO GARCIA OLGA 	2023-12-18 17:47:15.218585	\N
1202	3536	16	4	Aprobación Cr   ARIAS PULGARIN PAULA 	2023-12-18 17:47:41.522338	\N
1203	3537	13	4	CARTA CHEQUE DE GERENCIA U. JAVERIANA	2023-12-18 18:18:41.681128	\N
1204	3538	10	3	Entrega de Información	2023-12-19 10:45:28.645208	\N
1205	3539	37	7	 PAZ Y SALVO FORERO DIAZ MONICA	2023-12-19 13:45:11.817721	\N
1206	3540	16	4	Aprobación Cr   RODRIGUEZ BALLEN OSCAR DAVID	2023-12-19 17:16:12.058452	\N
1207	3541	16	4	Aprobación Cr SARMIENTO ORJUELA ARIAN 	2023-12-19 17:16:52.321044	\N
1208	3542	16	4	Aprobación Cr REAL RUEDA MAGDA MILENA	2023-12-20 09:39:05.892222	\N
1209	3543	16	4	Aprobación Cr    ROMERO LARRAHONDO PAULO	2023-12-20 11:30:57.216376	\N
1210	3544	16	4	Aprobación Cr    GÓMEZ CAMPO VÍCTOR MANUEL 	2023-12-20 11:31:32.858201	\N
1211	3545	16	4	Aprobación Cr    RODRIGUEZ MEJIA KARLA 	2023-12-20 11:32:01.323459	\N
1212	3546	16	4	Aprobación Cr    BENAVIDES DIAZ DANIEL 	2023-12-20 11:32:31.976318	\N
1213	3547	16	4	Aprobación Cr    GUTIERREZ CEBALLOS OSCAR 	2023-12-20 11:32:54.484592	\N
1214	3548	16	4	Aprobación Cr    DUARTE RUIZ ALVARO	2023-12-20 11:33:19.213892	\N
1215	3549	16	4	Aprobación Cr    ZAMBRANO ACOSTA INGRID 	2023-12-20 11:34:30.407859	\N
1216	3550	16	4	Aprobación Cr    ZAMBRANO ACOSTA INGRID	2023-12-20 11:34:55.565385	\N
1217	3551	37	4	 PAZ Y SALVO AMAYA MARQUEZ MARISOL	2023-12-20 16:00:28.865794	\N
1218	3552	16	4	Aprobación Cupo Rotativo Pavajeau Hermes Francisco	2023-12-20 16:13:36.256669	\N
1219	3553	16	4	Aprobación Cr Bejarano Pardo Hayde 	2023-12-20 16:14:14.117984	\N
1220	3554	129	7	Seguimiento al proyecto de seguridad de la información.	2023-12-21 08:49:48.034005	\N
1221	3555	129	2	Respuesta seguimiento al proyecto de seguridad de la información.	2023-12-21 08:51:37.174221	\N
1222	3556	32	7	PROVISION DE EFECTIVO CAJA	2023-12-21 09:21:51.333856	\N
1223	3557	32	7	CANCELACION CTA DE AHORROS BBVA	2023-12-21 09:43:43.736347	\N
1224	3558	29	6	CARTA DE BIENVENIDA ORJUELA URQUIJO JESUS ANTONIO	2023-12-21 09:58:18.942358	\N
1225	3559	29	6	CARTA DE BIENVENIDA ROMERO GONZALEZ JAIME YECID	2023-12-21 09:58:33.945367	\N
1226	3560	29	6	CARTA DE BIENVENIDA VELANDIA BLANCO LAURA MAYERLY	2023-12-21 09:58:54.210229	\N
1227	3561	16	4	Aprobación Cr Martinez carlos Julio 	2023-12-21 11:25:13.462184	\N
1228	3562	32	4	PROVISION D EEFECTIVO	2023-12-21 12:40:30.665924	\N
1229	3563	122	8	Autorización para declaración final de delineación urbana, secretaría de hacienda	2023-12-21 16:08:28.132746	\N
1230	3564	16	4	Aprobación Cr GARZON ROBAYO ANGEL PAVEL	2023-12-21 16:10:32.29133	\N
1231	3565	16	4	Aprobación Cr GARZON ROBAYO ANGEL PAVEL	2023-12-21 16:10:33.897695	\N
1232	3566	16	4	Aprobación Cr LEÓN MOLINA HELIA BIBIANA 	2023-12-21 16:11:52.614053	\N
1233	3567	32	4	RESPUESTA A DIR CONTROL INTERNO MEMO-DCI3322 WM473385	2023-12-22 08:38:22.568786	\N
1234	3568	5	4	CERTIFICADO ALVARO AVILA QUINTERO	2023-12-22 14:22:49.868639	\N
1235	3569	14	4	Carta aprobación MEDINA CASTAÑEDA ELVA YOLANDA	2023-12-22 16:35:05.408701	\N
1236	3570	14	4	Derecho de peticion 	2023-12-22 17:47:34.777544	\N
1237	3571	16	4	Aprobación Cr   RODRIGUEZ JIMENEZ LUIS VICENTE 	2023-12-26 10:46:07.331961	\N
1238	3572	16	4	Aprobación Cr   USECHE LOPEZ RICARDO 	2023-12-26 10:46:35.303217	\N
1239	3573	16	4	Aprobación Cr   BORNACELLI ACOSTA FIORELLA 	2023-12-26 10:46:58.881756	\N
1240	3574	16	4	Aprobación Cr   PEÑALOZA SUAREZ ELIANA 	2023-12-26 10:49:27.773888	\N
1241	3575	16	4	Aprobación Cr   JARAMILLO GUERRA PATRICIA 	2023-12-26 10:49:51.307554	\N
1242	3576	16	4	Aprobación Cr    HUERTAS MILLAN LUCIA 	2023-12-26 10:50:15.205836	\N
1243	3577	16	4	Aprobación Cr   SÁNCHEZ RIVERA CLAUDIA	2023-12-26 10:50:44.776433	\N
1244	3578	16	4	Aprobación Cr   HINCAPIÉ CETINA DIANA 	2023-12-26 10:51:09.088145	\N
1245	3579	16	4	Aprobación Cr   BRICEÑO GAMBA WILLIAM 	2023-12-26 10:51:33.878033	\N
1246	3580	16	4	Aprobación Cr   PORTILLA GAMBOA MODESTO 	2023-12-26 10:52:01.620366	\N
1247	3581	16	4	Aprobación Cr   PARRA RODRIGUEZ JUANA OLIVA 	2023-12-26 10:52:27.928709	\N
1248	3582	16	4	Aprobación Cr   GONZALEZ NAVARRETE JULIO 	2023-12-26 10:52:51.566116	\N
1249	3583	16	4	Aprobación Cr   CHACON SIERRA GIOVANNI 	2023-12-26 10:53:18.080148	\N
1250	3584	16	4	Aprobación Cr   GUTIERREZ CEBALLOS OSCAR 	2023-12-26 10:58:22.288032	\N
1251	3585	119	6	CARTA DE APROBACIÓN DE RETIRO- MONICA PAOLA BEJARANO CASTILLO	2023-12-26 11:08:20.182237	\N
1252	3586	119	6	CARTA DE APROBACIÓN DE RETIRO- DIVA YANIRA CRIOLLO VARGAS 	2023-12-26 11:08:56.079819	\N
1253	3587	119	6	CARTA DE APROBACIÓN DE RETIRO POR FALLECIMIENTO- MARIA CONSUELO DIAZ BAEZ 	2023-12-26 11:09:52.872919	\N
1254	3588	119	6	CARTA DE APROBACIÓN DE RETIRO POR FALLECIMIENTO- MARIA XIMENA HERNANDEZ VANEGAS 	2023-12-26 11:11:04.251124	\N
1255	3589	119	6	CARTA DE APROBACIÓN DE RETIRO- MARTA LUZ OCHOA CARDENAS 	2023-12-26 11:13:13.945947	\N
1256	3590	29	6	CARTA DE BIENVENIDA OLARTE PARDO MAGALY	2023-12-26 11:27:09.760405	\N
1257	3591	15	7	Reporte reducción del fondo de liquidez SES	2023-12-26 15:54:28.021134	\N
1258	3592	16	4	Aprobación Cr GONZALEZ CAMPOS STELLA	2023-12-26 17:27:27.254045	\N
1259	3593	5	4	CERTIFICADO CLARA ELENA CHAMORRO BELLO	2023-12-27 07:28:53.780456	\N
1260	3594	32	4	TRASL DE FINANDINA A FONVAL	2023-12-27 08:14:04.187184	\N
1261	3595	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-27 10:30:28.25407	\N
1262	3596	16	4	Aprobación Cr   ALHIPPIO CHAVARRO ISABEL CRISTINA	2023-12-27 10:55:29.877872	\N
1263	3597	16	4	ALHIPPIO CHAVARRO ISABEL CRISTINA	2023-12-27 10:56:20.272195	\N
1264	3598	16	4	Aprobación Cr  CETRE CASTILLO MOISES 	2023-12-27 10:57:03.697229	\N
1265	3599	16	4	Aprobación Cr  RODRIGUEZ MEJIA KARLA 	2023-12-27 10:57:32.357858	\N
1266	3600	16	4	Aprobación Cr  GOMEZ GRANADOS FERNANDO	2023-12-27 10:58:02.190461	\N
1267	3601	16	4	Aprobación Cr MANCERA RODRIGUEZ MATEO  	2023-12-27 10:58:37.407579	\N
1268	3602	16	4	Aprobación Cr  NAVARRO DE MORALES AMPARO 	2023-12-27 10:59:09.845833	\N
1269	3603	16	4	Aprobación Cr  VELANDIA BLANCO LAURA 	2023-12-27 10:59:47.665747	\N
1270	3604	16	4	Aprobación Cr  ARAQUE SALAMANCA AMILCAR 	2023-12-27 11:00:18.737435	\N
1271	3605	16	4	Aprobación Cr  BARRERO RUSSI MARTHA	2023-12-27 11:00:50.092054	\N
1272	3606	16	4	Aprobación Cr  CASAS GAONA LUZ IMELDA 	2023-12-27 11:01:19.742286	\N
1273	3607	37	4	 CERTIFICADO DE DEUDA CREDITO AL DIA CHAMORRO BELLO CLARA ELENA	2023-12-28 08:31:32.199643	\N
1274	3608	37	4	 PAZ Y SALVO ZGAIB ABURAD MARIAM GLORIA	2023-12-28 08:40:03.907832	\N
1275	3609	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-28 08:52:54.584528	\N
1276	3610	16	4	Aprobación Cr  MIRANDA CORTES BEATRIZ 	2023-12-28 09:34:50.310215	\N
1277	3611	16	4	Aprobación Cr  PERILLA FINO EDWIN 	2023-12-28 09:35:19.797901	\N
1278	3612	16	4	Aprobación Cr  SENDOYA  LUIS ANDRES 	2023-12-28 09:35:43.268417	\N
1279	3613	16	4	Aprobación Cr  TORRES NARVAEZ FLOR 	2023-12-28 09:36:40.129665	\N
1280	3614	16	4	Aprobación Cr  PEREZ BARRAGAN MONICA 	2023-12-28 09:37:07.835347	\N
1281	3615	16	4	Aprobación Cr  MORENO LACHE NUBIA 	2023-12-28 09:37:26.479776	\N
1282	3616	16	4	Aprobación Cr   DAZA CASTILLO JEANNETTE 	2023-12-28 09:37:46.872984	\N
1283	3617	16	4	Aprobación Cr  MONTENEGRO DE CARRILLO NOHORA 	2023-12-28 09:38:11.183947	\N
1284	3618	16	4	Aprobación Cr  RODRIGUEZ ORTIZ EDINSON	2023-12-28 09:38:47.449989	\N
1285	3619	32	4	PROVISION DE EFECTIVO CAJA	2023-12-28 10:40:32.430767	\N
1286	3620	16	4	Aprobación Blue Card PERILLA FINO EDWIN ALIRIO	2023-12-28 11:52:45.262833	\N
1287	3621	29	6	CARTA DE BIENVENIDA  LINARES NAVARRO GUIOMAR	2023-12-29 08:10:16.606131	\N
1288	3622	29	6	CARTA DE BIENVENIDA JIMENEZ CADAVID JHOVANNA PAOLA	2023-12-29 08:10:36.387751	\N
1289	3623	29	6	CARTA DE BIENVENIDA AMOROCHO SALAZAR MARTHA CECILIA	2023-12-29 08:10:50.417315	\N
1290	3624	29	6	CARTA DE BIENVENIDA LOPEZ TELLEZ ESTEBAN	2023-12-29 08:11:04.817114	\N
1291	3625	29	6	CARTA DE BIENVENIDA VALBUENA GUAIRIYU LUIS ALBERTO	2023-12-29 08:11:21.824861	\N
1292	3626	29	6	CARTA DE BIENVENIDA OLARTE SANCHEZ ISABELLA	2023-12-29 08:11:42.265157	\N
1293	3627	37	4	 PAZ Y SALVO PARA LEVANTAMIENTO ALVARADO FLOREZ LILIANA ESTHER	2023-12-29 08:45:27.394046	\N
1294	3628	16	4	Aprobación Blue Card SENDOYA ZAMUDIO LUIS ANDRES 	2023-12-29 09:05:41.509503	\N
1295	3629	5	4	CERTIFICADO CLAUDINE FLOREN BELLANGER VERONIQUE	2023-12-29 10:17:43.571116	\N
1296	3630	122	9	Respuesta a la superintendencia de economía solidaria respecto de la petición presentada por sra LUCY GABRIELA DELGADO	2023-12-29 10:27:46.155952	\N
1297	3631	10	3	solicitud de Información enero 2024	2023-12-29 11:31:18.924866	\N
1298	3632	10	3	solicitud de Información enero 2024	2023-12-29 11:31:54.601903	\N
1299	3633	10	3	solicitud de Información enero 2024	2023-12-29 11:32:05.666538	\N
1300	3634	10	3	solicitud de Información enero 2024	2023-12-29 11:32:16.116773	\N
1301	3635	10	3	solicitud de Información enero 2024	2023-12-29 11:32:26.736136	\N
1302	3636	10	3	solicitud de Información enero 2024	2023-12-29 11:32:35.370677	\N
1303	3637	10	3	solicitud de Información enero 2024	2023-12-29 11:32:48.594861	\N
1304	3638	10	3	solicitud de Información enero 2024	2023-12-29 11:33:03.607939	\N
1305	3639	10	3	solicitud de Información enero 2024	2023-12-29 11:33:19.354656	\N
1306	3640	10	3	solicitud de Información enero 2024	2023-12-29 11:33:29.473025	\N
1307	3641	10	3	solicitud de Información enero 2024	2023-12-29 11:33:40.785296	\N
1308	3642	10	3	solicitud de Información enero 2024	2023-12-29 11:33:54.31365	\N
1309	3643	10	3	solicitud de Información enero 2024	2023-12-29 11:34:08.6799	\N
1310	3644	10	3	solicitud de Información enero 2024	2023-12-29 11:34:20.025789	\N
1311	3645	10	3	solicitud de Información enero 2024	2023-12-29 11:34:29.137342	\N
1312	3646	10	3	solicitud de Información enero 2024	2023-12-29 11:34:39.506007	\N
1313	3647	10	3	solicitud de Información enero 2024	2023-12-29 11:34:52.050961	\N
1314	3648	10	3	solicitud de Información enero 2024	2023-12-29 11:35:06.249084	\N
1315	3649	10	3	solicitud de Información enero 2024	2023-12-29 11:35:16.849777	\N
1316	3650	10	3	solicitud de Información enero 2024	2023-12-29 11:35:27.585555	\N
1317	3651	10	3	solicitud de Información enero 2024	2023-12-29 11:35:36.835547	\N
1318	3652	10	3	solicitud de Información enero 2024	2023-12-29 11:35:49.611054	\N
1319	3653	10	3	solicitud de Información enero 2024	2023-12-29 11:35:57.277105	\N
1320	3654	10	3	solicitud de Información enero 2024	2023-12-29 11:36:07.676421	\N
1321	3655	10	3	solicitud de Información enero 2024	2023-12-29 11:36:16.92437	\N
1322	3656	10	3	solicitud de Información enero 2024	2023-12-29 11:36:27.604034	\N
1323	3657	10	3	solicitud de Información enero 2024	2023-12-29 11:36:36.131283	\N
1324	3658	10	3	solicitud de Información enero 2024	2023-12-29 11:36:51.019316	\N
1325	3659	10	3	solicitud de Información enero 2024	2023-12-29 11:37:00.893264	\N
1326	3660	29	6	CARTA DE BIENVENIDA MARTINEZ SANCHEZ CLARA TERESA	2023-12-29 13:38:45.158684	\N
1327	3661	29	6	CARTA DE BIENVENIDA LOPEZ CANTOR LUIS FERNANDO	2023-12-29 13:39:10.011936	\N
1328	3662	29	6	CARTA DE BIENVENIDA MATIZ CARDENAS MARIANA ROSA DELIA	2023-12-29 13:39:28.207908	\N
1329	3663	29	6	CARTA DE BIENVENIDA PARRA MEDINA ASTRID LUCILA	2023-12-29 13:39:44.259757	\N
1330	3664	29	6	CARTA DE BIENVENIDA MESA CALDERON SARA VALENTINA	2023-12-29 13:40:01.074334	\N
1331	3665	29	6	CARTA DE BIENVENIDA FULA SOTELO GUSTAVO ADOLFO	2023-12-29 13:40:15.930531	\N
1332	3666	29	6	CARTA DE BIENVENIDA PORTILLA CORTES ANGELICA MARIA	2023-12-29 13:40:34.289902	\N
1333	3667	37	4	CERTIFICADO PATRICIA MARTINEZ	2023-12-29 15:56:54.794559	\N
1334	3668	14	4	Respuesta control interno DCI 3331	2023-12-29 16:20:36.817864	\N
1335	3669	5	4	CERTIFICADO CONSUELO MARTINEZ DE MORGENSZTERN	2023-12-29 16:58:52.937101	\N
1336	3670	120	4	OTORGAMIENTO PERIODO DE GRACIA ADRIANA GOMEZ	2023-12-31 17:56:29.689477	\N
1337	3671	120	4	RESPUESTA RECLAMACION SINIESTRO ASEGURABILIDAD BELALCAZAR	2023-12-31 17:57:20.351417	\N
1338	1	32	7	PROVISION DE EFECTIVO	2024-01-02 14:22:47.446646	\N
1339	2	32	7	PROVISION DE EFECTIVO	2024-01-02 14:23:29.550078	\N
1341	4	133	7	Solicitud de títulos a nombre de la Cooperativa  que existen en el Banco Agrario	2024-01-03 08:59:25.031293	\N
1342	5	37	4	 CERTIFICADO CREDITO HIPOTECARIO CORTE 31 DE DICIEMBRE MURILLO TINOCO ERIKA DEL PILAR	2024-01-03 10:42:07.354766	\N
1343	6	29	6	CARTA DE BIENVENIDA VASQUEZ LAMPREA BRAYAN NICOLAS	2024-01-03 14:24:46.092924	\N
1344	7	29	6	CARTA DE BIENVENIDA BARRERA LOPEZ YILSEIT ILEIN	2024-01-03 14:26:11.406527	\N
1345	8	29	6	CARTA DE BIENVENIDA RAMIREZ RIOS MANUEL ALEJANDRO	2024-01-03 14:26:34.359052	\N
1346	9	29	6	CARTA DE BIENVENIDA DIAZ SANCHEZ ANGELA MARIA	2024-01-03 14:26:57.849986	\N
1347	10	29	6	CARTA DE BIENVENIDA BARRERA SIERRA LILIANA	2024-01-03 17:20:18.692888	\N
1348	11	29	6	CARTA DE BIENVENIDA DELGADILLO BARRERA SARA	2024-01-03 17:20:38.801759	\N
1349	12	133	4	Solicitud de terminación de proceso judicial	2024-01-04 08:32:21.694684	\N
1350	13	1	1	Consecutivo de prueba 2024	2024-01-04 10:47:10.546629	\N
1351	2534	1	1	Ultimo consecutivo manual	2024-10-04 10:47:10.546	\N
1446	2535	163	1	Probar consecutivo	2024-10-10 14:40:35	\N
1459	2536	163	1	Prueba	2024-10-10 16:28:54	\N
1460	2537	163	1	prueb	2024-10-10 16:30:13	\N
1461	2538	163	1	prueba	2024-10-10 16:30:58	\N
1462	2539	163	1	prueba	2024-10-10 16:31:38	\N
1463	2540	163	1	prueba	2024-10-10 16:37:41	\N
1464	2541	163	1	prueba	2024-10-10 16:37:41	\N
1465	2542	163	1	asd	2024-10-10 16:39:24	\N
1466	2543	163	1	prueba	2024-10-10 16:41:59	\N
1467	2544	163	1	prueba	2024-10-10 16:43:13	\N
1468	2545	163	1	prueba	2024-10-10 16:44:54	\N
1469	2546	163	1	asd	2024-10-10 16:46:31	\N
1470	2547	145	1	pruebas	2024-10-10 16:48:10	\N
1471	2548	145	1	pruebas	2024-10-10 16:48:10	\N
1472	2549	145	1	pruebas	2024-10-10 16:48:10	\N
1473	2550	145	1	prueba	2024-10-10 16:49:57	\N
1474	2551	145	1	pruebas1|	2024-10-10 16:50:42	\N
1475	2552	145	3	asdsa	2024-10-10 16:51:31	\N
1476	2553	145	3	pruebaQ 	2024-10-10 16:52:37	\N
1477	2554	145	9	ASDA	2024-10-10 16:52:48	\N
1478	2555	145	7	ASDSA	2024-10-10 16:52:59	\N
1479	2556	163	1	prueba	2024-10-10 16:53:18	\N
1480	2557	163	1	prueba	2024-10-10 16:53:18	\N
1481	2558	163	1	prueba	2024-10-10 16:54:03	\N
1482	2559	163	1	p	2024-10-10 16:54:35	\N
1483	2560	163	1	asd	2024-10-10 16:55:12	\N
1484	2561	163	1	asd	2024-10-10 16:55:16	\N
1485	2562	163	1	ppp	2024-10-10 16:55:25	\N
1486	2563	163	1	ppp	2024-10-10 16:55:25	\N
1487	2564	163	1	prueba	2024-10-10 16:56:23	\N
1488	2565	163	1	validando	2024-10-10 16:58:24	\N
1489	2566	163	1	validando	2024-10-10 16:58:24	\N
1490	2567	163	1	validando	2024-10-10 16:58:24	\N
1491	2568	163	1	sad	2024-10-10 17:00:21	\N
1492	2569	145	1	hi mundo	2024-10-10 17:30:55	\N
1493	2570	163	1	Prueba consecutivo 001	2024-10-10 17:35:23	\N
1494	2571	163	1	Validacion	2024-10-10 17:44:31	\N
\.


--
-- TOC entry 4821 (class 0 OID 16401)
-- Dependencies: 222
-- Data for Name: opcion_por_perfil; Type: TABLE DATA; Schema: consecutivo; Owner: postgres
--

COPY consecutivo.opcion_por_perfil (opcion_id, perfil_id, descripcion, descripcion_corta, activa) FROM stdin;
1	1	Reiniciar numeración de consecutivo, por cambio de año o por solicitud de ajuste	Ajusta consecutivo	1
2	1	Administración de perfiles y usuarios.	Admon. Perfiles-Usuario	1
3	1	Consultas de nivel administrativo operativo.	Consultas	1
4	2	Generar consecutivos.	Generar consecutivo	1
5	3	Reportes de control y auditoría.	Auditoria y control	1
6	2	Reportes de generación de consecutivos.	Consecutivos Generados	1
\.


--
-- TOC entry 4824 (class 0 OID 16408)
-- Dependencies: 225
-- Data for Name: perfil; Type: TABLE DATA; Schema: consecutivo; Owner: postgres
--

COPY consecutivo.perfil (perfil_id, perfil, activo, perfil_defecto) FROM stdin;
1	Administrador	1	0
4	Consulta nivel 2	1	0
3	Auditoría y Control	1	0
2	Usuario Generador	1	1
\.


--
-- TOC entry 4828 (class 0 OID 16416)
-- Dependencies: 229
-- Data for Name: perfil_usuario; Type: TABLE DATA; Schema: consecutivo; Owner: postgres
--

COPY consecutivo.perfil_usuario (fecha_asociacion_perfil, perfil_id, usuario_id) FROM stdin;
\.


--
-- TOC entry 4830 (class 0 OID 16422)
-- Dependencies: 231
-- Data for Name: prefijo; Type: TABLE DATA; Schema: consecutivo; Owner: postgres
--

COPY consecutivo.prefijo (prefijo_id, prefijo, descripcion_prefijo) FROM stdin;
3	CI	CONTROL INTERNO
7	GG	GERENCIA/SUBGERENCIA
9	JV	JUNTA DE VIGILANCIA
8	JR	AREA JURÍDICA
10	CA	CONSEJO DE ADMINISTRACIÓN
4	DF	DIRECCIÓN FINANCIERA
5	DA	DIRECCIÓN ADMINISTRATIVA
6	DC	DIRECCIÓN COMERCIAL
1	DT	DIRECCIÓN TICS
2	CR	COORDINACIÓN RIESGOS
\.


--
-- TOC entry 4826 (class 0 OID 16412)
-- Dependencies: 227
-- Data for Name: usuario; Type: TABLE DATA; Schema: consecutivo; Owner: postgres
--

COPY consecutivo.usuario (usuario_id, usuario_nombre, usuario_ldap, pasword) FROM stdin;
1	ANDRES MAURICIO CARDENAS SANCHEZ	acardenas	TEMPO2024
3	MIGUEL ANGEL CASTAÑEDA ROCHA	mcastaneda	TEMPO2024
4	LIZETH ANDREA AMAYA GUANEME	lamaya	TEMPO2024
5	SANDY VANESSA BERROCAL PATERNINA	sberrocal	TEMPO2024
6	PAOLA ANDREA PATIÑO CASTAÑEDA	pcastaneda	TEMPO2024
7	YEIMY VIVIANA REYES CUERVO	yvreyes	TEMPO2024
163	Juan Sebastían Rincón Calderón	jrincon	LOL
9	DAMARIS  REYES CASTRO	dreyes	TEMPO2024
10	MARTHA YINETH PEREZ BARRAGAN	mperez	TEMPO2024
12	OLIVA  GARZON AREVALO	ggarzon	TEMPO2024
13	LUZ YOLANDA ACUÑA GONZALEZ	lacuna	TEMPO2024
14	ANDREA  BECERRA GOMEZ	abecerra	TEMPO2024
17	NELSY JOHANA AVILA PEDROZA	navila	TEMPO2024
18	CESAR ARNOVIL SOSSA CHAPARRO	csossa	TEMPO2024
19	ANGIEE LORENA PINZON PACHON	apinzon	TEMPO2024
20	JUAN CARLOS OSORIO ECHEVERRI	josorio	TEMPO2024
21	JOSE ANDERSON CASTILLO RODRIGUEZ	jcastillo	TEMPO2024
22	LAURA GABRIELA MORENO MARTINEZ	lmoreno	TEMPO2024
23	JOSE HUMBERTO BALAGUERA RICARDO	jbalaguera	TEMPO2024
24	HECTOR RAUL RUIZ VELANDIA	hruiz	TEMPO2024
25	EDGAR ASDRUBAL ALARCON QUINTERO	ealarcon	TEMPO2024
26	MARVIN SANTIAGO ORDOÑEZ ORDOÑEZ	mordonez	TEMPO2024
27	ANDREA  TOVAR FIGUEROA	atovar	TEMPO2024
29	DIANA MARIA FONSECA BARBOSA	dfonseca	TEMPO2024
30	INGRID YULIANA ROSAS CUBILLOS	irosas	TEMPO2024
31	BRIAN ANDRES CORONADO ZAPATA	bcoronado	TEMPO2024
32	PEDRO NEL CASAS 	pcasas	TEMPO2024
33	ANGIE KATHERIN GUZMAN DURAN	aguzman	TEMPO2024
34	KAREN  BUSTAMANTE VALCARCEL	kbustamante	TEMPO2024
35	SHIRLEY MERCEDES TAPIA PIZO	stapia	TEMPO2024
36	MAXIMILIANO  MANJARRES CUELLO	mmanjarres	TEMPO2024
37	CAMILA ANDREA MEDINA PÉÑA	cmedina	TEMPO2024
38	SONIA GERALDINE MORA TORRES	smora	TEMPO2024
39	LUZ DARY ALVIZ SIMANCA	lalviz	TEMPO2024
41	MAYRA ALEJANDRA HERRERA FIGUEROA	mherrera	TEMPO2024
42	EDUARDO JOSE MAZUERA RENDON	emazuera	TEMPO2024
43	CRISTIAN GIOVANNI TARAZONA TORRES	ctarazona	TEMPO2024
103	JEISSON ANTONIO VELOSA SURINCHO	jvelosa	TEMPO2024
118	Edilberto Forero Vivas	eforero	TEMPO2024
119	Nicolas Fernando Castillo Tabares	ncastillo	TEMPO2024
120	Sandra Milena León Ortiz	sleon	TEMPO2024
121	Maria Fernanda Rivas Correa	mrivas	TEMPO2024
122	Hans Sebastian Alvarez Rinco	halvarez	TEMPO2024
123	Ingrid Maritza Beltran Misas	ibeltran	TEMPO2024
109	sin usuario	pruebas	TEMPO2024
124	Héctor Raúl Ariza Ardila	hariza	TEMPO2024
125	Lina Maria Otero Carvajal	lotero	TEMPO2024
126	Leidy Johana Castillo Gonzalez	lcastillo	TEMPO2024
11	JORGE ALVARO MORA GRAJALES	jmorag	TEMPO2024
15	ELSA  SANABRIA RODRÍGUEZ	esanabria	TEMPO2024
16	JHON ALEXANDER MORA BELTRAN	amora	TEMPO2024
28	LUZ ADRIANA GARCIA LOPEZ	agarcia	TEMPO2024
127	Frank Andrés Gómez Villamizar	fgomezv	TEMPO2024
40	GLADYS MILENA VALBUENA LIZARAZO	gvalbuena	TEMPO2024
128	Lina María Ruíz Parra	lruizp	TEMPO2024
129	ANGELA VIVIANA CRUZ IBAÑEZ	acruz	TEMPO2024
130	Jackeline Piñeros Londoño	jpineros	TEMPO2024
117	Junta Vigilancia	jvigilancia	TEMPO2024
131	Yeison Stiven Simijaca Torralba	ysimijaca	TEMPO2024
132	Yeison Stiven Simijaca Torralba	ysimijaca	TEMPO2024
133	Daniel Fernando Ariza Abril	dariza	TEMPO2024
134	Yuri Milena Ordoñez Rodriguez	yordoñez	TEMPO2024
135	Ángela María Montero Gonzalez	amontero	TEMPO2024
136	Margie Lizeth Umbarila Murcia	lumbarila	TEMPO2024
137	Yulieth Natalia Guevara Puentes	yguevara	TEMPO2024
138	Julieth Camila Daza Pinzón	jdaza	TEMPO2024
139	Laura Daniela León Ortiz	lortiz	TEMPO2024
140	Valeria Dayana Malaver Gómez	vmalaver	TEMPO2024
141	Ivonne Tatiana Castiblanco Hernández	icastiblanco	TEMPO2024
142	Diego Fernando Villareal Diaz	dvillareal	TEMPO2024
143	Silvia Fernanda Otálvaro López	sotalvaro	TEMPO2024
144	Ángel Gabriel López Cubides	alopez	TEMPO2024
8	WILLINTON DE JESUS ORTIZ MARTINEZ	wortiz	1234
146	pruebas1	pruebas1	TEMPO2024
147	Soporte Linix	SLINIX	TEMPO2024
148	Diana Marcela León Palacios	dleon	TEMPO2024
149	Oscar Alfonso Ardila Jiménez	oardila.ext	TEMPO2024
150	Sandra Bibiana Arias Martínez	sarias.ext	TEMPO2024
151	German Felipe Molina Camargo	gmolina	TEMPO2024
152	Hernan Darío Ramos Mariño	hramos	TEMPO2024
153	Harol Yesid Castañeda Astudillo	hcastaneda	TEMPO2024
154	Maria Isabel Villegas Pulido	mvillegas	TEMPO2024
155	Plugin GLPI Inventory	Plugin_GLPI_Inventory	TEMPO2024
156	Sandra Milena Cubides Guerrero	scubides	TEMPO2024
157	Jose Luis Velasco Nieto	jvelasco	TEMPO2024
158	Biller Leonel Bustos Santos	bbustos	TEMPO2024
159	Liliana Cifuentes López	lcifuentes	TEMPO2024
160	Claudia Patricia Cifuentes Mikan	ccifuentes	TEMPO2024
161	Vanessa Adelina Hernández	vhernandez	TEMPO2024
162	Ingrid Nataly Pulecio Triana	npulecio	TEMPO2024
164	Karen Gonzalez Karen Jissend Gonzalez Guerrero	kgonzalez	TEMPO2024
145	Gilberto Martinez Santos	gmartinez	Tempo20245
\.


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 219
-- Name: gestion_consecutivo_consecutivo_seq; Type: SEQUENCE SET; Schema: consecutivo; Owner: postgres
--

SELECT pg_catalog.setval('consecutivo.gestion_consecutivo_consecutivo_seq', 2559, true);


--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 221
-- Name: historia_consecutivo_consecutivo_id_seq; Type: SEQUENCE SET; Schema: consecutivo; Owner: postgres
--

SELECT pg_catalog.setval('consecutivo.historia_consecutivo_consecutivo_id_seq', 1687, true);


--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 223
-- Name: opcion_por_perfil_opcion_id_seq; Type: SEQUENCE SET; Schema: consecutivo; Owner: postgres
--

SELECT pg_catalog.setval('consecutivo.opcion_por_perfil_opcion_id_seq', 6, true);


--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 224
-- Name: opcion_por_perfil_perfil_id_seq; Type: SEQUENCE SET; Schema: consecutivo; Owner: postgres
--

SELECT pg_catalog.setval('consecutivo.opcion_por_perfil_perfil_id_seq', 1, false);


--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 226
-- Name: perfil_perfil_id_seq; Type: SEQUENCE SET; Schema: consecutivo; Owner: postgres
--

SELECT pg_catalog.setval('consecutivo.perfil_perfil_id_seq', 4, true);


--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 230
-- Name: perfil_usuario_perfil_id_seq; Type: SEQUENCE SET; Schema: consecutivo; Owner: postgres
--

SELECT pg_catalog.setval('consecutivo.perfil_usuario_perfil_id_seq', 1, false);


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 232
-- Name: prefijo_prefijo_id_seq; Type: SEQUENCE SET; Schema: consecutivo; Owner: postgres
--

SELECT pg_catalog.setval('consecutivo.prefijo_prefijo_id_seq', 10, true);


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 228
-- Name: usuario_usuario_id_seq; Type: SEQUENCE SET; Schema: consecutivo; Owner: postgres
--

SELECT pg_catalog.setval('consecutivo.usuario_usuario_id_seq', 184, true);


--
-- TOC entry 4656 (class 2606 OID 16435)
-- Name: gestion_consecutivo pk_gestion_consecutivo; Type: CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.gestion_consecutivo
    ADD CONSTRAINT pk_gestion_consecutivo PRIMARY KEY (consecutivo);


--
-- TOC entry 4658 (class 2606 OID 16437)
-- Name: historia_consecutivo pk_historia_consecutivo; Type: CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.historia_consecutivo
    ADD CONSTRAINT pk_historia_consecutivo PRIMARY KEY (consecutivo_id);


--
-- TOC entry 4660 (class 2606 OID 16439)
-- Name: opcion_por_perfil pk_opcion_por_perfil; Type: CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.opcion_por_perfil
    ADD CONSTRAINT pk_opcion_por_perfil PRIMARY KEY (opcion_id);


--
-- TOC entry 4662 (class 2606 OID 16441)
-- Name: perfil pk_perfil; Type: CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.perfil
    ADD CONSTRAINT pk_perfil PRIMARY KEY (perfil_id);


--
-- TOC entry 4666 (class 2606 OID 16443)
-- Name: prefijo pk_prefijo; Type: CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.prefijo
    ADD CONSTRAINT pk_prefijo PRIMARY KEY (prefijo_id);


--
-- TOC entry 4664 (class 2606 OID 16445)
-- Name: usuario pk_usuario; Type: CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (usuario_id);


--
-- TOC entry 4667 (class 2606 OID 16446)
-- Name: historia_consecutivo fk_historia_consecutivo_prefijo; Type: FK CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.historia_consecutivo
    ADD CONSTRAINT fk_historia_consecutivo_prefijo FOREIGN KEY (prefijo_id) REFERENCES consecutivo.prefijo(prefijo_id);


--
-- TOC entry 4668 (class 2606 OID 16451)
-- Name: historia_consecutivo fk_historia_consecutivo_usuario; Type: FK CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.historia_consecutivo
    ADD CONSTRAINT fk_historia_consecutivo_usuario FOREIGN KEY (usuario_id) REFERENCES consecutivo.usuario(usuario_id);


--
-- TOC entry 4669 (class 2606 OID 16456)
-- Name: opcion_por_perfil fk_opcion_por_perfil_perfil; Type: FK CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.opcion_por_perfil
    ADD CONSTRAINT fk_opcion_por_perfil_perfil FOREIGN KEY (perfil_id) REFERENCES consecutivo.perfil(perfil_id);


--
-- TOC entry 4670 (class 2606 OID 16461)
-- Name: perfil_usuario fk_perfil_usuario_perfil; Type: FK CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.perfil_usuario
    ADD CONSTRAINT fk_perfil_usuario_perfil FOREIGN KEY (perfil_id) REFERENCES consecutivo.perfil(perfil_id);


--
-- TOC entry 4671 (class 2606 OID 16466)
-- Name: perfil_usuario fk_perfil_usuario_usuario; Type: FK CONSTRAINT; Schema: consecutivo; Owner: postgres
--

ALTER TABLE ONLY consecutivo.perfil_usuario
    ADD CONSTRAINT fk_perfil_usuario_usuario FOREIGN KEY (usuario_id) REFERENCES consecutivo.usuario(usuario_id);


-- Completed on 2025-01-08 08:52:23

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2025-01-08 08:52:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 16481)
-- Name: consecutivos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA consecutivos;


ALTER SCHEMA consecutivos OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16482)
-- Name: f_trg_hist_consecutivo(); Type: FUNCTION; Schema: consecutivos; Owner: postgres
--

CREATE FUNCTION consecutivos.f_trg_hist_consecutivo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare v_fecha_generacion timestamp;
	declare v_hash_key numeric(10,0);
	declare v_consecutivo bigint;
begin
	v_fecha_generacion := current_timestamp;  
	v_hash_key := ceiling(random()*1000000000);	

	insert into consecutivo.gestion_consecutivo(hash_key,fecha_genera_consecutivo) 
	values (v_hash_key, v_fecha_generacion);

	select consecutivo into v_consecutivo
	from consecutivo.gestion_consecutivo
	where hash_key = v_hash_key and fecha_genera_consecutivo = v_fecha_generacion;

	update consecutivo.historia_consecutivo
	set consecutivo=v_consecutivo
	where consecutivo_id = new.consecutivo_id;

	return new;
end;
$$;


ALTER FUNCTION consecutivos.f_trg_hist_consecutivo() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16483)
-- Name: gestion_consecutivo; Type: TABLE; Schema: consecutivos; Owner: postgres
--

CREATE TABLE consecutivos.gestion_consecutivo (
    consecutivo bigint NOT NULL,
    hash_key integer,
    fecha_genera_consecutivo timestamp without time zone
);


ALTER TABLE consecutivos.gestion_consecutivo OWNER TO postgres;

--
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN gestion_consecutivo.consecutivo; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.gestion_consecutivo.consecutivo IS 'Consecutivo generado asociado al hash aleatorio';


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN gestion_consecutivo.hash_key; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.gestion_consecutivo.hash_key IS 'identificador del último evento de generación de consecutivo.';


--
-- TOC entry 218 (class 1259 OID 16486)
-- Name: gestion_consecutivo_consecutivo_seq; Type: SEQUENCE; Schema: consecutivos; Owner: postgres
--

CREATE SEQUENCE consecutivos.gestion_consecutivo_consecutivo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivos.gestion_consecutivo_consecutivo_seq OWNER TO postgres;

--
-- TOC entry 4843 (class 0 OID 0)
-- Dependencies: 218
-- Name: gestion_consecutivo_consecutivo_seq; Type: SEQUENCE OWNED BY; Schema: consecutivos; Owner: postgres
--

ALTER SEQUENCE consecutivos.gestion_consecutivo_consecutivo_seq OWNED BY consecutivos.gestion_consecutivo.consecutivo;


--
-- TOC entry 219 (class 1259 OID 16487)
-- Name: historia_consecutivo; Type: TABLE; Schema: consecutivos; Owner: postgres
--

CREATE TABLE consecutivos.historia_consecutivo (
    consecutivo_id bigint NOT NULL,
    consecutivo bigint,
    usuario_id bigint NOT NULL,
    prefijo_id bigint NOT NULL,
    descripcion character varying(512) NOT NULL,
    fecha_generacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    num_consecutivo integer
);


ALTER TABLE consecutivos.historia_consecutivo OWNER TO postgres;

--
-- TOC entry 4844 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE historia_consecutivo; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON TABLE consecutivos.historia_consecutivo IS 'almacena cada uno de los consecutivos que los usuarios han solicitado a la aplicación asociado a un prefijo específico. Estos consecutivos numeran especificamente documentos que genera la Cooperativa a nivel de correspondencia.';


--
-- TOC entry 4845 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN historia_consecutivo.consecutivo_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.historia_consecutivo.consecutivo_id IS 'identificador único del consecutivo';


--
-- TOC entry 4846 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN historia_consecutivo.consecutivo; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.historia_consecutivo.consecutivo IS 'Número consecutivo generado por el sistema para un usuario y un prefijo en una fecha específica';


--
-- TOC entry 4847 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN historia_consecutivo.usuario_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.historia_consecutivo.usuario_id IS 'usuario que solicita la creación del consecutivo';


--
-- TOC entry 4848 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN historia_consecutivo.prefijo_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.historia_consecutivo.prefijo_id IS 'identificador del prefijo seleccionado por el usuario al momento de generar un consecutivo';


--
-- TOC entry 4849 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN historia_consecutivo.descripcion; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.historia_consecutivo.descripcion IS 'Breve descripción de la razón de generación del consecutivo. La digita el usuario que lo está solicitando. Debe estar en mayúscula siempre';


--
-- TOC entry 4850 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN historia_consecutivo.fecha_generacion; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.historia_consecutivo.fecha_generacion IS 'Fecha en la que se genera el consecutivo solicitado por el usuario';


--
-- TOC entry 220 (class 1259 OID 16493)
-- Name: historia_consecutivo_consecutivo_id_seq; Type: SEQUENCE; Schema: consecutivos; Owner: postgres
--

CREATE SEQUENCE consecutivos.historia_consecutivo_consecutivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivos.historia_consecutivo_consecutivo_id_seq OWNER TO postgres;

--
-- TOC entry 4851 (class 0 OID 0)
-- Dependencies: 220
-- Name: historia_consecutivo_consecutivo_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivos; Owner: postgres
--

ALTER SEQUENCE consecutivos.historia_consecutivo_consecutivo_id_seq OWNED BY consecutivos.historia_consecutivo.consecutivo_id;


--
-- TOC entry 221 (class 1259 OID 16494)
-- Name: opcion_por_perfil; Type: TABLE; Schema: consecutivos; Owner: postgres
--

CREATE TABLE consecutivos.opcion_por_perfil (
    opcion_id bigint NOT NULL,
    perfil_id bigint NOT NULL,
    descripcion character varying(512),
    descripcion_corta character varying(30),
    activa bit(1)
);


ALTER TABLE consecutivos.opcion_por_perfil OWNER TO postgres;

--
-- TOC entry 4852 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE opcion_por_perfil; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON TABLE consecutivos.opcion_por_perfil IS 'Opciones de cada uno de los perfiles. Una opción es una tarea relacionada a un perfil y que los usuarios inscritos a un perfil pueden ejecutar. Usualmente las opciones de un perfil están atadas a la implementación de un menú de opciones en la herramienta';


--
-- TOC entry 4853 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN opcion_por_perfil.opcion_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.opcion_por_perfil.opcion_id IS 'Identificador único de una opción';


--
-- TOC entry 4854 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN opcion_por_perfil.perfil_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.opcion_por_perfil.perfil_id IS 'Identificador único de un perfil en la aplicación';


--
-- TOC entry 4855 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN opcion_por_perfil.descripcion; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.opcion_por_perfil.descripcion IS 'Descripción de la tarea que indica la acción de la opción. Esta descripción puede hacerse visible como una ayuda cuando un usuario se encuentre en la selección de la opción en el menú.';


--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN opcion_por_perfil.descripcion_corta; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.opcion_por_perfil.descripcion_corta IS 'Descripción que usualmente es la que debe aparecer visualmente en un menú.';


--
-- TOC entry 4857 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN opcion_por_perfil.activa; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.opcion_por_perfil.activa IS 'Indica si la opción está activa.\n\nActiva = 1\nInactiva =0';


--
-- TOC entry 222 (class 1259 OID 16499)
-- Name: opcion_por_perfil_opcion_id_seq; Type: SEQUENCE; Schema: consecutivos; Owner: postgres
--

CREATE SEQUENCE consecutivos.opcion_por_perfil_opcion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivos.opcion_por_perfil_opcion_id_seq OWNER TO postgres;

--
-- TOC entry 4858 (class 0 OID 0)
-- Dependencies: 222
-- Name: opcion_por_perfil_opcion_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivos; Owner: postgres
--

ALTER SEQUENCE consecutivos.opcion_por_perfil_opcion_id_seq OWNED BY consecutivos.opcion_por_perfil.opcion_id;


--
-- TOC entry 223 (class 1259 OID 16500)
-- Name: opcion_por_perfil_perfil_id_seq; Type: SEQUENCE; Schema: consecutivos; Owner: postgres
--

CREATE SEQUENCE consecutivos.opcion_por_perfil_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivos.opcion_por_perfil_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 223
-- Name: opcion_por_perfil_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivos; Owner: postgres
--

ALTER SEQUENCE consecutivos.opcion_por_perfil_perfil_id_seq OWNED BY consecutivos.opcion_por_perfil.perfil_id;


--
-- TOC entry 224 (class 1259 OID 16501)
-- Name: perfil; Type: TABLE; Schema: consecutivos; Owner: postgres
--

CREATE TABLE consecutivos.perfil (
    perfil_id bigint NOT NULL,
    perfil character varying(20),
    activo bit(1),
    perfil_defecto bit(1)
);


ALTER TABLE consecutivos.perfil OWNER TO postgres;

--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE perfil; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON TABLE consecutivos.perfil IS 'Listado de perfiles que tiene la aplicación';


--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN perfil.perfil_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.perfil.perfil_id IS 'Identificador único de un perfil en la aplicación';


--
-- TOC entry 4862 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN perfil.perfil; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.perfil.perfil IS 'Descripcion del perfil. Texto que describe el perfil';


--
-- TOC entry 4863 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN perfil.activo; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.perfil.activo IS 'Indica si un perfil está activo o no lo está,\n\nActivo = 1\nNo Activo = 0';


--
-- TOC entry 4864 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN perfil.perfil_defecto; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.perfil.perfil_defecto IS 'En el modelo existe un único perfil que toma por defecto un usuario cuando es creado en la tabla de usuarios. El perfil por defecto será inicialmente el de generador de consecutivo.\n\nSi el perfil tiene como valor en perfil_defecto = 1  es el perfil por defecto\nSi el perfil tiene como valor en perfil_defecto = 0  NO es el perfil por defecto';


--
-- TOC entry 225 (class 1259 OID 16504)
-- Name: perfil_perfil_id_seq; Type: SEQUENCE; Schema: consecutivos; Owner: postgres
--

CREATE SEQUENCE consecutivos.perfil_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivos.perfil_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 4865 (class 0 OID 0)
-- Dependencies: 225
-- Name: perfil_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivos; Owner: postgres
--

ALTER SEQUENCE consecutivos.perfil_perfil_id_seq OWNED BY consecutivos.perfil.perfil_id;


--
-- TOC entry 226 (class 1259 OID 16505)
-- Name: usuario; Type: TABLE; Schema: consecutivos; Owner: postgres
--

CREATE TABLE consecutivos.usuario (
    usuario_id integer NOT NULL,
    usuario_nombre character varying(128),
    usuario_ldap character varying(64),
    pasword character varying(128)
);


ALTER TABLE consecutivos.usuario OWNER TO postgres;

--
-- TOC entry 4866 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE usuario; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON TABLE consecutivos.usuario IS 'maestra de usuarios que generan consecutivos.';


--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN usuario.usuario_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.usuario.usuario_id IS 'identificador único de un usuario en la aplicación de consecutivo';


--
-- TOC entry 4868 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN usuario.usuario_nombre; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.usuario.usuario_nombre IS 'Nombre del usuario, debe corresponder al mismo que se tiene en el sistema fuente que administra los funcionarios (actualmente linix)';


--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN usuario.usuario_ldap; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.usuario.usuario_ldap IS 'Usuario del directorio activo';


--
-- TOC entry 227 (class 1259 OID 16508)
-- Name: usuario_usuario_id_seq; Type: SEQUENCE; Schema: consecutivos; Owner: postgres
--

CREATE SEQUENCE consecutivos.usuario_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivos.usuario_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 227
-- Name: usuario_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivos; Owner: postgres
--

ALTER SEQUENCE consecutivos.usuario_usuario_id_seq OWNED BY consecutivos.usuario.usuario_id;


--
-- TOC entry 228 (class 1259 OID 16509)
-- Name: perfil_usuario; Type: TABLE; Schema: consecutivos; Owner: postgres
--

CREATE TABLE consecutivos.perfil_usuario (
    fecha_asociacion_perfil date DEFAULT now(),
    perfil_id bigint NOT NULL,
    usuario_id integer DEFAULT nextval('consecutivos.usuario_usuario_id_seq'::regclass)
);


ALTER TABLE consecutivos.perfil_usuario OWNER TO postgres;

--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE perfil_usuario; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON TABLE consecutivos.perfil_usuario IS 'Almacena cada uno de los perfiles que tiene activo un usuario';


--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN perfil_usuario.fecha_asociacion_perfil; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.perfil_usuario.fecha_asociacion_perfil IS 'Fecha en la que se asocia el perfil al usuario';


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN perfil_usuario.perfil_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.perfil_usuario.perfil_id IS 'Identificador único de un perfil en la aplicación';


--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN perfil_usuario.usuario_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.perfil_usuario.usuario_id IS 'identificador único de un usuario en la aplicación de consecutivo';


--
-- TOC entry 229 (class 1259 OID 16514)
-- Name: perfil_usuario_perfil_id_seq; Type: SEQUENCE; Schema: consecutivos; Owner: postgres
--

CREATE SEQUENCE consecutivos.perfil_usuario_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivos.perfil_usuario_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 229
-- Name: perfil_usuario_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivos; Owner: postgres
--

ALTER SEQUENCE consecutivos.perfil_usuario_perfil_id_seq OWNED BY consecutivos.perfil_usuario.perfil_id;


--
-- TOC entry 230 (class 1259 OID 16515)
-- Name: prefijo; Type: TABLE; Schema: consecutivos; Owner: postgres
--

CREATE TABLE consecutivos.prefijo (
    prefijo_id bigint NOT NULL,
    prefijo character varying(5) NOT NULL,
    descripcion_prefijo character varying(256) NOT NULL
);


ALTER TABLE consecutivos.prefijo OWNER TO postgres;

--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE prefijo; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON TABLE consecutivos.prefijo IS 'Almacena los prefijos (que pueden ser áreas de la empresa, cargos, ...).  Los prefijos son administrados por fuera de la dirección de tics';


--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN prefijo.prefijo_id; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.prefijo.prefijo_id IS 'identificador único del prefijo';


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN prefijo.prefijo; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.prefijo.prefijo IS 'Prefijo utilizado para la generación de un consecutivo. Deben ser proveídos por un área misional.';


--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN prefijo.descripcion_prefijo; Type: COMMENT; Schema: consecutivos; Owner: postgres
--

COMMENT ON COLUMN consecutivos.prefijo.descripcion_prefijo IS 'Descripción corta del significado del prefijo';


--
-- TOC entry 231 (class 1259 OID 16518)
-- Name: prefijo_prefijo_id_seq; Type: SEQUENCE; Schema: consecutivos; Owner: postgres
--

CREATE SEQUENCE consecutivos.prefijo_prefijo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE consecutivos.prefijo_prefijo_id_seq OWNER TO postgres;

--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 231
-- Name: prefijo_prefijo_id_seq; Type: SEQUENCE OWNED BY; Schema: consecutivos; Owner: postgres
--

ALTER SEQUENCE consecutivos.prefijo_prefijo_id_seq OWNED BY consecutivos.prefijo.prefijo_id;


--
-- TOC entry 232 (class 1259 OID 16600)
-- Name: v_usuarios; Type: VIEW; Schema: consecutivos; Owner: postgres
--

CREATE VIEW consecutivos.v_usuarios AS
 SELECT usuario_id,
    pasword
   FROM consecutivos.usuario;


ALTER VIEW consecutivos.v_usuarios OWNER TO postgres;

--
-- TOC entry 4647 (class 2604 OID 16564)
-- Name: gestion_consecutivo consecutivo; Type: DEFAULT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.gestion_consecutivo ALTER COLUMN consecutivo SET DEFAULT nextval('consecutivos.gestion_consecutivo_consecutivo_seq'::regclass);


--
-- TOC entry 4648 (class 2604 OID 16565)
-- Name: historia_consecutivo consecutivo_id; Type: DEFAULT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.historia_consecutivo ALTER COLUMN consecutivo_id SET DEFAULT nextval('consecutivos.historia_consecutivo_consecutivo_id_seq'::regclass);


--
-- TOC entry 4650 (class 2604 OID 16566)
-- Name: opcion_por_perfil opcion_id; Type: DEFAULT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.opcion_por_perfil ALTER COLUMN opcion_id SET DEFAULT nextval('consecutivos.opcion_por_perfil_opcion_id_seq'::regclass);


--
-- TOC entry 4651 (class 2604 OID 16567)
-- Name: opcion_por_perfil perfil_id; Type: DEFAULT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.opcion_por_perfil ALTER COLUMN perfil_id SET DEFAULT nextval('consecutivos.opcion_por_perfil_perfil_id_seq'::regclass);


--
-- TOC entry 4652 (class 2604 OID 16568)
-- Name: perfil perfil_id; Type: DEFAULT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.perfil ALTER COLUMN perfil_id SET DEFAULT nextval('consecutivos.perfil_perfil_id_seq'::regclass);


--
-- TOC entry 4655 (class 2604 OID 16569)
-- Name: perfil_usuario perfil_id; Type: DEFAULT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.perfil_usuario ALTER COLUMN perfil_id SET DEFAULT nextval('consecutivos.perfil_usuario_perfil_id_seq'::regclass);


--
-- TOC entry 4657 (class 2604 OID 16570)
-- Name: prefijo prefijo_id; Type: DEFAULT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.prefijo ALTER COLUMN prefijo_id SET DEFAULT nextval('consecutivos.prefijo_prefijo_id_seq'::regclass);


--
-- TOC entry 4653 (class 2604 OID 16571)
-- Name: usuario usuario_id; Type: DEFAULT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.usuario ALTER COLUMN usuario_id SET DEFAULT nextval('consecutivos.usuario_usuario_id_seq'::regclass);


--
-- TOC entry 4821 (class 0 OID 16483)
-- Dependencies: 217
-- Data for Name: gestion_consecutivo; Type: TABLE DATA; Schema: consecutivos; Owner: postgres
--

COPY consecutivos.gestion_consecutivo (consecutivo, hash_key, fecha_genera_consecutivo) FROM stdin;
2548	439920283	2023-09-19 07:28:00.881121
2550	722727592	2023-09-19 11:57:16.235557
2552	355651774	2023-09-19 12:01:57.723997
2554	835737957	2023-09-19 15:07:29.5598
2556	644541186	2023-09-19 15:09:05.37446
2558	101107736	2023-09-19 16:51:31.931787
2560	691560505	2023-09-19 17:56:12.973964
2562	96106182	2023-09-19 17:57:24.805596
2564	557936779	2023-09-19 17:58:13.447464
2566	928857282	2023-09-20 11:44:10.241709
2568	747901087	2023-09-20 11:54:21.984673
2570	322485201	2023-09-20 11:55:08.194504
2572	442246903	2023-09-20 15:58:29.552611
2574	662549041	2023-09-20 16:00:09.926952
2576	519956744	2023-09-20 17:22:53.089001
2578	222915032	2023-09-21 11:31:28.608655
2580	695320423	2023-09-21 14:10:41.91859
2582	705460244	2023-09-21 15:19:40.454316
2584	516667682	2023-09-22 08:53:46.261248
2586	75853888	2023-09-22 11:42:13.744517
2588	332600792	2023-09-22 11:54:26.951276
2590	422717194	2023-09-22 12:31:40.803593
2592	572118388	2023-09-22 15:00:35.430664
2594	919905701	2023-09-22 15:01:53.640011
2596	665942946	2023-09-22 15:02:42.839809
2598	526546681	2023-09-22 15:31:47.05433
2600	337103060	2023-09-22 16:51:19.687941
2602	828768839	2023-09-25 10:41:02.174582
2604	847238979	2023-09-25 11:16:43.376009
2606	666652960	2023-09-25 14:30:06.069485
2608	168963956	2023-09-25 17:14:08.651001
2610	617304983	2023-09-25 17:15:16.742114
2612	485516418	2023-09-26 08:35:39.86497
2614	68576380	2023-09-26 09:28:37.917882
2616	899625697	2023-09-26 10:07:01.118662
2618	371836887	2023-09-26 11:11:53.759048
2620	839006257	2023-09-26 11:42:22.164977
2622	953249679	2023-09-26 11:43:44.597808
2624	141630789	2023-09-26 11:44:46.848245
2626	406127100	2023-09-26 11:48:31.707886
2628	944961156	2023-09-26 15:35:29.116009
2630	527597560	2023-09-26 15:47:06.462511
2632	566270958	2023-09-26 17:33:43.928233
2634	641224343	2023-09-27 15:07:41.991771
2636	399005287	2023-09-28 08:26:55.841217
2638	667563896	2023-09-28 08:53:52.893985
2640	821889686	2023-09-28 09:37:44.571798
2642	287658579	2023-09-28 10:13:32.409188
2644	231636522	2023-09-28 11:51:45.142658
2646	957186665	2023-09-28 14:48:58.552514
2648	892317235	2023-09-28 15:18:58.67462
2650	447450043	2023-09-28 17:16:45.234091
2652	842040016	2023-09-28 17:18:22.987628
2654	923572481	2023-09-28 17:20:48.774252
2656	14865987	2023-09-28 17:21:28.756563
2658	498122695	2023-09-28 17:22:16.052239
2660	671417057	2023-09-28 17:23:04.42201
2662	208393582	2023-09-29 08:59:44.568447
2664	549871685	2023-09-29 09:13:38.273783
2666	863165703	2023-09-29 10:24:25.472336
2668	128773918	2023-09-29 13:34:42.806579
2670	182389863	2023-09-29 14:17:48.905782
2671	652267604	2023-09-29 14:18:02.938225
2672	769137326	2023-09-29 14:18:14.093607
2673	205311060	2023-09-29 14:18:24.883724
2674	340064911	2023-09-29 14:18:34.653475
2675	533268961	2023-09-29 14:18:44.404246
2676	420124246	2023-09-29 14:18:49.995543
2677	483753150	2023-09-29 14:18:55.808876
2678	716102018	2023-09-29 14:19:00.909341
2679	809136111	2023-09-29 14:19:06.571095
2681	306027209	2023-09-29 16:04:21.805839
2683	263981363	2023-10-02 10:29:45.852449
2685	312729891	2023-10-02 12:16:43.979824
2687	972940800	2023-10-02 14:18:09.932696
2689	58759826	2023-10-02 15:03:17.560619
2691	391475621	2023-10-02 15:04:14.319021
2693	33888737	2023-10-02 15:05:38.758079
2695	477264352	2023-10-02 15:46:15.542514
2697	705147291	2023-10-02 15:47:56.906599
2699	534577583	2023-10-02 16:16:47.809053
2701	838849433	2023-10-03 08:30:25.959019
2703	333787034	2023-10-03 08:33:24.76454
2705	643812185	2023-10-03 08:35:45.845542
2707	850474757	2023-10-03 10:06:29.176469
2709	668877869	2023-10-03 10:20:20.856952
2711	877493956	2023-10-03 10:31:15.19421
2713	414403676	2023-10-03 10:32:01.402052
2715	465389551	2023-10-03 10:32:43.011885
2717	405651711	2023-10-03 12:00:33.026179
2719	894018564	2023-10-03 15:44:50.923484
2721	83188984	2023-10-03 17:41:24.628418
2725	472792324	2023-10-03 17:42:22.738393
2727	637595188	2023-10-04 09:01:38.920363
2729	535868788	2023-10-04 12:26:33.334571
2731	184066539	2023-10-04 12:34:55.106381
2733	973273752	2023-10-04 15:23:26.243783
2735	369768536	2023-10-04 15:31:00.006383
2737	233034822	2023-10-05 08:53:28.30589
2739	605920028	2023-10-05 08:55:28.714636
2741	134669173	2023-10-05 08:57:22.618611
2743	340609629	2023-10-05 09:05:35.902369
2745	293984808	2023-10-05 09:08:08.280196
2747	811934675	2023-10-05 09:10:24.756062
2749	174385096	2023-10-05 09:11:36.018156
2751	323651191	2023-10-05 10:03:20.390364
2753	658452064	2023-10-05 11:20:47.895633
2755	440636078	2023-10-05 11:52:18.40051
2757	408862746	2023-10-05 12:43:46.662807
2759	360244868	2023-10-05 15:11:14.44663
2761	888684855	2023-10-05 17:32:33.58875
2763	70468916	2023-10-05 17:33:21.520416
2765	830919676	2023-10-06 09:05:53.890208
2767	650048542	2023-10-06 09:28:49.994296
2769	207450778	2023-10-06 10:07:45.316998
2771	828248056	2023-10-06 17:01:05.20562
2773	714731226	2023-10-06 22:24:27.398594
2775	995638550	2023-10-09 08:08:03.869807
2777	553184284	2023-10-09 09:27:42.268392
2779	438284821	2023-10-09 12:02:55.401287
2782	893520810	2023-10-10 07:35:19.892522
2784	132439782	2023-10-10 09:46:22.432476
2786	769906070	2023-10-10 14:00:55.098329
2788	854887669	2023-10-11 08:50:40.157063
2790	606094719	2023-10-11 09:33:19.310299
2792	464227366	2023-10-11 09:38:20.077915
2794	841712599	2023-10-11 09:53:07.898533
2796	256345060	2023-10-11 09:59:40.006674
2798	708560134	2023-10-11 10:18:37.557257
2800	809359435	2023-10-11 10:23:01.498683
2802	690136505	2023-10-11 11:53:20.74491
2804	954704273	2023-10-11 11:56:03.195734
2806	139140989	2023-10-11 11:57:08.040007
2808	579140729	2023-10-11 15:24:49.728465
2810	155412795	2023-10-11 15:26:07.917937
2812	158258661	2023-10-11 17:14:46.346458
2814	689012664	2023-10-11 17:54:02.789385
2816	890595751	2023-10-11 18:14:46.677396
2818	714688708	2023-10-12 09:37:51.38018
2820	270345324	2023-10-12 16:07:06.826625
2822	526288592	2023-10-12 17:27:05.626897
2824	684200004	2023-10-13 07:53:05.372501
2826	576148486	2023-10-13 09:57:15.416009
2828	793881113	2023-10-13 11:42:09.182448
2830	907384102	2023-10-13 14:51:25.457025
2832	583539877	2023-10-17 09:15:12.047987
2834	454745989	2023-10-17 14:13:07.52044
2836	107919738	2023-10-17 15:04:02.709721
2838	65718060	2023-10-17 15:05:13.581553
2840	948174487	2023-10-17 15:15:42.834261
2842	600992009	2023-10-17 15:37:56.658427
2844	255117286	2023-10-18 08:05:13.053682
2846	535737757	2023-10-18 08:17:40.270334
2848	195364492	2023-10-18 09:07:02.256131
2850	495419915	2023-10-18 09:09:53.587871
2852	554545705	2023-10-18 09:11:58.051871
2854	186450729	2023-10-18 09:28:18.8529
2549	543740367	2023-09-19 11:06:50.458719
2551	303063597	2023-09-19 11:59:58.554428
2553	18389021	2023-09-19 14:35:19.597211
2555	297271368	2023-09-19 15:08:18.78149
2557	147678382	2023-09-19 15:55:04.790704
2559	460741510	2023-09-19 17:55:40.78893
2561	641553355	2023-09-19 17:56:59.879523
2563	648797955	2023-09-19 17:57:49.941902
2565	289806896	2023-09-19 17:58:32.175704
2567	742775105	2023-09-20 11:53:24.055415
2569	541105536	2023-09-20 11:54:48.684158
2571	442953797	2023-09-20 11:55:54.493154
2573	71538376	2023-09-20 15:59:34.673285
2575	900420292	2023-09-20 17:01:19.628694
2577	418755549	2023-09-21 08:37:16.306399
2579	729496679	2023-09-21 11:52:15.349602
2581	926922741	2023-09-21 14:58:21.252399
2583	305246918	2023-09-21 16:41:24.722035
2585	46429428	2023-09-22 09:33:28.709336
2587	798727407	2023-09-22 11:53:54.521173
2589	331805781	2023-09-22 12:29:33.18992
2591	781243602	2023-09-22 14:37:58.666263
2593	128409062	2023-09-22 15:01:23.797936
2595	323179038	2023-09-22 15:02:18.311253
2597	942468454	2023-09-22 15:14:24.174729
2599	51703152	2023-09-22 15:49:03.348437
2601	704974073	2023-09-25 10:40:16.623997
2603	188077115	2023-09-25 11:14:45.80869
2605	877525286	2023-09-25 14:10:05.466702
2607	791278745	2023-09-25 16:58:25.689812
2609	129046619	2023-09-25 17:14:39.672348
2611	797171036	2023-09-25 18:28:45.910648
2613	883738479	2023-09-26 09:26:11.461369
2615	196141586	2023-09-26 10:06:20.914327
2617	796570909	2023-09-26 10:07:47.911794
2619	314461868	2023-09-26 11:15:25.782574
2621	816904156	2023-09-26 11:43:01.118442
2623	177194087	2023-09-26 11:44:25.132884
2625	500306261	2023-09-26 11:45:20.854385
2627	287961602	2023-09-26 11:50:00.18448
2629	834191520	2023-09-26 15:46:29.83212
2631	909364882	2023-09-26 17:33:08.003033
2633	453866582	2023-09-27 13:53:11.31469
2635	984250901	2023-09-27 15:16:26.489093
2637	176169262	2023-09-28 08:52:52.48193
2639	230924428	2023-09-28 08:54:33.246637
2641	456080878	2023-09-28 09:43:09.280797
2643	983868406	2023-09-28 10:36:32.23611
2645	579304011	2023-09-28 11:52:12.707233
2647	690893006	2023-09-28 14:50:26.058303
2649	914243532	2023-09-28 15:40:34.84561
2651	771509859	2023-09-28 17:17:57.01799
2653	355856097	2023-09-28 17:19:12.617753
2655	416985854	2023-09-28 17:21:08.614074
2657	695920982	2023-09-28 17:21:49.839619
2659	609568381	2023-09-28 17:22:39.611501
2661	641501631	2023-09-29 08:18:21.190715
2663	98223740	2023-09-29 09:10:54.435984
2665	457724297	2023-09-29 10:20:43.540107
2667	768829118	2023-09-29 10:40:59.769448
2669	675697125	2023-09-29 13:50:32.814562
2680	771271355	2023-09-29 15:13:28.829746
2682	202303586	2023-10-02 09:58:17.934654
2684	688240600	2023-10-02 11:36:12.364197
2686	696150154	2023-10-02 12:22:32.958471
2688	200225289	2023-10-02 14:52:26.546508
2690	529043780	2023-10-02 15:03:49.093587
2692	151548342	2023-10-02 15:05:18.284341
2694	426948682	2023-10-02 15:45:32.090092
2696	459452230	2023-10-02 15:47:19.176837
2698	306308652	2023-10-02 16:03:53.654406
2700	74672803	2023-10-03 08:12:33.26645
2702	542484414	2023-10-03 08:32:52.321213
2704	58477812	2023-10-03 08:35:19.906233
2706	599414631	2023-10-03 09:40:07.034556
2708	889830216	2023-10-03 10:19:46.278288
2710	463091008	2023-10-03 10:30:51.595534
2712	701826016	2023-10-03 10:31:36.120286
2714	811691149	2023-10-03 10:32:22.999814
2716	883523792	2023-10-03 11:00:09.537395
2718	174611404	2023-10-03 15:42:49.386368
2720	899737092	2023-10-03 16:19:14.25609
2722	983272000	2023-10-03 17:41:50.766659
2723	724699637	2023-10-03 17:41:58.580425
2724	482447940	2023-10-03 17:42:06.011493
2726	538857543	2023-10-04 08:30:36.578211
2728	583571327	2023-10-04 11:34:27.010243
2730	840510078	2023-10-04 12:27:11.986505
2732	15632818	2023-10-04 14:51:34.980959
2734	984834791	2023-10-04 15:24:21.65605
2736	207805609	2023-10-04 15:57:46.172458
2738	920979605	2023-10-05 08:54:42.399704
2740	359871345	2023-10-05 08:56:21.517708
2742	661806640	2023-10-05 09:04:28.664061
2744	389787536	2023-10-05 09:07:33.413134
2746	657329027	2023-10-05 09:08:45.737308
2748	260371569	2023-10-05 09:11:01.583734
2750	888674723	2023-10-05 09:37:54.354144
2752	199741614	2023-10-05 10:40:29.939319
2754	253597321	2023-10-05 11:45:11.095657
2756	427408105	2023-10-05 12:43:06.942956
2758	275863092	2023-10-05 15:09:56.330303
2760	993135027	2023-10-05 16:59:00.212247
2762	132590231	2023-10-05 17:33:02.443368
2764	505884941	2023-10-05 19:26:39.685974
2766	841511192	2023-10-06 09:12:23.793648
2768	139752557	2023-10-06 10:04:30.336402
2770	269936834	2023-10-06 14:39:21.799817
2772	4361475	2023-10-06 17:40:30.195045
2774	551734269	2023-10-09 07:56:38.890353
2776	445305186	2023-10-09 08:26:48.073028
2778	174825882	2023-10-09 10:47:40.692651
2780	195546338	2023-10-09 13:48:53.78472
2781	16929649	2023-10-09 13:49:08.226317
2783	533020935	2023-10-10 09:14:55.380958
2785	284695882	2023-10-10 10:55:50.294132
2787	465399113	2023-10-11 07:51:08.978997
2789	834117984	2023-10-11 09:02:22.549796
2791	675843013	2023-10-11 09:35:48.961967
2793	346213152	2023-10-11 09:48:34.334168
2795	119059967	2023-10-11 09:56:04.858425
2797	304024876	2023-10-11 10:08:46.456126
2799	826394006	2023-10-11 10:22:32.960385
2801	328582745	2023-10-11 10:35:46.685693
2803	412595818	2023-10-11 11:54:14.882261
2805	881983658	2023-10-11 11:56:35.797374
2807	160340463	2023-10-11 15:19:15.220244
2809	898134427	2023-10-11 15:25:16.4775
2811	955795600	2023-10-11 15:50:40.306458
2813	466101600	2023-10-11 17:21:38.140833
2815	853799552	2023-10-11 18:09:17.529823
2817	806391200	2023-10-11 18:21:36.205067
2819	975435199	2023-10-12 09:44:48.323744
2821	86688232	2023-10-12 16:08:03.009172
2823	658196450	2023-10-12 17:32:43.46658
2825	324784494	2023-10-13 08:39:29.556955
2827	847305137	2023-10-13 10:50:03.849369
2829	476619437	2023-10-13 11:47:09.278863
2831	203947910	2023-10-17 08:32:57.197144
2833	353614396	2023-10-17 10:33:01.193849
2835	263901896	2023-10-17 15:03:02.034372
2837	181426787	2023-10-17 15:04:32.686808
2839	998477117	2023-10-17 15:05:52.696656
2841	260911180	2023-10-17 15:16:45.365703
2843	778536818	2023-10-17 16:20:00.305409
2845	891418368	2023-10-18 08:17:04.789434
2847	751092051	2023-10-18 08:18:07.346109
2849	39949929	2023-10-18 09:09:05.456547
2851	80970979	2023-10-18 09:11:14.960928
2853	491360662	2023-10-18 09:12:48.546624
2855	427768398	2023-10-18 11:53:00.746234
2856	200143545	2023-10-18 11:53:28.503592
2857	956876045	2023-10-18 11:53:54.31208
2858	527453697	2023-10-18 11:54:19.826468
2859	996770030	2023-10-18 11:54:43.521602
2860	506845838	2023-10-18 11:55:14.191761
2861	734910449	2023-10-18 11:55:44.226357
2862	575123343	2023-10-18 14:29:56.29144
2863	374447401	2023-10-18 14:32:09.23239
2864	290993411	2023-10-18 14:32:52.840656
2865	343736049	2023-10-18 14:34:52.4227
2866	725103231	2023-10-18 15:04:31.321729
2867	928771623	2023-10-18 15:04:58.50169
2868	750196169	2023-10-19 08:51:03.899112
2869	948442701	2023-10-19 08:51:39.697931
2870	359479957	2023-10-19 08:53:20.049641
2871	39849689	2023-10-19 10:10:55.371873
2872	374913123	2023-10-19 10:11:20.166472
2873	493145870	2023-10-19 11:22:01.859882
2874	251014867	2023-10-19 11:23:55.724125
2875	652779302	2023-10-19 11:57:31.113172
2876	515016875	2023-10-19 13:46:08.962483
2877	819692620	2023-10-19 13:58:57.749157
2878	661064730	2023-10-19 14:07:33.049553
2879	164740057	2023-10-19 14:38:59.358144
2880	476920298	2023-10-19 14:44:15.560599
2881	394751490	2023-10-19 15:38:22.65839
2882	192072341	2023-10-19 15:44:10.479417
2883	684694441	2023-10-19 15:45:02.368427
2884	835863171	2023-10-19 15:45:42.79184
2885	19842944	2023-10-19 16:01:30.453954
2886	279219444	2023-10-19 16:13:31.293631
2887	379592530	2023-10-19 17:45:46.690256
2888	758502670	2023-10-19 17:52:13.733958
2889	468491277	2023-10-19 18:01:57.268349
2890	491311023	2023-10-20 07:39:10.870386
2891	543706772	2023-10-20 08:01:21.071381
2892	777544188	2023-10-20 08:23:28.2297
2893	613816360	2023-10-20 08:27:28.27937
2894	449402429	2023-10-20 08:27:52.160154
2895	32366955	2023-10-20 08:29:24.420736
2896	896870613	2023-10-20 08:30:31.510132
2897	852586133	2023-10-20 08:40:58.454304
2898	80865827	2023-10-20 09:01:44.070916
2899	49204545	2023-10-20 09:10:44.33387
2900	344906882	2023-10-20 09:15:28.091934
2901	857253699	2023-10-20 09:26:43.88103
2902	959802136	2023-10-20 09:35:42.24901
2903	256887673	2023-10-20 10:44:03.052093
2904	711449829	2023-10-20 11:47:17.714192
2905	634170080	2023-10-20 11:48:09.053049
2906	284596429	2023-10-20 11:48:53.740069
2907	885233766	2023-10-20 11:49:25.575206
2908	798783811	2023-10-20 15:05:07.958327
2909	221720282	2023-10-20 17:21:42.87584
2910	146689464	2023-10-20 18:07:12.85837
2911	867104938	2023-10-23 10:37:04.796482
2912	954152433	2023-10-23 11:56:04.576996
2913	215947463	2023-10-23 12:17:46.929404
2914	807698564	2023-10-23 13:32:15.013501
2915	183700536	2023-10-23 13:34:04.019551
2916	899182838	2023-10-23 13:34:51.393291
2917	170495858	2023-10-23 14:22:26.575612
2918	929327899	2023-10-23 14:32:24.942059
2919	133778122	2023-10-23 16:55:03.105012
2920	535987765	2023-10-24 09:09:27.181898
2921	594617678	2023-10-24 10:06:18.922464
2922	910294933	2023-10-24 10:06:48.97752
2923	712489618	2023-10-24 15:13:52.306133
2924	889173623	2023-10-24 15:14:19.26818
2925	776678048	2023-10-24 15:27:23.198528
2926	360276314	2023-10-24 16:12:12.873087
2927	562522546	2023-10-24 16:13:05.660153
2928	868416064	2023-10-24 16:13:37.494125
2929	139338010	2023-10-24 16:14:14.306268
2930	954457900	2023-10-24 16:15:02.868988
2931	42761588	2023-10-24 16:15:26.17683
2932	891991682	2023-10-24 16:16:23.430125
2933	649780849	2023-10-24 16:16:49.250392
2934	447444129	2023-10-24 16:17:22.613426
2935	698216726	2023-10-24 16:17:52.813271
2936	300388386	2023-10-25 08:10:33.168572
2937	781539256	2023-10-25 11:49:19.013969
2938	848916984	2023-10-25 11:50:41.118212
2939	736484010	2023-10-25 11:55:59.693579
2940	21966326	2023-10-25 11:56:39.22568
2941	411737893	2023-10-25 11:57:41.252455
2942	698781190	2023-10-25 11:58:28.193457
2943	606450108	2023-10-25 11:58:54.056052
2944	55365027	2023-10-25 11:59:03.307851
2945	799850665	2023-10-25 11:59:32.172456
2946	729203677	2023-10-25 12:00:18.904114
2947	327737072	2023-10-25 12:01:37.910366
2948	607550142	2023-10-25 12:02:21.215619
2949	701853929	2023-10-25 12:02:45.831816
2950	537867974	2023-10-25 12:03:07.077947
2951	363075306	2023-10-25 12:03:29.542248
2952	661446996	2023-10-25 12:03:55.473292
2953	336456156	2023-10-25 12:05:03.326435
2954	319466354	2023-10-25 12:11:43.45781
2955	369397638	2023-10-25 12:12:04.317588
2956	271365519	2023-10-25 12:12:27.066357
2957	783957066	2023-10-25 12:12:49.186244
2958	854785667	2023-10-25 12:15:28.804845
2959	411510164	2023-10-25 12:16:01.6174
2960	632848762	2023-10-25 12:33:49.357605
2961	645487098	2023-10-25 15:17:32.820475
2962	481921289	2023-10-25 15:27:34.387231
2963	740271437	2023-10-26 08:43:35.555836
2964	279963370	2023-10-26 10:49:53.638086
2965	738923249	2023-10-26 10:50:42.704823
2966	189752603	2023-10-26 10:58:09.023498
2967	822834431	2023-10-26 11:26:26.117002
2968	933769312	2023-10-26 11:52:24.513525
2969	791250843	2023-10-26 14:34:49.892233
2970	497913078	2023-10-26 15:50:56.128528
2971	520958207	2023-10-27 08:55:58.563876
2972	409056185	2023-10-27 09:03:32.047891
2973	136715058	2023-10-27 09:16:14.944924
2974	651546027	2023-10-27 09:27:10.71687
2975	153599391	2023-10-27 09:32:57.344451
2976	542831166	2023-10-27 09:33:44.520823
2977	250065586	2023-10-27 09:59:50.036182
2978	250643295	2023-10-27 10:00:23.706144
2979	760410162	2023-10-27 10:00:52.476183
2980	989609812	2023-10-27 10:01:30.515634
2981	308535117	2023-10-27 10:01:52.357826
2982	158188521	2023-10-27 10:02:23.651047
2983	113971110	2023-10-27 11:14:16.380108
2984	479902549	2023-10-27 11:15:33.983688
2985	541108630	2023-10-27 15:00:17.871197
2986	126278589	2023-10-27 15:39:04.441504
2987	257116913	2023-10-27 15:45:01.49129
2988	904227816	2023-10-27 16:44:11.610253
2989	607503587	2023-10-27 16:47:47.826348
2990	638700654	2023-10-27 16:48:47.516168
2991	264882083	2023-10-27 16:50:32.3491
2992	549527305	2023-10-27 17:00:43.380199
2993	349053494	2023-10-27 17:01:29.272298
2994	1840206	2023-10-27 17:01:53.342269
2995	791785953	2023-10-27 17:02:11.813661
2996	479016261	2023-10-27 17:02:34.63137
2997	622592725	2023-10-27 17:02:55.866288
2998	396777654	2023-10-27 17:03:19.726372
2999	977690435	2023-10-27 18:18:16.024804
3000	279859948	2023-10-30 10:03:57.447805
3001	592592320	2023-10-30 10:06:49.749638
3002	727539729	2023-10-30 14:06:14.34277
3003	172727191	2023-10-30 16:31:26.0772
3004	105973934	2023-10-30 16:32:07.6587
3005	324949982	2023-10-30 16:32:57.549776
3006	117290869	2023-10-30 16:33:30.329197
3007	689381390	2023-10-30 16:33:56.348406
3008	7105361	2023-10-30 18:16:26.29838
3009	394967460	2023-10-30 18:21:04.930463
3010	917694623	2023-10-31 09:09:06.36968
3011	44613568	2023-10-31 10:21:59.371851
3012	72002663	2023-10-31 10:55:11.23667
3013	637060730	2023-10-31 11:11:14.624412
3014	710212579	2023-10-31 11:26:27.819242
3015	699317288	2023-10-31 11:31:47.334559
3016	913290488	2023-10-31 11:31:59.005466
3017	365324455	2023-10-31 11:32:14.546845
3018	106059347	2023-10-31 11:32:21.306072
3019	336231502	2023-10-31 11:32:26.94485
3020	704355105	2023-10-31 11:32:33.02991
3021	572664558	2023-10-31 11:32:39.525139
3022	675338592	2023-10-31 11:33:11.549625
3023	979684549	2023-10-31 11:33:23.285032
3024	560937355	2023-10-31 11:33:34.28678
3025	332257341	2023-10-31 11:33:45.554754
3026	216363396	2023-10-31 11:33:58.145637
3027	92489659	2023-10-31 11:34:12.046164
3028	520612883	2023-10-31 11:34:17.550633
3029	400267901	2023-10-31 12:06:05.13502
3030	324571188	2023-10-31 12:48:28.146587
3031	730711527	2023-10-31 12:55:57.1549
3032	174851848	2023-10-31 12:56:38.950496
3033	990352630	2023-10-31 14:08:58.578077
3034	307322270	2023-10-31 15:47:07.8427
3035	657716411	2023-10-31 16:55:36.460215
3036	266861032	2023-10-31 16:57:12.961
3037	756106027	2023-11-01 08:20:04.355386
3038	344334312	2023-11-01 08:28:29.465449
3039	822259842	2023-11-01 08:37:53.332045
3040	484793668	2023-11-01 10:02:42.931658
3041	124736982	2023-11-01 10:05:45.825941
3042	989035841	2023-11-01 10:06:15.60721
3043	787279427	2023-11-01 10:06:39.868253
3044	473658552	2023-11-01 10:07:01.856781
3045	628440780	2023-11-01 10:07:32.12971
3046	631396916	2023-11-01 10:46:29.694479
3047	813861389	2023-11-01 11:15:22.705144
3048	183515810	2023-11-01 14:31:17.33153
3049	994153498	2023-11-01 17:19:44.447741
3050	976595176	2023-11-01 17:20:18.456484
3051	222617023	2023-11-01 17:20:43.040166
3052	814240740	2023-11-01 17:21:08.058925
3053	277235694	2023-11-01 17:21:35.092135
3054	626165136	2023-11-02 07:40:20.871803
3055	64105389	2023-11-02 08:50:54.266182
3056	877821190	2023-11-02 10:20:46.241484
3057	700593230	2023-11-02 11:28:41.404449
3058	210690818	2023-11-02 11:29:13.326372
3059	601368183	2023-11-02 15:01:51.364028
3060	568782443	2023-11-02 15:02:29.924583
3061	62899070	2023-11-02 15:02:55.435745
3062	224670571	2023-11-02 15:56:17.007824
3063	700593273	2023-11-02 16:04:00.508452
3064	80527891	2023-11-03 08:18:01.83911
3065	119458714	2023-11-03 10:11:39.49
3066	347279168	2023-11-03 16:59:26.355102
3067	230745288	2023-11-07 08:05:39.294734
3068	510907349	2023-11-07 08:18:40.874278
3069	411045382	2023-11-07 09:53:59.768872
3070	954584465	2023-11-07 09:58:11.026173
3071	526428843	2023-11-07 10:08:36.315701
3072	975766756	2023-11-07 11:41:14.123078
3073	444377551	2023-11-07 11:53:47.746714
3074	175575171	2023-11-07 11:54:16.01534
3075	456768526	2023-11-07 11:54:35.469759
3076	37108732	2023-11-07 11:54:51.874317
3077	710286121	2023-11-07 11:55:09.562515
3078	386405949	2023-11-07 11:55:35.427678
3079	797988220	2023-11-07 13:45:49.737735
3080	128931222	2023-11-07 14:58:03.571928
3081	741911624	2023-11-07 14:58:53.193077
3082	72677004	2023-11-07 14:59:40.207122
3083	415597958	2023-11-08 08:16:54.102177
3084	543460804	2023-11-08 08:17:56.822761
3085	322432793	2023-11-08 08:18:28.991213
3086	170066599	2023-11-08 08:19:05.569197
3087	703170774	2023-11-08 08:43:58.56123
3088	445216727	2023-11-08 09:34:31.867146
3089	119930209	2023-11-08 10:26:50.445503
3090	726714187	2023-11-08 12:26:28.505727
3091	627103647	2023-11-08 15:21:51.666368
3092	758904187	2023-11-08 15:22:32.556671
3093	729161165	2023-11-08 15:57:36.009224
3094	977020625	2023-11-08 15:58:16.052922
3095	710176165	2023-11-08 16:51:33.169897
3096	668985148	2023-11-08 17:03:42.320436
3097	551527183	2023-11-09 08:32:37.551756
3098	373300470	2023-11-09 09:33:33.722858
3099	118515946	2023-11-09 10:04:18.110571
3100	204015021	2023-11-09 10:44:38.793982
3101	730404943	2023-11-09 10:50:58.27117
3102	406890924	2023-11-09 10:52:56.022782
3103	842600212	2023-11-09 11:13:41.998201
3104	84337934	2023-11-09 11:23:18.281296
3105	816280710	2023-11-09 11:36:09.368145
3106	967488109	2023-11-09 11:51:53.213385
3107	509054197	2023-11-09 11:52:22.267124
3108	392619203	2023-11-09 14:54:33.269674
3109	618302812	2023-11-09 15:28:05.195376
3110	330311575	2023-11-09 16:24:11.023895
3111	777788058	2023-11-09 16:25:00.107082
3112	501484101	2023-11-09 17:21:07.294848
3113	907958490	2023-11-09 17:41:04.979362
3114	656036895	2023-11-10 09:21:51.992215
3115	869067451	2023-11-10 12:31:09.64264
3116	988638974	2023-11-10 12:36:07.245283
3117	199566729	2023-11-10 12:37:08.559539
3118	974228958	2023-11-10 12:37:44.137371
3119	499531797	2023-11-10 12:47:22.528186
3120	178825009	2023-11-10 13:47:36.826506
3121	842574344	2023-11-10 14:02:34.134555
3122	856386436	2023-11-10 14:11:46.817514
3123	876350751	2023-11-10 15:16:58.193399
3124	738346847	2023-11-10 15:37:12.365821
3125	437885175	2023-11-10 15:51:34.556731
3126	329673693	2023-11-10 15:52:56.205823
3127	339882274	2023-11-10 15:54:33.367681
3128	52209429	2023-11-10 15:55:54.218946
3129	36793749	2023-11-10 16:10:59.189385
3130	224225032	2023-11-10 16:11:42.723691
3131	898505492	2023-11-10 16:19:14.495752
3132	721383582	2023-11-14 08:41:34.625007
3133	412195447	2023-11-14 09:32:08.571341
3134	8655527	2023-11-14 10:34:53.486195
3135	419608040	2023-11-14 15:18:47.653545
3136	95597396	2023-11-14 15:19:49.934933
3137	950179429	2023-11-14 16:27:45.882552
3138	142368782	2023-11-14 17:08:22.13612
3139	924649189	2023-11-14 17:08:56.973287
3140	724107197	2023-11-14 17:09:28.569332
3141	708687885	2023-11-14 17:10:27.870151
3142	795051111	2023-11-14 17:11:01.463259
3143	970523384	2023-11-14 17:11:36.315974
3144	924999512	2023-11-14 17:12:06.12267
3145	203585373	2023-11-14 17:20:54.699798
3146	343810211	2023-11-14 17:34:24.990858
3147	959562682	2023-11-15 08:11:18.18697
3148	876460536	2023-11-15 08:16:19.811982
3149	510166216	2023-11-15 10:19:25.642644
3150	601562648	2023-11-15 14:43:51.368047
3151	362672104	2023-11-15 17:06:05.154901
3152	421891100	2023-11-15 17:07:05.402115
3153	637391954	2023-11-15 17:07:40.409084
3154	810296666	2023-11-15 17:41:56.886669
3155	44123240	2023-11-16 09:03:07.175686
3156	45656456	2023-11-16 09:03:33.667627
3157	197477433	2023-11-16 09:03:57.536385
3158	312720806	2023-11-16 09:04:19.327361
3159	383907806	2023-11-16 09:04:37.874901
3160	729284234	2023-11-16 09:05:10.35324
3161	315479905	2023-11-16 09:07:17.392221
3162	172178492	2023-11-16 09:39:47.420334
3163	136929049	2023-11-16 10:27:23.185536
3164	73529204	2023-11-16 12:00:55.693863
3165	49892644	2023-11-16 14:47:18.786701
3166	526221201	2023-11-16 14:57:20.951849
3167	417153598	2023-11-16 15:06:43.407792
3168	275107731	2023-11-16 15:12:12.47481
3169	247235553	2023-11-16 15:12:55.143707
3170	621351459	2023-11-16 15:16:50.381877
3171	529671521	2023-11-16 15:39:40.772962
3172	596888711	2023-11-16 15:50:15.358471
3173	200151289	2023-11-16 16:03:11.069774
3174	531754466	2023-11-17 09:18:44.386096
3175	360213942	2023-11-17 09:36:23.737773
3176	412654492	2023-11-17 10:18:30.861577
3177	272994799	2023-11-17 14:25:08.555834
3178	387245311	2023-11-17 16:59:06.142212
3179	894606871	2023-11-20 09:12:24.38517
3180	466833176	2023-11-20 09:20:24.969094
3181	116026948	2023-11-20 09:36:03.993517
3182	194914128	2023-11-20 09:37:26.632034
3183	665549766	2023-11-20 09:38:15.004171
3184	449088864	2023-11-20 09:38:59.865084
3185	130074990	2023-11-20 09:39:38.99694
3186	892392806	2023-11-20 11:43:04.204823
3187	752857286	2023-11-20 11:45:30.263457
3188	453071395	2023-11-20 12:31:45.137372
3189	80058182	2023-11-20 16:37:28.433733
3190	969721196	2023-11-20 16:38:10.646097
3191	389365868	2023-11-20 16:39:48.600866
3192	910938545	2023-11-20 16:40:24.547919
3193	999337098	2023-11-20 16:41:07.555752
3194	283455612	2023-11-20 16:42:00.364245
3195	299495276	2023-11-20 16:48:10.547699
3196	110852450	2023-11-21 08:15:05.58019
3197	337000812	2023-11-21 08:16:57.306939
3198	837336919	2023-11-21 09:40:02.95334
3199	369445979	2023-11-21 15:35:03.86836
3200	568933756	2023-11-22 08:28:12.834078
3201	623890069	2023-11-22 08:28:57.993085
3202	458956866	2023-11-22 08:29:55.108911
3203	411352068	2023-11-22 08:30:21.009057
3204	251748077	2023-11-22 08:30:49.331394
3205	127311262	2023-11-22 08:31:31.418936
3206	251446882	2023-11-22 08:47:13.99551
3207	49138753	2023-11-22 10:05:31.053031
3208	251497387	2023-11-22 10:06:59.234549
3209	350578887	2023-11-22 10:07:53.032777
3210	294126324	2023-11-22 10:08:52.835889
3211	936700875	2023-11-22 10:10:31.203666
3212	702907431	2023-11-22 10:12:26.804264
3213	251658786	2023-11-22 10:12:54.187188
3214	781728330	2023-11-22 10:13:42.748206
3215	780829215	2023-11-22 10:14:23.715897
3216	295049336	2023-11-22 10:15:02.39828
3217	288226117	2023-11-22 10:16:11.527407
3218	560669094	2023-11-22 10:18:25.961507
3219	222217575	2023-11-22 10:20:49.083341
3220	273390423	2023-11-22 11:07:10.396007
3221	252982241	2023-11-22 14:46:49.796429
3222	488485273	2023-11-22 15:23:22.286184
3223	394924793	2023-11-22 15:31:53.702864
3224	741769731	2023-11-22 15:32:38.096441
3225	534068628	2023-11-22 15:33:02.356849
3226	820696335	2023-11-22 15:33:30.701018
3227	143591919	2023-11-22 15:33:56.186161
3228	156677289	2023-11-22 15:34:32.19662
3229	534647344	2023-11-22 15:35:18.532433
3230	687983778	2023-11-22 15:35:51.251627
3231	944110053	2023-11-22 15:36:36.978791
3232	12166421	2023-11-22 15:54:35.853598
3233	263933796	2023-11-22 15:55:01.461727
3234	592011622	2023-11-22 15:55:25.520841
3235	171220175	2023-11-22 16:35:37.515554
3236	244985754	2023-11-22 16:56:46.75712
3237	833298300	2023-11-23 08:43:10.176323
3238	695064366	2023-11-23 08:43:38.439018
3239	803792415	2023-11-23 08:44:03.824495
3240	915078019	2023-11-23 09:47:02.36477
3241	181755493	2023-11-23 09:49:40.680741
3242	479539658	2023-11-23 14:18:44.48974
3243	908390817	2023-11-24 10:38:20.63472
3244	171370536	2023-11-24 10:38:55.361017
3245	641248486	2023-11-24 10:39:20.676444
3246	889408435	2023-11-24 10:39:44.416658
3247	318218557	2023-11-24 15:34:38.455278
3248	965318456	2023-11-24 15:55:00.571681
3249	16929660	2023-11-24 15:55:32.859676
3250	175587928	2023-11-24 15:56:03.162959
3251	654902881	2023-11-24 15:56:31.403383
3252	192847629	2023-11-24 15:57:05.878099
3253	726066243	2023-11-24 15:57:28.270543
3254	704789506	2023-11-24 15:57:52.72093
3255	858290514	2023-11-24 16:00:43.995517
3256	654083346	2023-11-24 16:01:23.744588
3257	914178567	2023-11-24 16:30:50.150499
3258	964051207	2023-11-27 08:09:10.16989
3259	819039457	2023-11-27 08:46:16.220632
3260	867284333	2023-11-27 08:56:26.997893
3261	845269762	2023-11-27 09:09:54.032821
3262	819295546	2023-11-27 11:27:19.573694
3263	349373558	2023-11-27 12:16:42.836955
3264	878163266	2023-11-27 12:17:10.093398
3265	608193100	2023-11-27 13:44:31.480425
3266	3474848	2023-11-27 13:45:22.699937
3267	429313294	2023-11-27 14:19:10.381715
3268	725495926	2023-11-27 16:49:32.701924
3269	776031213	2023-11-27 16:50:40.657113
3270	478347919	2023-11-27 16:51:04.735468
3271	797670029	2023-11-27 16:51:47.695387
3272	335216024	2023-11-27 16:52:13.232448
3273	574257325	2023-11-27 16:52:47.306873
3274	469157649	2023-11-27 16:53:11.8305
3275	820630027	2023-11-27 20:32:15.598714
3276	184590144	2023-11-28 08:22:20.415458
3277	585363286	2023-11-28 08:48:02.31274
3278	973865349	2023-11-28 08:51:46.498693
3279	87539211	2023-11-28 08:58:35.895969
3280	651989322	2023-11-28 09:00:19.030628
3281	775299985	2023-11-28 09:38:08.507348
3282	392845722	2023-11-28 14:22:36.516919
3283	623994131	2023-11-28 18:02:57.524734
3284	76978687	2023-11-29 08:09:49.200931
3285	686481428	2023-11-29 09:08:11.27783
3286	954560451	2023-11-29 10:27:31.042513
3287	468224119	2023-11-29 10:28:29.580802
3288	6432234	2023-11-29 10:28:51.61096
3289	513247894	2023-11-29 10:29:15.592198
3290	444165142	2023-11-29 10:29:39.622343
3291	389291532	2023-11-29 10:30:06.103706
3292	83288342	2023-11-29 10:30:30.221913
3293	670477421	2023-11-29 10:32:06.448551
3294	935492781	2023-11-29 10:32:52.19547
3295	840288544	2023-11-29 10:33:26.672432
3296	875978749	2023-11-29 10:33:50.59299
3297	866675036	2023-11-29 10:40:24.891067
3298	622172942	2023-11-29 11:46:31.016452
3299	839238743	2023-11-29 11:47:07.296429
3300	19895923	2023-11-29 11:47:38.00766
3301	884980111	2023-11-29 11:48:10.956874
3302	90750107	2023-11-29 13:48:12.92525
3303	819457329	2023-11-29 15:30:57.62659
3304	115523892	2023-11-29 16:23:39.056826
3305	577210920	2023-11-30 12:40:09.536545
3306	289692103	2023-12-01 08:13:51.653797
3307	336194243	2023-12-01 08:14:43.024421
3308	265666384	2023-12-01 08:15:24.308571
3309	948930794	2023-12-01 08:15:42.117289
3310	160145026	2023-12-01 08:16:09.871565
3311	463530345	2023-12-01 08:16:56.373377
3312	781880385	2023-12-01 08:17:15.108255
3313	225762139	2023-12-01 08:17:35.675209
3314	606647477	2023-12-01 08:17:53.074582
3315	843008925	2023-12-01 08:18:14.269422
3316	497300039	2023-12-01 08:18:45.518526
3317	586797553	2023-12-01 08:19:17.007958
3318	773721645	2023-12-01 08:19:38.898083
3319	705014360	2023-12-01 08:19:54.783101
3320	648663638	2023-12-01 08:20:11.897463
3321	940038877	2023-12-01 08:20:28.57794
3322	667977302	2023-12-01 09:39:55.617627
3323	160987773	2023-12-01 09:40:15.871109
3324	15202804	2023-12-01 09:40:23.069748
3325	688077422	2023-12-01 09:40:29.346248
3326	654764388	2023-12-01 09:40:48.150328
3327	72302542	2023-12-01 09:40:54.396756
3328	774733546	2023-12-01 09:40:59.932285
3329	453003613	2023-12-01 09:41:13.753619
3330	496840841	2023-12-01 09:41:18.928225
3331	537440339	2023-12-01 09:41:24.270729
3332	284105613	2023-12-01 09:41:42.428475
3333	585883740	2023-12-01 09:41:53.92433
3334	457147257	2023-12-01 09:41:58.629044
3335	715842665	2023-12-01 09:42:03.489988
3336	311784407	2023-12-01 09:42:08.138979
3337	925984292	2023-12-01 10:06:53.185623
3338	73348133	2023-12-01 14:49:53.925035
3339	639352293	2023-12-01 15:40:51.459849
3340	780954049	2023-12-01 16:08:04.332686
3341	215378603	2023-12-01 16:35:02.128486
3342	784177470	2023-12-04 08:01:31.163385
3343	56136707	2023-12-04 08:01:53.719772
3344	433626738	2023-12-04 08:02:18.444167
3345	83171418	2023-12-04 08:02:40.005043
3346	908662940	2023-12-04 08:02:58.348707
3347	778311268	2023-12-04 08:03:15.78263
3348	534385607	2023-12-04 08:03:48.398187
3349	650735416	2023-12-04 08:04:05.85885
3350	484482191	2023-12-04 08:04:12.821917
3351	481450016	2023-12-04 08:58:40.213947
3352	478474608	2023-12-04 10:11:33.442184
3353	344688031	2023-12-04 11:07:32.219708
3354	910271098	2023-12-04 11:20:55.650129
3355	182082529	2023-12-04 11:29:28.108051
3356	669230644	2023-12-04 11:33:22.045484
3357	612073231	2023-12-04 11:44:53.049403
3358	677301330	2023-12-04 14:26:00.773428
3359	79026365	2023-12-04 14:33:45.639469
3360	281281950	2023-12-04 14:58:00.540808
3361	331075742	2023-12-04 17:22:25.354176
3362	602141186	2023-12-04 17:33:45.320923
3363	360375590	2023-12-05 09:00:04.154493
3364	352365900	2023-12-05 11:49:24.144762
3365	740915911	2023-12-05 11:49:55.125583
3366	736473320	2023-12-05 11:50:27.889611
3367	511076069	2023-12-05 13:14:39.049888
3368	922152229	2023-12-05 14:29:31.155149
3369	691985443	2023-12-05 14:46:55.55301
3370	112178939	2023-12-05 14:47:19.271585
3371	959677286	2023-12-05 14:47:36.313645
3372	265130400	2023-12-05 14:47:53.568473
3373	851109012	2023-12-05 14:48:09.310806
3374	293181584	2023-12-05 14:48:26.345696
3375	848756169	2023-12-05 14:48:43.552742
3376	852103292	2023-12-05 15:03:38.738853
3377	552656447	2023-12-05 15:13:56.290094
3378	133707833	2023-12-05 15:19:51.729403
3379	868029325	2023-12-05 15:23:35.547445
3380	399468660	2023-12-05 17:28:15.690281
3381	446382499	2023-12-05 18:26:36.577345
3382	612115016	2023-12-06 07:39:05.473456
3383	870220443	2023-12-06 09:22:16.544681
3384	727989994	2023-12-06 10:02:46.83411
3385	850701653	2023-12-06 10:33:30.418414
3386	791859005	2023-12-06 10:39:39.585583
3387	933870150	2023-12-06 11:36:15.614702
3388	282685120	2023-12-06 11:45:31.714065
3389	784545801	2023-12-06 15:41:20.538309
3390	466839905	2023-12-06 15:56:42.193912
3391	752724790	2023-12-06 15:57:44.927694
3392	288407766	2023-12-06 15:58:56.99337
3393	691524714	2023-12-06 15:59:39.346657
3394	73685296	2023-12-06 16:00:20.60242
3395	365985343	2023-12-06 16:01:26.586458
3396	48765823	2023-12-07 10:26:06.995126
3397	495004492	2023-12-07 10:26:31.955285
3398	536367234	2023-12-07 12:24:45.239497
3399	850880282	2023-12-07 14:19:16.068727
3400	933709769	2023-12-07 14:37:13.477134
3401	759288931	2023-12-07 16:26:10.785655
3402	632674622	2023-12-11 09:05:17.977535
3403	441615319	2023-12-11 09:27:19.302869
3404	644207753	2023-12-11 09:27:51.630856
3405	732122854	2023-12-11 09:28:19.03228
3406	302249855	2023-12-11 09:28:51.884954
3407	493562041	2023-12-11 09:29:07.885651
3408	646584587	2023-12-11 09:29:50.302854
3409	449457637	2023-12-11 09:30:14.730522
3410	389160937	2023-12-11 09:30:39.351722
3411	604119327	2023-12-11 09:31:20.166961
3412	776080941	2023-12-11 09:36:31.579911
3413	575117186	2023-12-11 09:42:10.78168
3414	849111096	2023-12-11 09:42:41.476371
3415	114111568	2023-12-11 09:44:04.38749
3416	81011822	2023-12-11 09:44:29.029849
3417	191051227	2023-12-11 09:44:55.677309
3418	637051072	2023-12-11 09:45:53.555574
3419	804636615	2023-12-11 09:46:17.603115
3420	15226577	2023-12-11 09:47:26.843961
3421	539666307	2023-12-11 10:13:12.581168
3422	593867287	2023-12-11 10:45:10.003529
3423	216854643	2023-12-11 11:08:17.434942
3424	790955361	2023-12-11 11:17:16.503367
3425	822835342	2023-12-11 11:40:06.493533
3426	203243668	2023-12-11 11:58:30.194558
3427	71216774	2023-12-11 13:08:01.147737
3428	40119697	2023-12-11 15:05:47.360132
3429	713956464	2023-12-11 15:06:07.638835
3430	733256580	2023-12-11 15:06:36.349493
3431	761150735	2023-12-11 15:35:34.364003
3432	806305493	2023-12-11 15:51:41.153243
3433	616738354	2023-12-11 16:58:17.617353
3434	990064355	2023-12-11 17:36:15.203213
3435	231848273	2023-12-11 17:44:42.063687
3436	253217617	2023-12-11 17:45:10.991136
3437	342218850	2023-12-11 17:45:37.522434
3438	303610283	2023-12-11 17:46:08.107784
3439	81747032	2023-12-11 17:46:35.829314
3440	315424856	2023-12-11 17:46:55.845621
3441	840276267	2023-12-12 08:51:37.869941
3442	238668342	2023-12-12 09:06:12.714846
3443	964467936	2023-12-12 09:19:03.254847
3444	863384431	2023-12-12 10:12:22.049819
3445	561869625	2023-12-12 10:30:40.764628
3446	207378484	2023-12-12 10:32:36.987475
3447	419059055	2023-12-12 10:33:47.512713
3448	751624737	2023-12-12 10:40:26.117841
3449	873966081	2023-12-12 10:40:48.66199
3450	335794460	2023-12-12 10:41:07.861271
3451	955514312	2023-12-12 10:41:23.593638
3452	917251448	2023-12-12 10:41:40.385979
3453	20365936	2023-12-12 10:41:57.224585
3454	107105275	2023-12-12 10:42:13.463761
3455	85031172	2023-12-12 10:42:28.610242
3456	35776633	2023-12-12 10:42:46.458151
3457	970600972	2023-12-12 10:43:02.639159
3458	883813845	2023-12-12 10:43:17.274662
3459	717474547	2023-12-12 11:03:49.803504
3460	742670173	2023-12-13 09:17:28.455579
3461	889943683	2023-12-13 09:17:54.484734
3462	645987841	2023-12-13 09:18:26.403825
3463	817498116	2023-12-13 09:19:01.733705
3464	698833337	2023-12-13 09:19:29.999177
3465	863095586	2023-12-13 09:19:52.662564
3466	74441131	2023-12-13 09:22:54.701884
3467	809318455	2023-12-13 11:13:41.237713
3468	755913170	2023-12-13 15:29:04.623203
3469	127237399	2023-12-13 15:45:40.101494
3470	969819591	2023-12-13 16:39:03.246791
3471	705204775	2023-12-13 16:39:46.447363
3472	245748912	2023-12-13 16:40:12.739676
3473	267833836	2023-12-13 16:40:42.636851
3474	730962878	2023-12-13 16:50:31.351842
3475	289915617	2023-12-13 23:33:13.187017
3476	510169208	2023-12-13 23:33:36.45723
3477	466623797	2023-12-13 23:34:14.292823
3478	700354827	2023-12-13 23:34:54.101169
3479	432150095	2023-12-13 23:35:15.424371
3480	276769368	2023-12-13 23:35:34.124111
3481	185819524	2023-12-13 23:35:52.681447
3482	954998381	2023-12-13 23:36:12.577471
3483	539339645	2023-12-14 09:16:31.13575
3484	965009295	2023-12-14 09:54:09.85779
3485	978406955	2023-12-14 10:54:53.073685
3486	64055869	2023-12-14 11:19:38.005382
3487	521751802	2023-12-14 11:20:27.315068
3488	35842400	2023-12-14 11:21:15.796798
3489	369216192	2023-12-14 11:21:51.619854
3490	626313353	2023-12-14 11:22:23.494478
3491	519251955	2023-12-14 11:47:38.498932
3492	62862902	2023-12-14 16:09:14.278963
3493	615570555	2023-12-14 16:32:07.993154
3494	101181614	2023-12-14 17:10:31.651144
3495	62256747	2023-12-14 17:26:24.897506
3496	78776238	2023-12-14 17:27:25.201018
3497	278220424	2023-12-14 17:28:01.092501
3498	793240517	2023-12-14 17:28:45.503594
3499	475716036	2023-12-15 09:12:13.12594
3500	997243677	2023-12-15 09:15:03.591835
3501	759003013	2023-12-15 09:26:39.57739
3502	654566049	2023-12-15 15:27:01.867904
3503	176494339	2023-12-15 15:49:51.7502
3504	578674904	2023-12-15 15:50:38.829096
3505	961722280	2023-12-15 15:51:23.27535
3506	905046747	2023-12-15 16:15:18.337713
3507	765397238	2023-12-15 17:08:50.742683
3508	168078652	2023-12-15 17:17:11.689724
3509	283964770	2023-12-15 17:27:51.449148
3510	825440422	2023-12-18 07:51:25.051485
3511	92323432	2023-12-18 09:01:22.561031
3512	798258777	2023-12-18 09:49:49.102372
3513	39296080	2023-12-18 09:50:25.290379
3514	513337902	2023-12-18 09:51:07.06557
3515	414688775	2023-12-18 09:51:40.362531
3516	730510661	2023-12-18 09:52:07.303307
3517	618690072	2023-12-18 09:58:02.812285
3518	281354947	2023-12-18 10:23:20.704651
3519	426905998	2023-12-18 11:21:13.61956
3520	926949578	2023-12-18 11:48:38.787301
3521	275859266	2023-12-18 11:50:53.230536
3522	999531638	2023-12-18 12:37:02.727259
3523	487447807	2023-12-18 12:37:29.901384
3524	521102510	2023-12-18 12:37:47.61471
3525	846671395	2023-12-18 12:38:05.772685
3526	7681868	2023-12-18 12:38:23.680139
3527	606371695	2023-12-18 12:38:38.77487
3528	490762665	2023-12-18 12:39:00.076364
3529	299007853	2023-12-18 13:18:10.149404
3530	610650596	2023-12-18 13:22:03.814614
3531	293343709	2023-12-18 17:06:38.636867
3532	119307398	2023-12-18 17:45:41.105933
3533	766055568	2023-12-18 17:46:26.23096
3534	810803597	2023-12-18 17:46:53.615499
3535	67499178	2023-12-18 17:47:15.218585
3536	601103793	2023-12-18 17:47:41.522338
3537	497742318	2023-12-18 18:18:41.681128
3538	910367252	2023-12-19 10:45:28.645208
3539	228343344	2023-12-19 13:45:11.817721
3540	361168940	2023-12-19 17:16:12.058452
3541	4969705	2023-12-19 17:16:52.321044
3542	651162911	2023-12-20 09:39:05.892222
3543	946077079	2023-12-20 11:30:57.216376
3544	266059949	2023-12-20 11:31:32.858201
3545	430059263	2023-12-20 11:32:01.323459
3546	217163972	2023-12-20 11:32:31.976318
3547	364207279	2023-12-20 11:32:54.484592
3548	315663135	2023-12-20 11:33:19.213892
3549	975639441	2023-12-20 11:34:30.407859
3550	134754976	2023-12-20 11:34:55.565385
3551	536225155	2023-12-20 16:00:28.865794
3552	562673424	2023-12-20 16:13:36.256669
3553	981854228	2023-12-20 16:14:14.117984
3554	976800470	2023-12-21 08:49:48.034005
3555	283501979	2023-12-21 08:51:37.174221
3556	410854566	2023-12-21 09:21:51.333856
3557	495962754	2023-12-21 09:43:43.736347
3558	128162239	2023-12-21 09:58:18.942358
3559	916055990	2023-12-21 09:58:33.945367
3560	813330521	2023-12-21 09:58:54.210229
3561	4230081	2023-12-21 11:25:13.462184
3562	620718548	2023-12-21 12:40:30.665924
3563	798896316	2023-12-21 16:08:28.132746
3564	716325355	2023-12-21 16:10:32.29133
3565	717507598	2023-12-21 16:10:33.897695
3566	242014708	2023-12-21 16:11:52.614053
3567	661356528	2023-12-22 08:38:22.568786
3568	169634020	2023-12-22 14:22:49.868639
3569	47255035	2023-12-22 16:35:05.408701
3570	595969557	2023-12-22 17:47:34.777544
3571	850034720	2023-12-26 10:46:07.331961
3572	857607378	2023-12-26 10:46:35.303217
3573	706155425	2023-12-26 10:46:58.881756
3574	867459400	2023-12-26 10:49:27.773888
3575	1430345	2023-12-26 10:49:51.307554
3576	495228600	2023-12-26 10:50:15.205836
3577	196620395	2023-12-26 10:50:44.776433
3578	867122338	2023-12-26 10:51:09.088145
3579	602193663	2023-12-26 10:51:33.878033
3580	142360189	2023-12-26 10:52:01.620366
3581	297096396	2023-12-26 10:52:27.928709
3582	740811929	2023-12-26 10:52:51.566116
3583	596311890	2023-12-26 10:53:18.080148
3584	905701226	2023-12-26 10:58:22.288032
3585	693910852	2023-12-26 11:08:20.182237
3586	752411954	2023-12-26 11:08:56.079819
3587	374944383	2023-12-26 11:09:52.872919
3588	197712219	2023-12-26 11:11:04.251124
3589	350006909	2023-12-26 11:13:13.945947
3590	78162504	2023-12-26 11:27:09.760405
3591	71010928	2023-12-26 15:54:28.021134
3592	490961995	2023-12-26 17:27:27.254045
3593	442323767	2023-12-27 07:28:53.780456
3594	24212688	2023-12-27 08:14:04.187184
3595	14956712	2023-12-27 10:30:28.25407
3596	421447459	2023-12-27 10:55:29.877872
3597	181518760	2023-12-27 10:56:20.272195
3598	415939465	2023-12-27 10:57:03.697229
3599	75952373	2023-12-27 10:57:32.357858
3600	694878664	2023-12-27 10:58:02.190461
3601	934702296	2023-12-27 10:58:37.407579
3602	491652245	2023-12-27 10:59:09.845833
3603	658239529	2023-12-27 10:59:47.665747
3604	94505838	2023-12-27 11:00:18.737435
3605	755021624	2023-12-27 11:00:50.092054
3606	618749110	2023-12-27 11:01:19.742286
3607	544827229	2023-12-28 08:31:32.199643
3608	765284595	2023-12-28 08:40:03.907832
3609	686850584	2023-12-28 08:52:54.584528
3610	941878634	2023-12-28 09:34:50.310215
3611	196917512	2023-12-28 09:35:19.797901
3612	955424527	2023-12-28 09:35:43.268417
3613	634239388	2023-12-28 09:36:40.129665
3614	373281064	2023-12-28 09:37:07.835347
3615	646217025	2023-12-28 09:37:26.479776
3616	357454362	2023-12-28 09:37:46.872984
3617	824434326	2023-12-28 09:38:11.183947
3618	586728603	2023-12-28 09:38:47.449989
3619	168433769	2023-12-28 10:40:32.430767
3620	151076507	2023-12-28 11:52:45.262833
3621	775506197	2023-12-29 08:10:16.606131
3622	640203368	2023-12-29 08:10:36.387751
3623	652943849	2023-12-29 08:10:50.417315
3624	242493190	2023-12-29 08:11:04.817114
3625	722860635	2023-12-29 08:11:21.824861
3626	780720990	2023-12-29 08:11:42.265157
3627	881561723	2023-12-29 08:45:27.394046
3628	704704566	2023-12-29 09:05:41.509503
3629	414569032	2023-12-29 10:17:43.571116
3630	249475884	2023-12-29 10:27:46.155952
3631	484639002	2023-12-29 11:31:18.924866
3632	292615374	2023-12-29 11:31:54.601903
3633	782289502	2023-12-29 11:32:05.666538
3634	546541932	2023-12-29 11:32:16.116773
3635	548285748	2023-12-29 11:32:26.736136
3636	719956623	2023-12-29 11:32:35.370677
3637	12690294	2023-12-29 11:32:48.594861
3638	859509975	2023-12-29 11:33:03.607939
3639	449755346	2023-12-29 11:33:19.354656
3640	703575791	2023-12-29 11:33:29.473025
3641	337361127	2023-12-29 11:33:40.785296
3642	672785691	2023-12-29 11:33:54.31365
3643	63673945	2023-12-29 11:34:08.6799
3644	602960088	2023-12-29 11:34:20.025789
3645	82314988	2023-12-29 11:34:29.137342
3646	531829986	2023-12-29 11:34:39.506007
3647	808829415	2023-12-29 11:34:52.050961
3648	514806948	2023-12-29 11:35:06.249084
3649	739303375	2023-12-29 11:35:16.849777
3650	241739792	2023-12-29 11:35:27.585555
3651	573497315	2023-12-29 11:35:36.835547
3652	575165445	2023-12-29 11:35:49.611054
3653	514652891	2023-12-29 11:35:57.277105
3654	781200537	2023-12-29 11:36:07.676421
3655	234493070	2023-12-29 11:36:16.92437
3656	170554192	2023-12-29 11:36:27.604034
3657	824199343	2023-12-29 11:36:36.131283
3658	986449131	2023-12-29 11:36:51.019316
3659	724975177	2023-12-29 11:37:00.893264
3660	478550570	2023-12-29 13:38:45.158684
3661	686057541	2023-12-29 13:39:10.011936
3662	23409475	2023-12-29 13:39:28.207908
3663	477540701	2023-12-29 13:39:44.259757
3664	522519063	2023-12-29 13:40:01.074334
3665	771145386	2023-12-29 13:40:15.930531
3666	934378420	2023-12-29 13:40:34.289902
3667	208311240	2023-12-29 15:56:54.794559
3668	524564981	2023-12-29 16:20:36.817864
3669	121828454	2023-12-29 16:58:52.937101
3670	703916163	2023-12-31 17:56:29.689477
3671	953545512	2023-12-31 17:57:20.351417
1	742909062	2024-01-02 14:22:47.446646
2	234675337	2024-01-02 14:23:29.550078
3	273685841	2024-01-02 14:29:31.164921
4	878970833	2024-01-03 08:59:25.031293
5	351749442	2024-01-03 10:42:07.354766
6	755520011	2024-01-03 14:24:46.092924
7	996634874	2024-01-03 14:26:11.406527
8	552070932	2024-01-03 14:26:34.359052
9	810406514	2024-01-03 14:26:57.849986
10	841256534	2024-01-03 17:20:18.692888
11	116406715	2024-01-03 17:20:38.801759
12	463720461	2024-01-04 08:32:21.694684
13	91780678	2024-01-04 10:47:10.546629
14	313053424	2024-10-08 16:30:10.266104
\.


--
-- TOC entry 4823 (class 0 OID 16487)
-- Dependencies: 219
-- Data for Name: historia_consecutivo; Type: TABLE DATA; Schema: consecutivos; Owner: postgres
--

COPY consecutivos.historia_consecutivo (consecutivo_id, consecutivo, usuario_id, prefijo_id, descripcion, fecha_generacion, num_consecutivo) FROM stdin;
436	2770	16	4	Aprobación cr GOMEZ PAVA VILMA AMPARO	2023-10-06 14:39:21.799817	\N
443	2777	125	7	Radicado Work-Manager 449274, solicitud del señor BARBOSA QUIMBAY HORACIO, (Cancelación pólizas, retiro cooperativa).	2023-10-09 09:27:42.268392	\N
451	2785	38	4	Certificado JORGE ENRIQUE ROJAS OTALORA cc: 19181093 credito 10- 211001141 	2023-10-10 10:55:50.294132	\N
458	2792	16	4	Aprobación cr APONTE MOTTA JORGE MARIO	2023-10-11 09:38:20.077915	\N
398	2732	16	5	APROBACIÓN CR RODRIGUEZ BALLEN OSCAR DAVID	2023-10-04 14:51:34.980959	\N
403	2737	119	6	CARTA DE RETIRO MARCELINO JAIME PRATS SALAS	2023-10-05 08:53:28.30589	\N
408	2742	119	6	CARTA DE APROBACIÓN DE RETIRO JOHN FITZGERALD LOZANO PAZ	2023-10-05 09:04:28.664061	\N
413	2747	119	6	CARTA DE APROBACIÓN DE RETIRO BERTHA ROMERO ROMERO	2023-10-05 09:10:24.756062	\N
418	2752	37	4	PAZ Y SALVO  HOUGHTON PEREZ JOSE MARIA	2023-10-05 10:40:29.939319	\N
423	2757	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-10-05 12:43:46.662807	\N
428	2762	29	6	CARTA DE BIENVENIDA COY SILVA DIANA JAZMIN	2023-10-05 17:33:02.443368	\N
433	2767	17	7	TRASLADO COOPCENTRAL AH UPCR A CTE AFINIDAD	2023-10-06 09:28:49.994296	\N
347	2681	16	4	APROBACIÓN CR IAC	2023-09-29 16:04:21.805839	\N
351	2685	32	4	REDENCION CDT 58269 DAVIVIENDA ABONO A CUENTA DE AHORROS	2023-10-02 12:16:43.979824	\N
355	2689	29	6	CARTA DE BIENVENIDA  BRAVO SANCHEZ ANDREA LUCIA	2023-10-02 15:03:17.560619	\N
359	2693	29	6	CARTA DE BIENVENIDA ESPINOSA SANCHEZ JEREMIAS	2023-10-02 15:05:38.758079	\N
363	2697	16	4	APROBACIÓN CR MORA MARTINEZ DIANA MILENA 	2023-10-02 15:47:56.906599	\N
367	2701	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-10-03 08:30:25.959019	\N
371	2705	30	5	ACEPTACIÓN DE RENUNCIA 	2023-10-03 08:35:45.845542	\N
375	2709	16	4	APROBACIÓN CR PÉREZ HOYOS GUSTAVO	2023-10-03 10:20:20.856952	\N
379	2713	29	6	CARTA DE BIENVENIDA ESCALANTE MARQUEZ BRUNO RICARDO	2023-10-03 10:32:01.402052	\N
465	2799	16	4	Aprobación cr GARCIA REYES LUZ FANNY	2023-10-11 10:22:32.960385	\N
472	2806	119	6	CARTA DE BIENVENIDA ASOCIADO RAUL ALBERTO RUIZ GARCIA 	2023-10-11 11:57:08.040007	\N
479	2813	16	4	Aprobación cr DELGADO GOMEZ OMAR OSWALDO	2023-10-11 17:21:38.140833	\N
486	2820	16	4	Aprobación Lozano Marquez Harvey 	2023-10-12 16:07:06.826625	\N
493	2827	16	4	Aprobación cr GARZON GOMEZ YASMINA 	2023-10-13 10:50:03.849369	\N
500	2834	7	9	Respuesta derecho de petición ANA YAMILE PINEDA TORRES	2023-10-17 14:13:07.52044	\N
506	2840	7	7	Respuesta derecho de petición asociado TEOFRASTO ANTONIO TATIS	2023-10-17 15:15:42.834261	\N
512	2846	16	4	Aprobación cr LOZANO GUARNIZO JAIRO ALBERTO	2023-10-18 08:17:40.270334	\N
518	2852	119	6	CARTA DE APROBACIÓN DE RETIRO- ROBERTO GARCÍA PIEDRAHITA 	2023-10-18 09:11:58.051871	\N
524	2858	119	6	CARTA DEBIENVENIDA- ROJAS OSPINA JULIO CESAR 	2023-10-18 11:54:19.826468	\N
383	2717	120	4	PAZ Y SALVO CARMEN TULIA BARRIOS DE CHAPARRO	2023-10-03 12:00:33.026179	\N
386	2720	16	4	APROBACIÓN CR SEPULVEDA CACERES WILLIAM HUMBERTO	2023-10-03 16:19:14.25609	\N
392	2726	37	4	CERTIFICADO DE DEUDA CREDITO AL DIA  CORREDOR RUIZ ALEJANDRA	2023-10-04 08:30:36.578211	\N
395	2729	32	4	CANCELACION CDT COOPCENTRAL FL NO 1991473	2023-10-04 12:26:33.334571	\N
272	2606	5	4	CERTIFICADO ANA CARMENZA CASTRO SALCEDO	2023-09-25 14:30:06.069485	\N
275	2609	16	4	APROBACIÓN CR RINCÓN LEURO OMAR 	2023-09-25 17:14:39.672348	\N
278	2612	5	4	CERTIFICADO HECTOR JOSE GALLEGO MARTINEZ	2023-09-26 08:35:39.86497	\N
281	2615	16	4	APROBACIÓN CR CORTES MORENO DIANA CLEMENCIA 	2023-09-26 10:06:20.914327	\N
284	2618	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-26 11:11:53.759048	\N
218	2552	32	4	PROVISION EFECTIVO TESORERIA	2023-09-19 12:01:57.723997	\N
318	2652	29	6	CARTA DE BIENVENIDA DUARTE MARTINEZ LUZ ANGELICA	2023-09-28 17:18:22.987628	\N
321	2655	29	6	CARTA DE BIENVENIDA FLOREZ PINZON JONATHAN ESTIBEN	2023-09-28 17:21:08.614074	\N
324	2658	29	6	CARTA DE BIENVENIDA BARRERA MOJICA KATHERINE	2023-09-28 17:22:16.052239	\N
327	2661	32	4	SOLICITUD CH GERENCIA SOCIEDAD GANLANTE RENDON Y CIA PAGO CASA PCR	2023-09-29 08:18:21.190715	\N
330	2664	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-29 09:13:38.273783	\N
333	2667	30	5	CONCESIÓN DE VACACIONES	2023-09-29 10:40:59.769448	\N
336	2670	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:17:48.905782	\N
337	2671	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:02.938225	\N
338	2672	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:14.093607	\N
530	2864	16	4	Aprobación cr DUEÑAS BOHORQUEZ SERGIO 	2023-10-18 14:32:52.840656	\N
533	2867	16	4	RPTA CONTROL INTERNO CRÉDITOS DIRECTIVOS 	2023-10-18 15:04:58.50169	\N
538	2872	5	4	CERTIFICADO MARIA AMPARO IBAÑEZ DE MONTAÑA	2023-10-19 10:11:20.166472	\N
544	2878	32	7	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-19 14:07:33.049553	\N
549	2883	16	4	Aprobación cr GARZÓN BOLIVAR MARCELA 	2023-10-19 15:45:02.368427	\N
554	2888	121	4	Carta reporte de pagos Ramón Moisés García Piment,y otros mes de julio de 2023	2023-10-19 17:52:13.733958	\N
559	2893	121	4	Carta Reporte de Pagos Mercedes Duarte de Navas y otros  P. No. 43227	2023-10-20 08:27:28.27937	\N
560	2894	32	7	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-20 08:27:52.160154	\N
565	2899	5	4	CERTIFICADO NILSON EVELIO LOPEZ SOTO	2023-10-20 09:10:44.33387	\N
570	2904	16	4	Aprobación cr DUARTE JARAMILLO DIANA CAROLINA	2023-10-20 11:47:17.714192	\N
575	2909	16	4	Aprobación cr NIETO PINTO MANUEL ANTONIO	2023-10-20 17:21:42.87584	\N
580	2914	16	4	aprobación cr Rubio León Clara Melisa	2023-10-23 13:32:15.013501	\N
585	2919	5	4	CERTIFICADO JOSE DARIO SALAZAR RAMOS	2023-10-23 16:55:03.105012	\N
590	2924	32	4	TRASL A CREDICORP DE BB RENTA YA	2023-10-24 15:14:19.26818	\N
595	2929	16	4	Aprobación cr ARIAS MARTINEZ SANDRA BIBIANA	2023-10-24 16:14:14.306268	\N
600	2934	16	4	Aprobación cr ARIZA RIAÑO PABLO ENRIQUE	2023-10-24 16:17:22.613426	\N
605	2939	16	7	Aprobación cr VANOY LUQUE IVAN GIOVANNI 	2023-10-25 11:55:59.693579	\N
437	2771	7	7	Solicitud de prorroga reporte del margen operacional septiembre 2023.	2023-10-06 17:01:05.20562	\N
444	2778	15	7	SOLICITUD PRORROGA PROYECCIONES FINANCIERAS SES	2023-10-09 10:47:40.692651	\N
452	2786	13	4	CARTA DE AUTORIZACION CHEQUERA EXCENTA	2023-10-10 14:00:55.098329	\N
459	2793	32	4	CIRCULARIZACION INVERSIONES-FED NAL DE COOP EDUCATIVO	2023-10-11 09:48:34.334168	\N
466	2800	16	4	Aprobación cr Torres Hernandez Carmelo 	2023-10-11 10:23:01.498683	\N
473	2807	32	7	CIRCULARIZACION INVERSIONES-IAC	2023-10-11 15:19:15.220244	\N
480	2814	16	4	Aprobación cr PALACIOS HOLGUIN LAURENCIO	2023-10-11 17:54:02.789385	\N
487	2821	16	4	Aprobación cr Pinto Nolla Jorge	2023-10-12 16:08:03.009172	\N
494	2828	37	4	PAZ Y SALVO MORENO ROMERO CESAR EDUARDO	2023-10-13 11:42:09.182448	\N
501	2835	16	4	Aprobación cr sacristan vega leslie 	2023-10-17 15:03:02.034372	\N
399	2733	16	4	APROBACIÓN CR ACERO BAENA JUAN PABLO 	2023-10-04 15:23:26.243783	\N
404	2738	119	6	CARTA DE APROBACIÓN DE RETIRO AURA ROSARIO GUTIERREZ AFRICANO	2023-10-05 08:54:42.399704	\N
409	2743	119	6	CARTA DE APROBACIÓN DE RETIRO OLGA LUCIA RODRIGUEZ CUELLAR	2023-10-05 09:05:35.902369	\N
507	2841	7	7	Respuesta derecho de petición LUZ YOLANDA ACUÑA GONZALEZ	2023-10-17 15:16:45.365703	\N
513	2847	16	4	Aprobación cr JAIMEZ SANCHEZ JEANET	2023-10-18 08:18:07.346109	\N
519	2853	119	6	CARTA DE APROBACIÓN DE RETIRO- LUZ MERY BOHORQUEZ FORERO	2023-10-18 09:12:48.546624	\N
525	2859	119	6	GOMEZ MORENO MARIBEL	2023-10-18 11:54:43.521602	\N
531	2865	16	4	Aprobación Garcia de \r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nAprobación cr Garcia de Achury Flora Helena\r\n\r\n\r\n\r\n\r\n\r\n	2023-10-18 14:34:52.4227	\N
534	2868	16	4	Aprobación cr SENCIAL GOMEZ CIRCE URANIA	2023-10-19 08:51:03.899112	\N
539	2873	38	4	Paz y salvo ESTEFANIA ARTEAGA NAVARRO  cc 1019004307  crédito 10-211001809  	2023-10-19 11:22:01.859882	\N
545	2879	7	7	Respuesta derecho de petición BRAYAN ANDRÉS MALDONADO PERDOMO - apoderado de EDDNY TATIANA PACHON RAMIREZ	2023-10-19 14:38:59.358144	\N
550	2884	16	4	Aprobación cr HENRIQUEZ HERNANDEZ CECILIA 	2023-10-19 15:45:42.79184	\N
555	2889	121	4	Carta Reporte de Pagos, caso Jorge Mario Méndez Morales y otros P. 1386-40716	2023-10-19 18:01:57.268349	\N
561	2895	16	4	Aprobación Blue Card Guevara Molano Elías 	2023-10-20 08:29:24.420736	\N
414	2748	119	6	CARTA DE APROBACIÓN DE RETIRO CESAR ARTURO PUERTAS CÉSPEDES	2023-10-05 09:11:01.583734	\N
419	2753	16	4	APROBACIÓN CR NOGUERA SIERRA JOAN LUIS	2023-10-05 11:20:47.895633	\N
424	2758	16	4	APROBACIÓN CR MARTINEZ PAEZ JOSE JESUS FERNANDO	2023-10-05 15:09:56.330303	\N
429	2763	29	6	CARTA DE BIENVENIDA PÉREZ CORREDOR VICTOR SANTIAGO	2023-10-05 17:33:21.520416	\N
434	2768	32	4	PROVISION EFECTIVO TESORERIA\r\n	2023-10-06 10:04:30.336402	\N
287	2621	16	4	APROBACIÓN CR MÉDINA AMARIS ALVARO LUIS 	2023-09-26 11:43:01.118442	\N
290	2624	29	6	CARTA DE BIENVENIDA FANDIÑO VALDERRAMA  CAMILO ARTURO	2023-09-26 11:44:46.848245	\N
293	2627	29	6	CARTA DE BIENVENIDA GUEVARA PEÑALOZA LAURA XIMENA	2023-09-26 11:50:00.18448	\N
296	2630	16	4	APROBACIÓN CR CABALLERO GALINDO LUZ OMAIRA 	2023-09-26 15:47:06.462511	\N
264	2598	16	4	APROBACIÓN MARTINEZ PULIDO PAOLA 	2023-09-22 15:31:47.05433	\N
215	2549	16	4	APROBACIÓN CRÉDITO VERGARA NAVARRO ERIKA VALENTINA KRUPSKAYA	2023-09-19 11:06:50.458719	\N
221	2555	15	7	GODOY & HOYOS ABOGADOS-SERVICIOS PROFESIONALES DECLARACIÓN DE RENTA 2019	2023-09-19 15:08:18.78149	\N
224	2558	15	7	SOLICITUD PRORROGA REPORTES UIAF (SES)	2023-09-19 16:51:31.931787	\N
227	2561	29	6	CARTA DE BIENVENIDA CABARCAS ALVAREZ JUAN PABLO	2023-09-19 17:56:59.879523	\N
230	2564	29	6	CARTA DE BIENVENIDA CLAVIJO BUSTOS PEDRO JULIO	2023-09-19 17:58:13.447464	\N
233	2567	119	6	RETIRO	2023-09-20 11:53:24.055415	\N
566	2900	121	4	Carta reporte abonos P.  48101 Myriam Roa De Barreto y otros	2023-10-20 09:15:28.091934	\N
571	2905	16	4	Aprobación cr CAMARGO SANCHEZ JESUS 	2023-10-20 11:48:09.053049	\N
576	2910	119	6	CARTA DE APROBACIÓN DE RETIRO- MARIN DELGADO ARIEL CARLOS	2023-10-20 18:07:12.85837	\N
581	2915	16	4	Aprobación cr Peñaranda Supelano Daniel ricardo 	2023-10-23 13:34:04.019551	\N
586	2920	32	4	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-24 09:09:27.181898	\N
591	2925	16	4	Aprobación cr CORREDOR PARDO DARIO	2023-10-24 15:27:23.198528	\N
596	2930	16	4	Aprobación cr ROJAS GUZMÁN LEIDY JULIET	2023-10-24 16:15:02.868988	\N
601	2935	16	4	Aprobación cr TAMAYO OSORIO RICARDO MAURICIO 	2023-10-24 16:17:52.813271	\N
606	2940	16	4	Aprobación cr HERRERA CORTES SERGIO ALBERTO	2023-10-25 11:56:39.22568	\N
611	2945	29	6	CARTA DE BIENVENIDA RAMOS JOVEL ANDRES ENRIQUE\r\n	2023-10-25 11:59:32.172456	\N
615	2949	29	6	CARTA DE BIENVENIDA MENDEZ RAMIREZ OLGA LUCIA	2023-10-25 12:02:45.831816	\N
619	2953	29	6	CARTA DE BIENVENIDA GOMEZ CASTAÑEDA ELVIS	2023-10-25 12:05:03.326435	\N
624	2958	29	6	CARTA DE BIENVENIDA RODRIGUEZ CASTAÑO JHON EDWIN	2023-10-25 12:15:28.804845	\N
628	2962	128	5	Solicitud Radicación Novedades Masivas	2023-10-25 15:27:34.387231	\N
632	2966	16	4	Aprobación Blue Card OJEDA MUÑOZ CAMILO	2023-10-26 10:58:09.023498	\N
635	2969	16	4	Aprobación cr MORENO MONROY ANTONIO 	2023-10-26 14:34:49.892233	\N
638	2972	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA SALAMANCA GONZALEZ LUIS GUILLERMO\r\n	2023-10-27 09:03:32.047891	\N
641	2975	16	4	Aprobación cr ZAMBRANO PARDO LILIANA 	2023-10-27 09:32:57.344451	\N
644	2978	29	6	CARTA DE BIENVENIDA ZARATE LUGO SYLVIA BIBIANA	2023-10-27 10:00:23.706144	\N
647	2981	29	6	CARTA DE BIENVENIDA CAICEDO BERDUGO ANDRES FELIPE	2023-10-27 10:01:52.357826	\N
649	2983	32	4	TRASL INTERNO BB RENTA YA A EXENTA BB	2023-10-27 11:14:16.380108	\N
651	2985	29	6	CARTA DE BIENVENIDA MARTINEZ BERNAL MARIA MARGARITA	2023-10-27 15:00:17.871197	\N
653	2987	37	4	PAZ Y SALVO SUAREZ QUICENO MONICA	2023-10-27 15:45:01.49129	\N
655	2989	119	6	CARTA DE BIENVENIDA- MURILLO SENCIAL ZAKIK	2023-10-27 16:47:47.826348	\N
438	2772	121	7	Certificación solicitada por la señora Mercedes Duarte para su declaración de Renta	2023-10-06 17:40:30.195045	\N
445	2779	32	4	TRASL INTERNO DE FIDUBBVA A BB AHO RENTA YA 	2023-10-09 12:02:55.401287	\N
453	2787	32	4	TRASL DE COLPATRIA AHO A CREDICORP	2023-10-11 07:51:08.978997	\N
460	2794	32	4	CIRCULARIZACION INVERSIONES-INCUBADORA EMP COLOMBIANA	2023-10-11 09:53:07.898533	\N
467	2801	32	7	CIRCULARIZACION INVERSIONES-IAC	2023-10-11 10:35:46.685693	\N
474	2808	32	7	\tCIRCULARIZACION INVERSIONES-BANCO COOPCENTRAL	2023-10-11 15:24:49.728465	\N
217	2551	32	4	TRASL INTERNO BANCO BOGOTA 	2023-09-19 11:59:58.554428	\N
481	2815	16	4	Aprobación cr TORRES MORENO BERTHA LILIANA	2023-10-11 18:09:17.529823	\N
488	2822	16	4	Aprobación cr GIRALDO GOMEZ JUAN ALEJANDRO	2023-10-12 17:27:05.626897	\N
495	2829	37	4	PAZ Y SALVO COMPRA VEHICULO  MORENO ROMERO CESAR EDUARDO	2023-10-13 11:47:09.278863	\N
502	2836	16	4	Aprobación cr RIVERA BARBOSA MARÍA ALEJANDRA  	2023-10-17 15:04:02.709721	\N
508	2842	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA CORREDOR RUIZ ALEJANDRA	2023-10-17 15:37:56.658427	\N
514	2848	119	6	CARTA APROBACIÓN DE RETIRO- MARTHA LUCÍA MINA RODRIGUEZ 	2023-10-18 09:07:02.256131	\N
520	2854	119	6	CARTA DE APROBACIÓN DE RETIRO- GABRIELA LUCIA SALAMANCA LEMOS 	2023-10-18 09:28:18.8529	\N
526	2860	119	6	CARTA DE BIENVENIDA- LOPEZ RODRIGUEZ JUAN CARLOS	2023-10-18 11:55:14.191761	\N
535	2869	16	4	Aprobación cr ARDILA GONZALEZ ANTONIO ALBERTO 	2023-10-19 08:51:39.697931	\N
540	2874	32	4	TRASL INTERNO DE COLPATRIA AHO A CREDICORP	2023-10-19 11:23:55.724125	\N
400	2734	16	4	APROBACIÓN BLUE CARD JAIME CORREA JAIRO	2023-10-04 15:24:21.65605	\N
405	2739	119	6	CARTA DE APROBACIÓN DE RETIRO YOLANDA CASTRO SALCEDO 	2023-10-05 08:55:28.714636	\N
410	2744	119	6	CARTA DE APROBACIÓN DE RETIRO SILVINO MARTIN MENDOZA 	2023-10-05 09:07:33.413134	\N
415	2749	119	6	CARTA DE APROBACIÓN DE RETIRO JOSE ANDRES ORDOÑEZ GUAQUETA	2023-10-05 09:11:36.018156	\N
420	2754	16	4	APROBACIÓN CR VANEGAS GARZON KAORY DANIELA	2023-10-05 11:45:11.095657	\N
425	2759	16	4	APROBACIÓN CR BRAVO SANCHEZ ANDREA LUCIA 	2023-10-05 15:11:14.44663	\N
430	2764	7	10	RESPUESTA DERECHO DE PETICIÓN ANA YAMILE PINEDA 	2023-10-05 19:26:39.685974	\N
435	2769	32	4	TRASL DE COLPATRIA AHO A CREDICORP	2023-10-06 10:07:45.316998	\N
396	2730	32	4	APERTURA CDT BANCOOMEVA FDO L	2023-10-04 12:27:11.986505	\N
267	2601	16	4	APROBACIÓN CR RAMIREZ MORENO BIBIANA	2023-09-25 10:40:16.623997	\N
270	2604	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-25 11:16:43.376009	\N
299	2633	30	5	SOLICITUD EXAMEN MEDICO OCUPACIONAL DE INGRESO	2023-09-27 13:53:11.31469	\N
302	2636	17	7	TRASLADO DE PSE A CTA AFINIDAD COOPCENTRAL	2023-09-28 08:26:55.841217	\N
305	2639	16	4	APROBACIÓN CR FLORES RONCANCIO VÍCTOR JULIO 	2023-09-28 08:54:33.246637	\N
308	2642	16	4	APROBACIÓN CR URREGO CASTIBLANCO FABIAN 	2023-09-28 10:13:32.409188	\N
311	2645	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-28 11:52:12.707233	\N
314	2648	16	4	APROBACIÓN CR ESTRADA ÁLVAREZ JAIRO HERNANDO  	2023-09-28 15:18:58.67462	\N
317	2651	29	6	CARTA DE BIENVENIDA INSTITUCION AUXILIAR DEL COOPERATIVISMO PARA EL BIENESTAR DE LOS ASOCIADOS DE COOPROFESORESUN	2023-09-28 17:17:57.01799	\N
320	2654	29	6	CARTA DE BIENVENIDA SANCHEZ HEREDIA ANA IMELDA	2023-09-28 17:20:48.774252	\N
323	2657	29	6	CARTA DE BIENVENIDA BARRERA MOJICA PIEDAD CONSTANZA	2023-09-28 17:21:49.839619	\N
326	2660	29	6	CARTA DE BIENVENIDA JARAMILLO TOCANCHON DAVID	2023-09-28 17:23:04.42201	\N
329	2663	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-29 09:10:54.435984	\N
349	2683	16	4	APROBACIÓN BLUE CARD CAMARGO CORTES GUILLERMO ARTURO	2023-10-02 10:29:45.852449	\N
353	2687	32	4	PROVISION EFECTIVO TESORERIA	2023-10-02 14:18:09.932696	\N
357	2691	29	6	CARTA DE BIENVENIDA CARRASCAL HERRERA ANA MARIA	2023-10-02 15:04:14.319021	\N
388	2722	10	3	SOLICITUD DE INFORMACIÓN	2023-10-03 17:41:50.766659	\N
546	2880	7	7	Respuesta derecho de petición Luz Yolanda Acuña González	2023-10-19 14:44:15.560599	\N
551	2885	14	4	Respuesta Derecho de petición Profesora Norma Chavarro	2023-10-19 16:01:30.453954	\N
556	2890	121	4	Carta reporte de abonos Hernán Javier Morales y otros Pagaré No.1315- 437	2023-10-20 07:39:10.870386	\N
562	2896	16	4	Aprobación cr Ibáñez Rincón Carolina 	2023-10-20 08:30:31.510132	\N
567	2901	121	4	Carta Reporte abonos P.7624 Lilia Stella Tarazona Romero y Diva Yanira Criollo Vargas	2023-10-20 09:26:43.88103	\N
572	2906	16	4	Aprobación cr PIMIENTO NELSON 	2023-10-20 11:48:53.740069	\N
577	2911	16	4	Aprobación cr RUIZ IZQUIERDO MARIA ALEJANDRA	2023-10-23 10:37:04.796482	\N
582	2916	16	4	Aprobación cr Riveros Riveros Sandra Rocio 	2023-10-23 13:34:51.393291	\N
587	2921	5	4	CERTIFICADO P.C.R.	2023-10-24 10:06:18.922464	\N
592	2926	16	4	Aprobación cr Tores Torres Libardo	2023-10-24 16:12:12.873087	\N
597	2931	16	4	Aprobación cr MORENO SOSA MARIBEL 	2023-10-24 16:15:26.17683	\N
602	2936	8	1	ORDEN DE COMPRA	2023-10-25 08:10:33.168572	\N
607	2941	16	4	Aprobación cr PEÑA DE TAMAYO TERESA DE JESUS 	2023-10-25 11:57:41.252455	\N
612	2946	29	6	CARTA DE BIENVENIDA HUERTAS MILLAN LUCIA	2023-10-25 12:00:18.904114	\N
616	2950	29	6	CARTA DE BIENVENIDA PERICO PULIDO HERNAN	2023-10-25 12:03:07.077947	\N
620	2954	29	6	CARTA DE BIENVENIDA MEDRANO BERMUDEZ JORGE ALFONSO	2023-10-25 12:11:43.45781	\N
625	2959	29	6	CARTA DE BIENVENIDA SMART FACTORING S.A.	2023-10-25 12:16:01.6174	\N
629	2963	37	4	CERTIFICADO DE DEUDA CREDITO AL DIA MATIZ MELO GERMAN EDUARDO	2023-10-26 08:43:35.555836	\N
633	2967	7	9	Solicitud de prorroga SANDRA PATRICIA BOHORQUEZ PIÑA	2023-10-26 11:26:26.117002	\N
636	2970	119	6	CERTIFICACIÓN DE NO ASOCIADOS COOPROFESORES	2023-10-26 15:50:56.128528	\N
639	2973	29	6	CARTA DE BIENVENIDA LEON NIETO DIEGO ISMAEL	2023-10-27 09:16:14.944924	\N
642	2976	16	4	Aprobación cr GOMEZ GUERRERO MANUEL EDUARDO	2023-10-27 09:33:44.520823	\N
645	2979	29	6	CARTA DE BIENVENIDA MORA TORRES SONIA GERALDINE	2023-10-27 10:00:52.476183	\N
439	2773	120	7	MEDICION Y SEGUIMIENTO CARTERA CON CORTE A SEPTIEMBRE DE 2023	2023-10-06 22:24:27.398594	\N
446	2780	8	1	Orden de Compra	2023-10-09 13:48:53.78472	\N
447	2781	8	1	Orden de Compra	2023-10-09 13:49:08.226317	\N
236	2570	119	6	RETIRO	2023-09-20 11:55:08.194504	\N
239	2573	16	7	APROBACIÓN CR MEJIA ACEVEDO MIGUEL ANGEL	2023-09-20 15:59:34.673285	\N
242	2576	16	7	APROBACIÓN CR RIVERA MORATO CLAUDIA PATRICIA	2023-09-20 17:22:53.089001	\N
245	2579	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA MONROY RODRIGUEZ CAMILO ANDRES 80873954	2023-09-21 11:52:15.349602	\N
248	2582	16	4	APROBACIÓN CR GALINDO CUERVO FLOR 	2023-09-21 15:19:40.454316	\N
251	2585	5	4	CERTIFICADO GERARDO RODRIGO IBAÑEZ FONSECA	2023-09-22 09:33:28.709336	\N
254	2588	32	4	CONSTITUCION CDT BANCOOMEVA	2023-09-22 11:54:26.951276	\N
257	2591	38	4	CERTIFICADO HIPOTECARIO 2022 - JORGE MARTINEZ CC 7226897  10-191008992 	2023-09-22 14:37:58.666263	\N
260	2594	29	6	CARTA DE BIENVENIDA ROLDAN GARCIA TULIA CONSTANZA	2023-09-22 15:01:53.640011	\N
263	2597	13	4	CARTA CHEQUE DE GERENCIA UNIVERSIDAD NACIONAL	2023-09-22 15:14:24.174729	\N
348	2682	16	4	ENTREGA DE PAGARÉ IAC A TESORERÍA 	2023-10-02 09:58:17.934654	\N
352	2686	38	4	CERTIFICADO CREDITO HIPOTECARIO COMERCIAL 10-211001792  BARBARA DE LAS MERCEDES MORENO MURILLO CC 41406699	2023-10-02 12:22:32.958471	\N
356	2690	29	6	CARTA DE BIENVENIDA DIAZ CASTILLO URIEL	2023-10-02 15:03:49.093587	\N
360	2694	16	4	APROBACIÓN CR BERMUDEZ NUR MIRABAI 	2023-10-02 15:45:32.090092	\N
364	2698	15	5	RESPUESTA SERVIDUMBRE PANDI. ÁREA DE INMUEBLES	2023-10-02 16:03:53.654406	\N
368	2702	30	5	CARTA RETIRO DE CESANTIAS	2023-10-03 08:32:52.321213	\N
372	2706	38	4	PAZ Y SALVO  ANIVERSARIO COOPROFESORESUN NO. 10– 211001723  DIANA MILENA GOMEZ MORENO  CC 1023910993 	2023-10-03 09:40:07.034556	\N
376	2710	29	6	CARTA DE BIENVENIDA GARZON SANTOS JUAN PABLO	2023-10-03 10:30:51.595534	\N
380	2714	29	6	CARTA DE BIENVENIDA CARDENAS LOBOGUERRERO DAMIAN	2023-10-03 10:32:22.999814	\N
384	2718	16	4	APROBACIÓN CR PACHÓN VALERO LIDA CAROLINA	2023-10-03 15:42:49.386368	\N
387	2721	10	3	SOLICITUD DE INFORMACION	2023-10-03 17:41:24.628418	\N
393	2727	37	4	CERTIFICADO CREDITO HIPOTECARIO CORTE 31 DE DICIEMBRE BAENA DOELLO JUAN DOMINGO AREA DE CARTERA	2023-10-04 09:01:38.920363	\N
361	2695	16	4	APROBACIÓN CR CARRERO ACEVEDO URIEL ANCIZAR	2023-10-02 15:46:15.542514	\N
365	2699	38	4	PAZ Y SALVO 11– 211000181  VILMA AMPARO GOMEZ PAVA  CC 36176946 	2023-10-02 16:16:47.809053	\N
369	2703	30	5	CARTA SOLICITUD EXÁMENES MÉDICOS DE EGRESO	2023-10-03 08:33:24.76454	\N
373	2707	5	4	CERTIFICADO DAVID ERNESTO PUENTES LAGOS	2023-10-03 10:06:29.176469	\N
377	2711	29	6	CARTA DE BIENVENIDA PABON  LEIDY OMAIRA	2023-10-03 10:31:15.19421	\N
381	2715	29	6	CARTA DE BIENVENIDA ZAMBRANO ACOSTA INGRID	2023-10-03 10:32:43.011885	\N
385	2719	16	4	APROBACIÓN CR JARAMILLO TOCANCHON DAVID	2023-10-03 15:44:50.923484	\N
389	2723	10	3	SOLICITUD DE INFORMACIÓN	2023-10-03 17:41:58.580425	\N
390	2724	10	3	SOLICITUD DE INFORMACIÓN	2023-10-03 17:42:06.011493	\N
394	2728	16	4	APROBACIÓN CR RINCON NOGUERA DIANA CAROLINA	2023-10-04 11:34:27.010243	\N
401	2735	126	7	CARTA APOYO  FESTIVAL FOLCLORICO "DEJANDO HUELLA"	2023-10-04 15:31:00.006383	\N
406	2740	119	7	CARTA DE APROBACIÓN DE RETIRO NANCY MOGOLLON CADENA	2023-10-05 08:56:21.517708	\N
411	2745	119	6	CARTA DE APROBACIÓN DE RETIRO LUIS ENRIQUE FLOREZ ALARCON	2023-10-05 09:08:08.280196	\N
416	2750	37	4	CERTIFICADO CREDITO HIPOTECARIO CORTE 31 DE DICIEMBRE VARGAS SANCHEZ JENNY ASTRID	2023-10-05 09:37:54.354144	\N
421	2755	120	4	CERTIFICACION PAGO SEPTIEMBRE 27 GLORIA LIGIA CUELLAR	2023-10-05 11:52:18.40051	\N
426	2760	16	4	APROBACIÓN CR MESA CARO LAURA VICTORIA	2023-10-05 16:59:00.212247	\N
431	2765	16	4	APROBACIÓN CR DUARTE MARTINEZ LUZ ANGELICA	2023-10-06 09:05:53.890208	\N
312	2646	5	4	CERTIFICADO CAMILO ANTONIO MONROY PEÑA	2023-09-28 14:48:58.552514	\N
332	2666	16	4	APROBACIÓN CR RODRIGUEZ SIERRA DORA ALBA 	2023-09-29 10:24:25.472336	\N
335	2669	16	4	APROBACIÓN CR  VASQUEZ MENDOZA ALMA RAQUEL	2023-09-29 13:50:32.814562	\N
273	2607	15	7	CARTA A AVIA SEGRUOS	2023-09-25 16:58:25.689812	\N
276	2610	16	4	APROBACIÓN CR NAVARRO DE MORALES AMPARO 	2023-09-25 17:15:16.742114	\N
279	2613	37	7	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA CORREDOR ESPINEL VLADIMIR	2023-09-26 09:26:11.461369	\N
282	2616	16	4	APROBACIÓN CR BERNAL POVEDA CAMPO ELIAS  	2023-09-26 10:07:01.118662	\N
285	2619	32	4	TRASLADO A FONVAL CREDICORP FIC	2023-09-26 11:15:25.782574	\N
397	2731	125	4	RESPUESTA PQR LUIS ROBERTO MARTINEZ MUÑOZ	2023-10-04 12:34:55.106381	\N
288	2622	29	6	CARTA DE BIENVENIDA RODRIGUEZ BLANCO ANDREA LUCERO	2023-09-26 11:43:44.597808	\N
291	2625	29	6	CARTA DE BIENVENIDA SOLANO CARDENAS JANETH TATIANA	2023-09-26 11:45:20.854385	\N
294	2628	29	6	CARTA DE BIENVENIDA LEYTON BASTIDAS JULIO WILFREDO	2023-09-26 15:35:29.116009	\N
265	2599	16	4	APROBACIÓN CR VASQUEZ MENDOZA EVELYN 	2023-09-22 15:49:03.348437	\N
454	2788	16	4	Aprobación cr DIAZ ORTEGON JOHN ALEXANDER	2023-10-11 08:50:40.157063	\N
461	2795	32	7	CIRCULARIZACION INVERSIONES-ASOCIACION COLOMBIANA DE COOPERATIVAS-ASCOOP	2023-10-11 09:56:04.858425	\N
468	2802	119	6	CARTA DE BIENVENIDA ASOCIADO JUAN SEBASTIAN GUTIERREZ RAMOS 	2023-10-11 11:53:20.74491	\N
475	2809	32	7	CIRCULARIZACION INVERSIONES-COOPERACION VERDE SA	2023-10-11 15:25:16.4775	\N
482	2816	16	4	Aprobación cr MARTINEZ CASTRO JOSE ORLANDO	2023-10-11 18:14:46.677396	\N
489	2823	16	4	Aprobación cr PABON  LEIDY OMAIRA	2023-10-12 17:32:43.46658	\N
496	2830	32	4	PROVISION EFECTIVO	2023-10-13 14:51:25.457025	\N
503	2837	16	4	Aprobación cr TORRES CARDENAS ALICIA 	2023-10-17 15:04:32.686808	\N
509	2843	42	7	Terminación del contrato de aprendizaje por vencimiento del término pactado.	2023-10-17 16:20:00.305409	\N
515	2849	119	6	CARTA DE APROBACIÓN DE RETIRO-FABIAN ENRIQUE VILAR RUBIANO	2023-10-18 09:09:05.456547	\N
521	2855	119	6	CARTA DE BIENVENIDA- RIVEROS RIVEROS SANDRA ROCIO\r\n	2023-10-18 11:53:00.746234	\N
541	2875	32	4	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-19 11:57:31.113172	\N
440	2774	13	7	CARTA CHEQUE DE GERENCIA U. NACIONAL 	2023-10-09 07:56:38.890353	\N
448	2782	42	5	Solicitud examen médico de ingreso.	2023-10-10 07:35:19.892522	\N
455	2789	16	4	Aprobación cr GUEVARA PEÑALOZA LAURA XIMENA	2023-10-11 09:02:22.549796	\N
462	2796	32	7	\tCIRCULARIZACION INVERSIONES-BANCO COOPCENTRAL	2023-10-11 09:59:40.006674	\N
469	2803	119	6	CARTA DE BIENVENIDA ASOCIADO VANOY LUQUE IVAN GIOVANNI	2023-10-11 11:54:14.882261	\N
476	2810	32	7	CIRCULARIZACION INVERSIONES-PROMOTORA DE PROYECTOS AMBIENTALES	2023-10-11 15:26:07.917937	\N
483	2817	16	4	Aprobación cr TOLOZA AYALA ZEGELLA	2023-10-11 18:21:36.205067	\N
490	2824	16	7	Aprobación cr CHARA CALVACHE MARLYN ALEXANDRA	2023-10-13 07:53:05.372501	\N
497	2831	5	4	CERTIFICADO PEDRO CALIXTO ROBERTO PATARROYO GAMA	2023-10-17 08:32:57.197144	\N
504	2838	16	4	Aprobación cr APONTE MOTTA JORGE MARIO 	2023-10-17 15:05:13.581553	\N
510	2844	5	4	CERTIFICADO FANNY HERNANDEZ GARCIA	2023-10-18 08:05:13.053682	\N
516	2850	119	6	CARTA DE APROBACIÓN DE RETIRO- ROBERTO FERNANDO BECERRA TORRES 	2023-10-18 09:09:53.587871	\N
522	2856	119	6	CARTA DE BIENVENIDA- BELTRAN ALFONSO MANUEL JOSE 	2023-10-18 11:53:28.503592	\N
527	2861	119	6	CARTA DE BIENVENIDA-BALLESTEROS CELIS BRIGITH DAYANA 	2023-10-18 11:55:44.226357	\N
536	2870	16	4	Aprobación cr Dueñas Pinto Ramiro Javier	2023-10-19 08:53:20.049641	\N
542	2876	32	7	CARTA CANCELACION CUENTA BBVA AHORROS	2023-10-19 13:46:08.962483	\N
547	2881	42	5	RESPUESTA A DERECHO DE PETICIÓN.	2023-10-19 15:38:22.65839	\N
552	2886	13	7	CARTA CHEQUE DE GERENCIA COMPENSAR	2023-10-19 16:13:31.293631	\N
557	2891	121	4	Carta Reporte de Pago José Vicente Cruz García P. 37673 	2023-10-20 08:01:21.071381	\N
563	2897	121	4	Carta Reporte de Abonos Luis Felipe Cruz Rodríguez  P. 1697-3196	2023-10-20 08:40:58.454304	\N
568	2902	121	4	Carta Reporte de Pago P. 6915 GIOVANNI ROMERO PEREZ	2023-10-20 09:35:42.24901	\N
573	2907	16	4	Aprobación cr SANTOS SAENZ GUILLERMO ARTURO	2023-10-20 11:49:25.575206	\N
578	2912	10	3	ENTREGA DE ESCRITURAS- UNION A CARTERA	2023-10-23 11:56:04.576996	\N
583	2917	129	2	Respuesta memorando Solicitud información SARLAFT III Trimestre 2023	2023-10-23 14:22:26.575612	\N
588	2922	5	4	CERTIFICADO GLADYS ARIZA CUBIDES	2023-10-24 10:06:48.97752	\N
593	2927	16	4	Aprobación cr PARRA MARTINEZ CLARA INES 	2023-10-24 16:13:05.660153	\N
598	2932	16	4	Aprobación cr URREGO ARIAS ELIZABETH 	2023-10-24 16:16:23.430125	\N
603	2937	32	4	REDENCION CDT FL 1991512 COOPCENTRAL\r\n	2023-10-25 11:49:19.013969	\N
608	2942	16	4	Aprobación cr RODRÍGUEZ ESPINOSA PABLO	2023-10-25 11:58:28.193457	\N
613	2947	29	6	CARTA DE BIENVENIDA GUERRERO CASTELLANOS CAMILA 	2023-10-25 12:01:37.910366	\N
617	2951	29	6	CARTA DE BIENVENIDA MEZA CASTILLO MIGUEL JACINTO	2023-10-25 12:03:29.542248	\N
621	2955	29	6	CARTA DE BIENVENIDA RODRIGUEZ OLIVERA ALDERSON	2023-10-25 12:12:04.317588	\N
622	2956	29	6	CARTA DE BIENVENIDA BECERRA OSTOS LUISA FERNANDA	2023-10-25 12:12:27.066357	\N
626	2960	7	7	Respuesta solicitud de auxilio JAIRO ANTONIO GARCÍA SUESCA	2023-10-25 12:33:49.357605	\N
630	2964	16	4	Aprobación Blue card GUEVARA PEÑALOZA LAURA XIMENA	2023-10-26 10:49:53.638086	\N
634	2968	121	4	Carta de Cobro William Amílcar Daza 26/10/2023	2023-10-26 11:52:24.513525	\N
637	2971	37	4	PAZ Y SALVO SALAMANCA GONZALEZ LUIS GUILLERMO	2023-10-27 08:55:58.563876	\N
640	2974	16	4	Aprobación cr ANTOLINEZ CACERES ANA ISBELIA	2023-10-27 09:27:10.71687	\N
643	2977	29	6	CARTA DE BIENVENIDA TORRES PINZÓN MICHAEL NICOLÁS	2023-10-27 09:59:50.036182	\N
646	2980	29	6	CARTA DE BIENVENIDA SERRANO SANABRIA SANDRA LILIANA	2023-10-27 10:01:30.515634	\N
648	2982	29	6	CARTA DE BIENVENIDA JARA GUTIERREZ NICOLAS	2023-10-27 10:02:23.651047	\N
650	2984	38	4	certificado de deuda MONICA SUAREZ QUICENO cc 30330343 crédito 10- 231000285 	2023-10-27 11:15:33.983688	\N
652	2986	120	4	respuesta solicitud periodo de gracia Adriana Alder 	2023-10-27 15:39:04.441504	\N
654	2988	119	6	CARTA DE BIENVENIDA- RAMOS JOVEL ANDRES ENRIQUE 	2023-10-27 16:44:11.610253	\N
656	2990	119	6	CARTA DE BIENVENIDA- HUERTAS MILLAN LUCIA 	2023-10-27 16:48:47.516168	\N
657	2991	119	6	CARTA DE BIENVENIDA- GUERRERO CASTELLANOS CAMILA 	2023-10-27 16:50:32.3491	\N
658	2992	16	4	Aprobación cr BELTRÁN ALFONSO MANUEL  	2023-10-27 17:00:43.380199	\N
659	2993	16	4	Aprobación cr VILLATE BOLIVAR OROMACIO	2023-10-27 17:01:29.272298	\N
660	2994	16	4	Aprobación cr RODRIGUEZ MUÑOZ EDUARDO	2023-10-27 17:01:53.342269	\N
661	2995	16	4	Aprobación cr MOJICA CARDOZO CLARA	2023-10-27 17:02:11.813661	\N
662	2996	16	4	Aprobación cr CORREA HERRAN ALBERTO	2023-10-27 17:02:34.63137	\N
663	2997	16	4	Aprobación cr ZARATE MARTINEZ ALBERTO	2023-10-27 17:02:55.866288	\N
664	2998	16	4	Aprobación cr HERNANDEZ CORTES MARGARITA 	2023-10-27 17:03:19.726372	\N
665	2999	16	4	Aprobación cr CELY RODRIGUEZ ALEXANDER	2023-10-27 18:18:16.024804	\N
666	3000	130	4	CARTA CRÉDITO COMERCIAL	2023-10-30 10:03:57.447805	\N
667	3001	32	4	PROVISION EFECTIVO	2023-10-30 10:06:49.749638	\N
668	3002	37	4	CERTIFICADO DE DEUDA CREDITO AL DIA PINEDA TORRES NORHA ESPERANZA	2023-10-30 14:06:14.34277	\N
669	3003	16	4	Aprobación cr MALAMBO LILIANA	2023-10-30 16:31:26.0772	\N
670	3004	16	4	Aprobación cr VANEGAS DE AHOGADO BLANCA CECILIA 	2023-10-30 16:32:07.6587	\N
671	3005	16	4	Aprobación cr RODRIGUEZ CASTAÑO JHON EDWIN	2023-10-30 16:32:57.549776	\N
672	3006	16	4	Aprobación cr FONSECA GARZÓN PATRICIA 	2023-10-30 16:33:30.329197	\N
673	3007	16	4	Aprobación cr BALLESTEROS PEREZ JUAN DAVID	2023-10-30 16:33:56.348406	\N
674	3008	121	7	Atención derecho de petición Clarita Franco de Machado y Luis Eduardo Machado, 9 de octubre de 2023	2023-10-30 18:16:26.29838	\N
675	3009	7	7	Carta de compromiso de desembolso Helber De Jesús Barbosa 	2023-10-30 18:21:04.930463	\N
676	3010	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-31 09:09:06.36968	\N
441	2775	125	4	Radicado Work-manager 449657, no aplicación de cobros de póliza año 2021	2023-10-09 08:08:03.869807	\N
449	2783	127	5	Carta Solicitud Radiación Novedades Masivas Sanitas	2023-10-10 09:14:55.380958	\N
456	2790	32	4	CIRCULARIZACION INVERSIONES-LA EQUIDAD S O.C.	2023-10-11 09:33:19.310299	\N
463	2797	32	7	CIRCULARIZACION INVERSIONES-PROMOTORA DE PROYECTOS AMBIENTALES	2023-10-11 10:08:46.456126	\N
470	2804	119	6	CARTA DE BIENVENIDA ASOCIADA LUZ MARINA LEON MONTENEGRO	2023-10-11 11:56:03.195734	\N
477	2811	5	4	CERTIFICADO NOHORA STELLA DIAZ CUBILLOS	2023-10-11 15:50:40.306458	\N
484	2818	16	4	Aprobación cr GONZALEZ TIQUE SERGIO LEONARDO	2023-10-12 09:37:51.38018	\N
491	2825	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-13 08:39:29.556955	\N
498	2832	37	4	CERTIFICADO CREDITO HIPOTECARIO CORTE 31 DE DICIEMBRE PERILLA BURBANO SOLVEY JANETH	2023-10-17 09:15:12.047987	\N
505	2839	16	4	Aprobación cr MALDONADO PACHÓN HERNANDO 	2023-10-17 15:05:52.696656	\N
511	2845	16	7	Aprobación cr GARCIA CASTAÑEDA AMAURY	2023-10-18 08:17:04.789434	\N
517	2851	119	6	CARTA DE APROBACIÓN DE RETIRO-LENYN ALEJANDRO URUEÑA LÓPEZ\r\n	2023-10-18 09:11:14.960928	\N
523	2857	119	6	CARTA DE BIENVENIDA- ORTEGA QUICASAN CLAUDIA MARCELA 	2023-10-18 11:53:54.31208	\N
528	2862	16	4	Aprobación cr RINCON QUIJANO EDGARD 	2023-10-18 14:29:56.29144	\N
532	2866	16	4	RPTA CONTROL INTERNO PAGARÉS 	2023-10-18 15:04:31.321729	\N
537	2871	5	4	CERTIFICADO MARIA AMPARO IBAÑEZ DE MONTAÑA	2023-10-19 10:10:55.371873	\N
543	2877	32	7	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-19 13:58:57.749157	\N
548	2882	16	4	Aprobación cr VELANDIA UYABAN ADERSON DUBAN	2023-10-19 15:44:10.479417	\N
553	2887	121	4	Carta reporte de honorarios Daniel Alberto Libreros Caicedo,  julio y agosto 2023	2023-10-19 17:45:46.690256	\N
216	2550	42	7	PREVENCIÓN SOBRE ACOSO SEXUAL	2023-09-19 11:57:16.235557	\N
219	2553	16	4	ENTREGA DE PAGARÉS A TESORERÍA 	2023-09-19 14:35:19.597211	\N
222	2556	15	7	BUITRAGO Y ASOCIADOS - SERVICIOS PROFESIONALES DECLARACIÓN DE RENTA 2019	2023-09-19 15:09:05.37446	\N
225	2559	29	6	CARTA DE BIENVENIDA AREVALO QUIÑONES WILLIAM FERNANDO	2023-09-19 17:55:40.78893	\N
228	2562	29	6	CARTA DE BIENVENIDA LEGUZAMON CARDENAS LUIS GERMAN	2023-09-19 17:57:24.805596	\N
231	2565	29	6	CARTA DE BIENVENIDA ANGEL DAVILA JUAN CARLOS	2023-09-19 17:58:32.175704	\N
234	2568	119	6	RETIRO	2023-09-20 11:54:21.984673	\N
237	2571	119	6	RETIRO	2023-09-20 11:55:54.493154	\N
240	2574	16	7	APROBACIÓN CR BAQUERO ZAMUDIO JUAN DAVID	2023-09-20 16:00:09.926952	\N
243	2577	38	4	PAZ Y SALVO MARIA GLORIA ZGAIBA CC: 20565540 -  CRÉDITO ORDINARIO DE INVERSION LIBRE NO. 10– 231000492	2023-09-21 08:37:16.306399	\N
246	2580	16	7	APROBACIÓN CR MARTINEZ PULIDO PAOLA	2023-09-21 14:10:41.91859	\N
249	2583	16	4	APROBACIÓN CR PEREA SABOGAL JUAN FRANCISCO	2023-09-21 16:41:24.722035	\N
252	2586	32	4	REDENCION CDT FALABELLA 433004	2023-09-22 11:42:13.744517	\N
255	2589	30	5	CONCESIÓN DE VACACIONES	2023-09-22 12:29:33.18992	\N
258	2592	29	6	CARTA DE BIENVENIDA ACOSTA MALAGON JOSE ELVER	2023-09-22 15:00:35.430664	\N
261	2595	29	6	CARTA DE BIENVENIDA DIAZ ORTEGON JOHN ALEXANDER	2023-09-22 15:02:18.311253	\N
268	2602	16	4	APROBACIÓN CR RAMIREZ GUARIN OLGA LUCIA 	2023-09-25 10:41:02.174582	\N
271	2605	13	4	CARTA CHEQUE DE GERENCIA COMPENSAR	2023-09-25 14:10:05.466702	\N
297	2631	16	4	APROBACIÓN CR CHAPPE CHAPPE ANGELICA 	2023-09-26 17:33:08.003033	\N
300	2634	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-27 15:07:41.991771	\N
303	2637	16	4	APROBACIÓN CR MORENO RODRIGUEZ MARIA CRISTINA	2023-09-28 08:52:52.48193	\N
306	2640	32	4	PROVISION EFECTIVO TESORERIA\r\n	2023-09-28 09:37:44.571798	\N
309	2643	122	8	RESPUESTA A DERECHO DE PETICIÓN MIGUEL ANGEL VERA	2023-09-28 10:36:32.23611	\N
315	2649	5	4	CERTIFICADO AURELIANO HERNANDEZ VASQUEZ	2023-09-28 15:40:34.84561	\N
247	2581	30	5	SOLICITUD EXAMEN MEDICO OCUPACIONAL DE INGRESO	2023-09-21 14:58:21.252399	\N
250	2584	16	4	APROBACIÓN CR ORTIZ GOMEZ ISABEL CRISTINA	2023-09-22 08:53:46.261248	\N
253	2587	17	7	TRASLADO DE RENTAYA A EXENTA	2023-09-22 11:53:54.521173	\N
256	2590	30	5	SOLICITUD EXAMEN MEDICO OCUPACIONAL DE INGRESO	2023-09-22 12:31:40.803593	\N
259	2593	29	6	CARTA DE BIENVENIDA CRUZ IBAÑEZ ANGELA VIVIANA	2023-09-22 15:01:23.797936	\N
262	2596	29	6	CARTA DE BIENVENIDA DAVIA CASTILLO MARIA TERESA CLEMENCIA	2023-09-22 15:02:42.839809	\N
269	2603	32	4	PROVISION EFECTIVO TESORERIA	2023-09-25 11:14:45.80869	\N
558	2892	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-20 08:23:28.2297	\N
564	2898	121	4	Carta reporte de abonos P. 1943-2568, Herbert Giraldo Gómez y otro	2023-10-20 09:01:44.070916	\N
569	2903	119	6	CARTA DE BIENVENIDA- BAYUELO SIERRA ALFREDO JOSE \r\n	2023-10-20 10:44:03.052093	\N
574	2908	7	7	Derecho de petición dirigido a EMPRESA DE ACUEDUCTO Y ALCANTARILLADO DE BOGOTA E.S.P.	2023-10-20 15:05:07.958327	\N
579	2913	16	4	Aprobación cr PATARROYO MURILLO MANUEL ELKIN	2023-10-23 12:17:46.929404	\N
584	2918	32	4	\tPROVISION EFECTIVO	2023-10-23 14:32:24.942059	\N
589	2923	32	4	TRASLADO ENTRE CTAS BB	2023-10-24 15:13:52.306133	\N
594	2928	16	4	Aprobación cr SÁNCHEZ PALOMINO PEDRO 	2023-10-24 16:13:37.494125	\N
599	2933	16	4	Aprobación cr LOZANO GUARNIZO JAIRO	2023-10-24 16:16:49.250392	\N
604	2938	32	4	CONST CDT FINANDINA VIENE DE COOPCENTRAL	2023-10-25 11:50:41.118212	\N
609	2943	29	6	CARTA DE BIENVENIDA GOMEZ GUERRERO MANUEL EDUARDO	2023-10-25 11:58:54.056052	\N
610	2944	16	4	Aprobación BLUE CARD VERGARA NAVARRO ERIKA	2023-10-25 11:59:03.307851	\N
614	2948	29	6	CARTA DE BIENVENIDA MURILLO SENCIAL ZAKIK	2023-10-25 12:02:21.215619	\N
618	2952	29	6	CARTA DE BIENVENIDA SABOYA CORTES GINA PAOLA	2023-10-25 12:03:55.473292	\N
623	2957	29	6	CARTA DE BIENVENIDA BECERRA OSTOS LUISA FERNANDA	2023-10-25 12:12:49.186244	\N
627	2961	42	5	Inscripción empresa a proceso masivo de radicación de novedades	2023-10-25 15:17:32.820475	\N
631	2965	16	4	Aprobación cr RESTREPO FORERO GABRIEL	2023-10-26 10:50:42.704823	\N
339	2673	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:24.883724	\N
340	2674	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:34.653475	\N
341	2675	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:44.404246	\N
342	2676	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:49.995543	\N
343	2677	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:18:55.808876	\N
344	2678	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:19:00.909341	\N
345	2679	10	3	SOLICITUD DE INFORMACIÓN	2023-09-29 14:19:06.571095	\N
274	2608	16	4	APROBACIÓN CR CUBILLOS LEAL CARLOS ALBERTO	2023-09-25 17:14:08.651001	\N
277	2611	16	4	APROBACIÓN CR ZUÑIGA REYES  DAGHELY GIOVANNA	2023-09-25 18:28:45.910648	\N
280	2614	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA CORREDOR ESPINEL VLADIMIR (SE CORRIGE DEPENDENCIA)	2023-09-26 09:28:37.917882	\N
283	2617	16	4	APROBACIÓN GUERRERO FAJARDO CARLOS ALBERTO	2023-09-26 10:07:47.911794	\N
286	2620	16	4	APROBACIÓN CR CHICA ARIAS CARLOS ALBERTO	2023-09-26 11:42:22.164977	\N
289	2623	29	6	CARTA DE BIENVENIDA URREGO BARRETO GUSTAVO	2023-09-26 11:44:25.132884	\N
292	2626	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-26 11:48:31.707886	\N
295	2629	16	4	APROBACIÓN CR HERRERA GONZALEZ GUSTAVO	2023-09-26 15:46:29.83212	\N
298	2632	16	4	APROBACIÓN CR GARCIA OROZCO FERNANDO MANUEL 	2023-09-26 17:33:43.928233	\N
214	2548	32	4	RESPUESTA REQUERIMIENTO CONTROL INTERNO DCI 2314	2023-09-19 07:28:00.881121	\N
220	2554	15	7	TRIBUTAR ASESORES SAS-SERVICIOS PROFESIONALES DECLARACIÓN DE RENTA 2019	2023-09-19 15:07:29.5598	\N
223	2557	5	4	CERTIFICADO ALVARO DUARTE RUIZ	2023-09-19 15:55:04.790704	\N
226	2560	29	6	CARTA DE BIENVENIDA CASTELBLANCO RAMOS MANUEL ANTONIO	2023-09-19 17:56:12.973964	\N
229	2563	29	6	CARTA DE BIENVENIDA MURCIA DE MARTINEZ CONSTANZA ROSA	2023-09-19 17:57:49.941902	\N
232	2566	32	4	TRASL INTERNO BANCO BOGOTA	2023-09-20 11:44:10.241709	\N
235	2569	119	6	RETIRO	2023-09-20 11:54:48.684158	\N
238	2572	16	7	APROBACIÓN CR CASTILLO REINA JOSE FERNANDO	2023-09-20 15:58:29.552611	\N
241	2575	15	7	ADJUDICACIÓN COLECTIVA DE AUTOMÓVILES ZURICH	2023-09-20 17:01:19.628694	\N
244	2578	16	7	APROBACIÓN CRÉDITO QUEVEDO BLANCO JOSE DAVID	2023-09-21 11:31:28.608655	\N
266	2600	120	7	PODER RECLAMACIÓN TITULOS JUDICIALES HERBERT GIRALDO GÓMEZ, ROSA MILENA DIAZ BOBADILLA Y LUIS ENRIQUE GIL TORRES 201600348	2023-09-22 16:51:19.687941	\N
301	2635	16	4	APROBACIÓN CR PÉREZ CRISTANCHO LUZ ANGELA	2023-09-27 15:16:26.489093	\N
304	2638	16	4	APROBACIÓN CR RODRÍGUEZ NÚÑEZ ANDRÉS FELIPE 	2023-09-28 08:53:52.893985	\N
307	2641	38	4	PAZ Y SALVO LEVANTAMIENTO DE HIPOTECA JAIRO JAIME CORREA  CC 7223613  CRÉDITO 10– 12112007131 	2023-09-28 09:43:09.280797	\N
310	2644	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-28 11:51:45.142658	\N
313	2647	16	4	APROBACIÓN CR BAQUERO GARCIA CARLOS MAURICIO	2023-09-28 14:50:26.058303	\N
316	2650	29	6	CARTA DE BIENVENIDA VASQUEZ MENDOZA ALMA RAQUEL	2023-09-28 17:16:45.234091	\N
319	2653	29	6	CARTA DE BIENVENIDA MANCERA RODRIGUEZ  MATEO	2023-09-28 17:19:12.617753	\N
322	2656	29	6	CARTA DE BIENVENIDA ROJAS LOPEZ MARTA LUCIA	2023-09-28 17:21:28.756563	\N
325	2659	29	6	CARTA DE BIENVENIDA BARRERA MOJICA LINA PATRICIA	2023-09-28 17:22:39.611501	\N
328	2662	38	4	CERTIFICADO HIPOTECARIO 2022 MELLIZO ROJAS WILSON HERNEY CC 79649177 CRÉDITO 10- 221000288 	2023-09-29 08:59:44.568447	\N
331	2665	16	4	APROBACIÓN BLUE CARD PEREZ CRISTANCHO LUZ ANGELA	2023-09-29 10:20:43.540107	\N
334	2668	16	4	APROBACIÓN CR AREVALO QUIÑONES WILLIAM FERNANDO	2023-09-29 13:34:42.806579	\N
346	2680	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-09-29 15:13:28.829746	\N
350	2684	16	4	APROBACIÓN BLUE CARD MAHECHA ESPINOSA YANETH ISABEL	2023-10-02 11:36:12.364197	\N
354	2688	16	4	APROBACIÓN CR BASTO MERCADO JOSE ORMINSO	2023-10-02 14:52:26.546508	\N
358	2692	29	6	CARTA DE BIENVENIDA PINZON BUSTAMANTE MARIA ALEJANDRA	2023-10-02 15:05:18.284341	\N
362	2696	16	4	APROBACIÓN BLUE CARD AREVALO QUIÑONES WILLIAM FERNANDO 	2023-10-02 15:47:19.176837	\N
366	2700	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-03 08:12:33.26645	\N
370	2704	30	5	REMISIÓN DE APORTES	2023-10-03 08:35:19.906233	\N
374	2708	16	4	APROBACIÓN CR ROJAS CORREAL LUISA INES	2023-10-03 10:19:46.278288	\N
378	2712	29	6	CARTA DE BIENVENIDA RUIZ IZQUIERDO MARIA ALEJANDRA	2023-10-03 10:31:36.120286	\N
382	2716	29	6	CARTA DE BIENVENIDA MORENO CORTES FANNY JULYANNA	2023-10-03 11:00:09.537395	\N
391	2725	10	3	SOLICITUD DE INFORMACIÓN	2023-10-03 17:42:22.738393	\N
402	2736	5	4	CERTIFICADO P.C.R.	2023-10-04 15:57:46.172458	\N
407	2741	119	6	CARTA DE APROBACIÓN DE RETIRO LUZ MARY PRADA HERNANDEZ	2023-10-05 08:57:22.618611	\N
412	2746	119	6	CARTA DE APROBACIÓN DE RETIRO DIANA ZULIMA URREGO MENDOZA	2023-10-05 09:08:45.737308	\N
417	2751	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GOMEZ PADILLA MIGUEL JESUS	2023-10-05 10:03:20.390364	\N
422	2756	32	4	TRASL INTERNO BANCO BOGOTA\r\n	2023-10-05 12:43:06.942956	\N
427	2761	29	6	CARTA DE BIENVENIDA CARVAJAL CAMACHO SORAYA ANDREA	2023-10-05 17:32:33.58875	\N
432	2766	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-10-06 09:12:23.793648	\N
442	2776	32	4	TRASL DE COLPATRIA AHO A CREDICORP	2023-10-09 08:26:48.073028	\N
450	2784	127	5	Carta Inscripción Empresa a Proceso Masivo de Radicación Novedades EPS Sanitas	2023-10-10 09:46:22.432476	\N
457	2791	32	4	CIRCULARIZACION INVERSIONES-LA EQUIDAD SG O.C.	2023-10-11 09:35:48.961967	\N
464	2798	32	7	CIRCULARIZACION INVERSIONES-COOPERACION VERDE SA	2023-10-11 10:18:37.557257	\N
471	2805	119	6	CARTA DE BIENVENIDA ASOCIADO NELSON PIMIENTO	2023-10-11 11:56:35.797374	\N
478	2812	5	4	CERTIFICADO MARIA CAROLINA MEJIA HERNANDEZ	2023-10-11 17:14:46.346458	\N
485	2819	119	6	CARTA DE BIENVENIDA ASOCIADO VELANDIA UYABAN ADERSON DUBAN	2023-10-12 09:44:48.323744	\N
492	2826	32	4	TRASL INTERNO DE FIDUBBVA A RENTA YA BB	2023-10-13 09:57:15.416009	\N
499	2833	37	4	PAZ Y SALVO ARTEAGA NAVARRO ESTEFANIA	2023-10-17 10:33:01.193849	\N
529	2863	16	4	Aprobación cr VERGARA NAVARRO ERIKA	2023-10-18 14:32:09.23239	\N
677	3011	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA PERILLA BURBANO SOLVEY JANETH	2023-10-31 10:21:59.371851	\N
678	3012	37	4	CERTIFICADO DE DEUDA CREDITO AL DIA  SPATIUM VC S.A.S	2023-10-31 10:55:11.23667	\N
679	3013	7	7	Respuesta derecho de petición LUIS EDUARDO MACHADO HÉRNANDEZ y \r\nCLARITA FRANCO LEÓN DE MACHADO\r\n	2023-10-31 11:11:14.624412	\N
680	3014	13	7	CARTA CHEQUE DE GERENCIA COMPENSAR	2023-10-31 11:26:27.819242	\N
681	3015	10	3	Solicitud de información 	2023-10-31 11:31:47.334559	\N
682	3016	10	3	Solicitud de información	2023-10-31 11:31:59.005466	\N
683	3017	10	3	Solicitud de información	2023-10-31 11:32:14.546845	\N
684	3018	10	3	Solicitud de información	2023-10-31 11:32:21.306072	\N
685	3019	10	3	Solicitud de información	2023-10-31 11:32:26.94485	\N
686	3020	10	3	Solicitud de información	2023-10-31 11:32:33.02991	\N
687	3021	10	3	Solicitud de información	2023-10-31 11:32:39.525139	\N
688	3022	10	3	Solicitud de información	2023-10-31 11:33:11.549625	\N
689	3023	10	3	Solicitud de información	2023-10-31 11:33:23.285032	\N
690	3024	10	3	Solicitud de información	2023-10-31 11:33:34.28678	\N
691	3025	10	3	Solicitud de información	2023-10-31 11:33:45.554754	\N
692	3026	10	3	Solicitud de información	2023-10-31 11:33:58.145637	\N
693	3027	10	3	Solicitud de información	2023-10-31 11:34:12.046164	\N
694	3028	10	3	Solicitud de información	2023-10-31 11:34:17.550633	\N
695	3029	16	4	Aprobación cr MORA RODRIGUEZ FELIPE EDUARDO	2023-10-31 12:06:05.13502	\N
696	3030	119	6	CARTA DE APROBACIÓN DE RETIRO- MARGARITA GIRALDO MONTEALEGRE 	2023-10-31 12:48:28.146587	\N
697	3031	119	6	CARTA DE APROBACIÓN DE RETIRO POR FALLECIMIENTO- LINDA ROCÍO GARCÍA JIMENEZ	2023-10-31 12:55:57.1549	\N
698	3032	119	6	CARTA DE RETIRO POR FALLECIMIENTO- LUIS ARNALDO SANTOS VELASQUEZ	2023-10-31 12:56:38.950496	\N
699	3033	16	4	Aprobación cr GARZON PEREZ DORA ELSIE	2023-10-31 14:08:58.578077	\N
700	3034	16	4	Aprobación cr MENDEZ BUENAVENTURA FERNANDO	2023-10-31 15:47:07.8427	\N
701	3035	16	4	Aprobación cr MEZA CASTILLO MIGUEL JACINTO	2023-10-31 16:55:36.460215	\N
702	3036	16	4	Aprobación cr LOPEZ ROMERO DIEGO FERNANDO	2023-10-31 16:57:12.961	\N
703	3037	32	4	CERTIFICADO NO INGRESO DE COMPRA, ADQUIRENCIA	2023-11-01 08:20:04.355386	\N
704	3038	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA RODRIGUEZ TORRES OMAR ROLANDO	2023-11-01 08:28:29.465449	\N
705	3039	16	4	Aprobación cr Sarmiento Garzón Leidy Janeth 	2023-11-01 08:37:53.332045	\N
706	3040	29	6	CARTA DE BIENVENIDA RINCÓN NOGUERA CARLA PAOLA	2023-11-01 10:02:42.931658	\N
707	3041	29	6	CARTA DE BIENVENIDA TORO TAMAYO JULIAN DAVID	2023-11-01 10:05:45.825941	\N
708	3042	29	6	CARTA DE BIENVENIDA MEJIA CARRION GERARDO ANDRES	2023-11-01 10:06:15.60721	\N
709	3043	29	6	CARTA DE BIENVENIDA MEJIA CARRION LUISA MARIA	2023-11-01 10:06:39.868253	\N
710	3044	29	6	CARTA DE BIENVENIDA INGENIERIA GEOTECNIA Y RIESGOS S.A.S	2023-11-01 10:07:01.856781	\N
711	3045	37	4	PAZ Y SALVO GIRALDO GALLO JOSE JAIRO	2023-11-01 10:07:32.12971	\N
712	3046	121	4	Solicitud de terminación del proceso únicamente en cabeza de Giobanny Prieto, por cumplimiento de acuerdo de pago parcial 	2023-11-01 10:46:29.694479	\N
713	3047	32	4	COMUNICADO A FINANDINA FONDO LIQUIDEZ	2023-11-01 11:15:22.705144	\N
714	3048	32	4	\tPROVISION EFECTIVO	2023-11-01 14:31:17.33153	\N
715	3049	119	6	CARTA APROBACIÓN DE RETIRO- MIGUEL ANGEL CONTRERAS GARCIA 	2023-11-01 17:19:44.447741	\N
716	3050	119	6	CARTA DE APROBACIÓN DE RETIRO- PETRONILA ESNEDA PARRA DE MAYO	2023-11-01 17:20:18.456484	\N
717	3051	119	6	CARTA DE APROBACIÓN DE RETIRO- ANA ISABEL SANABRIA DE AREVALO	2023-11-01 17:20:43.040166	\N
718	3052	119	6	CARTA DE APROBACIÓN DE RETIRO-JORGE EDUARDO AYA RODRIGUEZ	2023-11-01 17:21:08.058925	\N
719	3053	119	6	CARTA DE APROBACIÓN DE RETIRO- JUAN CARLOS GÓMEZ BECERRA	2023-11-01 17:21:35.092135	\N
720	3054	16	4	Aprobación cr TORRES CASTELLANOS GILMA VIRGINIA 	2023-11-02 07:40:20.871803	\N
721	3055	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-11-02 08:50:54.266182	\N
722	3056	16	4	Memorando entrega de pagarés a tesorería	2023-11-02 10:20:46.241484	\N
723	3057	29	6	CARTA DE BIENVENIDA DUITAMA BORDA MARIA STELLA	2023-11-02 11:28:41.404449	\N
724	3058	29	6	CARTA DE BIENVENIDA GALVAN VILLAMARIN JOSE FERNANDO	2023-11-02 11:29:13.326372	\N
725	3059	16	4	Aprobación cr CASTILLO CAICEDO DIRLEY	2023-11-02 15:01:51.364028	\N
726	3060	16	4	Aprobación cr ORTEGA QUICASAN CLAUDIA 	2023-11-02 15:02:29.924583	\N
727	3061	16	4	Aprobación cr ORTEGA ROA NESTOR 	2023-11-02 15:02:55.435745	\N
728	3062	42	7	APROBACIÓN PROPUESTA DE COMPRA DEL APARTAMENTO 503 DEL EDIFICIO ADOLFO SALAMANCA CORREA	2023-11-02 15:56:17.007824	\N
729	3063	16	4	Aprobación cr MARTINEZ BECERRA CARLOS JULIO 	2023-11-02 16:04:00.508452	\N
730	3064	5	4	CERTIFICADO MARIA TERESA DE JESUS PARDO VALENCIA	2023-11-03 08:18:01.83911	\N
731	3065	16	4	Aprobación cr PEREZ GARCIA MARIA TERESA	2023-11-03 10:11:39.49	\N
732	3066	5	4	CERTIFICADO BLANCA YANETH GONZALEZ PINZON	2023-11-03 16:59:26.355102	\N
733	3067	37	4	PAZ Y SALVO OVALLE SANCHEZ YOLANDA	2023-11-07 08:05:39.294734	\N
734	3068	37	4	PAZ Y SALVO PINEDA MORENO DANIEL	2023-11-07 08:18:40.874278	\N
735	3069	37	4	CERTIFICADO CREDITO COMPRA DE CARTERA CORTE 31 DE DICIEMBRE ACHURY GARCIA CRISTINA	2023-11-07 09:53:59.768872	\N
736	3070	120	4	RESPUESTA SOLICITUD JULIO 5 DE 2023 - HELGA DUARTE	2023-11-07 09:58:11.026173	\N
737	3071	120	7	RESPUESTA PQRSD JOHANA HAYDEE FORERO RODRIGUEZ	2023-11-07 10:08:36.315701	\N
738	3072	37	4	PAZ Y SALVO CASTRO PAEZ GLORIA EUGENIA	2023-11-07 11:41:14.123078	\N
739	3073	29	6	CARTA DE BIENVENIDA BLANCO NUÑEZ ANA GEORGINA	2023-11-07 11:53:47.746714	\N
740	3074	29	6	CARTA DE BIENVENIDA LONDOÑO LONDOÑO ANDRES EDUARDO	2023-11-07 11:54:16.01534	\N
741	3075	29	6	CARTA DE BIENVENIDA RODRIGUEZ BLANCO CAROLINA	2023-11-07 11:54:35.469759	\N
1340	3	8	1	Prueba	2024-01-02 14:29:31.164921	\N
742	3076	29	6	CARTA DE BIENVENIDA JUNCO ROMERO JOHANNA PAOLA	2023-11-07 11:54:51.874317	\N
743	3077	29	6	CARTA DE BIENVENIDA MORA GRACIA YENNY PAOLA	2023-11-07 11:55:09.562515	\N
744	3078	29	6	CARTA DE BIENVENIDA AVILA CORTES ERIKA JULIETH	2023-11-07 11:55:35.427678	\N
745	3079	37	4	PAZ Y SALVO SAIZ ESPITIA ESPERANZA	2023-11-07 13:45:49.737735	\N
746	3080	16	4	Aprobación Blue Card Rodriguez Olivera Alderson	2023-11-07 14:58:03.571928	\N
747	3081	16	4	Aprobación cr Castillo Castillo Edith Yuliana	2023-11-07 14:58:53.193077	\N
748	3082	16	4	Aprobación cr Ceicmo Ingeniería SAS	2023-11-07 14:59:40.207122	\N
749	3083	16	4	Aprobación Cr Rodríguez Olivera Alderson  	2023-11-08 08:16:54.102177	\N
750	3084	16	4	Aprobación Cr López Rodríguez Juan Carlos 	2023-11-08 08:17:56.822761	\N
751	3085	16	4	Aprobación Cr Noguera Ortiz Luis Eduardo	2023-11-08 08:18:28.991213	\N
752	3086	16	4	Aprobación Cr Ibañez Sastoque Sandra Milena  	2023-11-08 08:19:05.569197	\N
753	3087	123	4	Traslado Coopcentral	2023-11-08 08:43:58.56123	\N
754	3088	16	4	Aprobación Cr Guerrero Fajardo Carlos Alberto	2023-11-08 09:34:31.867146	\N
755	3089	37	4	 PAZ Y SALVO GIRALDO GALLO JOSE JAIRO 	2023-11-08 10:26:50.445503	\N
756	3090	32	4	REDENCION CDT NO FL 1991529-1991530 COOPCENTRAL	2023-11-08 12:26:28.505727	\N
757	3091	29	6	CARTA DE BIENVENIDA BUENO RAMIREZ JOSE CARLOS HUMBERTO	2023-11-08 15:21:51.666368	\N
758	3092	29	6	CARTA DE BIENVENIDA DUARTE CARDONA EDWIN	2023-11-08 15:22:32.556671	\N
759	3093	16	4	Aprobación Blue Card Aristizabal Gutierrez Fabio Ancizar	2023-11-08 15:57:36.009224	\N
760	3094	16	4	Aprobación Cr Sotelo Suarez William 	2023-11-08 15:58:16.052922	\N
761	3095	120	7	INFORME MENSUAL DE CARTERA SUPERSOLIDARIA OCTUBRE 2023	2023-11-08 16:51:33.169897	\N
762	3096	13	7	CARTA AUTORIZACION RECLAMAR CHEQUERA  EXENTA	2023-11-08 17:03:42.320436	\N
763	3097	123	7	Traslado	2023-11-09 08:32:37.551756	\N
764	3098	16	4	Aprobación Cr Perez Barragan Monica	2023-11-09 09:33:33.722858	\N
765	3099	5	4	CERTIFICADO PCR	2023-11-09 10:04:18.110571	\N
766	3100	119	6	CARTA DE RETIRO- BENÍTEZ SANCHEZ SANDRA 	2023-11-09 10:44:38.793982	\N
767	3101	119	6	CARTA DE APROBACIÓN DE RETIRO- GALLEGO MARTINEZ HECTOR JOSÉ	2023-11-09 10:50:58.27117	\N
768	3102	119	6	CARTA DE APROBACIÓN DE RETIRO- ANA CARMENZA CASTRO SALCEDO	2023-11-09 10:52:56.022782	\N
769	3103	32	4	TRASL INTERNO DE COOPCENTRAL AHO A CREDICORP	2023-11-09 11:13:41.998201	\N
770	3104	16	4	Aprobación Cr. Herrera Bedoya John Jairo	2023-11-09 11:23:18.281296	\N
771	3105	32	4	PROVISION EFECTIVO	2023-11-09 11:36:09.368145	\N
772	3106	32	4	REDENCION CDT FL 947227 BANCOOMEVA	2023-11-09 11:51:53.213385	\N
773	3107	32	4	CONST CDT FINANDINA VIENE DE BANCOOMEVA	2023-11-09 11:52:22.267124	\N
774	3108	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA ANDREA ISABEL FORERO RUIZ	2023-11-09 14:54:33.269674	\N
775	3109	15	7	Solicitud permiso de integración y desarrollo para la experta Lucia Pardo Garcia y Santos.	2023-11-09 15:28:05.195376	\N
776	3110	16	4	Aprobación Cr Tamayo Osorio Ricardo Mauricio 	2023-11-09 16:24:11.023895	\N
777	3111	16	4	Aprobación Cr. Perdomo Bahamon Melba	2023-11-09 16:25:00.107082	\N
778	3112	32	4	COMUNICADO A FINANDINA FONDO LIQUIDEZ	2023-11-09 17:21:07.294848	\N
779	3113	16	4	Aprobación Cr. ROZO BELLO JUAN CARLOS	2023-11-09 17:41:04.979362	\N
780	3114	121	4	Paz y Salvo Giobanny Prieto Moreno Proceso 2017-548	2023-11-10 09:21:51.992215	\N
781	3115	120	4	ENTREGA PROCESO JURIDICO KATHERINE YULIETH SALCEDO SANABRIA 	2023-11-10 12:31:09.64264	\N
782	3116	29	6	CARTA DE BIENVENIDA BERMUDEZ CUBIDES RENE	2023-11-10 12:36:07.245283	\N
783	3117	29	6	CARTA DE BIENVENIDA RODRIGUEZ BLANCO EDWIN ANDRES	2023-11-10 12:37:08.559539	\N
784	3118	29	6	CARTA DE BIENVENIDA RUIZ HERNANDEZ YESMIHC	2023-11-10 12:37:44.137371	\N
785	3119	120	4	ENTREGA COBRO JURIDICO OBLIGACION NIÑO MORALES FREDY ALEXANDER	2023-11-10 12:47:22.528186	\N
786	3120	120	4	ENTREGA INICIO PROCESO JURIDICO RODRIGUEZ PRIETO EDWARD ANTONIO 	2023-11-10 13:47:36.826506	\N
787	3121	120	4	ENTREGA COBRO JURIDICO VARELA ROJAS DIEGO AGUSTIN	2023-11-10 14:02:34.134555	\N
788	3122	120	4	ENTREGA COBRO JURIDICO PALACIO REBOLLEDO ANGELICA DEL PILAR	2023-11-10 14:11:46.817514	\N
789	3123	16	4	Aprobación Cr García de Achury Flora Helena	2023-11-10 15:16:58.193399	\N
790	3124	16	4	Aprobación Cr Ortiz de Ortiz Ana Guillermina  	2023-11-10 15:37:12.365821	\N
791	3125	4	6	CERTIFICACION DE AFILIACION	2023-11-10 15:51:34.556731	\N
792	3126	4	6	CERTIFICACION DE AFILIACION CC:1052393904 	2023-11-10 15:52:56.205823	\N
793	3127	4	6	CERTIFICACION DE AFILIACION CC 52821423	2023-11-10 15:54:33.367681	\N
794	3128	4	6	CERTIFICACION DE AFILIACION CC:79984170	2023-11-10 15:55:54.218946	\N
795	3129	16	4	Aprobación Cr Florez Guzmán Glaether  Yhon	2023-11-10 16:10:59.189385	\N
796	3130	16	4	Aprobación Cr León Nieto Diego Ismael 	2023-11-10 16:11:42.723691	\N
797	3131	4	6	CERTIFICACION DE AFILIACION CC 79952470	2023-11-10 16:19:14.495752	\N
798	3132	37	4	 PAZ Y SALVO JIMENEZ PALOMO GABRIEL STEFAN	2023-11-14 08:41:34.625007	\N
799	3133	4	6	Certificación de afiliación cc 1020734337	2023-11-14 09:32:08.571341	\N
800	3134	32	7	COMUNICADO A FINANDINA FONDO LIQUIDEZ	2023-11-14 10:34:53.486195	\N
801	3135	16	4	Aprobación Cr. QUESADA DE CLAVIJO DORIS	2023-11-14 15:18:47.653545	\N
802	3136	16	4	Aprobación Cr. Rodríguez Blanco Andrea Lucero	2023-11-14 15:19:49.934933	\N
803	3137	120	4	Inicio cobro jurídico pagarés #10661254 y # 11194094 - DIAZ CHAUX JOAN MANUEL	2023-11-14 16:27:45.882552	\N
804	3138	119	6	CARTA DE APROBACIÓN DE RETIRO- BEATRIZ ELENA DELGADO GOMEZ	2023-11-14 17:08:22.13612	\N
805	3139	119	6	CARTA DE APROBACIÓN  DE RETIRO POR FALLECIMIENTO- LUIS JORGE BONILLA CAMACHO	2023-11-14 17:08:56.973287	\N
806	3140	119	6	CARTA DE APROBACIÓN DE RETIRO- ROSALIA HURTADO MONTEALEGRE 	2023-11-14 17:09:28.569332	\N
807	3141	119	6	CARTA DE APROBACIÓN DE RETIRO- MARTHA ELENA MORALES VELA 	2023-11-14 17:10:27.870151	\N
808	3142	119	6	CARTA DE APROBACIÓN DE RETIRO- DEYANIRA PEREZ CASTRO	2023-11-14 17:11:01.463259	\N
809	3143	119	6	CARTA DE APROBACIÓN DE RETIRO - CARLOS ENRIQUE HERNANDEZ CAMPOS	2023-11-14 17:11:36.315974	\N
810	3144	119	6	CARTA DE APROBACIÓN DE RETIRO- PATRICIA SIMONSON	2023-11-14 17:12:06.12267	\N
811	3145	14	7	Respuesta asociada BARRETO OSORIO RUTH VIVIAN	2023-11-14 17:20:54.699798	\N
812	3146	13	7	CARTA CHEQUE DE GERENCIA  CDAT	2023-11-14 17:34:24.990858	\N
813	3147	16	4	Aprobación Cr. MEDINA FUENTES CRISTIAN ALEXANDER	2023-11-15 08:11:18.18697	\N
814	3148	32	4	CHEQ GERENCIA COMPRA CASA PCR AUT GERENCIA	2023-11-15 08:16:19.811982	\N
815	3149	16	4	Aprobación Cr. LIZCANO EUGENIO JOSEFINA	2023-11-15 10:19:25.642644	\N
816	3150	14	4	Respuesta comunicado asociada CHAVARRO CASAS MARIA NORMA	2023-11-15 14:43:51.368047	\N
817	3151	16	4	Aprobación Cr Acosta Cuesta María del Carmelo 	2023-11-15 17:06:05.154901	\N
818	3152	16	4	Aprobación Cr Rodríguez Pinilla María del Pilar  	2023-11-15 17:07:05.402115	\N
819	3153	16	7	Aprobación Cr Talavera Davila Henry Valdemar 	2023-11-15 17:07:40.409084	\N
820	3154	37	4	 PAZ Y SALVO FORERO RODRIGUEZ SANDRA ISABEL	2023-11-15 17:41:56.886669	\N
821	3155	29	6	CARTA DE BIENVENIDA MUÑOZ SABA MIGUEL ÁNGEL	2023-11-16 09:03:07.175686	\N
822	3156	29	6	CARTA DE BIENVENIDA RUBIANO DE REYES GLADYS DEL SOCORRO	2023-11-16 09:03:33.667627	\N
823	3157	29	6	CARTA DE BIENVENIDA GARCÍA VALDIVIESO MARÍA ANGÉLICA	2023-11-16 09:03:57.536385	\N
824	3158	29	6	CARTA DE BIENVENIDA SILVA PATIÑO BLANCA MARÍA	2023-11-16 09:04:19.327361	\N
825	3159	29	6	CARTA DE BIENVENIDA PARDO GONZÁLEZ CARLOS ALBERTO	2023-11-16 09:04:37.874901	\N
826	3160	29	6	CARTA DE BIENVENIDA MARTÍNEZ MARTÍNEZ ANA CONZUELO	2023-11-16 09:05:10.35324	\N
827	3161	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA MATIZ CUERVO JIMMY 	2023-11-16 09:07:17.392221	\N
828	3162	32	4	TRASL DE FIDUBBVA A RENTA YA BB	2023-11-16 09:39:47.420334	\N
829	3163	123	7	TRASLADO 	2023-11-16 10:27:23.185536	\N
830	3164	7	9	Respuesta derecho de petición SANDRA PATRICIA BOHÓRQUEZ PIÑA 	2023-11-16 12:00:55.693863	\N
831	3165	126	6	Carta patrocinio	2023-11-16 14:47:18.786701	\N
832	3166	126	6	Carta Patrocinio	2023-11-16 14:57:20.951849	\N
833	3167	126	6	Carta Patrocinio	2023-11-16 15:06:43.407792	\N
834	3168	16	4	Aprobación Cr Cáceres Corrales Pablo Julio 	2023-11-16 15:12:12.47481	\N
835	3169	16	4	Aprobación Cr Castiblanco Rozo Ernesto	2023-11-16 15:12:55.143707	\N
836	3170	126	6	Carta Patrocinio	2023-11-16 15:16:50.381877	\N
837	3171	126	6	Carta patrocinio	2023-11-16 15:39:40.772962	\N
838	3172	126	6	Carta Patrocinio	2023-11-16 15:50:15.358471	\N
839	3173	126	6	Carta Patrocinio	2023-11-16 16:03:11.069774	\N
840	3174	32	4	TRASL DE COOPCENTRAL A CREDICORP	2023-11-17 09:18:44.386096	\N
841	3175	120	4	Respuesta requerimiento periodo de gracia ADRIANA MUÑOZ ALDER	2023-11-17 09:36:23.737773	\N
842	3176	8	1	Diagnóstico y configuración de DNS servidor\r\ndominio y priorización de enrutamiento para\r\nbúsqueda interna de página web en red 	2023-11-17 10:18:30.861577	\N
843	3177	120	4	paz y salvo FAJARDO TOLOSA FABIO ENRIQUE 	2023-11-17 14:25:08.555834	\N
844	3178	32	4	RESPUESTA REQUERIMIENTO CONTROL INTERNO	2023-11-17 16:59:06.142212	\N
845	3179	16	4	Aprobación Cr MALDONADO CONTRERAS JULIO ERNESTO	2023-11-20 09:12:24.38517	\N
846	3180	16	4	Aprobación Cr Ariza Riaño Pablo Enrique 	2023-11-20 09:20:24.969094	\N
847	3181	16	4	Aprobación Cr DUARTE CARDONA EDWIN	2023-11-20 09:36:03.993517	\N
848	3182	16	4	Aprobación Cr Mosquera Meza Ricardo 	2023-11-20 09:37:26.632034	\N
849	3183	16	4	Aprobación Cr Cepeda Carranza Nelson Eduardo	2023-11-20 09:38:15.004171	\N
850	3184	16	4	Aprobación Cr Centanaro Lerch María Elizabeth  	2023-11-20 09:38:59.865084	\N
851	3185	16	4	Aprobación Cr Reina González Germán 	2023-11-20 09:39:38.99694	\N
852	3186	32	4	PROVISION EFECTIVO	2023-11-20 11:43:04.204823	\N
853	3187	7	9	Respuesta derecho de petición Martha Helena Bustos. 	2023-11-20 11:45:30.263457	\N
854	3188	7	7	Respuesta comunicación JAS Asesores & Consultores	2023-11-20 12:31:45.137372	\N
855	3189	16	4	Aprobación Cr Romero Fernandez Juan sebastian 	2023-11-20 16:37:28.433733	\N
856	3190	16	4	Aprobación Cr Sabogal Cancino Jairo Alberto 	2023-11-20 16:38:10.646097	\N
857	3191	16	4	Aprobación Cr Castro Cortés Andrés Alejandro 	2023-11-20 16:39:48.600866	\N
858	3192	16	4	Aprobación Cr Salamanca López Martha	2023-11-20 16:40:24.547919	\N
859	3193	16	4	Aprobación Blue Card Alvarado Florez Liliana	2023-11-20 16:41:07.555752	\N
860	3194	16	4	Aprobación Cr Pineda Delgado Victor Manuel  	2023-11-20 16:42:00.364245	\N
861	3195	16	4	Aprobación Cr Alvarado Florez Liliana	2023-11-20 16:48:10.547699	\N
862	3196	37	4	PAZ Y SALVO GOMEZ PRADA YANNETH MARCELA	2023-11-21 08:15:05.58019	\N
863	3197	13	7	CARTA CHEQUE DE GERENCIA FIDUBOGOTA	2023-11-21 08:16:57.306939	\N
864	3198	32	4	TRASL DE COOPCENTRAL A CREDICORP	2023-11-21 09:40:02.95334	\N
865	3199	38	4	certificado hipotecario al día MARIA ANGELICA HERRERA FONSECA  cc 52410153 10-211001962 	2023-11-21 15:35:03.86836	\N
866	3200	16	4	Aprobación Cr MENDEZ BUENAVENTURA FERNANDO	2023-11-22 08:28:12.834078	\N
867	3201	16	4	Aprobación Cr ALVAREZ CUADROS RAMIRO 	2023-11-22 08:28:57.993085	\N
868	3202	16	4	Aprobación Cr PARDO MORA DOLLY	2023-11-22 08:29:55.108911	\N
869	3203	16	4	Aprobación Cr SARMIENTO PEREZ GUSTAVO 	2023-11-22 08:30:21.009057	\N
870	3204	16	4	Aprobación Cr LIZARAZO VILLARREAL TATIANA	2023-11-22 08:30:49.331394	\N
871	3205	16	4	Aprobación Cr CADAVID MOJICA LUISA ALEJANDRA	2023-11-22 08:31:31.418936	\N
872	3206	5	4	CERTIFICADO MIRYAM STELLA VARGAS RODRIGUEZ	2023-11-22 08:47:13.99551	\N
873	3207	29	6	CARTA DE BIENVENIDA SAMACA SUAREZ JENNY PATRICIA	2023-11-22 10:05:31.053031	\N
874	3208	29	6	CARTA DE BIENVENIDA NAIZAQUE RAMOS MANUEL ALFREDO	2023-11-22 10:06:59.234549	\N
875	3209	29	6	CARTA DE BIENVENIDA MONTAÑO BELLO ALFREDO	2023-11-22 10:07:53.032777	\N
876	3210	29	6	CARTA DE BIENVENIDA CARDONA HOYOS JESUS FRANCISCO	2023-11-22 10:08:52.835889	\N
877	3211	29	6	CARTA DE BIENVENIDA TORRES CAYCEDO NICOLAS	2023-11-22 10:10:31.203666	\N
878	3212	29	6	CARTA DE BIENVENIDA MARTINEZ ALBARRACIN CARLOS JAIR	2023-11-22 10:12:26.804264	\N
879	3213	29	6	CARTA DE BIENVENIDA ESPINOSA MUÑOZ CHARICK MILADY	2023-11-22 10:12:54.187188	\N
880	3214	29	6	CARTA DE BIENVENIDA PICHOT ELLES MAURICIO RENE	2023-11-22 10:13:42.748206	\N
881	3215	29	6	CARTA DE BIENVENIDA ROA ORDOÑEZ DIEGO HERNAN	2023-11-22 10:14:23.715897	\N
882	3216	29	6	CARTA DE BIENVENIDA GOYENECHE TRIANA JOHN JAIRO	2023-11-22 10:15:02.39828	\N
883	3217	29	6	CARTA DE BIENVENIDA LUQUE MARTINEZ LUZ YAMILE	2023-11-22 10:16:11.527407	\N
884	3218	29	6	CARTA DE BIENVENIDA MUNEVAR VIANCHA JOHAN SEBASTIAN	2023-11-22 10:18:25.961507	\N
885	3219	29	6	CARTA DE BIENVENIDA VALLEJO YEPES ANA ROCIO	2023-11-22 10:20:49.083341	\N
886	3220	122	8	Memorando envío escritura pública firmada a COOTRADECUN 	2023-11-22 11:07:10.396007	\N
887	3221	32	4	PROVISION EFECTIVO	2023-11-22 14:46:49.796429	\N
888	3222	16	4	Aprobación Cr SILVA GOMEZ EDELBERTO	2023-11-22 15:23:22.286184	\N
889	3223	16	4	Aprobación Cr HERNANDEZ CORTES MARGARITA 	2023-11-22 15:31:53.702864	\N
890	3224	16	4	Aprobación Cr ALCARCEL CEPEDA NOHORA ALICIA 	2023-11-22 15:32:38.096441	\N
891	3225	16	4	Aprobación Cr MEDINA TORRES CARLOS 	2023-11-22 15:33:02.356849	\N
892	3226	16	4	Aprobación Cr TORRES TOVAR CARLOS ALBERTO 	2023-11-22 15:33:30.701018	\N
893	3227	16	4	Aprobación Cr TRUJILLO CARLOS ALEXANDER 	2023-11-22 15:33:56.186161	\N
894	3228	16	4	Aprobación Cr HOYOS URREA LEANDRO 	2023-11-22 15:34:32.19662	\N
895	3229	16	4	Aprobación Cr GALVIS VANEGAS JESÚS 	2023-11-22 15:35:18.532433	\N
896	3230	16	4	Aprobación Cr CONTRERAS GARCIA MIGUEL ANGEL 	2023-11-22 15:35:51.251627	\N
897	3231	16	4	Aprobación Cr SARMIENTO GALVIZ RONALD ALEXANDER 	2023-11-22 15:36:36.978791	\N
898	3232	29	6	CARTA DE BIENVENIDA CARDOZO SUAREZ YINNETH	2023-11-22 15:54:35.853598	\N
899	3233	29	6	CARTA DE BIENVENIDA CARDOZO GONZALEZ BENIGNO	2023-11-22 15:55:01.461727	\N
900	3234	29	6	CARTA DE BIENVENIDA GIA CONSULTORES LTDA	2023-11-22 15:55:25.520841	\N
901	3235	15	7	Autorización a Ascoop-aportes parafiscales Sena	2023-11-22 16:35:37.515554	\N
902	3236	29	6	CARTA DE BIENVENIDA DIAZ GAITAN CLARA INES	2023-11-22 16:56:46.75712	\N
903	3237	16	4	Aprobación Cr CACERES GAITAN MYRIAM  	2023-11-23 08:43:10.176323	\N
904	3238	16	4	Aprobación Cr SILVA PATIÑO BLANCA MARÍA 	2023-11-23 08:43:38.439018	\N
905	3239	16	4	Aprobación Cr QUEVEDO BLANCO JOSE DAVID	2023-11-23 08:44:03.824495	\N
906	3240	32	4	CONST CDT FINANDINA VIENE DE FALABELLA	2023-11-23 09:47:02.36477	\N
907	3241	32	4	CANCELAR CDT  FALABELLA	2023-11-23 09:49:40.680741	\N
908	3242	128	5	Respuesta SENA	2023-11-23 14:18:44.48974	\N
909	3243	16	4	Aprobación Cr SANABRIA SILVA ANDREA NATALIA 	2023-11-24 10:38:20.63472	\N
910	3244	16	4	Aprobación Cr GARZON GOMEZ NIVIA CRISTINA 	2023-11-24 10:38:55.361017	\N
911	3245	16	4	Aprobación Cr BARON GUAQUETA ANA FABIOLA 	2023-11-24 10:39:20.676444	\N
912	3246	16	4	Aprobación Cr RUBIO LEON CLARA MELISSA	2023-11-24 10:39:44.416658	\N
913	3247	16	4	Aprobación Blue Card Rubio León Clara Melisa	2023-11-24 15:34:38.455278	\N
914	3248	16	4	Aprobación Cr BAUTISTA ROMERO EDGAR 	2023-11-24 15:55:00.571681	\N
915	3249	16	4	Aprobación Cr SANTAMARIA ROJAS DIANA MILENA 	2023-11-24 15:55:32.859676	\N
916	3250	16	4	Aprobación Cr PIÑEROS SOSA YENNY ARBILIA 	2023-11-24 15:56:03.162959	\N
917	3251	16	4	Aprobación Cr TORRES TOVAR CARLOS ALBERTO 	2023-11-24 15:56:31.403383	\N
918	3252	16	4	Aprobación Cr VÉLEZ BOLAÑOS RICARDO ALONSO 	2023-11-24 15:57:05.878099	\N
919	3253	16	4	Aprobación Cr GONZALEZ GONZALEZ FERNANDO 	2023-11-24 15:57:28.270543	\N
920	3254	16	4	Aprobación Cr DAZA DE OROZCO MATILDE MARIA 	2023-11-24 15:57:52.72093	\N
921	3255	16	4	Aprobación Cr COLMENARES MONTAÑEZ JULIO ESTEBAN 	2023-11-24 16:00:43.995517	\N
922	3256	16	4	Aprobación Cr SÁNCHEZ DE ABELLA MARTHA INES 	2023-11-24 16:01:23.744588	\N
923	3257	42	7	Segunda notificación terminación unilateral del contrato de arrendamiento de vivienda urbana por parte del ARRENDADOR	2023-11-24 16:30:50.150499	\N
924	3258	37	4	 PAZ Y SALVO VARGAS AVILA NICOLLE	2023-11-27 08:09:10.16989	\N
925	3259	37	4	 PAZ Y SALVO MUÑOZ CADENA CAMILO AUGUSTO	2023-11-27 08:46:16.220632	\N
926	3260	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA MUÑOZ CADENA CAMILO AUGUSTO	2023-11-27 08:56:26.997893	\N
927	3261	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GOMEZ PRADA YANNETH MARCELA	2023-11-27 09:09:54.032821	\N
928	3262	7	7	Respuesta radicado No. 20232120558311 “relación de solvencia según radicado 20234400345262 Informe de revisor fiscal – III trim	2023-11-27 11:27:19.573694	\N
929	3263	29	6	CARTA DE BIENVENIDA CABEZA BARRETO JORGE ELIECER	2023-11-27 12:16:42.836955	\N
930	3264	29	7	CARTA DE BIENVENIDA REAL RUEDA MAGDA MILENA	2023-11-27 12:17:10.093398	\N
931	3265	8	1	Mantenimiento preventivo aires acondicionados	2023-11-27 13:44:31.480425	\N
932	3266	8	1	Mantenimiento preventivo UPS	2023-11-27 13:45:22.699937	\N
933	3267	7	7	Respuesta requerimiento radicado No. 20232120543951 evaluación de la cartera de créditos 2022.	2023-11-27 14:19:10.381715	\N
934	3268	16	4	Aprobación Cr FONSECA CARDONA RAFAEL 	2023-11-27 16:49:32.701924	\N
935	3269	16	4	Aprobación Cr MARTINEZ MARTINEZ ANA CONSUELO 	2023-11-27 16:50:40.657113	\N
936	3270	16	4	Aprobación Cr PEÑA PACHECO EDUARDO	2023-11-27 16:51:04.735468	\N
937	3271	16	4	Aprobación Cr MONTOYA GAVIRIA GERARDO  	2023-11-27 16:51:47.695387	\N
938	3272	16	4	Aprobación Cr RODRÍGUEZ BLANCO EDWIN 	2023-11-27 16:52:13.232448	\N
939	3273	16	4	Aprobación Cr BERMUDEZ CUBIDES RENE 	2023-11-27 16:52:47.306873	\N
940	3274	16	4	DUEÑAS PINTO NELSON	2023-11-27 16:53:11.8305	\N
941	3275	16	4	Aprobación Cr Gutierrez Moreno William 	2023-11-27 20:32:15.598714	\N
942	3276	123	7	Traslado	2023-11-28 08:22:20.415458	\N
943	3277	32	7	TRASL INTERNO DE BB SERVICIOS A BB RENTA YA	2023-11-28 08:48:02.31274	\N
944	3278	32	7	TRASL DE BB RENTA YA A CREDICORP CAPITAL 	2023-11-28 08:51:46.498693	\N
945	3279	32	7	TRASL DE BB RENTA YA A EXENTA	2023-11-28 08:58:35.895969	\N
946	3280	32	7	PROVISION EFECTIVO	2023-11-28 09:00:19.030628	\N
947	3281	32	7	COMUNICADO FINANDINA CDT FL	2023-11-28 09:38:08.507348	\N
948	3282	29	6	CARTA DE BIENVENIDA ROJAS BELTRAN ANGELA MARÍA	2023-11-28 14:22:36.516919	\N
949	3283	16	4	Aprobación Cr. Valero Cely Fernando 	2023-11-28 18:02:57.524734	\N
950	3284	37	4	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA QUINTERO APONTE NATALIA	2023-11-29 08:09:49.200931	\N
951	3285	16	4	Aprobación Cr DUEÑAS BARRETO DAVID	2023-11-29 09:08:11.27783	\N
952	3286	16	4	Aprobación Cr. BOFFET MAGALI	2023-11-29 10:27:31.042513	\N
953	3287	16	4	Aprobación Cr SAMACA SUAREZ JENNY 	2023-11-29 10:28:29.580802	\N
954	3288	16	4	Aprobación Cr RINCON PACHON FAVIO 	2023-11-29 10:28:51.61096	\N
955	3289	16	4	Aprobación Cr LOZANO MARQUEZ EYNER 	2023-11-29 10:29:15.592198	\N
956	3290	16	4	Aprobación Cr GOMEZ OCHOA ANA	2023-11-29 10:29:39.622343	\N
957	3291	16	4	Aprobación Cr ORTIZ ROJAS WILSON 	2023-11-29 10:30:06.103706	\N
958	3292	16	4	Aprobación Cr DIAZ LEGUIZAMON MARTHA 	2023-11-29 10:30:30.221913	\N
959	3293	16	4	Aprobación Cr GOMEZ RUGE PABLO 	2023-11-29 10:32:06.448551	\N
960	3294	16	4	Aprobación Cr MEJIA ALFARO JORGE 	2023-11-29 10:32:52.19547	\N
961	3295	16	4	Aprobación Cr CABEZA BARRETO JORGE 	2023-11-29 10:33:26.672432	\N
962	3296	16	4	Aprobación Cr MUÑOZ SABA MIGUEL ANGEL 	2023-11-29 10:33:50.59299	\N
963	3297	32	7	PROVISION EFECTIVO	2023-11-29 10:40:24.891067	\N
964	3298	119	6	CARTA DE APROBACIÓN DE RETIRO- TEOFRASTO ANTONIO TATIS CANCHILA \r\n\r\n	2023-11-29 11:46:31.016452	\N
965	3299	119	6	CARTA DE APROBACIÓN DE RETIRO- WILMAR ESTEVE ROLDÁN SOLANO	2023-11-29 11:47:07.296429	\N
966	3300	119	6	CARTA DE APROBACIÓN DE RETIRO-GABRIEL IGNACIO PATRÓN LÓPEZ	2023-11-29 11:47:38.00766	\N
967	3301	119	6	CARTA DE APROBACIÓN DE RETIRO - YEIMY ALEXANDRA PINZÓN GUTIÉRREZ	2023-11-29 11:48:10.956874	\N
968	3302	37	4	OBLIGACION AL DIA PALACIOS ESPITIA MARCOLINO	2023-11-29 13:48:12.92525	\N
969	3303	126	6	Carta legalización anticipo	2023-11-29 15:30:57.62659	\N
970	3304	15	7	CERTIFICACION ZURICH CONVENIO	2023-11-29 16:23:39.056826	\N
971	3305	123	7	TRASLADO	2023-11-30 12:40:09.536545	\N
972	3306	29	6	CARTA DE BIENVENIDA DAVID AMAYA HAZBLEIDY	2023-12-01 08:13:51.653797	\N
973	3307	29	6	CARTA DE BIENVENIDA  ZULUAGA HERNANDEZ DIANA MERCEDES	2023-12-01 08:14:43.024421	\N
974	3308	29	6	CARTA DE BIENVENIDA  BARRIOS ORDOÑEZ JESUS FERNANDO	2023-12-01 08:15:24.308571	\N
975	3309	29	6	CARTA DE BIENVENIDA  PAVAJEAU HERMES FRANCISCO	2023-12-01 08:15:42.117289	\N
976	3310	29	6	CARTA DE BIENVENIDA  GOYES BUSTOS MARIO FERNANDO	2023-12-01 08:16:09.871565	\N
977	3311	29	6	CARTA DE BIENVENIDA  AUSIQUE GAMEZ GERARDO ARTURO	2023-12-01 08:16:56.373377	\N
978	3312	29	6	CARTA DE BIENVENIDA  GAMBOA SUAREZ HENRY	2023-12-01 08:17:15.108255	\N
979	3313	29	6	CARTA DE BIENVENIDA  GARCIA NUNEZ JESUS RAFAEL	2023-12-01 08:17:35.675209	\N
980	3314	29	6	CARTA DE BIENVENIDA  BOHORQUEZ RIOS LUCY	2023-12-01 08:17:53.074582	\N
981	3315	29	6	CARTA DE BIENVENIDA  QUINTANA MURCIA CLAUDIA CECILIA	2023-12-01 08:18:14.269422	\N
982	3316	29	6	CARTA DE BIENVENIDA FLORIDO ARTEAGA JUAN FRANCISCO	2023-12-01 08:18:45.518526	\N
983	3317	29	6	CARTA DE BIENVENIDA  GUARNIZO CARDENAS ANGELA PATRICIA	2023-12-01 08:19:17.007958	\N
984	3318	29	6	CARTA DE BIENVENIDA  BERNAL LUGO SANTIAGO	2023-12-01 08:19:38.898083	\N
985	3319	29	6	CARTA DE BIENVENIDA  PRADO ARANGO BENJAMIN	2023-12-01 08:19:54.783101	\N
986	3320	29	6	CARTA DE BIENVENIDA CLAVIJO NARANJO MARYLIN STELLA	2023-12-01 08:20:11.897463	\N
987	3321	29	6	CARTA DE BIENVENIDA  GALVAN SANCHEZ OFELIA ROSA	2023-12-01 08:20:28.57794	\N
988	3322	10	3	mes de diciembre-2023	2023-12-01 09:39:55.617627	\N
989	3323	10	3	mes de diciembre-2023	2023-12-01 09:40:15.871109	\N
990	3324	10	3	mes de diciembre-2023	2023-12-01 09:40:23.069748	\N
991	3325	10	3	mes de diciembre-2023	2023-12-01 09:40:29.346248	\N
992	3326	10	3	mes de diciembre-2023	2023-12-01 09:40:48.150328	\N
993	3327	10	3	mes de diciembre-2023	2023-12-01 09:40:54.396756	\N
994	3328	10	3	mes de diciembre-2023	2023-12-01 09:40:59.932285	\N
995	3329	10	3	mes de diciembre-2023	2023-12-01 09:41:13.753619	\N
996	3330	10	3	mes de diciembre-2023	2023-12-01 09:41:18.928225	\N
997	3331	10	3	mes de diciembre-2023	2023-12-01 09:41:24.270729	\N
998	3332	10	3	mes de diciembre-2023	2023-12-01 09:41:42.428475	\N
999	3333	10	3	mes de diciembre-2023	2023-12-01 09:41:53.92433	\N
1000	3334	10	3	mes de diciembre-2023	2023-12-01 09:41:58.629044	\N
1001	3335	10	3	mes de diciembre-2023	2023-12-01 09:42:03.489988	\N
1002	3336	10	3	mes de diciembre-2023	2023-12-01 09:42:08.138979	\N
1003	3337	32	4	PROVISION EFECTIVO	2023-12-01 10:06:53.185623	\N
1004	3338	16	4	Certificación Coopserfun	2023-12-01 14:49:53.925035	\N
1005	3339	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE PRENDA PACHON PAGOTES JAIRO FRANCISCO	2023-12-01 15:40:51.459849	\N
1006	3340	15	7	LEVANTAMIENTO DE PRENDA ZYO570-JAIRO FRANCISCO PACHON PAGOTES	2023-12-01 16:08:04.332686	\N
1007	3341	37	4	 PAZ Y SALVO BARAJAS ORDOÑEZ SANDRA LILIANA	2023-12-01 16:35:02.128486	\N
1008	3342	29	6	CARTA DE BIENVENIDA ARIZA ARDILA HECTOR RAUL	2023-12-04 08:01:31.163385	\N
1009	3343	29	6	CARTA DE BIENVENIDA VIDAL GONZALEZ DAVID ORLANDO	2023-12-04 08:01:53.719772	\N
1010	3344	29	6	CARTA DE BIENVENIDA HUESO SARMIENTO MARCO ALFONSO	2023-12-04 08:02:18.444167	\N
1011	3345	29	6	CARTA DE BIENVENIDA RODRIGUEZ NIETO MARIA VICTORIA	2023-12-04 08:02:40.005043	\N
1012	3346	29	6	CARTA DE BIENVENIDA BARATO MORENO JUAN PAUBLO	2023-12-04 08:02:58.348707	\N
1013	3347	29	6	CARTA DE BIENVENIDA MARTINEZ MARIN GUSTAVO ADOLFO	2023-12-04 08:03:15.78263	\N
1014	3348	29	6	CARTA DE BIENVENIDA SANCHEZ VALENCIA OLGA LUCIA	2023-12-04 08:03:48.398187	\N
1015	3349	29	6	CARTA DE BIENVENIDA ORJUELA PARRA MIGUEL ANGEL	2023-12-04 08:04:05.85885	\N
1016	3350	37	4	 PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA CHAVARRO ORJUELA ISABEL	2023-12-04 08:04:12.821917	\N
1017	3351	37	4	PAZ Y SALVO SIN OBLIGACION IDENTIFICADA CHAVARRO ORJUELA ISABEL	2023-12-04 08:58:40.213947	\N
1018	3352	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-04 10:11:33.442184	\N
1019	3353	14	4	Carta de aprobación CAICEDO ESCOBAR CARLOS HERNAN	2023-12-04 11:07:32.219708	\N
1020	3354	14	4	Carta aprobación GOMEZ BERNAL JUAN MANUEL	2023-12-04 11:20:55.650129	\N
1021	3355	14	4	Carta aprobación MORALES  GABRIEL	2023-12-04 11:29:28.108051	\N
1022	3356	14	4	Carta aprobación FLOREZ PINZON JONATHAN ESTIBEN	2023-12-04 11:33:22.045484	\N
1023	3357	14	4	Aprobación crédito BARRIOS ORDOÑEZ JESUS FERNANDO	2023-12-04 11:44:53.049403	\N
1024	3358	37	4	 PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA SILVA LOPEZ OLGA LILIA	2023-12-04 14:26:00.773428	\N
1025	3359	37	4	PAZ Y SALVO HERRERA CASTIBLANCO SAMUEL ALBERTO	2023-12-04 14:33:45.639469	\N
1026	3360	37	4	 PAZ Y SALVO ROBAYO RODRIGUEZ JUAN MANUEL	2023-12-04 14:58:00.540808	\N
1027	3361	120	7	COMPENSACIÓN SALDOS JOSE ENRIQUE CORRALES ENCISO (Q.E.P.D)	2023-12-04 17:22:25.354176	\N
1028	3362	14	4	Aprobación crédito DUEÑAS PINTO RAMIRO JAVIER	2023-12-04 17:33:45.320923	\N
1029	3363	38	4	Respuesta periodo de gracia Henry Aragón cc: 19261689 	2023-12-05 09:00:04.154493	\N
1030	3364	119	6	CARTA DE APROBACIÓN DE RETIRO- AMERICO PEREA VALOYES 	2023-12-05 11:49:24.144762	\N
1031	3365	119	6	CARTA DE APROBACIÓN DE RETIRO- MARIA NORMA CHAVARRO CASAS 	2023-12-05 11:49:55.125583	\N
1032	3366	119	6	CARTA DE APROBACIÓN DE RETIRO- NADIA CATALINA SEGURA SARMIENTO	2023-12-05 11:50:27.889611	\N
1033	3367	119	6	CARTA RESPUESTA DE RETIRO- FEIBER ANTONIO CHAVEZ CASTRO	2023-12-05 13:14:39.049888	\N
1034	3368	16	4	Aprobación Cr Mejía Alfaro Jorge 	2023-12-05 14:29:31.155149	\N
1035	3369	29	6	CARTA DE BIENVENIDA CASTRO PINEDA MARCIA JOHANNA	2023-12-05 14:46:55.55301	\N
1036	3370	29	6	CARTA DE BIENVENIDA CORREDOR SILVA  DANA KAMILA 	2023-12-05 14:47:19.271585	\N
1037	3371	29	6	CARTA DE BIENVENIDA TRIANA HORTA OSCAR GERMAN	2023-12-05 14:47:36.313645	\N
1038	3372	29	6	CARTA DE BIENVENIDA GUACANEME GUTIERREZ JULIO ALBERTO	2023-12-05 14:47:53.568473	\N
1039	3373	29	6	CARTA DE BIENVENIDA JIMENEZ PINZON ALISON VIVIANA	2023-12-05 14:48:09.310806	\N
1040	3374	29	6	CARTA DE BIENVENIDA ROMERO BUITRAGO MARTHA CECILIA	2023-12-05 14:48:26.345696	\N
1041	3375	29	6	CARTA DE BIENVENIDA BENAVIDES DIAZ DANIEL ALEJANDRO	2023-12-05 14:48:43.552742	\N
1042	3376	29	6	CARTA DE BIENVENIDA RODRIGUEZ MEJIA KARLA GERALDINE	2023-12-05 15:03:38.738853	\N
1043	3377	16	4	Aprobación Cr MURILLO SENCIAL ZAKIK	2023-12-05 15:13:56.290094	\N
1044	3378	14	4	Carta aprobación NAVA SERRANO MARIA FANNY	2023-12-05 15:19:51.729403	\N
1045	3379	16	4	Aprobación cr PEREZ ORTIZ PAULA ANDREA	2023-12-05 15:23:35.547445	\N
1046	3380	14	4	Carta aprobación BERNAL POVEDA CAMPO ELIAS	2023-12-05 17:28:15.690281	\N
1047	3381	16	4	Aprobación Cr GUTIERREZ GUTIERREZ JOHN JAIRO	2023-12-05 18:26:36.577345	\N
1048	3382	14	4	Certificación ALVAREZ BERMUDEZ ZORAYA XIMENA 	2023-12-06 07:39:05.473456	\N
1049	3383	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-06 09:22:16.544681	\N
1050	3384	32	4	PROVISION EFECTIVO	2023-12-06 10:02:46.83411	\N
1051	3385	32	7	CANCELACION CTA BBVA	2023-12-06 10:33:30.418414	\N
1052	3386	32	7	CANCELACION FONDO FIC BBVA No 192-0000-56	2023-12-06 10:39:39.585583	\N
1053	3387	32	7	\tCANCELACION FONDO FIC BBVA No 182-5000-03	2023-12-06 11:36:15.614702	\N
1054	3388	32	7	DISMINUCION FL CTA AHORROS COOPCENTRAL A COOPCENTRAL AHO-PSE	2023-12-06 11:45:31.714065	\N
1055	3389	16	4	Aprobación Cr Muñoz Martínez Elvia 	2023-12-06 15:41:20.538309	\N
1056	3390	39	4	Aprobación Cr Real Rueda Magda	2023-12-06 15:56:42.193912	\N
1057	3391	39	4	Aprobación Cr Ruiz García Raul	2023-12-06 15:57:44.927694	\N
1058	3392	39	4	Aprobación Cr López Arévalo Hugo  	2023-12-06 15:58:56.99337	\N
1059	3393	39	4	Aprobación Vélez Sánchez Juan 	2023-12-06 15:59:39.346657	\N
1060	3394	39	4	Aprobación Salazar Pulido Luz Mary	2023-12-06 16:00:20.60242	\N
1061	3395	37	7	CERTIFICADO CRÉDITO HIPOTECARIO AL DÍA RODRIGUEZ TORRES OMAR ROLANDO	2023-12-06 16:01:26.586458	\N
1062	3396	14	4	Carta aprobación HUESO SARMIENTO MARCO ALFONSO	2023-12-07 10:26:06.995126	\N
1063	3397	14	4	Carta aprobación Aniversario HUESO SARMIENTO MARCO ALFONSO	2023-12-07 10:26:31.955285	\N
1064	3398	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-07 12:24:45.239497	\N
1065	3399	120	7	INFORME CATERA SUPERSOLIDARIA MES DE NOVIEMBRE DE 2023	2023-12-07 14:19:16.068727	\N
1066	3400	32	4	TRASLADO INT A CREDICORP DE BB RENTA YA	2023-12-07 14:37:13.477134	\N
1067	3401	120	4	COMPENSACIÓN SALDOS POR RETIRO VOLUNTARIO NELSON OLIVEROS	2023-12-07 16:26:10.785655	\N
1068	3402	4	7	Auxilio para la adquisición de mausoleos, osarios o lotes en parques cementerios.	2023-12-11 09:05:17.977535	\N
1069	3403	16	4	Aprobación Cr LÓPEZ ARÉVALO HUGO 	2023-12-11 09:27:19.302869	\N
1070	3404	16	4	Aprobación Cr RUIZ GARCÍA RAUL 	2023-12-11 09:27:51.630856	\N
1071	3405	16	4	Aprobación Cr VELEZ SANCHEZ JUAN CARLOS 	2023-12-11 09:28:19.03228	\N
1072	3406	16	4	Aprobación Cr SALAZAR PULIDO LUZ MARY 	2023-12-11 09:28:51.884954	\N
1073	3407	16	4	Aprobación Cr 	2023-12-11 09:29:07.885651	\N
1074	3408	16	4	Aprobación Cr TORRES HERNANDEZ ANA MARÍA 	2023-12-11 09:29:50.302854	\N
1075	3409	16	4	Aprobación Cr TELLEZ PEREZ MARTHA 	2023-12-11 09:30:14.730522	\N
1076	3410	16	4	Aprobación Cr OROZCO PARDO CLARA 	2023-12-11 09:30:39.351722	\N
1077	3411	16	4	Aprobación Cr CHICO RODRIGUEZ SANTIAGO 	2023-12-11 09:31:20.166961	\N
1078	3412	32	4	REDENCION CDT FINANDINA ABONO CTA AHORROS	2023-12-11 09:36:31.579911	\N
1079	3413	16	4	Aprobación Cr ARIAS FORERO ELCIA MARINA 	2023-12-11 09:42:10.78168	\N
1080	3414	16	4	Aprobación Cr BUSTAMANTE BUSTAMANTE MARTHA 	2023-12-11 09:42:41.476371	\N
1081	3415	16	4	Aprobación Cr CHICO DÍAZ RAFAEL 	2023-12-11 09:44:04.38749	\N
1082	3416	16	4	Aprobación Cr CORTEZ BARRERO CARLOS 	2023-12-11 09:44:29.029849	\N
1083	3417	16	4	Aprobación Cr DIAZ ORTEGON OSCAR 	2023-12-11 09:44:55.677309	\N
1084	3418	16	4	Aprobación Cr CAICEDO BERDUGO  ANDRÉS 	2023-12-11 09:45:53.555574	\N
1085	3419	32	4	PROVISION DE EFECTIVO CAJA	2023-12-11 09:46:17.603115	\N
1086	3420	119	6	RESPUESTA DERECHO DE PETICIÓN- AMERICO PEREA VALOYES 	2023-12-11 09:47:26.843961	\N
1087	3421	32	4	CHEQUE GERENCIA ULTIMO PAGO CASA PCR-SOCIEDAD GALANTE	2023-12-11 10:13:12.581168	\N
1088	3422	42	7	Terminación del contrato de aprendizaje por vencimiento del término pactado.	2023-12-11 10:45:10.003529	\N
1089	3423	32	4	TRASLADO INT A CREDICORP DE AHO FINANDINA	2023-12-11 11:08:17.434942	\N
1090	3424	42	7	TERMINACIÓN DEL CONTRATO DE PASANTÍA O PRÁCTICA UNIVERSITARIA.	2023-12-11 11:17:16.503367	\N
1091	3425	32	4	REDENCION CDT COOPCENTRAL ABONO CTA AHORROS	2023-12-11 11:40:06.493533	\N
1092	3426	32	4	TRASLADO INT A CREDICORP DE AHO COOPCENTRAL	2023-12-11 11:58:30.194558	\N
1093	3427	38	4	paz y salvo ROJAS MELO ROSALBA cc 41609121 10-221000521 	2023-12-11 13:08:01.147737	\N
1094	3428	32	7	CANCELACION FONDO FIC BBVA No 192-0000-56 de nuevo	2023-12-11 15:05:47.360132	\N
1095	3429	32	7	CANCELACION FONDO FIC BBVA No 182-5000-03 de nuevo 	2023-12-11 15:06:07.638835	\N
1096	3430	32	7	CANCELA CTA AHORROS BBVA	2023-12-11 15:06:36.349493	\N
1097	3431	37	4	PAZ Y SALVO TORRES BAZURTO JAIME	2023-12-11 15:35:34.364003	\N
1098	3432	37	4	OBLIGACION AL DIA MONROY ARIAS MARIA CONSTANZA	2023-12-11 15:51:41.153243	\N
1099	3433	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GARCIA VARGAS MERY CONSTANZA	2023-12-11 16:58:17.617353	\N
1100	3434	37	4	 PAZ Y SALVO SOTO RUEDA LEIDY MILENA	2023-12-11 17:36:15.203213	\N
1101	3435	16	4	Aprobación Cr GARZÓN GÓMEZ YASMINA 	2023-12-11 17:44:42.063687	\N
1102	3436	16	4	Aprobación Cr DUEÑAS TRIANA FERNANDO 	2023-12-11 17:45:10.991136	\N
1103	3437	16	4	Aprobación Cr ARIAS MARTINEZ SANDRA 	2023-12-11 17:45:37.522434	\N
1104	3438	16	4	Aprobación Cr COLMENARES MONTAÑEZ GERMAN 	2023-12-11 17:46:08.107784	\N
1105	3439	16	7	Aprobación Cr ORTIZ SANCHEZ SANDRA JUDITH 	2023-12-11 17:46:35.829314	\N
1106	3440	16	7	Aprobación Cr NIETO CRUZ DIEGO 	2023-12-11 17:46:55.845621	\N
1107	3441	4	7	Auxilio de incapacidad. Elvia Ortiz cc: 52106788	2023-12-12 08:51:37.869941	\N
1108	3442	4	7	Auxilio de incapacidad cc: 3046783  PATARROYO MURILLO MANUEL ELKIN	2023-12-12 09:06:12.714846	\N
1109	3443	16	4	Aprobación Blue Card MORA MARTINEZ DIANA MILENA	2023-12-12 09:19:03.254847	\N
1110	3444	16	4	Entrega de pagarés a tesorería 	2023-12-12 10:12:22.049819	\N
1111	3445	29	6	CARTA DE BIENVENIDA RUBIANO VINUEZA JAIME RAMON	2023-12-12 10:30:40.764628	\N
1112	3446	16	4	Aprobación Cr AMAYA PINTO SARA LUCIA 	2023-12-12 10:32:36.987475	\N
1113	3447	16	4	Aprobación Cr RAMOS RODRIGUEZ ZOILA INES 	2023-12-12 10:33:47.512713	\N
1114	3448	29	6	CARTA DE BIENVENIDA GONZALEZ CAMPOS STELLA	2023-12-12 10:40:26.117841	\N
1115	3449	29	6	CARTA DE BIENVENIDA MOYA DE GARCIA MARTHA CECILIA	2023-12-12 10:40:48.66199	\N
1116	3450	29	6	CARTA DE BIENVENIDA LEMUS GARCIA HUMBERTO	2023-12-12 10:41:07.861271	\N
1117	3451	29	6	CARTA DE BIENVENIDA JIMENEZ ESCALANTE CESAR AUGUSTO	2023-12-12 10:41:23.593638	\N
1118	3452	29	6	CARTA DE BIENVENIDA GRACIA RUBIO JULIA ELVIRA	2023-12-12 10:41:40.385979	\N
1119	3453	29	6	CARTA DE BIENVENIDA GUEVARA CASTRO LENDY VALERIA	2023-12-12 10:41:57.224585	\N
1120	3454	29	6	CARTA DE BIENVENIDA MARTIN JAIMES ANDRES FELIPE	2023-12-12 10:42:13.463761	\N
1121	3455	29	6	CARTA DE BIENVENIDA TRIANA PERDOMO LILANA ANDREA	2023-12-12 10:42:28.610242	\N
1122	3456	29	6	CARTA DE BIENVENIDA BARRIOS LADINO IRMA YORYAN DEL ROSARIO	2023-12-12 10:42:46.458151	\N
1123	3457	29	6	CARTA DE BIENVENIDA MEDINA CASTAÑEDA ELVA YOLANDA	2023-12-12 10:43:02.639159	\N
1124	3458	29	6	CARTA DE BIENVENIDA LADINO RODRIGUEZ MYRIAM ELVIA	2023-12-12 10:43:17.274662	\N
1125	3459	120	7	CREDITO CONSUMO TARJETA COOPCENTRAL 12- 161009061 	2023-12-12 11:03:49.803504	\N
1126	3460	16	4	Aprobación Cr CORTES LUNA JORGE ALBERTO	2023-12-13 09:17:28.455579	\N
1127	3461	16	4	Aprobación Cr FORERO DIAZ MONICA	2023-12-13 09:17:54.484734	\N
1128	3462	16	4	Aprobación Cr BERNAL CAMPO ELÍAS 	2023-12-13 09:18:26.403825	\N
1129	3463	16	4	Aprobación Cr ALFONSO RIOS DANIEL 	2023-12-13 09:19:01.733705	\N
1130	3464	16	4	Aprobación Cr ALFONSO ROA RAFAEL 	2023-12-13 09:19:29.999177	\N
1131	3465	16	4	Aprobación Cr MEJIA PIÑERES FERNANDO 	2023-12-13 09:19:52.662564	\N
1132	3466	37	4	 PAZ Y SALVO SOTO RUEDA LEIDY MILENA	2023-12-13 09:22:54.701884	\N
1133	3467	32	4	PROVISION DE EFECTIVO CAJA	2023-12-13 11:13:41.237713	\N
1134	3468	119	6	CERTIFICACIÓN PAZ Y SALVO- LUZ STELLA TALERO CORDOBA 	2023-12-13 15:29:04.623203	\N
1135	3469	120	7	COMPENSACIÓN SALDOS Gonzalo Rafael Villada Londoño  (Q.E.P.D)	2023-12-13 15:45:40.101494	\N
1136	3470	16	4	Aprobación Cr JIMÉNEZ VARGAS ANA CAROLINA 	2023-12-13 16:39:03.246791	\N
1137	3471	16	4	Aprobación Cr RUBIANO VINUEZA JAIME RAMÓN 	2023-12-13 16:39:46.447363	\N
1138	3472	16	4	Aprobación Cr  PAVAJEAU HERMES FRANCISCO 	2023-12-13 16:40:12.739676	\N
1139	3473	16	4	Aprobación Cr RIVERA MONTEALEGRE ENID	2023-12-13 16:40:42.636851	\N
1140	3474	13	4	CARTA AUTORIZACION CHEQUERAS	2023-12-13 16:50:31.351842	\N
1141	3475	29	6	CARTA DE BIENVENIDA LATORRE SUAREZ ALBA PATRICIA	2023-12-13 23:33:13.187017	\N
1142	3476	29	6	CARTA DE BIENVENIDA TIBOCHE GARCIA ARLENSIU	2023-12-13 23:33:36.45723	\N
1143	3477	29	6	CARTA DE BIENVENIDA CORTES RUEDA MARIA CLEMENCIA	2023-12-13 23:34:14.292823	\N
1144	3478	29	6	CARTA DE BIENVENIDA MONCADA CASTIBLANCO YASMI	2023-12-13 23:34:54.101169	\N
1145	3479	29	6	CARTA DE BIENVENIDA ROMERO LARRAHONDO PAULO ANDRES	2023-12-13 23:35:15.424371	\N
1146	3480	29	6	CARTA DE BIENVENIDA CASTAÑO LARA EMERSON	2023-12-13 23:35:34.124111	\N
1147	3481	29	6	CARTA DE BIENVENIDA CHACON SIERRA GIOVANNI ALEXANDER	2023-12-13 23:35:52.681447	\N
1148	3482	29	6	CARTA DE BIENVENIDA RUNCERA ROA LADY MARCELA	2023-12-13 23:36:12.577471	\N
1149	3483	37	4	PAZ Y SALVO POR TODO CONCEPTO TORRES BAZURTO JAIME	2023-12-14 09:16:31.13575	\N
1150	3484	5	4	CERTIFICADO PCR	2023-12-14 09:54:09.85779	\N
1151	3485	16	4	Aprobación Cr MARTINEZ SARMIENTO EVER	2023-12-14 10:54:53.073685	\N
1152	3486	119	6	CARTA DE APROBACIÓN DE RETIRO- LILIANA VALENCIA RODRIGUEZ 	2023-12-14 11:19:38.005382	\N
1153	3487	119	6	CARTA DE APROBACIÓN DE RETIRO- SONIA ZAMBRANO HERNANDEZ 	2023-12-14 11:20:27.315068	\N
1154	3488	119	6	CARTA DE APROBACIÓN DE RETIRO- LUZ MYRIAM AVECEDO HERNÁNDEZ	2023-12-14 11:21:15.796798	\N
1155	3489	119	6	CARTA DE APROBACIÓN DE RETIRO- MILDRED FARIDE HERNÁNDEZ QUINTERO	2023-12-14 11:21:51.619854	\N
1156	3490	119	6	CARTA DE APROBACIÓN DE RETIRO- SEBASTIAN GÓMEZ LÓPEZ	2023-12-14 11:22:23.494478	\N
1157	3491	120	7	COMPENSACIÓN SALDOS GONZALO RAFAEL VILLADA LONDOÑO (Q.E.P.D)	2023-12-14 11:47:38.498932	\N
1158	3492	13	4	CARTA CHEQUE DE GERENCIA PONTIFICIA U. JAVERIANA	2023-12-14 16:09:14.278963	\N
1159	3493	120	4	certificacion afiliacion RAMIREZ CELIS MARIA ELVIRA	2023-12-14 16:32:07.993154	\N
1160	3494	120	4	entrega cobro juridico RAMIREZ CELIS MARIA ELVIRA 	2023-12-14 17:10:31.651144	\N
1161	3495	16	4	Aprobación Cr  MARTINEZ NIÑO JHON ALEXANDER 	2023-12-14 17:26:24.897506	\N
1162	3496	16	4	Aprobación Cr NAIZAQUE RAMOS MANUEL ALFREDO 	2023-12-14 17:27:25.201018	\N
1163	3497	16	4	Aprobación Cr QUINTERO GALINDO SANDRA 	2023-12-14 17:28:01.092501	\N
1164	3498	16	4	Aprobación Cr BELTRÁN PARDO LUIS CARLOS 	2023-12-14 17:28:45.503594	\N
1165	3499	32	4	TRASL INTERNO COOPCENTRAL AHO A CORRIENTE	2023-12-15 09:12:13.12594	\N
1166	3500	32	4	PROVISION DE EFECTIVO CAJA	2023-12-15 09:15:03.591835	\N
1167	3501	32	4	REDENCION CDT FINANDINA ABONO CTA AHORROS FINANDINA	2023-12-15 09:26:39.57739	\N
1168	3502	122	8	Respuesta requerimento Supersolidaria	2023-12-15 15:27:01.867904	\N
1169	3503	16	4	Aprobación Cr SEPULVEDA MOLINA NADIA CATALINA 	2023-12-15 15:49:51.7502	\N
1170	3504	16	4	Aprobación Cr URREGO ARIAS JHOAN DAVID	2023-12-15 15:50:38.829096	\N
1171	3505	16	4	Aprobación Cr GOYENECHE TRIANA JOHN JAIRO 	2023-12-15 15:51:23.27535	\N
1172	3506	37	4	CERTIFICADO PATRICIA MARTINEZ	2023-12-15 16:15:18.337713	\N
1173	3507	16	4	Aprobación Cr Puyana Villamizar Yolanda	2023-12-15 17:08:50.742683	\N
1174	3508	16	4	Entrega Pagaré a Tesorería 	2023-12-15 17:17:11.689724	\N
1175	3509	16	4	Aprobación Cr Jaimes Sanchez Jeaneth 	2023-12-15 17:27:51.449148	\N
1176	3510	37	4	 PAZ Y SALVO LEON RODRIGUEZ NOHRA	2023-12-18 07:51:25.051485	\N
1177	3511	120	4	respuesta solicitud Elizabeth Bernal	2023-12-18 09:01:22.561031	\N
1178	3512	16	4	Aprobación Cr  DIAZ GAITAN CLARA INES 	2023-12-18 09:49:49.102372	\N
1179	3513	16	4	Aprobación Cr  PIÑEROS BUSTAMANTE VIVIANA MARCELA 	2023-12-18 09:50:25.290379	\N
1180	3514	16	4	Aprobación Cr  BRICEÑO AMARILLO OSCAR 	2023-12-18 09:51:07.06557	\N
1181	3515	16	4	Aprobación Cr  TALERO URREGO CESAR \r\n	2023-12-18 09:51:40.362531	\N
1182	3516	16	4	Aprobación Cr  GONZALEZ RUBIANO DAVID 	2023-12-18 09:52:07.303307	\N
1183	3517	37	4	PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GARCIA VARGAS MERY CONSTANZA	2023-12-18 09:58:02.812285	\N
1184	3518	37	4	 PAZ Y SALVO PARA LEVANTAMIENTO DE HIPOTECA GALINDO RAMIREZ MARTHA LILIANA	2023-12-18 10:23:20.704651	\N
1185	3519	37	4	 PARA LEVANTAMIENTO DE PRENDA GERENA USECHE BARBARA EMILSE	2023-12-18 11:21:13.61956	\N
1186	3520	32	4	PROVISION DE EFECTIVO CAJA	2023-12-18 11:48:38.787301	\N
1187	3521	37	4	PAZ Y SALVO SANTIESTEBAN QUINTERO ROSA ELVIA	2023-12-18 11:50:53.230536	\N
1188	3522	29	6	CARTA DE BIENVENIDAMURCIA DE QUINTANA MARIA CECILIA	2023-12-18 12:37:02.727259	\N
1189	3523	29	6	CARTA DE BIENVENIDA CASAS GAONA LUZ IMELDA	2023-12-18 12:37:29.901384	\N
1190	3524	29	6	CARTA DE BIENVENIDABERNAL LUGO JUAN DAVID	2023-12-18 12:37:47.61471	\N
1191	3525	29	6	CARTA DE BIENVENIDA ALARCON RUIZ LUIS FERNANDO 	2023-12-18 12:38:05.772685	\N
1192	3526	29	6	CARTA DE BIENVENIDA PAEZ GARZON JENNY PAOLA	2023-12-18 12:38:23.680139	\N
1193	3527	29	6	CARTA DE BIENVENIDA CUTIVA PEREZ YERMAIN ANDRES	2023-12-18 12:38:38.77487	\N
1194	3528	29	6	CARTA DE BIENVENIDA AROCA PERDOMO ELDA MARIA	2023-12-18 12:39:00.076364	\N
1195	3529	32	4	TRASLADO INT DE AHO RENTAYA A CREDICORP FIC	2023-12-18 13:18:10.149404	\N
1196	3530	32	4	TRASLADO INT DE BB SERVICIOS A BB RENTAYA 	2023-12-18 13:22:03.814614	\N
1197	3531	8	1	COMPRA DE COMPUTADORES	2023-12-18 17:06:38.636867	\N
1198	3532	16	4	Aprobación Cr   SARMIENTO ORJUELA LINA MARIA 	2023-12-18 17:45:41.105933	\N
1199	3533	16	4	Aprobación Cr   NAGLES GALEANO LEIDY JOHANA	2023-12-18 17:46:26.23096	\N
1200	3534	16	4	Aprobación Cr   LEON PARRA ANDREA 	2023-12-18 17:46:53.615499	\N
1201	3535	16	4	Aprobación Cr   PERDOMO GARCIA OLGA 	2023-12-18 17:47:15.218585	\N
1202	3536	16	4	Aprobación Cr   ARIAS PULGARIN PAULA 	2023-12-18 17:47:41.522338	\N
1203	3537	13	4	CARTA CHEQUE DE GERENCIA U. JAVERIANA	2023-12-18 18:18:41.681128	\N
1204	3538	10	3	Entrega de Información	2023-12-19 10:45:28.645208	\N
1205	3539	37	7	 PAZ Y SALVO FORERO DIAZ MONICA	2023-12-19 13:45:11.817721	\N
1206	3540	16	4	Aprobación Cr   RODRIGUEZ BALLEN OSCAR DAVID	2023-12-19 17:16:12.058452	\N
1207	3541	16	4	Aprobación Cr SARMIENTO ORJUELA ARIAN 	2023-12-19 17:16:52.321044	\N
1208	3542	16	4	Aprobación Cr REAL RUEDA MAGDA MILENA	2023-12-20 09:39:05.892222	\N
1209	3543	16	4	Aprobación Cr    ROMERO LARRAHONDO PAULO	2023-12-20 11:30:57.216376	\N
1210	3544	16	4	Aprobación Cr    GÓMEZ CAMPO VÍCTOR MANUEL 	2023-12-20 11:31:32.858201	\N
1211	3545	16	4	Aprobación Cr    RODRIGUEZ MEJIA KARLA 	2023-12-20 11:32:01.323459	\N
1212	3546	16	4	Aprobación Cr    BENAVIDES DIAZ DANIEL 	2023-12-20 11:32:31.976318	\N
1213	3547	16	4	Aprobación Cr    GUTIERREZ CEBALLOS OSCAR 	2023-12-20 11:32:54.484592	\N
1214	3548	16	4	Aprobación Cr    DUARTE RUIZ ALVARO	2023-12-20 11:33:19.213892	\N
1215	3549	16	4	Aprobación Cr    ZAMBRANO ACOSTA INGRID 	2023-12-20 11:34:30.407859	\N
1216	3550	16	4	Aprobación Cr    ZAMBRANO ACOSTA INGRID	2023-12-20 11:34:55.565385	\N
1217	3551	37	4	 PAZ Y SALVO AMAYA MARQUEZ MARISOL	2023-12-20 16:00:28.865794	\N
1218	3552	16	4	Aprobación Cupo Rotativo Pavajeau Hermes Francisco	2023-12-20 16:13:36.256669	\N
1219	3553	16	4	Aprobación Cr Bejarano Pardo Hayde 	2023-12-20 16:14:14.117984	\N
1220	3554	129	7	Seguimiento al proyecto de seguridad de la información.	2023-12-21 08:49:48.034005	\N
1221	3555	129	2	Respuesta seguimiento al proyecto de seguridad de la información.	2023-12-21 08:51:37.174221	\N
1222	3556	32	7	PROVISION DE EFECTIVO CAJA	2023-12-21 09:21:51.333856	\N
1223	3557	32	7	CANCELACION CTA DE AHORROS BBVA	2023-12-21 09:43:43.736347	\N
1224	3558	29	6	CARTA DE BIENVENIDA ORJUELA URQUIJO JESUS ANTONIO	2023-12-21 09:58:18.942358	\N
1225	3559	29	6	CARTA DE BIENVENIDA ROMERO GONZALEZ JAIME YECID	2023-12-21 09:58:33.945367	\N
1226	3560	29	6	CARTA DE BIENVENIDA VELANDIA BLANCO LAURA MAYERLY	2023-12-21 09:58:54.210229	\N
1227	3561	16	4	Aprobación Cr Martinez carlos Julio 	2023-12-21 11:25:13.462184	\N
1228	3562	32	4	PROVISION D EEFECTIVO	2023-12-21 12:40:30.665924	\N
1229	3563	122	8	Autorización para declaración final de delineación urbana, secretaría de hacienda	2023-12-21 16:08:28.132746	\N
1230	3564	16	4	Aprobación Cr GARZON ROBAYO ANGEL PAVEL	2023-12-21 16:10:32.29133	\N
1231	3565	16	4	Aprobación Cr GARZON ROBAYO ANGEL PAVEL	2023-12-21 16:10:33.897695	\N
1232	3566	16	4	Aprobación Cr LEÓN MOLINA HELIA BIBIANA 	2023-12-21 16:11:52.614053	\N
1233	3567	32	4	RESPUESTA A DIR CONTROL INTERNO MEMO-DCI3322 WM473385	2023-12-22 08:38:22.568786	\N
1234	3568	5	4	CERTIFICADO ALVARO AVILA QUINTERO	2023-12-22 14:22:49.868639	\N
1235	3569	14	4	Carta aprobación MEDINA CASTAÑEDA ELVA YOLANDA	2023-12-22 16:35:05.408701	\N
1236	3570	14	4	Derecho de peticion 	2023-12-22 17:47:34.777544	\N
1237	3571	16	4	Aprobación Cr   RODRIGUEZ JIMENEZ LUIS VICENTE 	2023-12-26 10:46:07.331961	\N
1238	3572	16	4	Aprobación Cr   USECHE LOPEZ RICARDO 	2023-12-26 10:46:35.303217	\N
1239	3573	16	4	Aprobación Cr   BORNACELLI ACOSTA FIORELLA 	2023-12-26 10:46:58.881756	\N
1240	3574	16	4	Aprobación Cr   PEÑALOZA SUAREZ ELIANA 	2023-12-26 10:49:27.773888	\N
1241	3575	16	4	Aprobación Cr   JARAMILLO GUERRA PATRICIA 	2023-12-26 10:49:51.307554	\N
1242	3576	16	4	Aprobación Cr    HUERTAS MILLAN LUCIA 	2023-12-26 10:50:15.205836	\N
1243	3577	16	4	Aprobación Cr   SÁNCHEZ RIVERA CLAUDIA	2023-12-26 10:50:44.776433	\N
1244	3578	16	4	Aprobación Cr   HINCAPIÉ CETINA DIANA 	2023-12-26 10:51:09.088145	\N
1245	3579	16	4	Aprobación Cr   BRICEÑO GAMBA WILLIAM 	2023-12-26 10:51:33.878033	\N
1246	3580	16	4	Aprobación Cr   PORTILLA GAMBOA MODESTO 	2023-12-26 10:52:01.620366	\N
1247	3581	16	4	Aprobación Cr   PARRA RODRIGUEZ JUANA OLIVA 	2023-12-26 10:52:27.928709	\N
1248	3582	16	4	Aprobación Cr   GONZALEZ NAVARRETE JULIO 	2023-12-26 10:52:51.566116	\N
1249	3583	16	4	Aprobación Cr   CHACON SIERRA GIOVANNI 	2023-12-26 10:53:18.080148	\N
1250	3584	16	4	Aprobación Cr   GUTIERREZ CEBALLOS OSCAR 	2023-12-26 10:58:22.288032	\N
1251	3585	119	6	CARTA DE APROBACIÓN DE RETIRO- MONICA PAOLA BEJARANO CASTILLO	2023-12-26 11:08:20.182237	\N
1252	3586	119	6	CARTA DE APROBACIÓN DE RETIRO- DIVA YANIRA CRIOLLO VARGAS 	2023-12-26 11:08:56.079819	\N
1253	3587	119	6	CARTA DE APROBACIÓN DE RETIRO POR FALLECIMIENTO- MARIA CONSUELO DIAZ BAEZ 	2023-12-26 11:09:52.872919	\N
1254	3588	119	6	CARTA DE APROBACIÓN DE RETIRO POR FALLECIMIENTO- MARIA XIMENA HERNANDEZ VANEGAS 	2023-12-26 11:11:04.251124	\N
1255	3589	119	6	CARTA DE APROBACIÓN DE RETIRO- MARTA LUZ OCHOA CARDENAS 	2023-12-26 11:13:13.945947	\N
1256	3590	29	6	CARTA DE BIENVENIDA OLARTE PARDO MAGALY	2023-12-26 11:27:09.760405	\N
1257	3591	15	7	Reporte reducción del fondo de liquidez SES	2023-12-26 15:54:28.021134	\N
1258	3592	16	4	Aprobación Cr GONZALEZ CAMPOS STELLA	2023-12-26 17:27:27.254045	\N
1259	3593	5	4	CERTIFICADO CLARA ELENA CHAMORRO BELLO	2023-12-27 07:28:53.780456	\N
1260	3594	32	4	TRASL DE FINANDINA A FONVAL	2023-12-27 08:14:04.187184	\N
1261	3595	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-27 10:30:28.25407	\N
1262	3596	16	4	Aprobación Cr   ALHIPPIO CHAVARRO ISABEL CRISTINA	2023-12-27 10:55:29.877872	\N
1263	3597	16	4	ALHIPPIO CHAVARRO ISABEL CRISTINA	2023-12-27 10:56:20.272195	\N
1264	3598	16	4	Aprobación Cr  CETRE CASTILLO MOISES 	2023-12-27 10:57:03.697229	\N
1265	3599	16	4	Aprobación Cr  RODRIGUEZ MEJIA KARLA 	2023-12-27 10:57:32.357858	\N
1266	3600	16	4	Aprobación Cr  GOMEZ GRANADOS FERNANDO	2023-12-27 10:58:02.190461	\N
1267	3601	16	4	Aprobación Cr MANCERA RODRIGUEZ MATEO  	2023-12-27 10:58:37.407579	\N
1268	3602	16	4	Aprobación Cr  NAVARRO DE MORALES AMPARO 	2023-12-27 10:59:09.845833	\N
1269	3603	16	4	Aprobación Cr  VELANDIA BLANCO LAURA 	2023-12-27 10:59:47.665747	\N
1270	3604	16	4	Aprobación Cr  ARAQUE SALAMANCA AMILCAR 	2023-12-27 11:00:18.737435	\N
1271	3605	16	4	Aprobación Cr  BARRERO RUSSI MARTHA	2023-12-27 11:00:50.092054	\N
1272	3606	16	4	Aprobación Cr  CASAS GAONA LUZ IMELDA 	2023-12-27 11:01:19.742286	\N
1273	3607	37	4	 CERTIFICADO DE DEUDA CREDITO AL DIA CHAMORRO BELLO CLARA ELENA	2023-12-28 08:31:32.199643	\N
1274	3608	37	4	 PAZ Y SALVO ZGAIB ABURAD MARIAM GLORIA	2023-12-28 08:40:03.907832	\N
1275	3609	17	7	TRASLADO ENTRE CUENTAS COOPCENTRAL PSE A AFINIDAD	2023-12-28 08:52:54.584528	\N
1276	3610	16	4	Aprobación Cr  MIRANDA CORTES BEATRIZ 	2023-12-28 09:34:50.310215	\N
1277	3611	16	4	Aprobación Cr  PERILLA FINO EDWIN 	2023-12-28 09:35:19.797901	\N
1278	3612	16	4	Aprobación Cr  SENDOYA  LUIS ANDRES 	2023-12-28 09:35:43.268417	\N
1279	3613	16	4	Aprobación Cr  TORRES NARVAEZ FLOR 	2023-12-28 09:36:40.129665	\N
1280	3614	16	4	Aprobación Cr  PEREZ BARRAGAN MONICA 	2023-12-28 09:37:07.835347	\N
1281	3615	16	4	Aprobación Cr  MORENO LACHE NUBIA 	2023-12-28 09:37:26.479776	\N
1282	3616	16	4	Aprobación Cr   DAZA CASTILLO JEANNETTE 	2023-12-28 09:37:46.872984	\N
1283	3617	16	4	Aprobación Cr  MONTENEGRO DE CARRILLO NOHORA 	2023-12-28 09:38:11.183947	\N
1284	3618	16	4	Aprobación Cr  RODRIGUEZ ORTIZ EDINSON	2023-12-28 09:38:47.449989	\N
1285	3619	32	4	PROVISION DE EFECTIVO CAJA	2023-12-28 10:40:32.430767	\N
1286	3620	16	4	Aprobación Blue Card PERILLA FINO EDWIN ALIRIO	2023-12-28 11:52:45.262833	\N
1287	3621	29	6	CARTA DE BIENVENIDA  LINARES NAVARRO GUIOMAR	2023-12-29 08:10:16.606131	\N
1288	3622	29	6	CARTA DE BIENVENIDA JIMENEZ CADAVID JHOVANNA PAOLA	2023-12-29 08:10:36.387751	\N
1289	3623	29	6	CARTA DE BIENVENIDA AMOROCHO SALAZAR MARTHA CECILIA	2023-12-29 08:10:50.417315	\N
1290	3624	29	6	CARTA DE BIENVENIDA LOPEZ TELLEZ ESTEBAN	2023-12-29 08:11:04.817114	\N
1291	3625	29	6	CARTA DE BIENVENIDA VALBUENA GUAIRIYU LUIS ALBERTO	2023-12-29 08:11:21.824861	\N
1292	3626	29	6	CARTA DE BIENVENIDA OLARTE SANCHEZ ISABELLA	2023-12-29 08:11:42.265157	\N
1293	3627	37	4	 PAZ Y SALVO PARA LEVANTAMIENTO ALVARADO FLOREZ LILIANA ESTHER	2023-12-29 08:45:27.394046	\N
1294	3628	16	4	Aprobación Blue Card SENDOYA ZAMUDIO LUIS ANDRES 	2023-12-29 09:05:41.509503	\N
1295	3629	5	4	CERTIFICADO CLAUDINE FLOREN BELLANGER VERONIQUE	2023-12-29 10:17:43.571116	\N
1296	3630	122	9	Respuesta a la superintendencia de economía solidaria respecto de la petición presentada por sra LUCY GABRIELA DELGADO	2023-12-29 10:27:46.155952	\N
1297	3631	10	3	solicitud de Información enero 2024	2023-12-29 11:31:18.924866	\N
1298	3632	10	3	solicitud de Información enero 2024	2023-12-29 11:31:54.601903	\N
1299	3633	10	3	solicitud de Información enero 2024	2023-12-29 11:32:05.666538	\N
1300	3634	10	3	solicitud de Información enero 2024	2023-12-29 11:32:16.116773	\N
1301	3635	10	3	solicitud de Información enero 2024	2023-12-29 11:32:26.736136	\N
1302	3636	10	3	solicitud de Información enero 2024	2023-12-29 11:32:35.370677	\N
1303	3637	10	3	solicitud de Información enero 2024	2023-12-29 11:32:48.594861	\N
1304	3638	10	3	solicitud de Información enero 2024	2023-12-29 11:33:03.607939	\N
1305	3639	10	3	solicitud de Información enero 2024	2023-12-29 11:33:19.354656	\N
1306	3640	10	3	solicitud de Información enero 2024	2023-12-29 11:33:29.473025	\N
1307	3641	10	3	solicitud de Información enero 2024	2023-12-29 11:33:40.785296	\N
1308	3642	10	3	solicitud de Información enero 2024	2023-12-29 11:33:54.31365	\N
1309	3643	10	3	solicitud de Información enero 2024	2023-12-29 11:34:08.6799	\N
1310	3644	10	3	solicitud de Información enero 2024	2023-12-29 11:34:20.025789	\N
1311	3645	10	3	solicitud de Información enero 2024	2023-12-29 11:34:29.137342	\N
1312	3646	10	3	solicitud de Información enero 2024	2023-12-29 11:34:39.506007	\N
1313	3647	10	3	solicitud de Información enero 2024	2023-12-29 11:34:52.050961	\N
1314	3648	10	3	solicitud de Información enero 2024	2023-12-29 11:35:06.249084	\N
1315	3649	10	3	solicitud de Información enero 2024	2023-12-29 11:35:16.849777	\N
1316	3650	10	3	solicitud de Información enero 2024	2023-12-29 11:35:27.585555	\N
1317	3651	10	3	solicitud de Información enero 2024	2023-12-29 11:35:36.835547	\N
1318	3652	10	3	solicitud de Información enero 2024	2023-12-29 11:35:49.611054	\N
1319	3653	10	3	solicitud de Información enero 2024	2023-12-29 11:35:57.277105	\N
1320	3654	10	3	solicitud de Información enero 2024	2023-12-29 11:36:07.676421	\N
1321	3655	10	3	solicitud de Información enero 2024	2023-12-29 11:36:16.92437	\N
1322	3656	10	3	solicitud de Información enero 2024	2023-12-29 11:36:27.604034	\N
1323	3657	10	3	solicitud de Información enero 2024	2023-12-29 11:36:36.131283	\N
1324	3658	10	3	solicitud de Información enero 2024	2023-12-29 11:36:51.019316	\N
1325	3659	10	3	solicitud de Información enero 2024	2023-12-29 11:37:00.893264	\N
1326	3660	29	6	CARTA DE BIENVENIDA MARTINEZ SANCHEZ CLARA TERESA	2023-12-29 13:38:45.158684	\N
1327	3661	29	6	CARTA DE BIENVENIDA LOPEZ CANTOR LUIS FERNANDO	2023-12-29 13:39:10.011936	\N
1328	3662	29	6	CARTA DE BIENVENIDA MATIZ CARDENAS MARIANA ROSA DELIA	2023-12-29 13:39:28.207908	\N
1329	3663	29	6	CARTA DE BIENVENIDA PARRA MEDINA ASTRID LUCILA	2023-12-29 13:39:44.259757	\N
1330	3664	29	6	CARTA DE BIENVENIDA MESA CALDERON SARA VALENTINA	2023-12-29 13:40:01.074334	\N
1331	3665	29	6	CARTA DE BIENVENIDA FULA SOTELO GUSTAVO ADOLFO	2023-12-29 13:40:15.930531	\N
1332	3666	29	6	CARTA DE BIENVENIDA PORTILLA CORTES ANGELICA MARIA	2023-12-29 13:40:34.289902	\N
1333	3667	37	4	CERTIFICADO PATRICIA MARTINEZ	2023-12-29 15:56:54.794559	\N
1334	3668	14	4	Respuesta control interno DCI 3331	2023-12-29 16:20:36.817864	\N
1335	3669	5	4	CERTIFICADO CONSUELO MARTINEZ DE MORGENSZTERN	2023-12-29 16:58:52.937101	\N
1336	3670	120	4	OTORGAMIENTO PERIODO DE GRACIA ADRIANA GOMEZ	2023-12-31 17:56:29.689477	\N
1337	3671	120	4	RESPUESTA RECLAMACION SINIESTRO ASEGURABILIDAD BELALCAZAR	2023-12-31 17:57:20.351417	\N
1338	1	32	7	PROVISION DE EFECTIVO	2024-01-02 14:22:47.446646	\N
1339	2	32	7	PROVISION DE EFECTIVO	2024-01-02 14:23:29.550078	\N
1341	4	133	7	Solicitud de títulos a nombre de la Cooperativa  que existen en el Banco Agrario	2024-01-03 08:59:25.031293	\N
1342	5	37	4	 CERTIFICADO CREDITO HIPOTECARIO CORTE 31 DE DICIEMBRE MURILLO TINOCO ERIKA DEL PILAR	2024-01-03 10:42:07.354766	\N
1343	6	29	6	CARTA DE BIENVENIDA VASQUEZ LAMPREA BRAYAN NICOLAS	2024-01-03 14:24:46.092924	\N
1344	7	29	6	CARTA DE BIENVENIDA BARRERA LOPEZ YILSEIT ILEIN	2024-01-03 14:26:11.406527	\N
1345	8	29	6	CARTA DE BIENVENIDA RAMIREZ RIOS MANUEL ALEJANDRO	2024-01-03 14:26:34.359052	\N
1346	9	29	6	CARTA DE BIENVENIDA DIAZ SANCHEZ ANGELA MARIA	2024-01-03 14:26:57.849986	\N
1347	10	29	6	CARTA DE BIENVENIDA BARRERA SIERRA LILIANA	2024-01-03 17:20:18.692888	\N
1348	11	29	6	CARTA DE BIENVENIDA DELGADILLO BARRERA SARA	2024-01-03 17:20:38.801759	\N
1349	12	133	4	Solicitud de terminación de proceso judicial	2024-01-04 08:32:21.694684	\N
1350	13	1	1	Consecutivo de prueba 2024	2024-01-04 10:47:10.546629	\N
1351	25000	1	1	Ultimo consecutivo manual	2024-10-04 10:47:10.546	\N
1522	25001	32	4	PROVISION EFECTIVO	2025-01-07 09:24:34	\N
1523	25002	143	6	carta bienvenida	2025-01-07 10:36:16	\N
1524	25003	162	4	PAZ Y SALVO MEJIA PIÑERES FERNANDO	2025-01-07 13:24:02	\N
1525	25004	162	4	PAZ Y SALVO MEDINA TORRES CARLOS ARTURO	2025-01-07 13:32:47	\N
1526	25005	162	4	CERTIFICADO DE DEUDA CIFUENTES RAMIREZ CLAUDIA MILENA	2025-01-07 17:50:36	\N
1527	25006	162	4	PAZ Y SALVO GONZALEZ FORERO ANA MARIA DE LOS DOLORES 	2025-01-08 08:45:19	\N
\.


--
-- TOC entry 4825 (class 0 OID 16494)
-- Dependencies: 221
-- Data for Name: opcion_por_perfil; Type: TABLE DATA; Schema: consecutivos; Owner: postgres
--

COPY consecutivos.opcion_por_perfil (opcion_id, perfil_id, descripcion, descripcion_corta, activa) FROM stdin;
1	1	Reiniciar numeración de consecutivo, por cambio de año o por solicitud de ajuste	Ajusta consecutivo	1
2	1	Administración de perfiles y usuarios.	Admon. Perfiles-Usuario	1
3	1	Consultas de nivel administrativo operativo.	Consultas	1
4	2	Generar consecutivos.	Generar consecutivo	1
5	3	Reportes de control y auditoría.	Auditoria y control	1
6	2	Reportes de generación de consecutivos.	Consecutivos Generados	1
\.


--
-- TOC entry 4828 (class 0 OID 16501)
-- Dependencies: 224
-- Data for Name: perfil; Type: TABLE DATA; Schema: consecutivos; Owner: postgres
--

COPY consecutivos.perfil (perfil_id, perfil, activo, perfil_defecto) FROM stdin;
1	Administrador	1	0
4	Consulta nivel 2	1	0
3	Auditoría y Control	1	0
2	Usuario Generador	1	1
\.


--
-- TOC entry 4832 (class 0 OID 16509)
-- Dependencies: 228
-- Data for Name: perfil_usuario; Type: TABLE DATA; Schema: consecutivos; Owner: postgres
--

COPY consecutivos.perfil_usuario (fecha_asociacion_perfil, perfil_id, usuario_id) FROM stdin;
\.


--
-- TOC entry 4834 (class 0 OID 16515)
-- Dependencies: 230
-- Data for Name: prefijo; Type: TABLE DATA; Schema: consecutivos; Owner: postgres
--

COPY consecutivos.prefijo (prefijo_id, prefijo, descripcion_prefijo) FROM stdin;
3	CI	CONTROL INTERNO
7	GG	GERENCIA/SUBGERENCIA
9	JV	JUNTA DE VIGILANCIA
8	JR	AREA JURÍDICA
10	CA	CONSEJO DE ADMINISTRACIÓN
4	DF	DIRECCIÓN FINANCIERA
5	DA	DIRECCIÓN ADMINISTRATIVA
6	DC	DIRECCIÓN COMERCIAL
1	DT	DIRECCIÓN TICS
2	CR	COORDINACIÓN RIESGOS
\.


--
-- TOC entry 4830 (class 0 OID 16505)
-- Dependencies: 226
-- Data for Name: usuario; Type: TABLE DATA; Schema: consecutivos; Owner: postgres
--

COPY consecutivos.usuario (usuario_id, usuario_nombre, usuario_ldap, pasword) FROM stdin;
1	ANDRES MAURICIO CARDENAS SANCHEZ	acardenas	TEMPO2024
3	MIGUEL ANGEL CASTAÑEDA ROCHA	mcastaneda	TEMPO2024
4	LIZETH ANDREA AMAYA GUANEME	lamaya	TEMPO2024
5	SANDY VANESSA BERROCAL PATERNINA	sberrocal	TEMPO2024
6	PAOLA ANDREA PATIÑO CASTAÑEDA	pcastaneda	TEMPO2024
7	YEIMY VIVIANA REYES CUERVO	yvreyes	TEMPO2024
163	Juan Sebastían Rincón Calderón	jrincon	LOL
9	DAMARIS  REYES CASTRO	dreyes	TEMPO2024
10	MARTHA YINETH PEREZ BARRAGAN	mperez	TEMPO2024
12	OLIVA  GARZON AREVALO	ggarzon	TEMPO2024
13	LUZ YOLANDA ACUÑA GONZALEZ	lacuna	TEMPO2024
14	ANDREA  BECERRA GOMEZ	abecerra	TEMPO2024
17	NELSY JOHANA AVILA PEDROZA	navila	TEMPO2024
18	CESAR ARNOVIL SOSSA CHAPARRO	csossa	TEMPO2024
19	ANGIEE LORENA PINZON PACHON	apinzon	TEMPO2024
20	JUAN CARLOS OSORIO ECHEVERRI	josorio	TEMPO2024
21	JOSE ANDERSON CASTILLO RODRIGUEZ	jcastillo	TEMPO2024
22	LAURA GABRIELA MORENO MARTINEZ	lmoreno	TEMPO2024
23	JOSE HUMBERTO BALAGUERA RICARDO	jbalaguera	TEMPO2024
24	HECTOR RAUL RUIZ VELANDIA	hruiz	TEMPO2024
25	EDGAR ASDRUBAL ALARCON QUINTERO	ealarcon	TEMPO2024
26	MARVIN SANTIAGO ORDOÑEZ ORDOÑEZ	mordonez	TEMPO2024
27	ANDREA  TOVAR FIGUEROA	atovar	TEMPO2024
29	DIANA MARIA FONSECA BARBOSA	dfonseca	TEMPO2024
30	INGRID YULIANA ROSAS CUBILLOS	irosas	TEMPO2024
31	BRIAN ANDRES CORONADO ZAPATA	bcoronado	TEMPO2024
32	PEDRO NEL CASAS 	pcasas	TEMPO2024
33	ANGIE KATHERIN GUZMAN DURAN	aguzman	TEMPO2024
34	KAREN  BUSTAMANTE VALCARCEL	kbustamante	TEMPO2024
35	SHIRLEY MERCEDES TAPIA PIZO	stapia	TEMPO2024
36	MAXIMILIANO  MANJARRES CUELLO	mmanjarres	TEMPO2024
37	CAMILA ANDREA MEDINA PÉÑA	cmedina	TEMPO2024
38	SONIA GERALDINE MORA TORRES	smora	TEMPO2024
39	LUZ DARY ALVIZ SIMANCA	lalviz	TEMPO2024
41	MAYRA ALEJANDRA HERRERA FIGUEROA	mherrera	TEMPO2024
42	EDUARDO JOSE MAZUERA RENDON	emazuera	TEMPO2024
43	CRISTIAN GIOVANNI TARAZONA TORRES	ctarazona	TEMPO2024
103	JEISSON ANTONIO VELOSA SURINCHO	jvelosa	TEMPO2024
118	Edilberto Forero Vivas	eforero	TEMPO2024
119	Nicolas Fernando Castillo Tabares	ncastillo	TEMPO2024
120	Sandra Milena León Ortiz	sleon	TEMPO2024
121	Maria Fernanda Rivas Correa	mrivas	TEMPO2024
122	Hans Sebastian Alvarez Rinco	halvarez	TEMPO2024
123	Ingrid Maritza Beltran Misas	ibeltran	TEMPO2024
109	sin usuario	pruebas	TEMPO2024
124	Héctor Raúl Ariza Ardila	hariza	TEMPO2024
125	Lina Maria Otero Carvajal	lotero	TEMPO2024
126	Leidy Johana Castillo Gonzalez	lcastillo	TEMPO2024
11	JORGE ALVARO MORA GRAJALES	jmorag	TEMPO2024
15	ELSA  SANABRIA RODRÍGUEZ	esanabria	TEMPO2024
16	JHON ALEXANDER MORA BELTRAN	amora	TEMPO2024
28	LUZ ADRIANA GARCIA LOPEZ	agarcia	TEMPO2024
127	Frank Andrés Gómez Villamizar	fgomezv	TEMPO2024
40	GLADYS MILENA VALBUENA LIZARAZO	gvalbuena	TEMPO2024
128	Lina María Ruíz Parra	lruizp	TEMPO2024
129	ANGELA VIVIANA CRUZ IBAÑEZ	acruz	TEMPO2024
130	Jackeline Piñeros Londoño	jpineros	TEMPO2024
117	Junta Vigilancia	jvigilancia	TEMPO2024
131	Yeison Stiven Simijaca Torralba	ysimijaca	TEMPO2024
132	Yeison Stiven Simijaca Torralba	ysimijaca	TEMPO2024
133	Daniel Fernando Ariza Abril	dariza	TEMPO2024
134	Yuri Milena Ordoñez Rodriguez	yordoñez	TEMPO2024
135	Ángela María Montero Gonzalez	amontero	TEMPO2024
136	Margie Lizeth Umbarila Murcia	lumbarila	TEMPO2024
137	Yulieth Natalia Guevara Puentes	yguevara	TEMPO2024
138	Julieth Camila Daza Pinzón	jdaza	TEMPO2024
139	Laura Daniela León Ortiz	lortiz	TEMPO2024
140	Valeria Dayana Malaver Gómez	vmalaver	TEMPO2024
141	Ivonne Tatiana Castiblanco Hernández	icastiblanco	TEMPO2024
142	Diego Fernando Villareal Diaz	dvillareal	TEMPO2024
143	Silvia Fernanda Otálvaro López	sotalvaro	TEMPO2024
144	Ángel Gabriel López Cubides	alopez	TEMPO2024
8	WILLINTON DE JESUS ORTIZ MARTINEZ	wortiz	1234
146	pruebas1	pruebas1	TEMPO2024
147	Soporte Linix	SLINIX	TEMPO2024
148	Diana Marcela León Palacios	dleon	TEMPO2024
149	Oscar Alfonso Ardila Jiménez	oardila.ext	TEMPO2024
150	Sandra Bibiana Arias Martínez	sarias.ext	TEMPO2024
151	German Felipe Molina Camargo	gmolina	TEMPO2024
152	Hernan Darío Ramos Mariño	hramos	TEMPO2024
153	Harol Yesid Castañeda Astudillo	hcastaneda	TEMPO2024
154	Maria Isabel Villegas Pulido	mvillegas	TEMPO2024
155	Plugin GLPI Inventory	Plugin_GLPI_Inventory	TEMPO2024
156	Sandra Milena Cubides Guerrero	scubides	TEMPO2024
157	Jose Luis Velasco Nieto	jvelasco	TEMPO2024
158	Biller Leonel Bustos Santos	bbustos	TEMPO2024
159	Liliana Cifuentes López	lcifuentes	TEMPO2024
160	Claudia Patricia Cifuentes Mikan	ccifuentes	TEMPO2024
161	Vanessa Adelina Hernández	vhernandez	TEMPO2024
162	Ingrid Nataly Pulecio Triana	npulecio	TEMPO2024
164	Karen Gonzalez Karen Jissend Gonzalez Guerrero	kgonzalez	TEMPO2024
145	Gilberto Martinez Santos	gmartinez	TEMPO2024
\.


--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 218
-- Name: gestion_consecutivo_consecutivo_seq; Type: SEQUENCE SET; Schema: consecutivos; Owner: postgres
--

SELECT pg_catalog.setval('consecutivos.gestion_consecutivo_consecutivo_seq', 2559, true);


--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 220
-- Name: historia_consecutivo_consecutivo_id_seq; Type: SEQUENCE SET; Schema: consecutivos; Owner: postgres
--

SELECT pg_catalog.setval('consecutivos.historia_consecutivo_consecutivo_id_seq', 1527, true);


--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 222
-- Name: opcion_por_perfil_opcion_id_seq; Type: SEQUENCE SET; Schema: consecutivos; Owner: postgres
--

SELECT pg_catalog.setval('consecutivos.opcion_por_perfil_opcion_id_seq', 6, true);


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 223
-- Name: opcion_por_perfil_perfil_id_seq; Type: SEQUENCE SET; Schema: consecutivos; Owner: postgres
--

SELECT pg_catalog.setval('consecutivos.opcion_por_perfil_perfil_id_seq', 1, false);


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 225
-- Name: perfil_perfil_id_seq; Type: SEQUENCE SET; Schema: consecutivos; Owner: postgres
--

SELECT pg_catalog.setval('consecutivos.perfil_perfil_id_seq', 4, true);


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 229
-- Name: perfil_usuario_perfil_id_seq; Type: SEQUENCE SET; Schema: consecutivos; Owner: postgres
--

SELECT pg_catalog.setval('consecutivos.perfil_usuario_perfil_id_seq', 1, false);


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 231
-- Name: prefijo_prefijo_id_seq; Type: SEQUENCE SET; Schema: consecutivos; Owner: postgres
--

SELECT pg_catalog.setval('consecutivos.prefijo_prefijo_id_seq', 10, true);


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 227
-- Name: usuario_usuario_id_seq; Type: SEQUENCE SET; Schema: consecutivos; Owner: postgres
--

SELECT pg_catalog.setval('consecutivos.usuario_usuario_id_seq', 164, true);


--
-- TOC entry 4659 (class 2606 OID 16528)
-- Name: gestion_consecutivo pk_gestion_consecutivo; Type: CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.gestion_consecutivo
    ADD CONSTRAINT pk_gestion_consecutivo PRIMARY KEY (consecutivo);


--
-- TOC entry 4661 (class 2606 OID 16530)
-- Name: historia_consecutivo pk_historia_consecutivo; Type: CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.historia_consecutivo
    ADD CONSTRAINT pk_historia_consecutivo PRIMARY KEY (consecutivo_id);


--
-- TOC entry 4663 (class 2606 OID 16532)
-- Name: opcion_por_perfil pk_opcion_por_perfil; Type: CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.opcion_por_perfil
    ADD CONSTRAINT pk_opcion_por_perfil PRIMARY KEY (opcion_id);


--
-- TOC entry 4665 (class 2606 OID 16534)
-- Name: perfil pk_perfil; Type: CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.perfil
    ADD CONSTRAINT pk_perfil PRIMARY KEY (perfil_id);


--
-- TOC entry 4669 (class 2606 OID 16536)
-- Name: prefijo pk_prefijo; Type: CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.prefijo
    ADD CONSTRAINT pk_prefijo PRIMARY KEY (prefijo_id);


--
-- TOC entry 4667 (class 2606 OID 16538)
-- Name: usuario pk_usuario; Type: CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (usuario_id);


--
-- TOC entry 4670 (class 2606 OID 16539)
-- Name: historia_consecutivo fk_historia_consecutivo_prefijo; Type: FK CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.historia_consecutivo
    ADD CONSTRAINT fk_historia_consecutivo_prefijo FOREIGN KEY (prefijo_id) REFERENCES consecutivos.prefijo(prefijo_id);


--
-- TOC entry 4671 (class 2606 OID 16544)
-- Name: historia_consecutivo fk_historia_consecutivo_usuario; Type: FK CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.historia_consecutivo
    ADD CONSTRAINT fk_historia_consecutivo_usuario FOREIGN KEY (usuario_id) REFERENCES consecutivos.usuario(usuario_id);


--
-- TOC entry 4672 (class 2606 OID 16549)
-- Name: opcion_por_perfil fk_opcion_por_perfil_perfil; Type: FK CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.opcion_por_perfil
    ADD CONSTRAINT fk_opcion_por_perfil_perfil FOREIGN KEY (perfil_id) REFERENCES consecutivos.perfil(perfil_id);


--
-- TOC entry 4673 (class 2606 OID 16554)
-- Name: perfil_usuario fk_perfil_usuario_perfil; Type: FK CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.perfil_usuario
    ADD CONSTRAINT fk_perfil_usuario_perfil FOREIGN KEY (perfil_id) REFERENCES consecutivos.perfil(perfil_id);


--
-- TOC entry 4674 (class 2606 OID 16559)
-- Name: perfil_usuario fk_perfil_usuario_usuario; Type: FK CONSTRAINT; Schema: consecutivos; Owner: postgres
--

ALTER TABLE ONLY consecutivos.perfil_usuario
    ADD CONSTRAINT fk_perfil_usuario_usuario FOREIGN KEY (usuario_id) REFERENCES consecutivos.usuario(usuario_id);


-- Completed on 2025-01-08 08:52:24

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-01-08 08:52:24

--
-- PostgreSQL database cluster dump complete
--

