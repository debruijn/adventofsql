-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- How to convert timezoned time to UTC time
-- How to find overlap between time periods -> just find max of start and min of finish, and see gap in between


-- Note to self: timezones in SQL suck, even more than in other systems
-- Big learning: never do timezones in SQL if possible
-- The business_start_time columns are already interpreted locally (my location) so converting to, say, utc adds time
-- to it instead of keeping it as is. Workaround: create it from scratch by adding the time to a date.


-- Workaround: add time to date, interpret it at the timezone column, and then convert to utc (pff)
SELECT timezone, ((CURRENT_DATE + business_start_time) AT TIME ZONE timezone AT TIME ZONE 'UTC') as utc_start_time
FROM workshops;

-- Strip time from the result (we don't need dates)
SELECT timezone, ((CURRENT_DATE + business_start_time) AT TIME ZONE timezone AT TIME ZONE 'UTC')::time as utc_start_time
FROM workshops;


-- Do the same for utc_end_time
-- Strip time from the result (we don't need dates)
SELECT timezone, ((CURRENT_DATE + business_end_time) AT TIME ZONE timezone AT TIME ZONE 'UTC')::time as utc_end_time
FROM workshops;


-- Find latest utc_start and earliest utc_end to see total gap for options -> there is no gap, error in the input...
SELECT MAX(utc_start_time), MIN(utc_end_time)
FROM (SELECT ((CURRENT_DATE + business_start_time) AT TIME ZONE timezone AT TIME ZONE 'UTC')::time as utc_start_time,
             ((CURRENT_DATE + business_end_time) AT TIME ZONE timezone AT TIME ZONE 'UTC')::time   as utc_end_time
      FROM workshops) as utc_times;


-- Ignoring the input error, the earliest overlap is of course the last start time (if end_time > start_time), so as
-- final output:
-- Find latest utc_start and earliest utc_end to see total gap for options -> there is no gap, error in the input...
SELECT MAX(utc_start_time)
FROM (SELECT ((CURRENT_DATE + business_start_time) AT TIME ZONE timezone AT TIME ZONE 'UTC')::time as utc_start_time
      FROM workshops) as utc_times;
