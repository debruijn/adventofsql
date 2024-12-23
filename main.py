import psycopg


def get_content(file="main.sql"):
    file = open(file, "r")
    file_content = file.read()
    file.close()
    return file_content


def main(day_str='01'):
    day_int = int(day_str)

    with psycopg.connect("postgresql://postgres:localpass@localhost:5432/adventofsql") as conn:
        with conn.cursor() as cur:
            # Prepare input - make sure to download this from the Advent of SQL website for each day
            content = get_content(file=f'2024/{day_str}/advent_of_sql_day_{day_int}.sql')
            cur.execute(content)

            # Solve puzzle
            content = get_content(file=f'2024/{day_str}/main.sql')
            for x in content.split(';')[:-1]:
                cur.execute(x + ';')

            # Print answer based on final query
            print(f'Answer {day_str}: \n' + "\n".join(",".join(str(y) for y in x) for x in cur))


if __name__ == "__main__":
    day = get_content('Makefile').split('\n', 1)[0].replace("DAY=", "")
    main(day)
