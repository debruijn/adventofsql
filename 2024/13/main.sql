-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- How to split domain from email -> use split_part
-- Apply that on array -> unnest
-- Aggregate


-- Unnest & split
SELECT split_part(unnest(email_addresses), '@', 2)
FROM contact_list;

-- Count domains
SELECT count(*)
FROM (SELECT split_part(unnest(email_addresses), '@', 2) as domain FROM contact_list) as cld
GROUP BY domain;

-- Instead return domain but sort by count
SELECT domain
FROM (SELECT split_part(unnest(email_addresses), '@', 2) as domain FROM contact_list) as cld
GROUP BY domain
ORDER BY count(*) DESC
LIMIT 1;
