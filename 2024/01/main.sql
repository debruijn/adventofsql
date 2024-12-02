-- Make sure to run `advent_of_sql_day_1.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters

-- Slight spoiler up front: to get started with this first day, I took hints online that I should use CASE and on the
-- JSON operators ->> and ->. I hope to avoid these for future days but in the end this does make me learn. :)

-- I first need to process the JSON in the wish_lists. I tried with other json functions but then learned about the ->>
-- combined operator to return text instead of JSON. I also apply the desired output naming (although it doesn't really
-- matter since we need to plug in the answers only anyway).
SELECT name,
    wishes ->> 'first_choice' AS primary_wish,
    wishes ->> 'second_choice' AS backup_wish,
    wishes -> 'colors' ->> 0 AS favorite_color,
    json_array_length(wishes -> 'colors') AS color_count
FROM children
         JOIN wish_lists on children.child_id = wish_lists.child_id;

--- Then on to do that also merge the toy_catalogue table and apply CASE to map. Limit to 5 cases.
SELECT name, primary_wish, backup_wish, favorite_color, color_count,
    CASE difficulty_to_make
        WHEN 1 THEN 'Simple Gift'
        WHEN 2 THEN 'Moderate Gift'
        WHEN 3 THEN 'Complex Gift'
        END AS gift_complexity,
    CASE category
        WHEN 'outdoor' THEN 'Outside Workshop'
        WHEN 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
        END AS workshop_assignment
FROM (
         SELECT
             name,
             wishes ->> 'first_choice' AS primary_wish,
             wishes ->> 'second_choice' AS backup_wish,
             wishes -> 'colors' ->> 0 AS favorite_color,
             json_array_length(wishes -> 'colors') AS color_count
         FROM children
                  JOIN wish_lists on children.child_id = wish_lists.child_id
     ) AS child_list
         JOIN toy_catalogue on child_list.primary_wish = toy_catalogue.toy_name
ORDER BY name LIMIT 5;
