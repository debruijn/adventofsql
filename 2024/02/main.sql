-- Make sure to run `advent_of_sql_day_2.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters

-- Approach:
-- a Join tables (by stacking)
-- b Convert to chars and ignore fluff characters
-- c Concatenate somehow


-- a Parent table with letters_a and letters_b as children
CREATE TABLE letters( LIKE letters_a );
ALTER TABLE letters_a INHERIT letters;
ALTER TABLE letters_b INHERIT letters;

-- b Keep letters and some special characters (I didn't see the list on the website until after finishing)
SELECT CHR(value)
    FROM letters
    WHERE value BETWEEN 65 AND 90 OR value BETWEEN 97 and 122 or CHR(value) IN (' ', ',', '.', '!', '?');

-- c Only change compared to b: add string_agg() function to convert to single row
SELECT string_agg(CHR(value), '')
FROM letters
WHERE value BETWEEN 65 AND 90 OR value BETWEEN 97 and 122 or CHR(value) IN (' ', ',', '.', '!', '?');
