-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- - Aggregate by quarter and sort by quarter
-- - Calculate growth rate
-- - Select highest


-- Aggregate by quarter in the format requested as output (yyyy,q)
SELECT quarter, sum(amount)
FROM (SELECT (extract(year from sale_date)::text || ',' || extract(quarter from sale_date)::text) as quarter, amount
      FROM sales) as quarter
GROUP BY quarter
ORDER BY quarter;


-- Growth rate
SELECT quarter, (sum - lag(sum) over (ORDER BY quarter)) / lag(sum) over (ORDER BY quarter) as growth_rate
FROM (SELECT quarter, sum(amount) as sum
      FROM (SELECT (extract(year from sale_date)::text || ',' || extract(quarter from sale_date)::text) as quarter,
                   amount
            FROM sales) as quarter
      GROUP BY quarter
      ORDER BY quarter) as sum_amount;


-- Select highest (coalesce the first quarter to minus infinity to avoid null as highest)
SELECT quarter
FROM (SELECT quarter,
             coalesce((sum - lag(sum) over (ORDER BY quarter)) / lag(sum) over (ORDER BY quarter),
                      '-Infinity') as growth_rate
      FROM (SELECT quarter, sum(amount) as sum
            FROM (SELECT (extract(year from sale_date)::text || ',' ||
                          extract(quarter from sale_date)::text) as quarter,
                         amount
                  FROM sales) as quarter
            GROUP BY quarter
            ORDER BY quarter) as sum_amount
      ORDER BY growth_rate DESC
      LIMIT 1) as result;