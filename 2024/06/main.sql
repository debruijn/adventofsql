-- Make sure to run `advent_of_sql_day_6.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters

-- Plan:
-- Get average gift price
-- Get gifts more expensive than average
-- Get children that get those gifts
-- LIMIT 1


-- Average price
SELECT AVG(price)
FROM gifts;

-- Find child with lowest price among children with price bigger than average
SELECT child_id
FROM gifts
WHERE price > (SELECT AVG(price) FROM gifts)
ORDER BY price ASC
LIMIT 1;

-- Join children table on it to find name of child
SELECT children.name
FROM gifts
         JOIN children on gifts.child_id = children.child_id
WHERE price > (SELECT AVG(price) FROM gifts)
ORDER BY price ASC
LIMIT 1;
