-- Make sure to run `advent_of_sql_day_3.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
---- Figure out how to parse XML schemas
---- Create one big table with all relevant data
---- Filter on menus with >78 guests
---- Find most common food_item_id


-- Three types, with guests in guestCount, total_count or total_guess. We can use CASE for that.
-- - Use xmlexists to see if a certain path exists and we know which schema to use.
-- - // can help in skipping high level folders
-- - With xpath we can then access those elements and parse them into integers
-- food_item_id is always named the same so that is easy

SELECT
    CASE
        WHEN xmlexists('//total_present/text()' PASSING BY REF menu_data)
            THEN (xpath('//total_present/text()', menu_data)::varchar[]::integer[])[1]
        WHEN xmlexists('//total_count/text()' PASSING BY REF menu_data)
            THEN (xpath('//total_count/text()', menu_data)::varchar[]::integer[])[1]
        WHEN xmlexists('//total_guests/text()' PASSING BY REF menu_data)
            THEN (xpath('//total_guests/text()', menu_data)::varchar[]::integer[])[1]
        WHEN xmlexists('//guestCount/text()' PASSING BY REF menu_data)
            THEN (xpath('//guestCount/text()', menu_data)::varchar[]::integer[])[1]
        ELSE 0
        END AS guest_nr,
    xpath('//food_item_id/text()', menu_data)::varchar[] AS food_item_ids
FROM christmas_menus;


-- To append these all into one table, use UNNEST. This needs
-- - Variable to unnest (food_item_ids)
-- - Results need to also be grouped by that result which is called unnest
-- - Internal query is the one above.
SELECT
    UNNEST(proc_count_ids.food_item_ids)
FROM (SELECT CASE
                 WHEN xmlexists('//total_present/text()' PASSING BY REF menu_data)
                     THEN (xpath('//total_present/text()', menu_data)::varchar[]::integer[])[1]
                 WHEN xmlexists('//total_count/text()' PASSING BY REF menu_data)
                     THEN (xpath('//total_count/text()', menu_data)::varchar[]::integer[])[1]
                 WHEN xmlexists('//total_guests/text()' PASSING BY REF menu_data)
                     THEN (xpath('//total_guests/text()', menu_data)::varchar[]::integer[])[1]
                 WHEN xmlexists('//guestCount/text()' PASSING BY REF menu_data)
                     THEN (xpath('//guestCount/text()', menu_data)::varchar[]::integer[])[1]
                 ELSE 0
                 END                                              AS guest_nr,
             xpath('//food_item_id/text()', menu_data)::varchar[] AS food_item_ids
      FROM christmas_menus) as proc_count_ids
GROUP BY unnest;

-- Then we add filtering on guest_nr, counting the cases, and ordering by that count.
SELECT
    UNNEST(proc_count_ids.food_item_ids)
FROM (SELECT CASE
                 WHEN xmlexists('//total_present/text()' PASSING BY REF menu_data)
                     THEN (xpath('//total_present/text()', menu_data)::varchar[]::integer[])[1]
                 WHEN xmlexists('//total_count/text()' PASSING BY REF menu_data)
                     THEN (xpath('//total_count/text()', menu_data)::varchar[]::integer[])[1]
                 WHEN xmlexists('//total_guests/text()' PASSING BY REF menu_data)
                     THEN (xpath('//total_guests/text()', menu_data)::varchar[]::integer[])[1]
                 WHEN xmlexists('//guestCount/text()' PASSING BY REF menu_data)
                     THEN (xpath('//guestCount/text()', menu_data)::varchar[]::integer[])[1]
                 ELSE 0
                 END                                              AS guest_nr,
             xpath('//food_item_id/text()', menu_data)::varchar[] AS food_item_ids
      FROM christmas_menus) as proc_count_ids
WHERE proc_count_ids.guest_nr > 78
GROUP BY unnest
ORDER BY COUNT(*) DESC
LIMIT 1;
