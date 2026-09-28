USE sql_practice;

CREATE TABLE IF NOT EXISTS EXAMPLE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    gender VARCHAR(20),
    age int
);

INSERT INTO EXAMPLE (name, gender, age) VALUES  ('Sourav', 'Male', 24);


SELECT * FROM EXAMPLE;