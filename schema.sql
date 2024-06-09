
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
