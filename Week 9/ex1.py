import psycopg2
from geopy.geocoders import Nominatim

geolocator = Nominatim(user_agent="my-dblab-hometask-week9")

def get_latitude_longitude(address):
    try:
        location = geolocator.geocode(address)
        if location is not None:
            return (location.latitude, location.longitude)
        else:
            return (0,0)
    except:
        return (0,0)

con = psycopg2.connect(database="dvdrental", user="user",
                       password="pwd", host="127.0.0.1", port="5000")

print("Database opened successfully")
cur = con.cursor()
cur.callproc('get_addresses', ())
row = cur.fetchone()
while row is not None:
    print("==== NEW ROW ==")
    print(row)
    r = row[2]
    lat, long = get_latitude_longitude(r)
    print("Lat, Long: ", lat, long)
    cur.execute("UPDATE address SET latitude = %s, longitude = %s WHERE address_id = %s", (lat, long, row[0]))
    print("Row updated")
    row = cur.fetchone()
cur.close()