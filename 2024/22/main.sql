-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- Convert string to array
-- Find element in array and check that it only matches it perfectly (so not as a substring)
-- Find all elves for which this holds with SQL and count

-- Convert string to array
SELECT string_to_array(skills, ',')
FROM elves;


-- Check whether element is in array
SELECT 'SQL' = ANY (string_to_array(skills, ','))
FROM elves;


-- Count elves
SELECT count(*)
FROM elves
WHERE 'SQL' = ANY (string_to_array(skills, ','));
