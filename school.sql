CREATE TABLE students (
  id         INTEGER PRIMARY KEY,
  first_name TEXT,
  last_name  TEXT,
  email      TEXT
);

CREATE TABLE classes (
  id         INTEGER PRIMARY KEY,
  name       TEXT,
  teacher    TEXT
);

CREATE TABLE grades(
  student_id INTEGER REFERENCES students ON DELETE RESTRICT,
  class_id   INTEGER REFERENCES classes ON DELETE RESTRICT,
  grade      TEXT
);

insert into students
  (id, first_name, last_name, email)
values
  (1, 'Haven', 'Domm', 'hdomm0@bing.com'),
  (2, 'Jena', 'Hehir', 'jhehir1@dell.com'),
  (3, 'Kaycee', 'Guise', 'kguise2@privacy.gov.au'),
  (4, 'Stephani', 'Kendall', 'skendall3@fotki.com'),
  (5, 'Loleta', 'Bastistini', 'lbastistini4@hao123.com'),
  (6, 'Pearce', 'Ofen', 'pofen5@slate.com'),
  (7, 'Keary', 'Elan', 'kelan6@nytimes.com'),
  (8, 'Paxton', 'Lapthorn', 'plapthorn7@fema.gov'),
  (9, 'Mordecai', 'Sichardt', 'msichardt8@amazon.de'),
  (10, 'Mead', 'Bidder', 'mbidder9@amazonaws.com');

insert into classes
  (id, name, teacher)
values
  (1, 'Algebra', 'Morse McLeoid'),
  (2, 'Chemistry', 'Salomo Fredy'),
  (3, 'Computer Science', 'Bernardine Wiskar'),
  (4, 'History', 'Aeriela Freed'),
  (5, 'Modern Economics', 'Mick Coates'),
  (6, 'Art Theory', 'Vince Stolberger'),
  (7, 'Sculpture', 'Cherianne Beddoes'),
  (8, 'Physical Education', 'Orlando Tidgewell'),
  (9, 'Engineering', 'Starlin Amps'),
  (10, 'Music Appreciation', 'Jaynell Ralston');

insert into grades
  (student_id, class_id, grade)
values
  (1, 6, 'C'),
  (1, 2, 'A'),
  (2, 2, 'B'),
  (2, 4, 'D'),
  (3, 8, 'A'),
  (3, 9, 'F'),
  (4, 1, 'B'),
  (4, 2, 'D'),
  (5, 2, 'D'),
  (5, 3, 'B'),
  (6, 3, 'F'),
  (6, 4, 'C'),
  (7, 5, 'C'),
  (7, 6, 'B'),
  (8, 7, 'C'),
  (8, 8, 'D'),
  (9, 8, 'A'),
  (9, 3, 'F'),
  (10, 3, 'C'),
  (10, 4, 'A'),
  (1, 9, 'A'),
  (2, 9, 'A'),
  (4, 9, 'C'),
  (5, 9, 'B');

-- All students who have taken a particular class.

SELECT s.*
FROM students AS s
JOIN grades AS g
ON s.id = g.student_id
JOIN classes AS c
ON g.class_id = c.id
WHERE c.name = 'Art Theory';

-- The number of each grade (using letter grades A-F) earned in a particular class.

SELECT COUNT(g.grade) as number_of_each, g.grade
FROM grades AS g
JOIN classes AS c
ON g.class_id = c.id
GROUP BY g.grade, c.name
HAVING c.name = 'Engineering';

-- Class names and the total number of students who have taken each class in the list.

SELECT c.name, COUNT (g.class_id)
FROM classes AS c
FULL JOIN grades AS g
ON c.id = g.class_id
GROUP BY c.name
ORDER BY c.name;

-- The class taken by the largest number of students.

SELECT c.name, COUNT (g.class_id) as students
FROM classes AS c
FULL JOIN grades AS g
ON c.id = g.class_id
GROUP BY c.name
ORDER BY students DESC
LIMIT 1;
