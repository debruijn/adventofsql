-- Make sure to run `advent_of_sql_day_7.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- Find out how to match on duplicate row within column
-- Find out how to get max and min per primary skill
-- Dedup and order by primary then seconday


-- "Self join" using an alias - turns out to actually not be needed but I keep it here for reference
SELECT *
FROM workshop_elves
         JOIN workshop_elves as clone on workshop_elves.primary_skill = clone.primary_skill
Limit 10;


-- Get max per primary_skill (this includes ties)
SELECT *
from (SELECT *,
             rank() over (partition by primary_skill order by years_experience desc) as rk
      FROM workshop_elves) x
WHERE rk = 1;


-- Limit the above to just the earliest elf_id
SELECT *
from (SELECT *,
             rank() over (partition by primary_skill order by years_experience desc, elf_id) as rk
      FROM workshop_elves) x
WHERE rk = 1;


-- Same for min per primary_skill
SELECT *
FROM (SELECT *,
             rank() over (partition by primary_skill order by years_experience, elf_id) as rk
      FROM workshop_elves) x
WHERE rk = 1;


-- Put it all together
SELECT elf_id_1, elf_id_2, x1.primary_skill
FROM (SELECT elf_id as elf_id_2, primary_skill
      FROM (SELECT *,
                   rank() over (partition by primary_skill order by years_experience, elf_id) as rk
            FROM workshop_elves) as rkx
      WHERE rk = 1) as x1
         JOIN (SELECT elf_id as elf_id_1, primary_skill
               FROM (SELECT *,
                            rank() over (partition by primary_skill order by years_experience desc, elf_id) as rk
                     FROM workshop_elves) as rkx
               WHERE rk = 1) as x2 on x1.primary_skill = x2.primary_skill;
