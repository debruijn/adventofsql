-- Make sure to run `advent_of_sql_day_3.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- Find out how to find overlapping and non-overlapping elements of arrays
-- Find out how to get length of arrays
-- Combine and sort on most added, limit to 1

-- Overlapping ("unchanged_tags")
SELECT toy_id,
       array(SELECT unnest(previous_tags)
             INTERSECT
             SELECT unnest(new_tags))
FROM toy_production
LIMIT 10;

-- Non-overlapping ("added_tags", "removed_tags")
SELECT toy_id,
       array(SELECT unnest(previous_tags)
             EXCEPT
             SELECT unnest(new_tags))
FROM toy_production
LIMIT 10;
SELECT toy_id,
       array(SELECT unnest(new_tags)
             EXCEPT
             SELECT unnest(previous_tags))
FROM toy_production
LIMIT 10;

-- Get length of array (first dimension)
SELECT toy_id,
       array_length(array(SELECT unnest(previous_tags)
                          INTERSECT
                          SELECT unnest(new_tags)), 1)
FROM toy_production
LIMIT 10;

-- Use coalesce to replace nulls with 0
SELECT toy_id,
       coalesce(array_length(array(SELECT unnest(previous_tags)
                                   INTERSECT
                                   SELECT unnest(new_tags)), 1), 0)
FROM toy_production
LIMIT 10;

-- All together, in order of question
SELECT toy_id,
       coalesce(array_length(array(SELECT unnest(new_tags) EXCEPT SELECT unnest(previous_tags)), 1), 0)    as added,
       coalesce(array_length(array(SELECT unnest(previous_tags) INTERSECT SELECT unnest(new_tags)), 1), 0) as unchanged,
       coalesce(array_length(array(SELECT unnest(previous_tags) EXCEPT SELECT unnest(new_tags)), 1), 0)    as removed
FROM toy_production
ORDER BY added DESC
LIMIT 1;
