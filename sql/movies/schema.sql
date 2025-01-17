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
    FOREIGN KEY(`series_id`) REFERENCES series(`id`),
    FOREIGN KEY(`reviewer_id`) REFERENCES reviewers(`id`)
);

-- Adding Data

INSERT INTO series (`title`, `released_year`, `genre`) VALUES
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

INSERT INTO reviewers (`first_name`, `last_name`) VALUES
('Thomas', 'Stoneman'),
('Wyatt', 'Skaggs'),
('Kimbra', 'Masters'),
('Cortes', 'Domingo'),
('Colt', 'Steele'),
('Pinkie', 'Petit'),
('Marlon', 'Crafford');

INSERT INTO reviews(`series_id`, `reviewer_id`, `rating`) VALUES
(1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
(2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
(3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
(4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
(5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
(6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
(7,2,9.1),(7,5,9.7),
(8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
(9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
(10,5,9.9),
(13,3,8.0),(13,4,7.2),
(14,2,8.5),(14,3,8.9),(14,4,8.9);

-- Querying Data

-- 1. Find all the ratings for all shows which are rated.

SELECT 
    s.title, 
    r.rating
FROM series s
INNER JOIN reviews r
ON s.id = r.series_id

-- 2. Find the average ratings for all shows which are rated.

SELECT 
    s.title, 
    ROUND(AVG(r.rating), 1) as `average_rating`
FROM series s
INNER JOIN reviews r
ON s.id = r.series_id
GROUP BY 1
ORDER BY 2 DESC;

-- 3. Find the rating of all reviewers.

SELECT 
    re.first_name,
    re.last_name,
    rv.rating
FROM reviewers re
INNER JOIN reviews rv 
ON re.id = rv.reviewer_id

-- 4. Find the titles of the series which are not reviewed yet.

SELECT 
    s.title AS `unreviewed_series`
FROM series s
LEFT JOIN reviews r ON s.id = r.series_id
WHERE r.series_id IS NULL;

-- Alternatively, this can also be done with subquery

SELECT 
    s.title AS `unreviewed_series`
FROM series s
WHERE NOT EXISTS (
    SELECT 1
    FROM reviews r
    WHERE s.id = r.series_id
);

-- 5. Find the average rating of each genre

SELECT 
    s.genre,
    ROUND(AVG(r.rating), 1) as `avg_rating`
FROM series s
INNER JOIN reviews r
ON s.id = r.series_id
GROUP BY 1
ORDER BY 2 DESC;

-- 6. Find the count, min, max, avg and status of each reviewer

SELECT 
    re.first_name,
    re.last_name,
    COUNT(rv.reviewer_id) as `COUNT`,
    IFNULL(ROUND(MIN(rv.rating), 2), 0.0) as `MIN`,
    IFNULL(ROUND(MAX(rv.rating), 2), 0.0) as `MAX`,
    IFNULL(ROUND(AVG(rv.rating), 2), 0.0) as `AVG`,
    IF(COUNT(rv.reviewer_id) = 0, 'INACTIVE', 'ACTIVE') as `STATUS`
FROM reviewers re
LEFT JOIN reviews rv
ON re.id = rv.reviewer_id
GROUP BY rv.reviewer_id, re.first_name, re.last_name;

-- 7. Find all the ratings for each series by every review

SELECT
    s.title,
    rv.rating,
    CONCAT(re.first_name, ' ', re.last_name) AS `reviewer`
FROM series s
INNER JOIN reviews rv
ON s.id = rv.series_id
INNER JOIN reviewers re
ON re.id = rv.reviewer_id;