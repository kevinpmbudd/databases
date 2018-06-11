CREATE TABLE rooms (
  id              INTEGER PRIMARY KEY,
  room_number     INTEGER,
  floor_number    INTEGER,
  price_per_night DECIMAL(6,2)
);

CREATE TABLE guests (
  id           INTEGER PRIMARY KEY,
  first_name   TEXT,
  last_name    TEXT,
  phone_number TEXT,
  email        TEXT,
  address      TEXT
);

CREATE TABLE bookings (
  id             INTEGER PRIMARY KEY,
  room_id        INTEGER REFERENCES rooms ON DELETE RESTRICT,
  guest_id       INTEGER REFERENCES guests ON DELETE RESTRICT,
  check_in_date  DATE,
  check_out_date DATE
);

insert into guests
  (id, first_name, last_name, phone_number, email, address)
values
  (1, 'Rosana', 'Gunderson', '997-611-5423', 'rgunderson0@google.com.au', '878 Cordelia Road'),
  (2, 'Lek', 'Shackel', '851-890-6267', 'lshackel1@imgur.com', '2065 Ridgeway Circle'),
  (3, 'Ber', 'Cathee', '562-643-6633', 'bcathee2@salon.com', '23332 Armistice Drive'),
  (4, 'Percival', 'Ridsdale', '369-287-9012', 'pridsdale3@forbes.com', '8 Granby Lane'),
  (5, 'Lola', 'Dureden', '988-977-0661', 'ldureden4@biglobe.ne.jp', '755 Lindbergh Lane'),
  (6, 'Madlen', 'OIlier', '983-603-2823', 'moilier5@nbcnews.com', '1760 Doe Crossing Terrace'),
  (7, 'Spencer', 'Litton', '794-231-7441', 'slitton6@unc.edu', '46032 Steensland Place'),
  (8, 'Rhea', 'Toulch', '736-571-7734', 'rtoulch7@time.com', '47830 Burrows Avenue'),
  (9, 'Marcela', 'Kerrigan', '743-165-4781', 'mkerrigan8@chron.com', '45154 Barnett Lane'),
  (10, 'Priscella', 'Bisp', '546-304-0746', 'pbisp9@cocolog-nifty.com', '95 Rutledge Lane');

insert into rooms
  (id, room_number, floor_number, price_per_night)
values
  (1, 101, 1, 255.89),
  (2, 102, 1, 176.47),
  (3, 103, 1, 227.38),
  (4, 201, 2, 297.86),
  (5, 202, 2, 229.44),
  (6, 203, 2, 121.0),
  (7, 301, 3, 245.69),
  (8, 302, 3, 262.34),
  (9, 401, 4, 236.87),
  (10, 402, 4, 219.23);

insert into bookings
  (id, room_id, guest_id, check_in_date, check_out_date)
values
  (1,  5,  4,  '07/16/2018', '07/17/2018'),
  (2,  6,  4,  '07/16/2018', '07/17/2018'),
  (3,  7, 9,  '07/19/2018', '07/25/2018'),
  (4,  5,  5,  '08/01/2018', '08/14/2018'),
  (5,  7,  9,  '08/10/2018', '08/15/2018'),
  (6,  2, 2, '10/05/2018', '10/26/2018'),
  (7,  7, 9,  '10/20/2018', '10/26/2018'),
  (8,  7, 1,  '10/29/2018', '11/04/2018'),
  (9,  1, 4, '11/02/2018', '11/06/2018'),
  (10, 5, 8, '12/11/2018', '12/19/2018');

-- guest(s) who have not booked a room

SELECT g.first_name, g.last_name
FROM guests AS g
LEFT JOIN bookings AS b
ON g.id = b.guest_id
WHERE b.guest_id IS NULL;

-- bookings for a guest who has booked two rooms for the same dates

SELECT g.first_name, g.last_name, b1.*
FROM bookings AS b1
INNER JOIN bookings AS b2
ON b1.guest_id = b2.guest_id
JOIN guests AS g
ON b1.guest_id = g.id
WHERE b1.check_in_date = b2.check_in_date
AND b1.check_out_date = b2.check_out_date
AND b1.room_id <> b2.room_id;

-- bookings for a guest who has booked one room several times on different dates

SELECT DISTINCT b1.*
FROM bookings AS b1
INNER JOIN bookings AS b2
ON  b1.room_id = b2.room_id
WHERE b1.guest_id = b2.guest_id
AND b1.check_in_date <> b2.check_in_date
AND b1.check_out_date <> b2.check_out_date;

-- Count the number of unique guests who have booked the same room

SELECT r.room_number, COUNT(DISTINCT b.guest_id) as unique_guests
FROM bookings AS b
JOIN rooms AS r
ON b.room_id = r.id
GROUP BY r.room_number;
