-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- Find out how to run a query repeatedly and use the intermediate results -> use RECURSIVE
-- Apply that on table while increasing a counter by 1


-- Idea of query to repeat is to basically join on itself using manager_id as staff_id
SELECT staff.staff_id, staff.staff_name, staff.manager_id, clone.manager_id
FROM staff
         JOIN staff as clone on staff.manager_id = clone.staff_id
Limit 10;


-- Use RECURSIVE to repeatedly join until there is nothing to join then query that result.
-- Without merging everyone (except top dog) would already show 2 levels, so start with 2, and increase by 1 for each
-- subsequent join.
WITH RECURSIVE staff_structure AS (SELECT staff_id,
                                          manager_id,
                                          staff_name,
                                          2 as staff_level_counter
                                   FROM staff
                                   WHERE staff_id = 2
                                   UNION
                                   SELECT clone.staff_id,
                                          clone.manager_id,
                                          clone.staff_name,
                                          staff_level_counter + 1
                                   FROM staff as clone
                                            INNER JOIN staff_structure s ON s.staff_id = clone.manager_id)
SELECT staff_level_counter
FROM staff_structure
ORDER BY staff_level_counter DESC
LIMIT 1;