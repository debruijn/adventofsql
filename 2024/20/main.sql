-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- - Split URL into query params
-- - Filter on the requested utm_source
-- - Count query params, order using that, and report url


-- Split URL into query params
SELECT url, string_to_array(split_part(url, '?', 2), '&') as queries
FROM web_requests;


-- Filter on utm_source
SELECT url, queries
FROM (SELECT url, string_to_array(split_part(url, '?', 2), '&') as queries FROM web_requests) as qrs
WHERE 'utm_source=advent-of-sql' = ANY (queries)
LIMIT 10;


-- Count query params
SELECT url, array_length(queries, 1) as n_query
FROM (SELECT url, string_to_array(split_part(url, '?', 2), '&') as queries FROM web_requests) as qrs
WHERE 'utm_source=advent-of-sql' = ANY (queries)
ORDER BY n_query DESC, url
LIMIT 1;


-- And again the same problem happens as in some other days.. the problem is not as stated:
-- "Submit the url with the most query params (including the utm-source)" means "Submit the url with the most unique
-- query param keys (ignoring value) as long one is the given utm_source=advent-of-sql"
-- So replace array_length() with something that fines uniques. I could refactor the WHERE statement but meh.

SELECT url
FROM (SELECT url,
             (SELECT count(DISTINCT match[1]) AS n_query
              FROM regexp_matches(url, '[?&]([^=#&]+)=([^&#]*)', 'g') AS match) AS n_query
      FROM (SELECT url, string_to_array(split_part(url, '?', 2), '&') AS queries FROM web_requests) AS qrs
      WHERE 'utm_source=advent-of-sql' = ANY (queries)
      ORDER BY n_query DESC, url
      LIMIT 1) as res;
