import psycopg

def get_content(file="main.sql"):
    file = open(file, "r")
    file_content = file.read()
    file.close()
    return file_content


def main():
    # Connect to an existing database
    with psycopg.connect("postgresql://postgres:localpass@localhost:5432/adventofsql") as conn:

        # Open a cursor to perform database operations
        with conn.cursor() as cur:

            content = get_content(file='advent_of_sql_day_0.sql')
            cur.execute(content)

            content = get_content()
            for x in content.split(';')[:-1]:
                cur.execute(x + ';')

            print('Answer is: ' + ", ".join(x[0] for x in cur))


if __name__ == "__main__":
    main()