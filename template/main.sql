-- Template queries to overwrite for specific days


CREATE TABLE temp (
                         temp_char		varchar(80),
                         temp_int		int
);

CREATE TABLE temp2 (
                       temp_char		varchar(80),
                       temp_date	    date
);

INSERT INTO temp (temp_char, temp_int)
VALUES ('Case 1', 43);

INSERT INTO temp (temp_char, temp_int)
VALUES ('Case 2', 44);

INSERT INTO temp2 (temp_date, temp_char)
VALUES ('1994-11-29', 'Case 1');

INSERT INTO temp2 (temp_date, temp_char)
VALUES ('1994-11-30', 'Case 2');

SELECT temp_int, temp_date
FROM temp JOIN temp2 ON temp.temp_char = temp2.temp_char;

DROP TABLE temp, temp2;
