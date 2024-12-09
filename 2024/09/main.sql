-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- Calculate average for reindeer/exercise for reindeer_id not Rudolphs
-- Find the highest average and the associated reindeer
-- Print them


-- Getting the averages
SELECT reindeer_id, AVG(speed_record) as avg_speed
FROM training_sessions
GROUP BY exercise_name, reindeer_id
ORDER BY avg_speed DESC;


-- Joining name unto it, filtering out Rudolph, limit to 3
SELECT reindeer_name, Round(AVG(speed_record), 2) as avg_speed
FROM training_sessions
         JOIN reindeers on training_sessions.reindeer_id = reindeers.reindeer_id
WHERE reindeer_name != 'RUDOLPH'
GROUP BY exercise_name, reindeers.reindeer_id
ORDER BY avg_speed DESC
LIMIT 3;
