-- Make sure to run `advent_of_sql_day_x.sql` first, which you need to get from the website
-- My approach is to step by step show how I have build up the queries, but only the last one really matters


-- Plan:
-- For each play, find whether it is skipped or not
    -- If len is NULL, any non Null is fine supposedly? (this song can have multiple lengths for different versions)
    -- if len is not NULL, compare with this len
-- Aggregate over songs for full and skipped
-- Order according to challenge and LIMIT 1


-- For each play, find whether it is skipped or not
SELECT songs.song_id,
       song_duration,
       duration,
       coalesce(duration, -1) < coalesce(song_duration, 0) as skip  -- Captures the NULL logic shown by example
FROM songs
         JOIN user_plays ON songs.song_id = user_plays.song_id;


-- Aggregate over songs for full and skipped
WITH skips as (SELECT songs.song_id,
                      song_duration,
                      duration,
                      coalesce(duration, -1) < coalesce(song_duration, 0) as skip
               FROM songs
                        JOIN user_plays ON songs.song_id = user_plays.song_id)
SELECT count(*), sum(skip::int)
FROM skips
GROUP BY song_id;


-- Order according to challenge and LIMIT 1
SELECT song_title
FROM (WITH skips as (SELECT songs.song_title,
                            songs.song_id,
                            song_duration,
                            duration,
                            coalesce(duration, -1) < coalesce(song_duration, 0) as skip
                     FROM songs
                              JOIN user_plays ON songs.song_id = user_plays.song_id)
      SELECT song_title, count(*) as count, sum(skip::int) as skips
      FROM skips
      GROUP BY song_title, song_id
      ORDER BY count DESC, skips
      LIMIT 1) as res;
