--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2026-10-19 15:09:02

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 28486)
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    title character varying(500) NOT NULL,
    adh_created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    adh_created_by character varying(255),
    adh_updated_date timestamp with time zone,
    adh_updated_by character varying(255)
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 28500)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    conversation_id uuid NOT NULL,
    message_role character varying(20) NOT NULL,
    message text NOT NULL,
    adh_created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    adh_created_by character varying(255),
    adh_updated_date timestamp with time zone,
    adh_updated_by character varying(255),
    CONSTRAINT chk_message_role CHECK (((message_role)::text = ANY ((ARRAY['user'::character varying, 'assistant'::character varying])::text[])))
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 28475)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email character varying(255) NOT NULL,
    adh_created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    adh_created_by character varying(255),
    adh_updated_date timestamp with time zone,
    adh_updated_by character varying(255),
    profile_name character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 4758 (class 2606 OID 28494)
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- TOC entry 4763 (class 2606 OID 28509)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- TOC entry 4754 (class 2606 OID 28485)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4756 (class 2606 OID 28483)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4759 (class 1259 OID 28515)
-- Name: idx_conversations_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_conversations_user_id ON public.conversations USING btree (user_id);


--
-- TOC entry 4760 (class 1259 OID 28516)
-- Name: idx_messages_conversation_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_conversation_id ON public.messages USING btree (conversation_id);


--
-- TOC entry 4761 (class 1259 OID 28517)
-- Name: idx_messages_created_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_created_date ON public.messages USING btree (adh_created_date);


--
-- TOC entry 4764 (class 2606 OID 28495)
-- Name: conversations fk_conversations_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fk_conversations_users FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4765 (class 2606 OID 28510)
-- Name: messages fk_messages_conversations; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_messages_conversations FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE;


-- Completed on 2026-10-19 15:09:02

--
-- PostgreSQL database dump complete
--

