
CREATE DATABASE IF NOT EXISTS `sql_grades`;

USE `sql_grades`;

-- Creating Tables

CREATE TABLE IF NOT EXISTS `students` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `papers` (
    `id` INT AUTO_INCREMENT,
    `student_id` INT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `grade` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`student_id`) REFERENCES students(`id`),
    CHECK (`grade` >= 0 AND `grade` <= 100)
);

-- Adding Data

INSERT INTO students (`first_name`) VALUES
('Caleb'),
('Samantha'),
('Raj'),
('Carlos'),
('Lisa');

INSERT INTO papers (student_id, title, grade) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(2, 'Borges and Magical Realism', 89);


-- Querying Data

-- 1. Find the grades and titles of students who have submitted papers.

SELECT 
    s.first_name, 
    p.title, 
    p.grade
FROM students s
INNER JOIN papers p
ON s.id = p.student_id
ORDER BY p.grade DESC;

-- 2. Find all the students with their papers.

SELECT 
    s.first_name,
    p.title,
    p.grade
FROM students s
LEFT JOIN papers p
ON s.id = p.student_id;

/*
-- 3. Find all the students with their papers and if any student 
has not given the paper then should be printed MISSING for title and 0 for grade.
*/

SELECT 
    s.first_name,
    IFNULL(p.title, 'MISSING') AS title,
    IFNULL(p.grade, 0) AS grade
FROM students s
LEFT JOIN papers p
ON s.id = p.student_id;

-- Alternatively, `COALESCE` statement

 can also be used instead of `IFNULL` function

SELECT 
    s.first_name,
    COALESCE(p.title, 'MISSING') AS title,
    COALESCE(p.grade, 0) AS grade
FROM students s
LEFT JOIN papers p ON s.id = p.student_id;

-- 4. Find the average grade of all students

SELECT 
    s.first_name,
    IFNULL(ROUND(AVG(p.grade), 2), 0) AS `average_grade`
FROM students s
LEFT JOIN papers p
ON s.id = p.student_id
GROUP BY 1;

-- 5. Find the average grade of all students with a passing status.

SELECT 
    s.first_name,
    IFNULL(ROUND(AVG(p.grade), 2), 0) AS `average_grade`,
    CASE
        WHEN IFNULL(ROUND(AVG(p.grade), 2), 0) > 60 THEN 'PASSING'
        ELSE 'FAILING'
    END AS `passing_status`    
FROM students s
LEFT JOIN papers p
ON s.id = p.student_id
GROUP BY 1;

-- Alternatively, `IF` function can also be used instead of `CASE` statement

SELECT 
    s.first_name,
    IFNULL(ROUND(AVG(p.grade), 2), 0) AS `average_grade`,
    IF(IFNULL(ROUND(AVG(p.grade), 2), 0) > 60, 'PASSING', 'FAILING') AS `passing_status`
FROM students s
LEFT JOIN papers p 
ON s.id = p.student_id
GROUP BY 1;