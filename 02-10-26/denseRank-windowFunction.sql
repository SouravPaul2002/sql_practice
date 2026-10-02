/*
===========================================================
SQL WINDOW FUNCTIONS - PRACTICE 02
===========================================================

TOPIC:
DENSE_RANK() with PARTITION BY and ORDER BY


===========================================================
QUESTION
===========================================================

For each subject, rank the students based on their marks.

The student with the highest marks should get rank 1.

Students with the same marks should receive the same rank.

Use DENSE_RANK().


Expected idea:

Math:

Rahul  90 -> 1
Amit   80 -> 2
Priya  80 -> 2

Science:

Sneha  95 -> 1
Neha   85 -> 2
Rohan  70 -> 3


===========================================================
SCHEMA
===========================================================

Table: students

Columns:

    student_id      INT
    student_name    VARCHAR(50)
    subject         VARCHAR(50)
    marks           INT


===========================================================
1. CREATE TABLE
===========================================================
*/

CREATE TABLE students (
    student_id INT,
    student_name VARCHAR(50),
    subject VARCHAR(50),
    marks INT
);


/*
===========================================================
2. INSERT DATA
===========================================================
*/

INSERT INTO students (student_id, student_name, subject, marks)
VALUES
    (1, 'Amit',   'Math',    80),
    (2, 'Rahul',  'Math',    90),
    (3, 'Priya',  'Math',    80),
    (4, 'Neha',   'Science', 85),
    (5, 'Rohan',  'Science', 70),
    (6, 'Sneha',  'Science', 95),
    (7, 'Arjun',  'English', 65),
    (8, 'Ananya', 'English', 88),
    (9, 'Vikram', 'English', 88);


/*
===========================================================
3. CHECK THE DATA
===========================================================
*/

SELECT *
FROM students;


/*
===========================================================
4. MY SOLUTION
===========================================================

This is the solution I wrote while practicing.
===========================================================
*/

SELECT student_name AS name,
       subject,
       marks,
       DENSE_RANK() OVER (
           PARTITION BY subject
           ORDER BY marks DESC
       ) AS subject_total
FROM students;


/*
===========================================================
5. EXPLANATION
===========================================================

DENSE_RANK()
------------
Assigns a rank to each row.

PARTITION BY subject
--------------------
Creates a separate ranking for each subject.

So Math students are ranked separately from Science
students and English students.


ORDER BY marks DESC
-------------------
Sorts the students from highest marks to lowest marks.

DESC means highest value comes first.


Example:

Math:

Rahul   90 -> rank 1
Amit    80 -> rank 2
Priya   80 -> rank 2


IMPORTANT:
DENSE_RANK() gives the same rank to students who have
the same marks.

Also, DENSE_RANK() does not skip the next rank.

Example:

90 -> 1
80 -> 2
80 -> 2
70 -> 3


===========================================================
6. EXPECTED RESULT
===========================================================

name   | subject | marks | subject_total
-----------------------------------------
Rahul  | Math    | 90    | 1
Amit   | Math    | 80    | 2
Priya  | Math    | 80    | 2

Sneha  | Science | 95    | 1
Neha   | Science | 85    | 2
Rohan  | Science | 70    | 3

Ananya | English | 88    | 1
Vikram | English | 88    | 1
Arjun  | English | 65    | 2


===========================================================
7. IMPORTANT NOTE ABOUT MY ALIAS
===========================================================

I originally used:

    AS subject_total

This works technically, but the name is misleading because
the column contains a rank, not a total.

A better alias would be:

    AS subject_rank

So the cleaner version is:

*/

SELECT student_name AS name,
       subject,
       marks,
       DENSE_RANK() OVER (
           PARTITION BY subject
           ORDER BY marks DESC
       ) AS subject_rank
FROM students;


/*
===========================================================
KEY CONCEPT
===========================================================

DENSE_RANK() OVER (
    PARTITION BY subject
    ORDER BY marks DESC
)

Read it as:

"For each subject, sort students by marks from highest
to lowest and assign ranks. Students with equal marks
receive the same rank."


===========================================================
DENSE_RANK() vs ROW_NUMBER()
===========================================================

DENSE_RANK():

90 -> 1
80 -> 2
80 -> 2
70 -> 3


ROW_NUMBER():

90 -> 1
80 -> 2
80 -> 3
70 -> 4


DENSE_RANK() allows ties.
ROW_NUMBER() always gives every row a unique number.


===========================================================
*/