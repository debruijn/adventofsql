-- Make sure to run `advent_of_sql_day_3.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- - Sort by date
-- - Figure out how to refer to the previous row -> answer: use lag()
-- - Calculating change and perc change should be ez
-- - Sort by perc change and limit 1


-- Put this and previous row next to each other using lag(.), which also needs an over-statement
SELECT production_date, lag(production_date) over (ORDER BY production_date)
FROM toy_production
ORDER BY production_date
LIMIT 10;

-- So instead we do it on toys_produced
SELECT production_date,
       (toys_produced - lag(toys_produced) over (ORDER BY production_date)) * 100.0 /
       lag(toys_produced) over (order by production_date) as production_change_percentage
FROM toy_production
ORDER BY production_date
LIMIT 10;

-- Then order by production_change_percentage, limit to 1, and get date only
SELECT production_date
FROM (SELECT production_date,
             round((toys_produced - lag(toys_produced) over (ORDER BY production_date)) * 100.0 /
                   lag(toys_produced) over (order by production_date), 2) as production_change_percentage
      FROM toy_production
      ORDER BY production_change_percentage DESC NULLS LAST
      LIMIT 1
) as toy_production_perc_increase;
