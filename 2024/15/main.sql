-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- In this, you also have to make sure to have installed postgis beforehand, and added to your search path.
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- Get most recent timestamp
-- Find out how to find if point is inside polygon
-- Combine

-- Most recent timestamp -- only one in input now so not really needed. If in future we must filter we can add WHERE.
SELECT coordinate
FROM sleigh_locations
ORDER BY timestamp DESC
LIMIT 1;


-- How to check if point is in polygon - I handpicked to use Berlins first coordinate
SELECT place_name
from areas
where ST_Intersects(areas.polygon, ST_Point(13.304644, 52.454563, 4326));


-- Combine to get answer
SELECT place_name
from areas,
     (SELECT coordinate
      FROM sleigh_locations
      ORDER BY timestamp DESC
      LIMIT 1) as location
where ST_Intersects(areas.polygon, location.coordinate);
