from pymongo import MongoClient

# I have database with user 'root' and password 'example', replace it if needed
client = MongoClient("mongodb://root:example@localhost:27017")
db = client['test']
col = db["restaurants"]


def exercise_1():
    print("== Query all Irish cuisines ==")
    result = col.find({"cuisine": "Irish"})
    for restaurant in result:
        print(restaurant["name"])

    print("== Query all Irish and Russian cuisines ==")
    result = col.find({"$or": [{"cuisine": "Irish"}, {"cuisine": "Russian"}]})
    for restaurant in result:
        print(restaurant["name"])

    print("== Find a restaurant with the following address: Prospect Park West 284, 11215 ==")
    restaurant = col.find_one(
        {"address.street": "Prospect Park West", "address.building": "284", "address.zipcode": "11215"}
    )
    print(restaurant["name"])


def exercise_2():
    new_restaurant = {
        "address": {
            "building": "126",
            "coord": [-73.9557413, 40.7720266],
            "street": "Sportivnaya",
            "zipcode": "420500"
        },
        "borough": "Innopolis",
        "cuisine": "Serbian",
        "name": "The Best Restaurant",
        "restaurant_id": "41712354",
        "grades": [
            {
                "date": "2023-04-04T00:00:00.000Z",
                "grade": "A",
                "score": 11
            }
        ]
    }
    result = col.insert_one(new_restaurant)
    print("Inserted document with id:", result.inserted_id)


def exercise_3():
    print("== Delete from the database a single Brooklyn located restaurant ==")
    result = col.delete_one({"borough": "Brooklyn"})
    print("Deleted documents count:", result.deleted_count)

    print("== Delete from the database all Thai cuisines ==")
    result = col.delete_many({"cuisine": "Thai"})
    print("Deleted documents count:", result.deleted_count)


def exercise_4():
    result = col.find({"address.street": "Prospect Park West"})

    for restaurant in result:
        grades = restaurant.get("grades", [])

        a_count = sum(1 for grade in grades if grade.get("grade") == "A")

        if a_count > 1:
            result = col.delete_one({"_id": restaurant["_id"]})
            print("Deleted restaurant with id:", restaurant["_id"])
        else:
            new_grade = {"date": "2023-04-04T00:00:00.000Z", "grade": "A", "score": 10}
            result = col.update_one({"_id": restaurant["_id"]}, {"$push": {"grades": new_grade}})
            print("Added A to restaurant with id:", restaurant["_id"])
