# How to run this app?

$ ruby findNextBookingApp.rb test/fixtures/bookings.csv 100

# RESTful Implementation

HTTP codes -> 200 (OK), 404 (Endpoint doesnt exist), 401 (Application Error), 500 (Infrastructure Error)

a) Get all bookings for a room


==== REQUEST ====

```
GET /rooms/<room id>/bookings
```

==== RESPONSE ====

```
{
  'bookings': [
    'booking_id': 540,
    'person_id': 34,
    'start_time': "2015-04-01T05:00",
    'end_time': "2015-04-01T05:30",
    'duration': 30,
    'created_at': "2015-03-01T00:00",
    'updated_at': "2015-03-01T20:00"
  ]
}
```

b) Create a booking for a room

==== REQUEST ====

```
POST /rooms/<room id>/bookings
{
  'person_id': 34,
  'start_time': "2015-04-01T05:00",
  'duration': 30
}
```

==== RESPONSE ====

```
{
  'booking_id': 540
}
```

c) Delete a booking associated with a room

==== REQUEST ====

```
URL -> DELETE /rooms/<room id>/bookings/<booking id>
```

==== RESPONSE ====

```
Empty body
```

# Database Implementation

I would try out mongodb to store all the data.
- Data is already in JSON, so its easy to store it
- Basic relationship between entities, so queries will be simple
- Easy to deploy and maintain

Collections:
* Rooms
* Persons
* Bookings

Query Examples:
1. Get all bookings for room x
bookings.where(room_id: x)
2. Get all bookings for person x
bookings.where(person_id: x)
