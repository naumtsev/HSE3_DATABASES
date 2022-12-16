SET SEARCH_PATH = cf_monitor_db;


-- CRUD запросы для users

INSERT INTO users(cf_handle, group_id, rank, firstname, surname) VALUES('tourist', 1, 'INTERNATIONAL_GRANDMASTER', 'Генадий', 'Короткевич');

SELECT
    cf_handle,
    rank
FROM users
WHERE group_id = 1;

UPDATE users
SET rank = 'SPECIALIST'
where cf_handle = 'Naumtsev';

DELETE FROM users
WHERE rank = 'INTERNATIONAL_GRANDMASTER';

-- CRUD запросы для submissions

INSERT INTO submissions(cf_id, cf_handle, problem_id, verdict, creation_time) VALUES
(12555, 'Naumtsev', '123A', 'OK', 123390);

SELECT
    problem_id,
    count(*) as ok_count
FROM submissions
WHERE verdict = 'OK'
GROUP BY problem_id;


UPDATE submissions
SET verdict = 'FAILED'
where cf_handle = 'Sunar' and problem_id = '123C';
