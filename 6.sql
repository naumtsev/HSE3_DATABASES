SET SEARCH_PATH = cf_monitor_db;



-- у определенного пользователя для каждого дня некоторого промежутка считаем количество отправленных им посылок
select result.date, sum(result.count)
from (select date_trunc('day', to_timestamp(creation_time)) as date,
             count(*)                                       as count
      from submissions
      WHERE cf_handle = 'Naumtsev'
      GROUP BY date
      union all
      select date, 0 as count
      from generate_series('1970-01-01'::timestamp, '1970-05-03'::timestamp, '1 day'::interval) as date) result
GROUP BY result.date
ORDER BY result.date;


Select group_name,
       group_id,
       problem_id,
       rating
from (
SELECT distinct
    group_name,
    pig.group_id,
    pip.problem_id,
    pig.problemset_id,
    rating,
    rank() over(partition by pig.group_id order by rating DESC ) as order_id
from groups
inner join problemsets_in_groups pig on groups.group_id = pig.group_id
inner join problems_in_problemsets pip on pig.problemset_id = pip.problemset_id
inner join problems on pip.problem_id = problems.problem_id) as t
where t.order_id <= 10;


--- Считаем для каждого куратора количество подопечных

SELECT
    curator_login,
    count(DISTINCT(users.cf_handle)) as controlled_users
from curators
inner join curators_in_groups cig on curators.login = cig.curator_login
inner join users on users.group_id = cig.group_id
GROUP BY curator_login
ORDER BY controlled_users DESC;


-- Среднее количество попыток, чтобы сдать задачу
select
    problem_id,
    avg(t.cnt)
from (
select
    submissions.cf_handle,
    problem_id,
    count(*) as cnt
from submissions
group by submissions.cf_handle, problem_id) as t
group by problem_id;


-- Для каждой задачи выводим название группы, в которой ее больше всего людей решило

SELECT
    t2.problem_id,
    t2.group_id,
    groups.group_name
from (
SELECT
    problem_id,
    cnt,
    group_id,
    dense_rank() over (partition by problem_id  order by cnt DESC) as rank
from (
SELECT
    s.problem_id as problem_id,
    u.group_id as group_id,
    count(*) as cnt
from problems
inner join submissions s on problems.problem_id = s.problem_id
inner join users u on s.cf_handle = u.cf_handle
where verdict = 'OK'
GROUP BY s.problem_id, u.group_id) as t) as t2
inner join groups on groups.group_id = t2.group_id
where rank = 1;

