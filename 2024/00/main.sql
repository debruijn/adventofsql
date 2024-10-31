-- Advent of SQL day 0 (example)
-- Make sure to run `advent_of_sql_day_0.sql` first, which you need to get from the website

-- My approach is to step by step show how I have build up the queries, but only the last one really matters

-- Find cities with at least 5 children -> this does nothing initially but turns out this req is for later
SELECT city, count(*) FROM children
    GROUP BY city
    HAVING count(*) >= 5;

-- Find children who receive gifts -> drops Spain, Italy and Netherlands, and part of Germany.
SELECT children.child_id, city, country, naughty_nice_score FROM children
    JOIN christmaslist ON children.child_id = christmaslist.child_id;

-- Also calculate average naughty_nice score per city -> drops Berlin as well due to fewer children remaining
SELECT city, country, avg(naughty_nice_score) FROM children
    JOIN christmaslist ON children.child_id = christmaslist.child_id
    GROUP BY city, country
    HAVING count(*) >= 5;

-- Detect 5 top cities per country -> since there are only 3 countries left, I assume this means just 5 top cities
-- This results in the final query with the result
SELECT city FROM children
    JOIN christmaslist ON children.child_id = christmaslist.child_id
    GROUP BY city
    HAVING count(*) >= 5
    ORDER BY avg(naughty_nice_score) DESC
    LIMIT 5;
