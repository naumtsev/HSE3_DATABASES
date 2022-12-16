SET SEARCH_PATH = cf_monitor_db;


--- заполнение groups

INSERT INTO groups(group_name) VALUES('СПбГУ');
INSERT INTO groups(group_name) VALUES('ВШЭ СПб');
INSERT INTO groups(group_name) VALUES('МФТИ');
INSERT INTO groups(group_name) VALUES('Кружок по программированию УлГТУ');
INSERT INTO groups(group_name) VALUES('Код Успеха');

--- заполнение users


INSERT INTO users(cf_handle, group_id, rank, firstname, surname) VALUES('Naumtsev', 1, 'NEWBIE', 'Антон', 'Наумцев');
INSERT INTO users(cf_handle, group_id, rank, firstname, surname) VALUES('cdkrot', 2, 'GRANDMASTER', 'Алиса', 'Саютина');
INSERT INTO users(cf_handle, group_id, rank, firstname, surname) VALUES('Sunar', 1, 'MASTER', 'Максим', 'Кашичкин');
INSERT INTO users(cf_handle, group_id, rank, firstname, surname) VALUES('noob', 2, 'NEWBIE', 'Вася', 'Пупкин');
INSERT INTO users(cf_handle, group_id, rank) VALUES('mikha', 3, 'MASTER');
INSERT INTO users(cf_handle, group_id, rank, firstname) VALUES('test_user', 1, 'SPECIALIST', 'Андрей');
INSERT INTO users(cf_handle, group_id, rank, firstname) VALUES('bot123', 1, 'SPECIALIST', 'Ботик');


--- заполнение curators
INSERT INTO curators(login, password) VALUES('admin', '12345678');
INSERT INTO curators(login, cf_handle, password) VALUES('Naumtsev', 'Naumtsev', 'test12345');
INSERT INTO curators(login, cf_handle, password) VALUES('mikha', 'mikha', '12345678');
INSERT INTO curators(login, password) VALUES('superadmin', 'superadmin');
INSERT INTO curators(login, password) VALUES('razboynik', '1232312313');


--- заполнение curators_in_groups

INSERT INTO curators_in_groups(curator_login, group_id) VALUES('Naumtsev', 1);
INSERT INTO curators_in_groups(curator_login, group_id) VALUES('Naumtsev', 2);
INSERT INTO curators_in_groups(curator_login, group_id) VALUES('Naumtsev', 3);
INSERT INTO curators_in_groups(curator_login, group_id) VALUES('admin', 1);
INSERT INTO curators_in_groups(curator_login, group_id) VALUES('admin', 5);
INSERT INTO curators_in_groups(curator_login, group_id) VALUES('superadmin', 1);
INSERT INTO curators_in_groups(curator_login, group_id) VALUES('mikha', 4);


--- заполнение problemset

INSERT INTO problemsets(curator_login, title) VALUES('Naumtsev', 'Динамика по поддеревьям');
INSERT INTO problemsets(curator_login, title) VALUES('Naumtsev', 'DFS');
INSERT INTO problemsets(curator_login, title) VALUES('Naumtsev', 'BFS');
INSERT INTO problemsets(curator_login, title) VALUES('admin', 'Задачи для Yandex Cup');
INSERT INTO problemsets(curator_login, title) VALUES('admin', 'Задачи для VK Cup');

--- заполнение problemsets in groups

INSERT INTO problemsets_in_groups(problemset_id, group_id) VALUES(1, 1);
INSERT INTO problemsets_in_groups(problemset_id, group_id) VALUES(2, 1);
INSERT INTO problemsets_in_groups(problemset_id, group_id) VALUES(3, 1);
INSERT INTO problemsets_in_groups(problemset_id, group_id) VALUES(4, 1);
INSERT INTO problemsets_in_groups(problemset_id, group_id) VALUES(5, 2);


--- заполнение problems

INSERT INTO problems(problem_id, title, rating) VALUES('1773K', 'Kings Puzzle', 1900);
INSERT INTO problems(problem_id, title, rating) VALUES('1773J', 'Jumbled Trees', 2900);
INSERT INTO problems(problem_id, title, rating) VALUES('123A', 'Easy Assembly', 900);
INSERT INTO problems(problem_id, title, rating) VALUES('123B', 'Football', 1100);
INSERT INTO problems(problem_id, title, rating) VALUES('123C', 'Access Levels', 2400);

-- заполнение submissions
INSERT INTO submissions(cf_id, cf_handle, problem_id, verdict, creation_time) VALUES
(1132, 'Naumtsev', '123A', 'FAILED', 123344),
(4123, 'Naumtsev', '123A', 'FAILED', 123445),
(1333, 'Naumtsev', '123A', 'OK', 123600),
(4129, 'Sunar', '123A', 'OK', 123447),
(1234, 'Sunar', '123B', 'OK', 123449),
(55, 'Sunar', '123C', 'OK', 123450),
(51, 'test_user', '123A', 'OK', 113222),
(52, 'bot123', '123A', 'FAILED', 113222);


-- заполнение problems in problemsets

INSERT INTO problems_in_problemsets(problem_id, problemset_id, priority, valid_from_dttm, valid_to_dttm) VALUES
('123A', 1, 1, '20210601', '20300101'),
('123B', 1, 2, '20210601', '20300101'),
('123C', 1, 3, '20210602', '20300101'),
('1773K', 2, 1, '20210610', '20300101'),
('1773J', 2, 2, '20210611', '20300101');