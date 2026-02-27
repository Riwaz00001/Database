create database exercise;
use exercise;
create table MOVIE(
MOVIE_ID INT PRIMARY KEY,
TITLE VARCHAR(210),
YEAR DATE,
DIRECTOR VARCHAR(100)
);
CREATE TABLE USER(
USER_ID INT PRIMARY KEY,
NAME VARCHAR(120)
);
CREATE TABLE RATING(
FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
FOREIGN KEY (MOVIE_ID) REFERENCES MOVIE(MOVIE_ID),
USER_ID INT,
MOVIE_ID INT,
RATING INT,
RATING_DATE DATE
);
#find the title and year of movies that were created after the year 2000.
INSERT INTO MOVIE (MOVIE_ID, TITLE, YEAR, DIRECTOR)
VALUES
(4, 'The Dark Knight', '2008-07-18', 'Christopher Nolan'),
(5, 'Avatar', '2009-12-18', 'James Cameron'),
(6, 'The Shawshank Redemption', '1994-09-23', 'Frank Darabont'),
(7, 'Avengers: Endgame', '2019-04-26', 'Anthony and Joe Russo'),
(8, 'Joker', '2019-10-04', 'Todd Phillips');
INSERT INTO USER (USER_ID, NAME)
VALUES
(104, 'Anita'),
(105, 'Kiran'),
(106, 'Bikash'),
(107, 'Maya'),
(108, 'Arjun');
INSERT INTO RATING (USER_ID, MOVIE_ID, RATING, RATING_DATE)
VALUES
(104, 4, 5, '2025-02-24'),
(105, 5, 4, '2025-02-24'),
(106, 6, 5, '2025-02-25'),
(107, 7, 4, '2025-02-25'),
(108, 8, 3, '2025-02-26');
#Find title and year of movie which were created after year 2000.
SELECT TITLE,YEAR FROM MOVIE WHERE YEAR(YEAR)>2000;
#Find title,mid and rating of movies that were created vefore the year 2000, and Rating>2 
SELECT M.TITLE,M.MOVIE_ID FROM MOVIE M JOIN RATING R ON M.MOVIE_ID=R.MOVIE_ID WHERE M.YEAR<2000 AND RATING>2;
#sort all of the movies by descending rating
SELECT * FROM MOVIE M JOIN RATING R ON M.MOVIE_ID=R.MOVIE_ID ORDER BY R.RATING DESC;
#Find all movies that have the exact same Rating
SELECT MOVIE_ID,RATING,COUNT(*) AS TOTAL FROM RATING GROUP BY MOVIE_ID,RATING HAVING COUNT(*)>0;
#Create a query that looks for a movies id, title,and director but only if it has rating above 4
SELECT M.MOVIE_ID,M.TITLE,M.DIRECTOR FROM MOVIE M JOIN RATING R ON M.MOVIE_ID=R.MOVIE_ID WHERE R.RATING>4;