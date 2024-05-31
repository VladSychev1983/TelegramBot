--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)

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
-- Name: chats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chats (
    id integer NOT NULL,
    chat_id integer NOT NULL
);


ALTER TABLE public.chats OWNER TO postgres;

--
-- Name: chats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chats_id_seq OWNER TO postgres;

--
-- Name: chats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chats_id_seq OWNED BY public.chats.id;


--
-- Name: english_words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.english_words (
    word_id integer NOT NULL,
    word character varying(255) NOT NULL
);


ALTER TABLE public.english_words OWNER TO postgres;

--
-- Name: english_words_word_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.english_words_word_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.english_words_word_id_seq OWNER TO postgres;

--
-- Name: english_words_word_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.english_words_word_id_seq OWNED BY public.english_words.word_id;


--
-- Name: history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.history (
    id integer NOT NULL,
    word_id integer NOT NULL,
    chat_id integer NOT NULL,
    answer boolean,
    count_times integer,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.history OWNER TO postgres;

--
-- Name: history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.history_id_seq OWNER TO postgres;

--
-- Name: history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;


--
-- Name: russian_words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.russian_words (
    word_id integer NOT NULL,
    word character varying(255) NOT NULL
);


ALTER TABLE public.russian_words OWNER TO postgres;

--
-- Name: russian_words_word_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.russian_words_word_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.russian_words_word_id_seq OWNER TO postgres;

--
-- Name: russian_words_word_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.russian_words_word_id_seq OWNED BY public.russian_words.word_id;


--
-- Name: translation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.translation (
    id integer NOT NULL,
    en_word_id integer NOT NULL,
    ru_word_id integer NOT NULL
);


ALTER TABLE public.translation OWNER TO postgres;

--
-- Name: translation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.translation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.translation_id_seq OWNER TO postgres;

--
-- Name: translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.translation_id_seq OWNED BY public.translation.id;


--
-- Name: user_words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_words (
    id integer NOT NULL,
    chat_id integer NOT NULL,
    ru_word character varying(255) NOT NULL,
    en_word character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.user_words OWNER TO postgres;

--
-- Name: user_words_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_words_id_seq OWNER TO postgres;

--
-- Name: user_words_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_words_id_seq OWNED BY public.user_words.id;


--
-- Name: chats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chats ALTER COLUMN id SET DEFAULT nextval('public.chats_id_seq'::regclass);


--
-- Name: english_words word_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.english_words ALTER COLUMN word_id SET DEFAULT nextval('public.english_words_word_id_seq'::regclass);


--
-- Name: history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);


--
-- Name: russian_words word_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.russian_words ALTER COLUMN word_id SET DEFAULT nextval('public.russian_words_word_id_seq'::regclass);


--
-- Name: translation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.translation ALTER COLUMN id SET DEFAULT nextval('public.translation_id_seq'::regclass);


--
-- Name: user_words id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_words ALTER COLUMN id SET DEFAULT nextval('public.user_words_id_seq'::regclass);


--
-- Data for Name: chats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chats (id, chat_id) FROM stdin;
7	307108722
\.


--
-- Data for Name: english_words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.english_words (word_id, word) FROM stdin;
1	Peace
2	Boy
3	Girl
4	Tree
5	Car
6	Leaf
7	Victory
8	War
9	Family
10	House
\.


--
-- Data for Name: history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.history (id, word_id, chat_id, answer, count_times, created_at) FROM stdin;
\.


--
-- Data for Name: russian_words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.russian_words (word_id, word) FROM stdin;
1	Мир
2	Мальчик
3	Девочка
4	Дерево
5	Машина
6	Лист
7	Победа
8	Война
9	Семья
10	Дом
\.


--
-- Data for Name: translation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.translation (id, en_word_id, ru_word_id) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	5
6	6	6
7	7	7
8	8	8
9	9	9
10	10	10
\.


--
-- Data for Name: user_words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_words (id, chat_id, ru_word, en_word, created_at) FROM stdin;
7	307108722	Любовь	Love	2024-05-31 18:04:04.557477
8	307108722	Песня	Song	2024-05-31 18:04:29.203504
9	307108722	Пятница	Friday	2024-05-31 18:05:04.565666
10	307108722	Жизнь	Life	2024-05-31 18:05:24.216267
\.


--
-- Name: chats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chats_id_seq', 7, true);


--
-- Name: english_words_word_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.english_words_word_id_seq', 10, true);


--
-- Name: history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.history_id_seq', 1, false);


--
-- Name: russian_words_word_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.russian_words_word_id_seq', 10, true);


--
-- Name: translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.translation_id_seq', 10, true);


--
-- Name: user_words_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_words_id_seq', 10, true);


--
-- Name: chats chats_chat_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_chat_id_key UNIQUE (chat_id);


--
-- Name: chats chats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- Name: english_words english_words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.english_words
    ADD CONSTRAINT english_words_pkey PRIMARY KEY (word_id);


--
-- Name: english_words english_words_word_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.english_words
    ADD CONSTRAINT english_words_word_key UNIQUE (word);


--
-- Name: history history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);


--
-- Name: russian_words russian_words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.russian_words
    ADD CONSTRAINT russian_words_pkey PRIMARY KEY (word_id);


--
-- Name: russian_words russian_words_word_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.russian_words
    ADD CONSTRAINT russian_words_word_key UNIQUE (word);


--
-- Name: translation translation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.translation
    ADD CONSTRAINT translation_pkey PRIMARY KEY (id);


--
-- Name: user_words user_words_en_word_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_en_word_key UNIQUE (en_word);


--
-- Name: user_words user_words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_pkey PRIMARY KEY (id);


--
-- Name: user_words user_words_ru_word_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_ru_word_key UNIQUE (ru_word);


--
-- Name: history history_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.chats(chat_id);


--
-- Name: history history_word_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_word_id_fkey FOREIGN KEY (word_id) REFERENCES public.russian_words(word_id);


--
-- Name: translation translation_en_word_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.translation
    ADD CONSTRAINT translation_en_word_id_fkey FOREIGN KEY (en_word_id) REFERENCES public.english_words(word_id);


--
-- Name: translation translation_ru_word_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.translation
    ADD CONSTRAINT translation_ru_word_id_fkey FOREIGN KEY (ru_word_id) REFERENCES public.russian_words(word_id);


--
-- Name: user_words user_words_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.chats(chat_id);


--
-- PostgreSQL database dump complete
--

