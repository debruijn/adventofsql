# adventofsql
Repository for participating in the upcoming Advent of SQL event, which will be live from December 1st on its 
[website](https://www.adventofsql.com/). So far, we have gotten one example challenge, based on which I have setup this repository to be
well prepared. Since PostgresQL (the main target of the event) is a new flavour of SQL for me, I want to make sure I
can hit the ground running this December with a tested setup.

Will you join too? Submit your email address on the website!

## Setup(s)
Currently, you can use the Makefile to generate a new folder following the `YYYY/dd/` structure. In this, the SQL
commands that will generate the database can be put in `advent_of_sql_day_x.sql` since that is the format used by the
website for the example. Then, the solution can be put in `main.sql`.

Of course, you are free to run these .sql files in any way you want. For me, I have it setup right now such that I can:
- Run the command in `psql` myself by coping over, during testing and solving the problem.
- Run the collected commands using the Python script `main.py` in the project root, after adding it to the loop that
calls the main function
  - This requires an install of `psycopg` as shown in the Makefile
- Run the collected commands using the Rust script `main.rs` in the src folder, after adding it to the vector in the
main function
  - This requires the `postgres` and `itertools` crates but of course this is specified exactly in `Cargo.toml`.

The Python and Rust implementations will only print the results of the last statement, based on the assumption that the
earlier statements will be setup statements, of one of the following types:
- Showing step by step how to get to the final query (like in the example challenge)
- Generating a temporary table to make the final query easier/faster

## Keeping track of skills used per challenge according to the creator:
1. JSON - Case - Joins
2. _UNION_ - CTE (Common Table Expressions) - ASCII - String agg
3. CTE - XML
4. Array functions - SET operations
5. LAG - ROUND - Window functions
6. Subquery - Aggregates
7. CTE - window_function
8. recursive_cte
9. CTE - Aggregate functions
10. PIVOT - CTE
11. Average over - Window functions
12. percentile - window functions
13. Window functions - _Temporary tables_ - Array agg
14. array functions - json functions
15. Geometry (PostGIS)
16. LAG - Geometry - Lead - CTE
17. CTE - Timezone
18. Recursive CTE - Aggregates
19. CROSS JOIN - SUM - ROUND
20. _JSON_ - CTE - _JSON_OBJECT_AGG_


(Items in italics I have worked around by using another approach.)