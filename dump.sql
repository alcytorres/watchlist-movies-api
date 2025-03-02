--
-- PostgreSQL database dump
--

-- Dumped from database version 14.14 (Homebrew)
-- Dumped by pg_dump version 14.14 (Homebrew)

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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: alcytorres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO alcytorres;

--
-- Name: favorite_movies; Type: TABLE; Schema: public; Owner: alcytorres
--

CREATE TABLE public.favorite_movies (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint NOT NULL,
    movie_id bigint NOT NULL
);


ALTER TABLE public.favorite_movies OWNER TO alcytorres;

--
-- Name: favorite_movies_id_seq; Type: SEQUENCE; Schema: public; Owner: alcytorres
--

CREATE SEQUENCE public.favorite_movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorite_movies_id_seq OWNER TO alcytorres;

--
-- Name: favorite_movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alcytorres
--

ALTER SEQUENCE public.favorite_movies_id_seq OWNED BY public.favorite_movies.id;


--
-- Name: movies; Type: TABLE; Schema: public; Owner: alcytorres
--

CREATE TABLE public.movies (
    id bigint NOT NULL,
    title character varying,
    image_url character varying,
    description character varying,
    director character varying,
    release_year integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    imdb_id character varying,
    streaming_services json
);


ALTER TABLE public.movies OWNER TO alcytorres;

--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: alcytorres
--

CREATE SEQUENCE public.movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_id_seq OWNER TO alcytorres;

--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alcytorres
--

ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: alcytorres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO alcytorres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: alcytorres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    password_digest character varying,
    admin boolean,
    image_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO alcytorres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: alcytorres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO alcytorres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alcytorres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: watchlist_movies; Type: TABLE; Schema: public; Owner: alcytorres
--

