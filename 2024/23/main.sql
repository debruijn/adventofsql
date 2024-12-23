-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- Sort ids
-- Find gaps
-- Create array based on gaps


-- Sort ids
SELECT * FROM sequence_table ORDER BY id;


-- Find gap by using lags -> lag is final element not in gap, id is first element not in gap
SELECT lag, id FROM (
    SELECT id, LAG(id) over (ORDER BY id) as lag
    FROM sequence_table
               ) as lag_table
    WHERE id != lag + 1;


-- Construct array based on gaps
SELECT ARRAY(SELECT * FROM generate_series(lag+1, id-1)) FROM (
                        SELECT id, LAG(id) over (ORDER BY id) as lag
                        FROM sequence_table
                    ) as lag_table
WHERE id != lag + 1;
