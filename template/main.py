import psycopg

def get_content():
    file = open("main.sql", "r")
    file_content = file.read()
    file.close()
    return file_content


def main():
    print("This is the template Python code")

    # Connect to an existing database
    with psycopg.connect("postgresql://postgres:localpass@localhost:5432/adventofsql") as conn:

        # Open a cursor to perform database operations
        with conn.cursor() as cur:

            content = get_content()
            cur.execute(content)


if __name__ == "__main__":
    main()