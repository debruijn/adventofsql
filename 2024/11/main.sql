-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- - Convert season
-- - How to do a moving window calculation
-- - Apply that on the full table


-- Convert season
SELECT field_name,
       AVG(trees_harvested) AS trees_harvested,
       CASE
           WHEN season = 'Spring' THEN 1
           WHEN season = 'Summer' THEN 2
           WHEN season = 'Fall' THEN 3
           WHEN season = 'Winter' THEN 4
           ELSE 0
           END              AS season
FROM treeharvests
GROUP BY field_name, season;


-- Moving average: use AVG with a Window that uses ROWS 2 PRECEDING
SELECT field_name,
       season,
       ROUND(AVG(trees_harvested) OVER w, 2) AS average_trees
FROM (SELECT field_name,
             SUM(trees_harvested) AS trees_harvested,
             CASE
                 WHEN season = 'Spring' THEN 1
                 WHEN season = 'Summer' THEN 2
                 WHEN season = 'Fall' THEN 3
                 WHEN season = 'Winter' THEN 4
                 ELSE 0
                 END              AS season
      FROM treeharvests
      GROUP BY field_name, season) AS trees
WINDOW w AS (
        ORDER BY field_name, season
        ROWS 2 PRECEDING
        )
ORDER BY average_trees DESC;


-- Then get thee right number -> filter out seasons 1 and 2 and take top result
SELECT average_trees
FROM (SELECT season,
             ROUND(AVG(trees_harvested) OVER w, 2) AS average_trees
      FROM (SELECT field_name,
                   AVG(trees_harvested) AS trees_harvested,
                   CASE
                       WHEN season = 'Spring' THEN 1
                       WHEN season = 'Summer' THEN 2
                       WHEN season = 'Fall' THEN 3
                       WHEN season = 'Winter' THEN 4
                       ELSE 0
                       END              AS season
            FROM treeharvests
            GROUP BY field_name, season) AS trees
      WINDOW w AS (
              ORDER BY field_name, season
              ROWS 2 PRECEDING
              )
      ORDER BY average_trees DESC) as full_result
WHERE season >= 3
LIMIT 1;
