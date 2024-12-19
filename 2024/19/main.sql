-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- For each employee, get most recent year end performance scores
-- Get employees with performance score above average
-- Get total salary with additional 15% for the above-average employees

-- Get most recent performance score
SELECT name, salary, year_end_performance_scores[array_upper(year_end_performance_scores, 1)]
FROM employees;

-- Get average score
SELECT AVG(year_end_performance_scores[array_upper(year_end_performance_scores, 1)]) AS avg_score
FROM employees;

-- Get employees with performance score above average
SELECT salary, score
FROM (SELECT name, salary, year_end_performance_scores[array_upper(year_end_performance_scores, 1)] AS score
      FROM employees) AS employees
WHERE score > (SELECT AVG(year_end_performance_scores[array_upper(year_end_performance_scores, 1)]) AS avg_score
               FROM employees);

-- For those, get sum of salary + 15%
SELECT sum(salary) * 1.15 AS high_sum
FROM (SELECT name, salary, year_end_performance_scores[array_upper(year_end_performance_scores, 1)] AS score
      FROM employees) AS employees
WHERE score > (SELECT AVG(year_end_performance_scores[array_upper(year_end_performance_scores, 1)]) AS avg_score
               FROM employees);

-- Similarly for bottom performers:
SELECT sum(salary) AS low_sum
FROM (SELECT name, salary, year_end_performance_scores[array_upper(year_end_performance_scores, 1)] AS score
      FROM employees) AS employees
WHERE score <= (SELECT AVG(year_end_performance_scores[array_upper(year_end_performance_scores, 1)]) AS avg_score
                FROM employees);

-- Combine and add
SELECT ROUND(high_sum + low_sum, 2)
FROM (SELECT sum(salary) * 1.15 AS high_sum
      FROM (SELECT name, salary, year_end_performance_scores[array_upper(year_end_performance_scores, 1)] AS score
            FROM employees) AS employees
      WHERE score > (SELECT AVG(year_end_performance_scores[array_upper(year_end_performance_scores, 1)]) AS avg_score
                     FROM employees)) AS high,
     (SELECT sum(salary) AS low_sum
      FROM (SELECT name, salary, year_end_performance_scores[array_upper(year_end_performance_scores, 1)] AS score
            FROM employees) AS employees
      WHERE score <= (SELECT AVG(year_end_performance_scores[array_upper(year_end_performance_scores, 1)]) AS avg_score
                      FROM employees)) AS low;