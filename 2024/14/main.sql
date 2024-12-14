-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- JSONB to individual rows
-- Test elements from dictionary
-- From that point on its straightforward


-- JSONB to individual rows
SELECT receipts
FROM santarecords,
     jsonb_array_elements(santarecords.cleaning_receipts) as receipts
Limit 10;

-- Filter on receipts with a green suit
SELECT receipts
FROM santarecords,
     jsonb_array_elements(santarecords.cleaning_receipts) as receipts
where receipts::json ->> 'color' = 'green'
  and receipts::json ->> 'garment' = 'suit'
Limit 10;

-- Get only drop-off date and limit to 1
SELECT receipts::json ->> 'drop_off' as drop_off
FROM santarecords,
     jsonb_array_elements(santarecords.cleaning_receipts) as receipts
where receipts::json ->> 'color' = 'green'
  and receipts::json ->> 'garment' = 'suit'
Limit 1;