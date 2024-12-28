# adventofsql
Repository for participating in the Advent of SQL event, which was live from December 1st to 24th on its 
[website](https://www.adventofsql.com/) (plus an additional example challenge that was released ahead of December). You can still participate, as
the challenges for each day are still online! So practice your SQL skills, learn a new SQL flavour, or try to solve
these problems without SQL - multiple ways to hone your skills using this set of challenges. 

And if you want some structure to help you get started, you can clone this repository, remove the `2024` folder, and
use it as described below.

## Setup(s)
Currently, most of the manual setup is done using the commands in the Makefile based on the variables DAY and YEAR: you
can use the Makefile to generate a new folder following the `YYYY/dd/` structure (although not needed if you only
clone this repo since my solutions will be there). In this, the SQL commands that will generate the database can be put
in `advent_of_sql_day_x.sql` which is exactly the format used by the website. Then, the solution can be put in `main.sql`.

Note: for some days I had to manually change the contents in `advent_of_sql_day_x.sql` to actually delete the tables if
they already existed (like `DROP TABLE IF EXISTS tablename CASCADE;`) which is correctly there for most days but for 
some was left out or included without the `IF EXISTS` clause. This might be fixed on the website already or by the time
you make use of it.

Of course, you are free to run these .sql files in any way you want. For me, I have it setup right now such that I can:
- Run the command in `psql` myself by copying over, during testing and solving the problem. (Tip: you can load the data
  by running `\i 2024/XX/advent_of_sql_day_XX.sql;`).
  - For a few days you also need to have `postgis` installed to work with geographic data. The installation thereof is not
    part of this README.
- Run the collected commands using the Python script `main.py` in the project root, which automatically reads the
selected year/day from the Makefile.
  - This requires an install of `psycopg` as shown in the Makefile
- Run the collected commands using the Rust script `main.rs` in the src folder, which also automatically reads the
  selected year/day from the Makefile.
  - This requires the `postgres`, `rust_decimal` and `chrono` crates but of course this is specified exactly in 
  `Cargo.toml`.
- Run `make run_rs`, `make run_py` or `make run_both` to run the Makefile commands that use the Python and/or Rust
  scripts to get the results.

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
21. extract - LAG - CTE
22. _SPLIT_ - _CROSS JOIN_
23. CTE - LEAD - Island problem
24. CTE - count


(Items in italics I have worked around by using another approach.)