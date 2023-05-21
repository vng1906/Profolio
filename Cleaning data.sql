
--filter out year of making to show only from 2010 to 2023
--and delete with rollback incase of mistakes
BEGIN TRANSACTION
DELETE FROM cars
WHERE year <2010
ROLLBACK

--filter out mpg if there is null value or zero
-- and remove null and 00 records
SELECT mpg
FROM cars
WHERE mpg LIKE '0%' or mpg IS NULL
--------
BEGIN TRANSACTION
DELETE FROM cars
WHERE mpg IS NULL OR mpg LIKE '0%'
ROLLBACK
--Remove all null values because. Where the size of dataset would not affect the results.

DELETE
FROM cars
WHERE year IS NULL OR mileage IS NULL OR engine IS NULL OR transmission IS NULL
OR drivetrain IS NULL OR fuel_type IS NULL OR mpg IS NULL



--Changing name of column to make it easier to work with
EXEC sp_rename 'reliability.Make-Model', 'make_model', 'COLUMN'
EXEC sp_rename 'reliability.Overall Score', 'overall_score', 'COLUMN'


SELECT *
FROM cars

--Standardize data types

UPDATE cars
SET make = CONVERT(nvarchar(255),make)

UPDATE cars
SET model = CONVERT(nvarchar(255),model)

UPDATE cars
SET year = CONVERT(numeric,year)

--Standardize engine size
SELECT SUBSTRING(engine, 1,7) as split_engine, engine
FROM cars

SELECT COUNT(engine_size) as count_engine, REPLACE(TRIM(engine_size),' ','')
from cars
GROUP BY engine_size 
ORDER by engine_size

SELECT COUNT(engine_size) as count_engine, REPLACE(TRIM(engine_size),' ','')
from cars

ALTER TABLE cars
ADD engine_size nvarchar(255);

UPDATE cars
SET engine_size = SUBSTRING(engine, 1,5)

UPDATE cars
SET engine_size = REPLACE(TRIM(engine_size),' ','')

SELECT REPLACE(engine_size, engine_size, '1.5L') as NEW, engine_size
from cars
WHERE engine_size LIKE '1.5L%'

UPDATE cars
SET engine_size = REPLACE(engine_size, engine_size, '1.5L')
WHERE engine_size LIKE '1.5L%' OR engine_size = 'Gas I4 1.5L/'

UPDATE cars
SET engine_size = REPLACE(engine_size, engine_size, '2.0L')
WHERE engine_size LIKE '2.0L%'


SELECT engine_size
FROM cars
WHERE engine_size NOT LIKE '1.%' AND 
engine_size NOT LIKE '2.%' AND
engine_size NOT LIKE '3.%'

--Remove all engine sizes that bigger than 3.L
BEGIN TRANSACTION
DELETE FROM cars
WHERE engine_size NOT LIKE '1.%' AND 
engine_size NOT LIKE '2.%' AND
engine_size NOT LIKE '3.%'
ROLLBACK

ALTER TABLE cars
DROP COLUMN engine

select * from cars