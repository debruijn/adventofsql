-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- - Sum of requests -> aggregate
-- - Rank to percentile


-- Sum of requests per gift
SELECT gift_id, count(*) as count
FROM gift_requests
GROUP BY gift_id;


-- How to get the max value which we should ignore
SELECT max(count)
FROM (SELECT gift_name, count(*) as count
      FROM gift_requests
               JOIN gifts on gifts.gift_id = gift_requests.gift_id
      GROUP BY gift_name) as gift_count;


-- All together
SELECT gift_name, round(cdist * 100) / 100 as rank
FROM (SELECT gift_name, count, percent_rank() OVER (ORDER BY count) as cdist
      FROM (SELECT gift_name, count(*) as count
            FROM gift_requests
                     JOIN gifts on gifts.gift_id = gift_requests.gift_id
            GROUP BY gift_name) as gift_count) as gift_count
WHERE count < (SELECT max(count)
               FROM (SELECT gift_name, count(*) as count
                     FROM gift_requests
                              JOIN gifts on gifts.gift_id = gift_requests.gift_id
                     GROUP BY gift_name) as gift_count)

ORDER BY cdist DESC, gift_name
LIMIT 1;