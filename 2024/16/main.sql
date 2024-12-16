-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- - Convert location to area
-- - ------ Remove area if previous area is the same
-- - Take difference and assign to prev timezone
-- - Sum across locations
-- - Find max


-- Convert location to area
SELECT timestamp, place_name
FROM areas,
     (SELECT coordinate, timestamp
      FROM sleigh_locations
      ORDER BY timestamp) as location
WHERE ST_Intersects(areas.polygon, location.coordinate);


-- Take difference with next location
SELECT lead(location.timestamp) OVER (ORDER BY location.timestamp) - location.timestamp as time_diff, place_name
FROM areas,
     (SELECT coordinate, timestamp
      FROM sleigh_locations
      ORDER BY timestamp) as location
WHERE ST_Intersects(areas.polygon, location.coordinate);


-- Sum across locations
SELECT sum(time_diff), place_name
FROM (SELECT lead(location.timestamp) OVER (ORDER BY location.timestamp) - location.timestamp as time_diff, place_name
      FROM areas,
           (SELECT coordinate, timestamp
            FROM sleigh_locations
            ORDER BY timestamp) as location
      WHERE ST_Intersects(areas.polygon, location.coordinate)) as td
GROUP BY place_name;


-- Get max of sum of time diffs
SELECT place_name
FROM (SELECT lead(location.timestamp) OVER (ORDER BY location.timestamp) - location.timestamp as time_diff, place_name
      FROM areas,
           (SELECT coordinate, timestamp
            FROM sleigh_locations
            ORDER BY timestamp) as location
      WHERE ST_Intersects(areas.polygon, location.coordinate)) as td
GROUP BY place_name
ORDER BY sum(time_diff) DESC
LIMIT 1;