CREATE TABLE public.watchlist_movies (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    movie_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.watchlist_movies OWNER TO alcytorres;

--
-- Name: watchlist_movies_id_seq; Type: SEQUENCE; Schema: public; Owner: alcytorres
--

CREATE SEQUENCE public.watchlist_movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watchlist_movies_id_seq OWNER TO alcytorres;

--
-- Name: watchlist_movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alcytorres
--

ALTER SEQUENCE public.watchlist_movies_id_seq OWNED BY public.watchlist_movies.id;


--
-- Name: favorite_movies id; Type: DEFAULT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.favorite_movies ALTER COLUMN id SET DEFAULT nextval('public.favorite_movies_id_seq'::regclass);


--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: watchlist_movies id; Type: DEFAULT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.watchlist_movies ALTER COLUMN id SET DEFAULT nextval('public.watchlist_movies_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: alcytorres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2024-07-11 18:14:45.319728	2024-07-11 18:14:45.31973
\.


--
-- Data for Name: favorite_movies; Type: TABLE DATA; Schema: public; Owner: alcytorres
--

COPY public.favorite_movies (id, created_at, updated_at, user_id, movie_id) FROM stdin;
134	2024-11-09 16:36:24.226381	2024-11-09 16:36:24.226381	1	145
136	2024-11-28 08:25:30.627809	2024-11-28 08:25:30.627809	1	195
137	2024-11-28 08:25:33.728288	2024-11-28 08:25:33.728288	1	119
138	2024-11-28 08:33:33.967834	2024-11-28 08:33:33.967834	1	200
139	2024-11-28 08:33:36.376478	2024-11-28 08:33:36.376478	1	201
140	2024-11-28 08:33:39.229333	2024-11-28 08:33:39.229333	1	197
141	2024-11-28 08:33:43.224582	2024-11-28 08:33:43.224582	1	199
142	2024-11-28 08:34:03.022938	2024-11-28 08:34:03.022938	1	196
143	2024-11-28 08:34:20.974657	2024-11-28 08:34:20.974657	1	192
145	2024-11-28 08:34:43.064803	2024-11-28 08:34:43.064803	1	198
146	2024-11-28 08:35:01.676897	2024-11-28 08:35:01.676897	1	152
147	2024-11-28 08:35:54.533452	2024-11-28 08:35:54.533452	1	189
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: alcytorres
--

COPY public.movies (id, title, image_url, description, director, release_year, created_at, updated_at, imdb_id, streaming_services) FROM stdin;
119	Beverly Hills Cop	https://image.tmdb.org/t/p/w500/eBJEvKkhQ0tUt1dBAcTEYW6kCle.jpg	Fast-talking, quick-thinking Detroit street cop Axel Foley has bent more than a few rules and regs in his time, but when his best friend is murdered, he heads to sunny Beverly Hills to work the case like only he can.	Martin Brest	1984	2024-09-24 22:01:14.576031	2024-09-24 22:01:14.576031	tt0086960	["paramount","other"]
126	2001: A Space Odyssey	https://image.tmdb.org/t/p/w500/ve72VxNqjGM69Uky4WTo2bK6rfq.jpg	Humanity finds a mysterious object buried beneath the lunar surface and sets off to find its origins with the help of HAL 9000, the world's most advanced super computer.	Stanley Kubrick	1968	2024-09-25 15:53:02.983024	2024-09-25 15:53:02.983024	tt0062622	["max","other"]
127	Lawrence of Arabia	https://image.tmdb.org/t/p/w500/AiAm0EtDvyGqNpVoieRw4u65vD1.jpg	The story of British officer T.E. Lawrence's mission to aid the Arab tribes in their revolt against the Ottoman Empire during the First World War. Lawrence becomes a flamboyant, messianic figure in the cause of Arab unity but his psychological instability threatens to undermine his achievements.	David Lean	1962	2024-09-25 15:53:16.815116	2024-09-25 15:53:16.815116	tt0056172	["amazon","other"]
128	North by Northwest	https://image.tmdb.org/t/p/w500/8gvfRlVpcKaTVqipXpYOGWBN1aO.jpg	Advertising man Roger Thornhill is mistaken for a spy, triggering a deadly cross-country chase.	Alfred Hitchcock	1959	2024-09-25 15:53:27.412811	2024-09-25 15:53:27.412811	tt0053125	[]
129	To Catch a Thief	https://image.tmdb.org/t/p/w500/cbMRkBGBgo3aLJK2M4MyicvkPLQ.jpg	An ex-thief is accused of enacting a new crime spree, so to clear his name he sets off to catch the new thief, who’s imitating his signature style.	Alfred Hitchcock	1955	2024-09-25 15:53:42.548417	2024-09-25 15:53:42.548417	tt0048728	["paramount","other"]
130	It's a Wonderful Life	https://image.tmdb.org/t/p/w500/bSqt9rhDZx1Q7UZ86dBPKdNomp2.jpg	A holiday favourite for generations...  George Bailey has spent his entire life giving to the people of Bedford Falls.  All that prevents rich skinflint Mr. Potter from taking over the entire town is George's modest building and loan company.  But on Christmas Eve the business's $8,000 is lost and George's troubles begin.	Frank Capra	1946	2024-09-25 15:53:58.846044	2024-09-25 15:53:58.846044	tt0038650	["amazon","other"]
132	Stagecoach	https://image.tmdb.org/t/p/w500/wsifrzutFIzt51FLVDbWW5AOTUG.jpg	A group of unlikely travelling companions find themselves on the same stagecoach to Cheyenne. They include a drunken doctor, a bar girl who's been thrown out of town, a professional gambler, a travelling liquor salesman, a banker who has decided to embezzle money, a gun-slinger out for revenge and a young woman going to join her army captain husband. All have secrets but when they are set upon by an Indian war party and then a family of outlaws, they find they must all work together if they are to stay alive.	Gordon Douglas	1966	2024-09-25 15:56:06.21253	2024-09-25 15:56:06.21253	tt0061024	[]
142	Batman Begins	https://image.tmdb.org/t/p/w500/4MpN4kIEqUjW8OPtOQJXlTdHiJV.jpg	Driven by tragedy, billionaire Bruce Wayne dedicates his life to uncovering and defeating the corruption that plagues his home, Gotham City.  Unable to work within the system, he instead creates a new identity, a symbol of fear for the criminal underworld - The Batman.	Christopher Nolan	2005	2024-10-20 20:53:19.191657	2024-10-20 20:53:19.191657	tt0372784	["max","other"]
143	Jaws	https://image.tmdb.org/t/p/w500/lxM6kqilAdpdhqUl2biYp5frUxE.jpg	When the seaside community of Amity finds itself under attack by a dangerous great white shark, the town's chief of police, a young marine biologist, and a grizzled hunter embark on a desperate quest to destroy the beast before it strikes again.	Steven Spielberg	1975	2024-10-20 20:53:34.077829	2024-10-20 20:53:34.077829	tt0073195	["netflix","other"]
144	Die Hard	https://image.tmdb.org/t/p/w500/7Bjd8kfmDSOzpmhySpEhkUyK2oH.jpg	NYPD cop John McClane's plan to reconcile with his estranged wife is thrown for a serious loop when, minutes after he arrives at her office, the entire building is overtaken by a group of terrorists. With little help from the LAPD, wisecracking McClane sets out to single-handedly rescue the hostages and bring the bad guys down.	John McTiernan	1988	2024-10-20 20:53:47.788195	2024-10-20 20:53:47.788195	tt0095016	["hulu","other"]
149	Argo	https://image.tmdb.org/t/p/w500/m5gPWFZFIp4UJFABgWyLkbXv8GX.jpg	As the Iranian revolution reaches a boiling point, a CIA 'exfiltration' specialist concocts a risky plan to free six Americans who have found shelter at the home of the Canadian ambassador.	Ben Affleck	2012	2024-10-21 03:32:54.877396	2024-10-21 03:32:54.877396	tt1024648	[]
154	Saving Private Ryan	https://image.tmdb.org/t/p/w500/uqx37cS8cpHg8U35f9U5IBlrCV3.jpg	As U.S. troops storm the beaches of Normandy, three brothers lie dead on the battlefield, with a fourth trapped behind enemy lines. Ranger captain John Miller and seven men are tasked with penetrating German-held territory and bringing the boy home.	Steven Spielberg	1998	2024-10-21 05:29:17.073397	2024-10-21 05:29:17.073397	tt0120815	["paramount","other"]
158	The Departed	https://image.tmdb.org/t/p/w500/nT97ifVT2J1yMQmeq20Qblg61T.jpg	To take down South Boston's Irish Mafia, the police send in one of their own to infiltrate the underworld, not realizing the syndicate has done likewise. While an undercover cop curries favor with the mob kingpin, a career criminal rises through the police ranks. But both sides soon discover there's a mole among them.	Martin Scorsese	2006	2024-10-21 17:57:02.339373	2024-10-21 17:57:02.339373	tt0407887	[]
163	Twisted	https://image.tmdb.org/t/p/w500/11YUiadbs5ZseoDqAHCZK5zoVYr.jpg	Recently promoted and transferred to the homicide division, Inspector Jessica Shepard feels pressure to prove herself -- and what better way than by solving San Francisco's latest murder? However, as Shepard and her partner, Mike Delmarco, soon discover, the victim shared a romantic connection to her. As more of Shepard's ex-lovers turn up dead, her mind starts to become unstable, and she begins to wonder if she could be the very killer she's trying to track down.	Philip Kaufman	2004	2024-10-27 23:57:00.581486	2024-10-27 23:57:00.581486	tt0315297	["netflix","paramount","other"]
166	The Batman	https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg	In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.	Matt Reeves	2022	2024-11-04 03:51:50.355011	2024-11-04 03:51:50.355011	tt1877830	["max","other"]
167	Batman & Robin	https://image.tmdb.org/t/p/w500/cGRDufDDSrFrv7VI4YnmWnslne0.jpg	Batman and Robin deal with relationship issues while preventing Mr. Freeze and Poison Ivy from attacking Gotham City.	Joel Schumacher	1997	2024-11-04 03:51:59.649351	2024-11-04 03:51:59.649351	tt0118688	["max","other"]
113	Rocky	https://image.tmdb.org/t/p/w500/cqxg1CihGR5ge0i1wYXr4Rdeppu.jpg	An uneducated collector for a Philadelphia loan shark is given a once-in-a-lifetime opportunity to fight against the world heavyweight boxing champion.	John G. Avildsen	1976	2024-09-24 21:58:48.698625	2024-09-24 21:58:48.698625	tt0075148	["amazon","other"]
114	Chinatown	https://image.tmdb.org/t/p/w500/1Wi1dgGRDmSETi4fZGWhRhQDSRj.jpg	Private eye Jake Gittes lives off of the murky moral climate of sunbaked, pre-World War II Southern California. Hired by a beautiful socialite to investigate her husband's extra-marital affair, Gittes is swept into a maelstrom of double dealings and deadly deceits, uncovering a web of personal and political scandals that come crashing together.	Roman Polanski	1974	2024-09-24 21:59:06.804266	2024-09-24 21:59:06.804266	tt0071315	["other"]
120	12 Angry Men	https://image.tmdb.org/t/p/w500/ow3wq89wM8qd5X7hWKxiRfsFf9C.jpg	The defense and the prosecution have rested and the jury is filing into the jury room to decide if a young Spanish-American is guilty or innocent of murdering his father. What begins as an open and shut case soon becomes a mini-drama of each of the jurors' prejudices and preconceptions about the trial, the accused, and each other.	Sidney Lumet	1957	2024-09-24 22:34:19.232841	2024-09-24 22:34:19.232841	tt0050083	["other"]
121	A Fistful of Dollars	https://image.tmdb.org/t/p/w500/lBwOEpwVeUAmrmglcstnaGcJq3Y.jpg	The Man With No Name enters the Mexican village of San Miguel in the midst of a power struggle among the three Rojo brothers and sheriff John Baxter. When a regiment of Mexican soldiers bearing gold intended to pay for new weapons is waylaid by the Rojo brothers, the stranger inserts himself into the middle of the long-simmering battle, selling false information to both sides for his own benefit.	Sergio Leone	1964	2024-09-24 22:34:32.267666	2024-09-24 22:34:32.267666	tt0058461	["other"]
131	Strangers on a Train	https://image.tmdb.org/t/p/w500/ihC083U7ef56Ui4x0P0dobojrZ1.jpg	Having met on a train, a smooth-talking psychotic socialite shares his theory on how two complete strangers can get away with murder to an amateur tennis player — a theory he plans to test out.	Alfred Hitchcock	1951	2024-09-25 15:55:01.714762	2024-09-25 15:55:01.714762	tt0044079	["other"]
133	The Lady Vanishes	https://image.tmdb.org/t/p/w500/7mJnCAi1DgAqYDyvA8xXBPxiTnR.jpg	On the eve of World War II, zany heiress Amanda Kelly travels by train to Switzerland. While passing through Germany, she meets a sweet elderly lady, who suddenly vanishes. Distraught, she questions her fellow passengers who claim that the woman was never there. Unsure if it's all in her mind or if there's a more sinister plot afoot, Amanda teams up with photographer Robert Condon to discover the truth.	Anthony Page	1979	2024-09-25 15:56:48.218718	2024-09-25 15:56:48.218718	tt0079428	[]
135	Predator	https://image.tmdb.org/t/p/w500/k3mW4qfJo6SKqe6laRyNGnbB9n5.jpg	A team of elite commandos on a secret mission in a Central American jungle come to find themselves hunted by an extraterrestrial warrior.	John McTiernan	1987	2024-09-29 00:54:40.218808	2024-09-29 00:54:40.218808	tt0093773	["hulu","other"]
138	Jaws 2	https://image.tmdb.org/t/p/w500/cN3ijEwsn4kBaRuHfcJpAQJbeWe.jpg	Police chief Brody must protect the citizens of Amity after a second monstrous shark begins terrorizing the waters.	Jeannot Szwarc	1978	2024-10-18 12:36:14.897538	2024-10-18 12:36:14.897538	tt0077766	["netflix","other"]
145	Avatar	https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg	In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.	James Cameron	2009	2024-10-20 20:57:39.526178	2024-10-20 20:57:39.526178	tt0499549	["disney"]
146	Beverly Hills Cop	https://image.tmdb.org/t/p/w500/eBJEvKkhQ0tUt1dBAcTEYW6kCle.jpg	Fast-talking, quick-thinking Detroit street cop Axel Foley has bent more than a few rules and regs in his time, but when his best friend is murdered, he heads to sunny Beverly Hills to work the case like only he can.	Martin Brest	1984	2024-10-20 21:00:12.811066	2024-10-20 21:00:12.811066	tt0086960	["paramount","other"]
150	Vertigo	https://image.tmdb.org/t/p/w500/15uOEfqBNTVtDUT7hGBVCka0rZz.jpg	A retired San Francisco detective suffering from acrophobia investigates the strange activities of an old friend's wife, all the while becoming dangerously obsessed with her.	Alfred Hitchcock	1958	2024-10-21 04:35:33.148793	2024-10-21 04:35:33.148793	tt0052357	[]
151	Duel	https://image.tmdb.org/t/p/w500/w9Vk1Txx14vWvACELFYFlixrsfr.jpg	Traveling businessman David Mann angers the driver of a rusty tanker while crossing the California desert. A simple trip turns deadly, as Mann struggles to stay on the road while the tanker plays cat and mouse with his life.	Steven Spielberg	1971	2024-10-21 04:37:58.056069	2024-10-21 04:37:58.056069	tt0067023	[]
155	City of God	https://image.tmdb.org/t/p/w500/k7eYdWvhYQyRQoU2TB2A2Xu2TfD.jpg	In the poverty-stricken favelas of Rio de Janeiro in the 1970s, two young men choose different paths. Rocket is a budding photographer who documents the increasing drug-related violence of his neighborhood, while José “Zé” Pequeno is an ambitious drug dealer diving into a dangerous life of crime.	Fernando Meirelles	2002	2024-10-21 17:40:04.758237	2024-10-21 17:40:04.758237	tt0317248	["other"]
187	Stagecoach	https://image.tmdb.org/t/p/w500/b4RUzWOalyPbUu66TT147b5iR0M.jpg	A group of people traveling on a stagecoach find their journey complicated by the threat of Geronimo, and learn something about each other in the process.	John Ford	1939	2024-11-08 17:13:27.327754	2024-11-08 17:13:27.327754	tt0031971	["amazon","other"]
106	Casablanca	https://image.tmdb.org/t/p/w500/5K7cOHoay2mZusSLezBOY0Qxh8a.jpg	In Casablanca, Morocco in December 1941, a cynical American expatriate meets a former lover, with unforeseen complications.	Michael Curtiz	1943	2024-09-23 23:57:14.280206	2024-09-23 23:57:14.280206	tt0034583	["max","other"]
108	Batman Begins	https://image.tmdb.org/t/p/w500/4MpN4kIEqUjW8OPtOQJXlTdHiJV.jpg	Driven by tragedy, billionaire Bruce Wayne dedicates his life to uncovering and defeating the corruption that plagues his home, Gotham City.  Unable to work within the system, he instead creates a new identity, a symbol of fear for the criminal underworld - The Batman.	Christopher Nolan	2005	2024-09-23 23:57:55.11681	2024-09-23 23:57:55.11681	tt0372784	["max","other"]
109	Jaws	https://image.tmdb.org/t/p/w500/lxM6kqilAdpdhqUl2biYp5frUxE.jpg	When the seaside community of Amity finds itself under attack by a dangerous great white shark, the town's chief of police, a young marine biologist, and a grizzled hunter embark on a desperate quest to destroy the beast before it strikes again.	Steven Spielberg	1975	2024-09-23 23:58:41.88144	2024-09-23 23:58:41.88144	tt0073195	["netflix","other"]
110	Once Upon a Time in the West	https://image.tmdb.org/t/p/w500/qbYgqOczabWNn2XKwgMtVrntD6P.jpg	As the railroad builders advance unstoppably through the Arizona desert on their way to the sea, Jill arrives in the small town of Flagstone with the intention of starting a new life.	Sergio Leone	1968	2024-09-24 00:01:53.487705	2024-09-24 00:01:53.487705	tt0064116	["amazon","other"]
115	The Deer Hunter	https://image.tmdb.org/t/p/w500/bbGtogDZOg09bm42KIpCXUXICkh.jpg	A group of working-class friends decide to enlist in the Army during the Vietnam War and finds it to be hellish chaos -- not the noble venture they imagined. Before they left, Steven married his pregnant girlfriend -- and Michael and Nick were in love with the same woman. But all three are different men upon their return.	Michael Cimino	1978	2024-09-24 22:00:09.422918	2024-09-24 22:00:09.422918	tt0077416	["netflix","other"]
117	The Thing	https://image.tmdb.org/t/p/w500/tzGY49kseSE9QAKk47uuDGwnSCu.jpg	In the winter of 1982, a twelve-man research team at a remote Antarctic research station discovers an alien buried in the snow for over 100,000 years. Soon unfrozen, the form-changing creature wreaks havoc, creates terror... and becomes one of them.	John Carpenter	1982	2024-09-24 22:00:28.922357	2024-09-24 22:00:28.922357	tt0084787	["other"]
118	The Terminator	https://image.tmdb.org/t/p/w500/qvktm0BHcnmDpul4Hz01GIazWPr.jpg	In the post-apocalyptic future, reigning tyrannical supercomputers teleport a cyborg assassin known as the "Terminator" back to 1984 to kill Sarah Connor, whose unborn son is destined to lead insurgents against 21st century mechanical hegemony. Meanwhile, the human-resistance movement dispatches a lone warrior to safeguard Sarah. Can he stop the virtually indestructible killing machine?	James Cameron	1984	2024-09-24 22:00:46.143529	2024-09-24 22:00:46.143529	tt0088247	["other"]
122	Butch Cassidy and the Sundance Kid	https://image.tmdb.org/t/p/w500/gFmmykF1Ym3OGzENo50nZQaD1dx.jpg	In late 1890s Wyoming, Butch Cassidy is the affable, clever and talkative leader of the outlaw Hole in the Wall Gang. His closest companion is the laconic dead-shot Sundance Kid. As the west rapidly becomes civilized, the law finally catches up to Butch, Sundance and their gang.  Chased doggedly by a special posse, the two decide to make their way to South America in hopes of evading their pursuers once and for all.	George Roy Hill	1969	2024-09-25 01:18:09.069371	2024-09-25 01:18:09.069371	tt0064115	["other"]
134	Avatar: The Way of Water	https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg	Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.	James Cameron	2022	2024-09-25 16:17:24.476183	2024-09-25 16:17:24.476183	tt1630029	["disney"]
136	Alien	https://image.tmdb.org/t/p/w500/vfrQk5IPloGg1v9Rzbh2Eg3VGyM.jpg	During its return to the earth, commercial spaceship Nostromo intercepts a distress signal from a distant planet. When a three-member team of the crew discovers a chamber containing thousands of eggs on the planet, a creature inside one of the eggs attacks an explorer. The entire crew is unaware of the impending nightmare set to descend upon them when the alien parasite planted inside its unfortunate host is birthed.	Ridley Scott	1979	2024-09-29 03:06:39.543907	2024-09-29 03:06:39.543907	tt0078748	["hulu"]
137	Spider-Man 3	https://image.tmdb.org/t/p/w500/qFmwhVUoUSXjkKRmca5yGDEXBIj.jpg	The seemingly invincible Spider-Man goes up against an all-new crop of villains—including the shape-shifting Sandman. While Spider-Man’s superpowers are altered by an alien organism, his alter ego, Peter Parker, deals with nemesis Eddie Brock and also gets caught up in a love triangle.	Sam Raimi	2007	2024-09-29 03:07:05.235165	2024-09-29 03:07:05.235165	tt0413300	["disney","other"]
139	Unforgiven	https://image.tmdb.org/t/p/w500/54roTwbX9fltg85zjsmrooXAs12.jpg	William Munny is a retired, once-ruthless killer turned gentle widower and hog farmer. To help support his two motherless children, he accepts one last bounty-hunter mission to find the men who brutalized a prostitute. Joined by his former partner and a cocky greenhorn, he takes on a corrupt sheriff.	Clint Eastwood	1992	2024-10-18 13:45:20.286537	2024-10-18 13:45:20.286537	tt0105695	[]
147	Avatar: The Way of Water	https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg	Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.	James Cameron	2022	2024-10-20 21:11:01.750927	2024-10-20 21:11:01.750927	tt1630029	["disney"]
152	The Shawshank Redemption	https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg	Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.	Frank Darabont	1994	2024-10-21 04:51:49.759349	2024-10-21 04:51:49.759349	tt0111161	[]
156	The Green Mile	https://image.tmdb.org/t/p/w500/8VG8fDNiy50H4FedGwdSVUPoaJe.jpg	A supernatural tale set on death row in a Southern prison, where gentle giant John Coffey possesses the mysterious power to heal people's ailments. When the cell block's head guard, Paul Edgecomb, recognizes Coffey's miraculous gift, he tries desperately to help stave off the condemned man's execution.	Frank Darabont	1999	2024-10-21 17:46:17.848323	2024-10-21 17:46:17.848323	tt0120689	[]
159	Avengers: Infinity War	https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg	As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.	Joe Russo	2018	2024-10-21 19:54:58.046451	2024-10-21 19:54:58.046451	tt4154756	["disney","other"]
160	The Shining	https://image.tmdb.org/t/p/w500/xazWoLealQwEgqZ89MLZklLZD3k.jpg	Jack Torrance accepts a caretaker job at the Overlook Hotel, where he, along with his wife Wendy and their son Danny, must live isolated from the rest of the world for the winter. But they aren't prepared for the madness that lurks within.	Stanley Kubrick	1980	2024-10-21 19:56:13.721745	2024-10-21 19:56:13.721745	tt0081505	["max","other"]
111	Avatar	https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg	In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.	James Cameron	2009	2024-09-24 03:49:04.270857	2024-09-24 03:49:04.270857	tt0499549	["disney"]
161	Toy Story	https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg	Led by Woody, Andy's toys live happily in his room until Andy's birthday brings Buzz Lightyear onto the scene. Afraid of losing his place in Andy's heart, Woody plots against Buzz. But when circumstances separate Buzz and Woody from their owner, the duo eventually learns to put aside their differences.	John Lasseter	1995	2024-10-21 19:57:21.990529	2024-10-21 19:57:21.990529	tt0114709	["disney"]
168	The Lego Batman Movie	https://image.tmdb.org/t/p/w500/snGwr2gag4Fcgx2OGmH9otl6ofW.jpg	A cooler-than-ever Bruce Wayne must deal with the usual suspects as they plan to rule Gotham City, while discovering that he has accidentally adopted a teenage orphan who wishes to become his sidekick.	Chris McKay	2017	2024-11-04 03:56:38.315768	2024-11-04 03:56:38.315768	tt4116284	["hulu","other"]
169	Batman: Mask of the Phantasm	https://image.tmdb.org/t/p/w500/hT4ehUteagUrhUOHAtmYiY7mp5l.jpg	Andrea Beaumont leaves her father to return to Gotham, rekindling an old romance with Bruce Wayne. At the same time, a mysterious figure begins to hunt down Gotham's criminals, wrongly implicating Batman in the murders. Now on the run from the law, Batman must find and stop the culprit, while also navigating his relationship with Andrea.	Bruce Timm	1993	2024-11-04 03:59:44.879273	2024-11-04 03:59:44.879273	tt0106364	[]
172	Batman: The Dark Knight Returns, Part 1	https://image.tmdb.org/t/p/w500/kkjTbwV1Xnj8wBL52PjOcXzTbnb.jpg	Batman has not been seen for ten years. A new breed of criminal ravages Gotham City, forcing 55-year-old Bruce Wayne back into the cape and cowl. But, does he still have what it takes to fight crime in a new era?	Jay Oliva	2012	2024-11-04 18:01:41.644813	2024-11-04 18:01:41.644813	tt2313197	[]
173	Batman: The Killing Joke	https://image.tmdb.org/t/p/w500/ibgiQ1a1q4UBEjOcqZzsRPhRK0g.jpg	As Batman hunts for the escaped Joker, the Clown Prince of Crime attacks the Gordon family to prove a diabolical point mirroring his own fall into madness.	Sam Liu	2016	2024-11-04 18:01:48.788468	2024-11-04 18:01:48.788468	tt4853102	[]
140	Inception	https://image_url.com/inception	A mind-bending thriller	Christopher Nolan	2010	2024-10-20 20:31:38.22312	2024-10-20 20:31:38.22312	tt1375666	\N
141	Inception	https://image_url.com/inception	A mind-bending thriller	Christopher Nolan	2010	2024-10-20 20:36:07.39174	2024-10-20 20:36:07.39174	tt1375666	\N
153	GoodFellas	https://image.tmdb.org/t/p/w500/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg	The true story of Henry Hill, a half-Irish, half-Sicilian Brooklyn kid who is adopted by neighbourhood gangsters at an early age and climbs the ranks of a Mafia family under the guidance of Jimmy Conway.	Martin Scorsese	1990	2024-10-21 05:11:08.896496	2024-10-21 05:11:08.896496	tt0099685	[]
157	Godzilla x Kong: The New Empire	https://image.tmdb.org/t/p/w500/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg	Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.	Adam Wingard	2024	2024-10-21 17:55:39.283965	2024-10-21 17:55:39.283965	tt14539740	["max","other"]
162	Braveheart	https://image.tmdb.org/t/p/w500/or1gBugydmjToAEq7OZY0owwFk.jpg	Enraged at the slaughter of Murron, his new bride and childhood love, Scottish warrior William Wallace slays a platoon of the local English lord's soldiers. This leads the village to revolt and, eventually, the entire country to rise up against English rule.	Mel Gibson	1995	2024-10-22 22:13:42.725971	2024-10-22 22:13:42.725971	tt0112573	["paramount","other"]
164	The Lord of the Rings: The Return of the King	https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg	As armies mass for a final battle that will decide the fate of the world--and powerful, ancient forces of Light and Dark compete to determine the outcome--one member of the Fellowship of the Ring is revealed as the noble heir to the throne of the Kings of Men. Yet, the sole hope for triumph over evil lies with a brave hobbit, Frodo, who, accompanied by his loyal friend Sam and the hideous, wretched Gollum, ventures deep into the very dark heart of Mordor on his seemingly impossible quest to destroy the Ring of Power.​	Peter Jackson	2003	2024-11-02 00:54:32.637297	2024-11-02 00:54:32.637297	tt0167260	["amazon","max","other"]
165	Batman	https://image.tmdb.org/t/p/w500/cij4dd21v2Rk2YtUQbV5kW69WB2.jpg	Batman must face his most ruthless nemesis when a deformed madman calling himself "The Joker" seizes control of Gotham's criminal underworld.	Tim Burton	1989	2024-11-04 03:34:24.228446	2024-11-04 03:34:24.228446	tt0096895	["max","other"]
112	Taxi Driver	https://image.tmdb.org/t/p/w500/ekstpH614fwDX8DUln1a2Opz0N8.jpg	A mentally unstable Vietnam War veteran works as a night-time taxi driver in New York City where the perceived decadence and sleaze feed his urge for violent action.	Martin Scorsese	1976	2024-09-24 21:57:24.816636	2024-09-24 21:57:24.816636	tt0075314	["amazon","other"]
170	Batman	https://image.tmdb.org/t/p/w500/AvzD3mrtokIzZOiV6zAG7geIo6F.jpg	Japanese master spy Daka operates a covert espionage-sabotage organization located in Gotham City's now-deserted Little Tokyo, which turns American scientists into pliable zombies. The great crime-fighters Batman and Robin, with the help of their allies, are in pursuit.	Lambert Hillyer	1943	2024-11-04 04:05:53.024786	2024-11-04 04:05:53.024786	tt0035665	[]
171	Batman v Superman: Dawn of Justice	https://image.tmdb.org/t/p/w500/5UsK3grJvtQrtzEgqNlDljJW96w.jpg	Fearing the actions of a god-like Super Hero left unchecked, Gotham City’s own formidable, forceful vigilante takes on Metropolis’s most revered, modern-day savior, while the world wrestles with what sort of hero it really needs. And with Batman and Superman at war with one another, a new threat quickly arises, putting mankind in greater danger than it’s ever known before.	Zack Snyder	2016	2024-11-04 04:06:34.763221	2024-11-04 04:06:34.763221	tt2975590	["max","other"]
174	Batman and Superman: Battle of the Super Sons	https://image.tmdb.org/t/p/w500/mvffaexT5kA3chOnGxwBSlRoshh.jpg	After discovering he has powers, 11-year-old Jonathan Kent and assassin-turned-Boy-Wonder Damian Wayne must join forces to rescue their fathers (Superman & Batman) and save the planet from the malevolent alien force known as Starro.	Matt Peters	2022	2024-11-04 18:02:00.083399	2024-11-04 18:02:00.083399	tt21197740	["max","other"]
175	Batman Returns	https://image.tmdb.org/t/p/w500/jKBjeXM7iBBV9UkUcOXx3m7FSHY.jpg	Batman must face The Penguin, a sewer-dwelling gangleader intent on being accepted into Gotham society.  Meanwhile, another Gotham resident finds herself transformed into Catwoman and is out for revenge...	Tim Burton	1992	2024-11-04 18:02:17.460871	2024-11-04 18:02:17.460871	tt0103776	["max","other"]
176	Batman Forever	https://image.tmdb.org/t/p/w500/mzzNBVwTiiY94xAXDMWJpNPW2US.jpg	Batman must battle a disfigured district attorney and a disgruntled former employee with help from an amorous psychologist and a young circus acrobat.	Joel Schumacher	1995	2024-11-04 18:02:46.034461	2024-11-04 18:02:46.034461	tt0112462	["max","other"]
177	Batman Ninja vs. Yakuza League	https://image.tmdb.org/t/p/w500/aEsqIZHA7AqJfLtcUkQdZrGYlm6.jpg	Sequel film to Batman Ninja (2018)	Jumpei Mizusaki	\N	2024-11-04 18:03:16.107663	2024-11-04 18:03:16.107663	tt32508210	[]
178	Batman: The Doom That Came to Gotham	https://image.tmdb.org/t/p/w500/dzPNQXI8FlpXTGGp1082RJ8OQoT.jpg	Explorer Bruce Wayne accidentally unleashes an ancient evil, and returns to Gotham after being away for two decades. There, Batman battles Lovecraftian supernatural forces and encounters allies and enemies such as Green Arrow, Ra's al Ghul, Mr. Freeze, Killer Croc, Two-Face and James Gordon.	Sam Liu	2023	2024-11-04 18:03:19.804909	2024-11-04 18:03:19.804909	tt24223450	["max","other"]
179	Batman Ninja	https://image.tmdb.org/t/p/w500/5xSB0Npkc9Fd9kahKBsq9P4Cdzp.jpg	Batman, along with many of his allies and adversaries, finds himself transported to feudal Japan by Gorilla Grodd's time displacement machine.	Jumpei Mizusaki	2018	2024-11-04 18:03:29.915704	2024-11-04 18:03:29.915704	tt7451284	[]
180	Batman: The Dark Knight Returns, Part 2	https://image.tmdb.org/t/p/w500/arEZYd6uMOFTILne9Ux0A8qctMe.jpg	Batman has stopped the reign of terror that The Mutants had cast upon his city.  Now an old foe wants a reunion and the government wants The Man of Steel to put a stop to Batman.	Jay Oliva	2013	2024-11-04 18:03:34.654332	2024-11-04 18:03:34.654332	tt2166834	[]
181	Batman: The Long Halloween, Part Two	https://image.tmdb.org/t/p/w500/f46QMSo2wAVY1ywrNc9yZv0rkNy.jpg	As Gotham City's young vigilante, the Batman, struggles to pursue a brutal serial killer, district attorney Harvey Dent gets caught in a feud involving the criminal family of the Falcones.	Chris Palmer	2021	2024-11-04 18:03:40.735445	2024-11-04 18:03:40.735445	tt14402926	[]
182	Batman: Hush	https://image.tmdb.org/t/p/w500/eiVQORVyVuNNZHPAELuWtlXoQsD.jpg	A mysterious new villain known only as Hush uses a gallery of villains to destroy Batman's crime-fighting career as well as Bruce Wayne's personal life, which has been further complicated by a relationship with Selina Kyle/Catwoman.	Justin Copeland	2019	2024-11-04 18:03:45.904068	2024-11-04 18:03:45.904068	tt8752440	[]
183	Batman	https://image.tmdb.org/t/p/w500/zzoPxWHnPa0eyfkMLgwbNvdEcVF.jpg	The Dynamic Duo faces four super-villains who plan to hold the world for ransom with the help of a secret invention that instantly dehydrates people.	Leslie H. Martinson	1966	2024-11-04 18:11:27.491005	2024-11-04 18:11:27.491005	tt0060153	[]
188	Blade Runner	https://image.tmdb.org/t/p/w500/63N9uy8nd9j7Eog2axPQ8lbr3Wj.jpg	In the smog-choked dystopian Los Angeles of 2019, blade runner Rick Deckard is called out of retirement to terminate a quartet of replicants who have escaped to Earth seeking their creator for a way to extend their short life spans.	Ridley Scott	1982	2024-11-28 08:06:41.637608	2024-11-28 08:06:41.637608	tt0083658	[]
184	The Avengers	https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg	When an unexpected enemy emerges and threatens global safety and security, Nick Fury, director of the international peacekeeping agency known as S.H.I.E.L.D., finds himself in need of a team to pull the world back from the brink of disaster. Spanning the globe, a daring recruitment effort begins!	Joss Whedon	2012	2024-11-05 03:50:57.199154	2024-11-05 03:50:57.199154	tt0848228	["disney"]
185	Avengers: Endgame	https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg	After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos. With the help of remaining allies, the Avengers must assemble once more in order to undo Thanos' actions and restore order to the universe once and for all, no matter what consequences may be in store.	Joe Russo	2019	2024-11-05 03:51:00.120908	2024-11-05 03:51:00.120908	tt4154796	["disney","other"]
186	Avengers: Age of Ultron	https://image.tmdb.org/t/p/w500/4ssDuvEDkSArWEdyBl2X5EHvYKU.jpg	When Tony Stark tries to jumpstart a dormant peacekeeping program, things go awry and Earth’s Mightiest Heroes are put to the ultimate test as the fate of the planet hangs in the balance. As the villainous Ultron emerges, it is up to The Avengers to stop him from enacting his terrible plans, and soon uneasy alliances and unexpected action pave the way for an epic and unique global adventure.	Joss Whedon	2015	2024-11-05 03:51:02.747099	2024-11-05 03:51:02.747099	tt2395427	["disney","other"]
189	Casino Royale	https://image.tmdb.org/t/p/w500/lMrxYKKhd4lqRzwUHAy5gcx9PSO.jpg	Le Chiffre, a banker to the world's terrorists, is scheduled to participate in a high-stakes poker game in Montenegro, where he intends to use his winnings to establish his financial grip on the terrorist market. M sends Bond—on his maiden mission as a 00 Agent—to attend this game and prevent Le Chiffre from winning. With the help of Vesper Lynd and Felix Leiter, Bond enters the most important poker game in his already dangerous career.	Martin Campbell	2006	2024-11-28 08:14:33.289138	2024-11-28 08:14:33.289138	tt0381061	["other"]
190	There Will Be Blood	https://image.tmdb.org/t/p/w500/fa0RDkAlCec0STeMNAhPaF89q6U.jpg	Ruthless silver miner, turned oil prospector, Daniel Plainview, moves to oil-rich California. Using his son to project a trustworthy, family-man image, Plainview cons local landowners into selling him their valuable properties for a pittance. However, local preacher Eli Sunday suspects Plainview's motives and intentions, starting a slow-burning feud that threatens both their lives.	Paul Thomas Anderson	2007	2024-11-28 08:15:35.456765	2024-11-28 08:15:35.456765	tt0469494	["paramount","other"]
191	Mamma Mia!	https://image.tmdb.org/t/p/w500/zdUA4FNHbXPadzVOJiU0Rgn6cHR.jpg	Donna Sheridan, an independent, single mother who owns a small hotel on a Greek island, is preparing for her daughter's wedding, along with the help of her two old friends, Tanya and Rosie. Meanwhile Sophie, the spirited bride, has a plan. She secretly invites three of her mother's ex-lovers - Sam, Harry, and Bill - in hope of finding her biological father and having him escort her down the aisle on her big day.	Phyllida Lloyd	2008	2024-11-28 08:16:40.346908	2024-11-28 08:16:40.346908	tt0795421	["max","other"]
192	La La Land	https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg	Mia, an aspiring actress, serves lattes to movie stars in between auditions and Sebastian, a jazz musician, scrapes by playing cocktail party gigs in dingy bars, but as success mounts they are faced with decisions that begin to fray the fragile fabric of their love affair, and the dreams they worked so hard to maintain in each other threaten to rip them apart.	Damien Chazelle	2016	2024-11-28 08:18:17.360475	2024-11-28 08:18:17.360475	tt3783958	["hulu"]
193	Singin' in the Rain	https://image.tmdb.org/t/p/w500/w03EiJVHP8Un77boQeE7hg9DVdU.jpg	In 1927 Hollywood, a silent film production company and cast make a difficult transition to sound.	Stanley Donen	1952	2024-11-28 08:19:16.271621	2024-11-28 08:19:16.271621	tt0045152	["max","other"]
194	Raiders of the Lost Ark	https://image.tmdb.org/t/p/w500/ceG9VzoRAVGwivFU403Wc3AHRys.jpg	When Dr. Indiana Jones – the tweed-suited professor who just happens to be a celebrated archaeologist – is hired by the government to locate the legendary Ark of the Covenant, he finds himself up against the entire Nazi regime.	Steven Spielberg	1981	2024-11-28 08:24:28.602051	2024-11-28 08:24:28.602051	tt0082971	["amazon","paramount","other"]
195	Broadcast News	https://image.tmdb.org/t/p/w500/kQNR1Lc0qAF5xuBySpDn481KVjb.jpg	Basket-case network news producer Jane Craig falls for new reporter Tom Grunnick, a pretty boy who represents the trend towards entertainment news she despises. Aaron Altman, a talented but plain correspondent, carries an unrequited torch for Jane. Sparks fly between the three as the network prepares for big changes, and both the news and Jane must decide between style and substance.	James L. Brooks	1987	2024-11-28 08:25:17.384508	2024-11-28 08:25:17.384508	tt0092699	["other"]
196	Total Recall	https://image.tmdb.org/t/p/w500/wVbeL6fkbTKSmNfalj4VoAUUqJv.jpg	Construction worker Douglas Quaid's obsession with the planet Mars leads him to visit Recall, a company that manufactures memories. When his memory implant goes wrong, Doug can no longer be sure what is and isn't reality.	Paul Verhoeven	1990	2024-11-28 08:26:38.372699	2024-11-28 08:26:38.372699	tt0100802	["other"]
197	Jurassic Park	https://image.tmdb.org/t/p/w500/oU7Oq2kFAAlGqbU4VoAE36g4hoI.jpg	A wealthy entrepreneur secretly creates a theme park featuring living dinosaurs drawn from prehistoric DNA. Before opening day, he invites a team of experts and his two eager grandchildren to experience the park and help calm anxious investors. However, the park is anything but amusing as the security systems go off-line and the dinosaurs escape.	Steven Spielberg	1993	2024-11-28 08:27:33.743679	2024-11-28 08:27:33.743679	tt0107290	["max","other"]
198	Speed	https://image.tmdb.org/t/p/w500/o1Zs7VaS9y2GYH9CLeWxaVLWd3x.jpg	Jack Traven, an LAPD cop on SWAT detail, and veteran SWAT officer Harry Temple thwart an extortionist-bomber's scheme for a $3 million ransom. As they corner the bomber, he flees and detonates a bomb vest, seemingly killing himself. Weeks later, Jack witnesses a mass transit city bus explode and nearby a pay phone rings. On the phone is that same bomber looking for vengeance and the money he's owed. He gives a personal challenge to Jack: a bomb is rigged on another city bus - if it slows down below 50 mph, it will explode - bad enough any day, but a nightmare in LA traffic. And that's just the beginning...	Jan de Bont	1994	2024-11-28 08:28:03.457718	2024-11-28 08:28:03.457718	tt0111257	["other"]
199	Friday	https://image.tmdb.org/t/p/w500/2lReF53F8trkC68piGSfk0JVwWU.jpg	Craig and Smokey are two guys in Los Angeles hanging out on their porch on a Friday afternoon, smoking and drinking, looking for something to do.	F. Gary Gray	1995	2024-11-28 08:28:55.665413	2024-11-28 08:28:55.665413	tt0113118	[]
200	Rush Hour	https://image.tmdb.org/t/p/w500/9FRw2qOU74GLSWbDkX6wWp6mgQD.jpg	When Hong Kong Inspector Lee is summoned to Los Angeles to investigate a kidnapping, the FBI doesn't want any outside help and assigns cocky LAPD Detective James Carter to distract Lee from the case. Not content to watch the action from the sidelines, Lee and Carter form an unlikely partnership and investigate the case themselves.	Brett Ratner	1998	2024-11-28 08:30:32.002193	2024-11-28 08:30:32.002193	tt0120812	[]
201	Mystic River	https://image.tmdb.org/t/p/w500/hCHVDbo6XJGj3r2i4hVjKhE0GKF.jpg	The lives of three men who were childhood friends are shattered when one of them suffers a family tragedy.	Clint Eastwood	2003	2024-11-28 08:33:01.306944	2024-11-28 08:33:01.306944	tt0327056	[]
202	Back to the Future	https://image.tmdb.org/t/p/w500/fNOH9f1aA7XRTzl1sAOx9iF553Q.jpg	Eighties teenager Marty McFly is accidentally sent back in time to 1955, inadvertently disrupting his parents' first meeting and attracting his mother's romantic interest. Marty must repair the damage to history by rekindling his parents' romance and - with the help of his eccentric inventor friend Doc Brown - return to 1985.	Robert Zemeckis	1985	2024-11-29 00:39:04.28234	2024-11-29 00:39:04.28234	tt0088763	["other"]
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: alcytorres
--

COPY public.schema_migrations (version) FROM stdin;
20240711181130
20240711200529
20240712170618
20240920014409
20240922011526
20240929023320
20241020053028
20241020053058
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: alcytorres
--

COPY public.users (id, first_name, last_name, email, password_digest, admin, image_url, created_at, updated_at) FROM stdin;
1	Luke	Skywalker	luke@email.com	$2a$12$EPYiM5C0QioleBAtlK7WFOdu40h9dOAb47yM5c.k8rVD87VC0bTby	t	https://miro.medium.com/v2/resize:fit:1400/0*4rjebfeSc7JDNSVh.jpg	2024-07-11 21:02:08.046262	2024-07-11 21:02:08.046262
2	Sarah	Connor	sarah@email.com	$2a$12$iYUP99okerTzJAga6OAUB.3CYnVnmzl.aLe5h6P6OwrRetVvcA0tK	f	https://go_service.aieasypic.com/?url=https%3A%2F%2Fimage.civitai.com%2FxG1nkqKTMzGDvpLrqFT7WA%2Fde510ca9-d3f6-4566-977f-10bc319e01f3%2Fwidth%3D600%2F5199972.jpeg&type=jpeg&width=512&quality=80	2024-07-11 21:06:14.363499	2024-07-11 21:06:14.363499
3	Jules	Winnfield	jules@email.com	$2a$12$/qFL0sR2rWZFG2Hz1l/bKepoDR8IHkUQpgo.fjBwcfVxvhPK7CUcq	f	https://static.wikia.nocookie.net/tarantinoverse/images/3/3a/3880be0b24e775a7f47402687421d533.jpg/revision/latest?cb=20190805111920	2024-07-11 21:07:02.680492	2024-07-11 21:07:02.680492
5	Emily	Wilde	emily@email.com	$2a$12$HzY5sUjhKo33aBG88Vhq9Ol42A1Zzp3tRbIdwy63P4RK4EHC1Beh2	f	\N	2024-07-15 16:48:22.990483	2024-07-30 15:38:55.185636
4	John	Smith	johnsmith@email.com	$2a$12$.QKwpsUu7H4juMlPVLl9pOphpaQUiP5w37QNKVk9EkMwZ.9SZaHOO	f	\N	2024-07-15 16:41:54.4809	2024-07-30 15:39:12.592976
\.


--
-- Data for Name: watchlist_movies; Type: TABLE DATA; Schema: public; Owner: alcytorres
--

COPY public.watchlist_movies (id, user_id, movie_id, created_at, updated_at) FROM stdin;
246	1	128	2024-11-08 17:13:57.123894	2024-11-08 17:13:57.123894
247	1	127	2024-11-08 17:14:21.818641	2024-11-08 17:14:21.818641
248	1	150	2024-11-08 17:14:47.825983	2024-11-08 17:14:47.825983
259	1	106	2024-11-28 08:02:23.585622	2024-11-28 08:02:23.585622
260	1	130	2024-11-28 08:03:23.801887	2024-11-28 08:03:23.801887
261	1	126	2024-11-28 08:04:39.045188	2024-11-28 08:04:39.045188
264	1	190	2024-11-28 08:15:35.469442	2024-11-28 08:15:35.469442
265	1	191	2024-11-28 08:16:40.358492	2024-11-28 08:16:40.358492
271	1	134	2024-11-28 08:25:43.776505	2024-11-28 08:25:43.776505
276	1	162	2024-11-28 08:28:35.605997	2024-11-28 08:28:35.605997
281	1	202	2024-11-29 00:39:04.30174	2024-11-29 00:39:04.30174
182	1	143	2024-11-05 03:44:42.648243	2024-11-05 03:44:42.648243
75	1	177	2024-11-04 18:03:16.116446	2024-11-04 18:03:16.116446
\.


--
-- Name: favorite_movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alcytorres
--

SELECT pg_catalog.setval('public.favorite_movies_id_seq', 147, true);


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alcytorres
--

SELECT pg_catalog.setval('public.movies_id_seq', 202, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alcytorres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: watchlist_movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alcytorres
--

SELECT pg_catalog.setval('public.watchlist_movies_id_seq', 281, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: favorite_movies favorite_movies_pkey; Type: CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT favorite_movies_pkey PRIMARY KEY (id);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: watchlist_movies watchlist_movies_pkey; Type: CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.watchlist_movies
    ADD CONSTRAINT watchlist_movies_pkey PRIMARY KEY (id);


--
-- Name: index_favorite_movies_on_movie_id; Type: INDEX; Schema: public; Owner: alcytorres
--

CREATE INDEX index_favorite_movies_on_movie_id ON public.favorite_movies USING btree (movie_id);


--
-- Name: index_favorite_movies_on_user_id; Type: INDEX; Schema: public; Owner: alcytorres
--

CREATE INDEX index_favorite_movies_on_user_id ON public.favorite_movies USING btree (user_id);


--
-- Name: index_watchlist_movies_on_movie_id; Type: INDEX; Schema: public; Owner: alcytorres
--

CREATE INDEX index_watchlist_movies_on_movie_id ON public.watchlist_movies USING btree (movie_id);


--
-- Name: index_watchlist_movies_on_user_id; Type: INDEX; Schema: public; Owner: alcytorres
--

CREATE INDEX index_watchlist_movies_on_user_id ON public.watchlist_movies USING btree (user_id);


--
-- Name: favorite_movies fk_rails_4d22931adc; Type: FK CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT fk_rails_4d22931adc FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- Name: watchlist_movies fk_rails_94709e5a04; Type: FK CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.watchlist_movies
    ADD CONSTRAINT fk_rails_94709e5a04 FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- Name: watchlist_movies fk_rails_c1729c5635; Type: FK CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.watchlist_movies
    ADD CONSTRAINT fk_rails_c1729c5635 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: favorite_movies fk_rails_e5afd0a893; Type: FK CONSTRAINT; Schema: public; Owner: alcytorres
--

ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT fk_rails_e5afd0a893 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

