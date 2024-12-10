-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- - Find out how to Pivot / roll up / long to wide in SQL
-- - Then just query

-- To do the conversion into separate rows, do separate queries combined using FILTER statements:
SELECT date, sum(quantity) FILTER (WHERE drink_name = 'Eggnog') as eggnog
from drinks
group by date
limit 10;


-- So the final statement becomes:
SELECT date
FROM (SELECT date,
             sum(quantity) FILTER (WHERE drink_name = 'Eggnog')              as eggnog,
             sum(quantity) FILTER (WHERE drink_name = 'Hot Cocoa')           as hotcocoa,
             sum(quantity) FILTER (WHERE drink_name = 'Peppermint Schnapps') as peppermintschnapps

      from drinks
      group by date) as agg_table
WHERE eggnog = 198
  and hotcocoa = 38
  and peppermintschnapps = 298;
