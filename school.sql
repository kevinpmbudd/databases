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

insert into students (id, first_name, last_name, email) values (1, 'Haven', 'Domm', 'hdomm0@bing.com');
insert into students (id, first_name, last_name, email) values (2, 'Jena', 'Hehir', 'jhehir1@dell.com');
insert into students (id, first_name, last_name, email) values (3, 'Kaycee', 'Guise', 'kguise2@privacy.gov.au');
insert into students (id, first_name, last_name, email) values (4, 'Stephani', 'Kendall', 'skendall3@fotki.com');
insert into students (id, first_name, last_name, email) values (5, 'Loleta', 'Bastistini', 'lbastistini4@hao123.com');
insert into students (id, first_name, last_name, email) values (6, 'Pearce', 'Ofen', 'pofen5@slate.com');
insert into students (id, first_name, last_name, email) values (7, 'Keary', 'Elan', 'kelan6@nytimes.com');
insert into students (id, first_name, last_name, email) values (8, 'Paxton', 'Lapthorn', 'plapthorn7@fema.gov');
insert into students (id, first_name, last_name, email) values (9, 'Mordecai', 'Sichardt', 'msichardt8@amazon.de');
insert into students (id, first_name, last_name, email) values (10, 'Mead', 'Bidder', 'mbidder9@amazonaws.com');

insert into classes (id, name, teacher) values (1, 'Algebra', 'Morse McLeoid');
insert into classes (id, name, teacher) values (2, 'Chemistry', 'Salomo Fredy');
insert into classes (id, name, teacher) values (3, 'Computer Science', 'Bernardine Wiskar');
insert into classes (id, name, teacher) values (4, 'History', 'Aeriela Freed');
insert into classes (id, name, teacher) values (5, 'Modern Economics', 'Mick Coates');
insert into classes (id, name, teacher) values (6, 'Art Theory', 'Vince Stolberger');
insert into classes (id, name, teacher) values (7, 'Sculpture', 'Cherianne Beddoes');
insert into classes (id, name, teacher) values (8, 'Physical Education', 'Orlando Tidgewell');
insert into classes (id, name, teacher) values (9, 'Engineering', 'Starlin Amps');
insert into classes (id, name, teacher) values (10, 'Music Appreciation', 'Jaynell Ralston');

insert into grades (student_id, class_id, grade) values (1, 6, 'C');
insert into grades (student_id, class_id, grade) values (1, 2, 'A');
insert into grades (student_id, class_id, grade) values (2, 2, 'B');
insert into grades (student_id, class_id, grade) values (2, 4, 'D');
insert into grades (student_id, class_id, grade) values (3, 8, 'A');
insert into grades (student_id, class_id, grade) values (3, 9, 'F');
insert into grades (student_id, class_id, grade) values (4, 1, 'B');
insert into grades (student_id, class_id, grade) values (4, 2, 'D');
insert into grades (student_id, class_id, grade) values (5, 2, 'D');
insert into grades (student_id, class_id, grade) values (5, 3, 'B');
insert into grades (student_id, class_id, grade) values (6, 3, 'F');
insert into grades (student_id, class_id, grade) values (6, 4, 'C');
insert into grades (student_id, class_id, grade) values (7, 5, 'C');
insert into grades (student_id, class_id, grade) values (7, 6, 'B');
insert into grades (student_id, class_id, grade) values (8, 7, 'C');
insert into grades (student_id, class_id, grade) values (8, 8, 'D');
insert into grades (student_id, class_id, grade) values (9, 8, 'A');
insert into grades (student_id, class_id, grade) values (9, 3, 'F');
insert into grades (student_id, class_id, grade) values (10, 3, 'C');
insert into grades (student_id, class_id, grade) values (10, 4, 'A');
insert into grades (student_id, class_id, grade) values (1, 9, 'A');
insert into grades (student_id, class_id, grade) values (2, 9, 'A');
insert into grades (student_id, class_id, grade) values (4, 9, 'C');
insert into grades (student_id, class_id, grade) values (5, 9, 'B');

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
