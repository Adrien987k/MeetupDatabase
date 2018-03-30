
import csv
import psycopg2

conn = psycopg2.connect("host=localhost dbname=postgres user=postgres")
cur = conn.cursor()

with open('user_accounts.csv', 'r') as f:
    reader = csv.reader(f)
    next(reader)  # Skip the header row.
    """for row in reader:
        cur.execute(
            "INSERT INTO users VALUES (%s, %s, %s, %s)",
            row
        )"""

    cur.copy_from('cities.csv', 'city', columns=('city_name', 'city_id', 'country', 'latitude', 'longitude', 'state')

conn.commit()
