DROP SCHEMA IF EXISTS cf_monitor_db CASCADE;
CREATE SCHEMA cf_monitor_db;

SET SEARCH_PATH = cf_monitor_db;


-- Создание таблиц
DROP TABLE IF EXISTS groups CASCADE;
CREATE TABLE groups (
    group_id serial NOT NULL,
    group_name text CHECK (group_name != ''),
    PRIMARY KEY (group_id)
);

DROP TYPE IF EXISTS ERank;
CREATE TYPE ERank AS ENUM ('NEWBIE',
                            'PUPIL',
                            'SPECIALIST',
                            'EXPERT',
                            'CANDIDATE_MASTER',
                            'MASTER',
                            'INTERNATIONAL_MASTER',
                            'GRANDMASTER',
                            'INTERNATIONAL_GRANDMASTER',
                            'LEGENDARY_GRANDMASTER');


DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users(
    cf_handle varchar(20) UNIQUE CHECK (cf_handle ~ '^[a-zA-Z0-9_]+$' and char_length(cf_handle) > 3),
    group_id integer REFERENCES groups(group_id)  ON DELETE CASCADE,
    rank ERank default 'NEWBIE' NOT NULL,
    firstname varchar(20),
    surname varchar(20),
    PRIMARY KEY (cf_handle)
);


DROP TABLE IF EXISTS problems CASCADE;
CREATE TABLE problems(
    problem_id text UNIQUE NOT NULL CHECK (problem_id ~ '[0-9]+[A-Z]'),
    title text NOT NULL,
    rating integer,
    PRIMARY KEY (problem_id)
);


DROP TYPE IF EXISTS EVerdict;
CREATE TYPE EVerdict AS ENUM ('OK',
                            'FAILED');


DROP TABLE IF EXISTS submissions CASCADE;
CREATE TABLE submissions(
    cf_id integer NOT NULL UNIQUE,
    cf_handle varchar(20) REFERENCES users(cf_handle)  ON DELETE CASCADE,
    problem_id text REFERENCES problems(problem_id)  ON DELETE CASCADE,
    verdict EVERDICT NOT NULL,
    creation_time integer NOT NULL,
    PRIMARY KEY (cf_id)
);


DROP TABLE IF EXISTS curators CASCADE;
CREATE TABLE curators(
    login text UNIQUE NOT NULL CHECK(char_length(login) > 3),
    cf_handle varchar(20) REFERENCES users(cf_handle) ON DELETE CASCADE,
    password text NOT NULL CHECK(char_length(password) > 7),
    PRIMARY KEY (login)
);


DROP TABLE IF EXISTS curators_in_groups CASCADE;
CREATE TABLE curators_in_groups(
    curator_login text REFERENCES curators(login) ON DELETE CASCADE,
    group_id integer REFERENCES groups(group_id)  ON DELETE CASCADE,
    PRIMARY KEY (curator_login, group_id)
);


DROP TABLE IF EXISTS problemsets CASCADE;
CREATE TABLE problemsets(
    problemset_id serial NOT NULL,
    curator_login text REFERENCES curators(login) ON DELETE SET NULL,
    title text NOT NULL CHECK (title != ''),
    PRIMARY KEY (problemset_id)
);


DROP TABLE IF EXISTS problemsets_in_groups CASCADE;
CREATE TABLE problemsets_in_groups(
    problemset_id integer REFERENCES problemsets(problemset_id)  ON DELETE CASCADE,
    group_id integer REFERENCES groups(group_id)  ON DELETE CASCADE,
    PRIMARY KEY (problemset_id, group_id)
);


DROP TABLE IF EXISTS problems_in_problemsets CASCADE;
CREATE TABLE problems_in_problemsets(
    problem_id text REFERENCES problems(problem_id)  ON DELETE CASCADE,
    problemset_id integer REFERENCES problemsets(problemset_id)  ON DELETE CASCADE,
    priority integer NOT NULL CHECK (priority > 0),
    valid_from_dttm date NOT NULL,
    valid_to_dttm date NOT NULL CHECK (valid_to_dttm > valid_from_dttm),
    PRIMARY KEY (problem_id, problemset_id, valid_from_dttm)
);