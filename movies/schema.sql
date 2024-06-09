CREATE DATABASE IF NOT EXISTS `sql_movies`;

USE `sql_movies`;

-- Creating Tables

CREATE TABLE IF NOT EXISTS `series` (
    `id` INT AUTO_INCREMENT,
    `title` VARCHAR(200) NOT NULL,
    `released_year` YEAR NOT NULL,
    `genre` VARCHAR(100) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `reviewers` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `reviews` (
    `id` INT AUTO_INCREMENT,
    `series_id` INT NOT NULL,
    `reviewer_id` INT NOT NULL,
    `rating` DECIMAL(2, 1) NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`series_id`) REFERENCES series(`id`) ON DELETE CASCADE,
    FOREIGN KEY(`reviewer_id`) REFERENCES reviewers(`id`) ON DELETE CASCADE,
);

-- Adding Data

INSERT INTO series (title, released_year, genre) VALUES
('Archer', 2009, 'Animation'),
('Arrested Development', 2003, 'Comedy'),
("Bob's Burgers", 2011, 'Animation'),
('Bojack Horseman', 2014, 'Animation'),
('Breaking Bad', 2008, 'Drama'),
('Curb Your Enthusiasm', 2000, 'Comedy'),
('Fargo', 2014, 'Drama'),
('Freaks and Geeks', 1999, 'Comedy'),
('General Hospital', 1963, 'Drama'),
('Halt and Catch Fire', 2014, 'Drama'),
('Malcolm In The Middle', 2000, 'Comedy'),
('Pushing Daisies', 2007, 'Comedy'),
('Seinfeld', 1989, 'Comedy'),
('Stranger Things', 2016, 'Drama');

INSERT INTO reviewers (first_name, last_name) VALUES
('Thomas', 'Stoneman'),
('Wyatt', 'Skaggs'),
('Kimbra', 'Masters'),
('Cortes', 'Domingo'),
('Colt', 'Steele'),
('Pinkie', 'Petit'),
('Marlon', 'Crafford');

INSERT INTO reviews (series_id, reviewer_id, `rating`) VALUES
(7, 0, 7.8),
(8, 1, 7.8),
(7, 0, 6.5),
(8, 5, 9.9),
(6, 1, 3.0),
(8, 5, 8.8),
(5, 1, 9.5),
(9, 3, 7.7),
(7, 7, 8.5),
(7, 7, 8.0),
(7, 8, 8.0),
(8, 5, 9.9),
(4, 6, 9.3),
(7, 7, 7.0),
(7, 8, 9.9),
(9, 7, 6.4),
(6, 4, 6.5),
(6, 4, 4.5),
(5, 5, 5.0),
(5, 5, 5.0),
(5, 5, 5.0);