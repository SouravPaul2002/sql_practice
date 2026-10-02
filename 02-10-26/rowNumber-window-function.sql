/*
===========================================================
SQL WINDOW FUNCTIONS - PRACTICE 03
===========================================================

TOPIC:
ROW_NUMBER() with PARTITION BY and ORDER BY

-----------------------------------------------------------
QUESTION
-----------------------------------------------------------

For each subject, assign a unique row number to every
student based on their marks.

The student with the highest marks in each subject should
get row number 1.

Important:
- The numbering should restart for every subject.
- Even if two students have the same marks, they should
  receive different row numbers.

Expected idea:

Math:
Rahul  90 -> 1
Amit   80 -> 2
Priya  80 -> 3

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
4. YOUR SOLUTION
===========================================================

For each subject:
    - Create a separate partition
    - Sort students by marks from highest to lowest
    - Assign a unique row number
===========================================================
*/

SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY subject
           ORDER BY marks DESC
       ) AS student_number
FROM students;


/*
===========================================================
5. QUERY BREAKDOWN
===========================================================

ROW_NUMBER()
------------
Assigns a unique number to every row.

PARTITION BY subject
--------------------
Creates a separate numbering group for each subject.

For example:

Math:
    Amit
    Rahul
    Priya

Science:
    Neha
    Rohan
    Sneha

English:
    Arjun
    Ananya
    Vikram

The numbering starts again from 1 for every subject.


ORDER BY marks DESC
-------------------
Sorts students inside each subject from highest marks
to lowest marks.

DESC means:

90
80
75

instead of:

75
80
90


Therefore:

Math:

Rahul   90 -> 1
Amit    80 -> 2
Priya   80 -> 3

Science:

Sneha   95 -> 1
Neha    85 -> 2
Rohan   70 -> 3


IMPORTANT:
ROW_NUMBER() always gives every row a unique number.

Even if two students have the same marks:

Amit   80 -> 2
Priya  80 -> 3


===========================================================
6. EXPECTED RESULT
===========================================================

student_id | student_name | subject | marks | student_number
-------------------------------------------------------------
2          | Rahul        | Math    | 90    | 1
1          | Amit         | Math    | 80    | 2
3          | Priya        | Math    | 80    | 3

6          | Sneha        | Science | 95    | 1
4          | Neha         | Science | 85    | 2
5          | Rohan        | Science | 70    | 3

8          | Ananya       | English | 88    | 1
9          | Vikram       | English | 88    | 2
7          | Arjun        | English | 65    | 3


===========================================================
KEY CONCEPT
===========================================================

ROW_NUMBER() OVER (
    PARTITION BY subject
    ORDER BY marks DESC
)

Read this as:

"For each subject, sort students by marks from highest
to lowest, and assign a unique number to each student."


===========================================================
*/