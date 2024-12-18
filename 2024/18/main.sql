-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- Start from what we had for day 8 for finding level of each employee
-- Count how often manager_id appears and find maximum
-- Filter managers with that maximum number of peers under them
-- Find staff from those managers, sort by level and then id, limit to 1


-- Adjusted day 8: also add id/name/manager to output and don't limit to 1.
WITH RECURSIVE staff_structure AS (SELECT staff_id,
                                          manager_id,
                                          staff_name,
                                          2 as staff_level_counter
                                   FROM staff
                                   WHERE staff_id = 1
                                   UNION
                                   SELECT clone.staff_id,
                                          clone.manager_id,
                                          clone.staff_name,
                                          staff_level_counter + 1
                                   FROM staff as clone
                                            INNER JOIN staff_structure s ON s.staff_id = clone.manager_id)
SELECT staff_id, staff_name, manager_id, staff_level_counter
FROM staff_structure
ORDER BY staff_level_counter DESC;


-- Count manager_id and find maximum
WITH RECURSIVE staff_structure AS (SELECT staff_id,
                                          manager_id,
                                          staff_name,
                                          2 as staff_level_counter
                                   FROM staff
                                   WHERE staff_id = 1
                                   UNION
                                   SELECT clone.staff_id,
                                          clone.manager_id,
                                          clone.staff_name,
                                          staff_level_counter + 1
                                   FROM staff as clone
                                            INNER JOIN staff_structure s ON s.staff_id = clone.manager_id)
SELECT max(count_peers) as max_peers
FROM (SELECT manager_id, count(*) as count_peers
      FROM staff_structure
      GROUP BY manager_id) as counts;


-- Find manager_ids with this maximum value of peers under them
WITH RECURSIVE staff_structure AS (SELECT staff_id,
                                          manager_id,
                                          staff_name,
                                          2 as staff_level_counter
                                   FROM staff
                                   WHERE staff_id = 1
                                   UNION
                                   SELECT clone.staff_id,
                                          clone.manager_id,
                                          clone.staff_name,
                                          staff_level_counter + 1
                                   FROM staff as clone
                                            INNER JOIN staff_structure s ON s.staff_id = clone.manager_id)
SELECT manager_id
FROM (SELECT manager_id, count(*) as count_peers, max_peers
      FROM staff_structure,
           (SELECT max(count_peers) as max_peers
            FROM (SELECT manager_id, count(*) as count_peers
                  FROM staff_structure
                  GROUP BY manager_id) as counts) as max_val
      GROUP BY manager_id, max_peers) as mgr
WHERE count_peers = max_peers;


-- Find staff under those managers, sort by id, limit 1
WITH RECURSIVE staff_structure AS (SELECT staff_id,
                                          manager_id,
                                          staff_name,
                                          2 as staff_level_counter
                                   FROM staff
                                   WHERE staff_id = 1
                                   UNION
                                   SELECT clone.staff_id,
                                          clone.manager_id,
                                          clone.staff_name,
                                          staff_level_counter + 1
                                   FROM staff as clone
                                            INNER JOIN staff_structure s ON s.staff_id = clone.manager_id)
SELECT staff_id, mgr.manager_id
FROM staff_structure,
     (SELECT manager_id
      FROM (SELECT manager_id, count(*) as count_peers, max_peers
            FROM staff_structure,
                 (SELECT max(count_peers) as max_peers
                  FROM (SELECT manager_id, count(*) as count_peers
                        FROM staff_structure
                        GROUP BY manager_id) as counts) as max_val
            GROUP BY manager_id, max_peers) as mgr
      WHERE count_peers = max_peers) as mgr
WHERE staff_structure.manager_id = mgr.manager_id
ORDER BY staff_id
LIMIT 1;


-- Update: I stick to the above for answering the question as how it is written, but apparently "Peers are defined as
-- employees who share both the same manager and the same level in the hierarchy." means "Ignore the part about manager,
-- peers are defined as people on the same level in the hierarchy."
-- Because of that, different approach is needed... (which I sort-of like because it means I get to solve 2 problems)


-- Find the most common org level
WITH RECURSIVE staff_structure AS (SELECT staff_id,
                                          manager_id,
                                          staff_name,
                                          2 as staff_level_counter
                                   FROM staff
                                   WHERE staff_id = 1
                                   UNION
                                   SELECT clone.staff_id,
                                          clone.manager_id,
                                          clone.staff_name,
                                          staff_level_counter + 1
                                   FROM staff as clone
                                            INNER JOIN staff_structure s ON s.staff_id = clone.manager_id)
SELECT COUNT(*) as count_level, staff_level_counter
FROM staff_structure
GROUP BY staff_level_counter
ORDER BY count_level DESC
LIMIT 1;


-- Find all workers from that org level and pick lowest id
WITH RECURSIVE staff_structure AS (SELECT staff_id,
                                          manager_id,
                                          staff_name,
                                          2 as staff_level_counter
                                   FROM staff
                                   WHERE staff_id = 1
                                   UNION
                                   SELECT clone.staff_id,
                                          clone.manager_id,
                                          clone.staff_name,
                                          staff_level_counter + 1
                                   FROM staff as clone
                                            INNER JOIN staff_structure s ON s.staff_id = clone.manager_id)
SELECT staff_id
FROM staff_structure,
     (SELECT COUNT(*) as count_level, staff_level_counter as most_common_level
      FROM staff_structure
      GROUP BY staff_level_counter
      ORDER BY count_level DESC
      LIMIT 1) as cmn
WHERE staff_structure.staff_level_counter = most_common_level
ORDER BY staff_structure.staff_id
LIMIT 1;
