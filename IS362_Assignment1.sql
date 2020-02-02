-- 1. How many airplanes have listed speeds?
SELECT 
COUNT(*) AS 'Count of Planes with listed Speeds' 
FROM planes
WHERE speed IS NOT NULL;

/*What is the minimum listed speed and the maximum listed speed?*/

SELECT speed  AS 'Planes Minimum listed speed' 
FROM planes
WHERE speed IS NOT NULL
ORDER BY speed ASC LIMIT 1;

SELECT speed  AS 'Planes Maximum listed speed' 
FROM planes
WHERE speed IS NOT NULL
ORDER BY speed DESC LIMIT 1;

/*2. What is the total distance flown by all of the planes in January 2013?*/

SELECT SUM(distance) AS 'Total distance flown by all of the planes on January 2013'
FROM flights
WHERE month = 1 AND year = 2013;
-- What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?
SELECT SUM(distance) AS 'Total distance flown by all of the planes on January 2013 where the tailnum is missing.'
FROM flights
WHERE month = 1 AND year = 2013 AND tailnum IS NULL;

/*3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? 
Write this statement first using an INNER JOIN, 
then using a LEFT OUTER JOIN. How do your results compare?*/
SELECT p.manufacturer, SUM(f.distance)
From planes p
INNER JOIN flights f
ON p.tailnum = f.tailnum
WHERE f.month = 7 AND f.day = 5 AND f.year = 2013
GROUP BY p.manufacturer;

SELECT p.manufacturer, SUM(f.distance)
From planes p
LEFT OUTER JOIN flights f
ON p.tailnum = f.tailnum
WHERE f.month = 7 AND f.day = 5 AND f.year = 2013
GROUP BY p.manufacturer;

/*4. Write and answer at least one question of your own choosing that joins information from at 
least three of the tables in the flights database.*/
-- What is the avreage delay for flights at 3 NYC Airports by manufacturer?
SELECT a.name, CONCAT(f.year,'/', f.month, '/', f.day) AS 'Date',
IF(f.tailnum = '', 'Unkown Aircraft', f.tailnum) as 'Aircraft' ,
IF(p.manufacturer = '', 'Unknown Manufacturer', p.manufacturer) as 'Manufacturer',
AVG(IFNULL(arr_delay, 0)) AS 'Average Delay', COUNT(*) AS 'Number of Flights'
FROM flights f
INNER JOIN planes p 
ON f.tailnum = p.tailnum
LEFT JOIN airports a
ON f.origin = a.faa
GROUP BY a.name, f.tailnum , p.manufacturer, f.year, f.month, f.day
ORDER BY a.name, f.year, f.month, f.day;

-- Link to Tableau workbook representing this data 
-- https://public.tableau.com/views/IS361Assignment1/Dashboard1?:display_count=y&publish=yes&:origin=viz_share_link
