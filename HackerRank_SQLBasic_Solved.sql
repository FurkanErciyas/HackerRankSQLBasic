Use master;

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'HackerRankSQLBasic') CREATE DATABASE HackerRankSQLBasic;

GO

USE HackerRankSQLBasic;
GO

DROP TABLE IF EXISTS City
GO

DROP TABLE IF EXISTS Country
GO

DROP TABLE IF EXISTS Station
GO

DROP TABLE IF EXISTS Students
GO

DROP TABLE IF EXISTS Employee
GO

DROP TABLE IF EXISTS Occupations
GO

DROP TABLE IF EXISTS Employees
GO

DROP TABLE IF EXISTS Triangles
GO

CREATE TABLE City(
	Id INT PRIMARY KEY,
	Name NVARCHAR(17),
	CountryCode NVARCHAR(3),
	District NVARCHAR(20),
	Population INT
);
GO

CREATE TABLE Country(
	Code NVARCHAR(3),
	Name NVARCHAR(44),
	Continent NVARCHAR(13),
	Region NVARCHAR(25),
	Surfacearea INT,
	Indepyear NVARCHAR(5),
	Population INT,
	Lifeexpectancy NVARCHAR(4),
	Gnp INT,
	Gnpold NVARCHAR(9),
	Localname NVARCHAR(44),
	Governmentform NVARCHAR(44),
	Headofstate NVARCHAR(32),
	Capital NVARCHAR(4),
	Code2 NVARCHAR(2)
);
GO

CREATE TABLE Station(
	Id INT PRIMARY KEY,
	City NVARCHAR(21),
	State NVARCHAR(2),
	Lat_N DECIMAL,
	Long_W DECIMAL
);
GO

CREATE TABLE Students(
	Id INT PRIMARY KEY,
	Name NVARCHAR,
	Marks INT
);
GO

CREATE TABLe Employee(
	Employee_Id INT PRIMARY KEY,
	Name NVARCHAR,
	Months INT,
	Salary INT
);
GO

CREATE TABLE Occupations(
	Name NVARCHAR,
	Occupation NVARCHAR
);
GO

CREATE TABLE Employees(
	Id INT PRIMARY KEY,
	Name NVARCHAR,
	Salary INT
);
GO

CREATE TABLE Triangles(
	A INT,
	B INT,
	C INT
);
GO

/* -------------------------------------------------------------------- HackerRank: Prepare > SQL > Basic Select > Query ------------------------------------------------------------------- */


/* Revising The Select Query I */
SELECT * FROM City WHERE CountryCode = N'USA' AND Population > 100000; 

/* Resiving The Select Query II */
SELECT Name FROM City WHERE CountryCode = N'USA' AND Population > 120000; 

/* Select All */
SELECT * FROM City; 

/* Select By Id */
SELECT * FROM City WHERE Id = 1661; 

/* Japanese Cities Attributes */
SELECT * FROM City WHERE CountryCode = N'JPN'; 

/* Japanese Cities Names */
SELECT Name FROM City WHERE CountryCode = N'JPN'; 

/* Weather Observation Station 1 */
SELECT City, State FROM Station; 

/* Weather Observation Station 3 */
SELECT DISTINCT City FROM Station WHERE Id%2 = 0; 

/* Weather Observation Station 4 */
SELECT COUNT(City) - COUNT(DISTINCT City) FROM Station; 

/* Weather Observation Station 6 */
SELECT DISTINCT City FROM Station WHERE City LIKE N'[aeiou]%'; 

/* Weather Observation Station 7 */
SELECT DISTINCT City FROM Station WHERE City LIKE N'½[aeiou]'; 

/* Weather Observation Station 8 */
SELECT DISTINCT City FROM Station WHERE City LIKE N'[aeiou]½[aeiou]'; 

/* Weather Observation Station 9 */
SELECT DISTINCT City FROM Station WHERE City NOT LIKE N'[aeiou]½'; 

/* Weather Observation Station 10 */
SELECT DISTINCT City FROM Station WHERE City NOT LIKE N'%[aeiou]'; 

/* Weather Observation Station 11 */
SELECT DISTINCT City FROM Station WHERE City NOT LIKE N'[aeiou]%' OR City NOT LIKE N'%[aeiou]'; 

/* Weather Observation Station 12 */
SELECT DISTINCT City FROM Station WHERE City NOT LIKE N'[aeiou]%' AND City NOT LIKE N'%[aeiou]'; 

/* Higher Than 75 Marks */
SELECT * FROM Students WHERE Marks > 75 ORDER BY RIGHT(Name, 3), Id; 

/* Employee Name */
SELECT Name FROM Employee ORDER BY Name; 

/* Employee Salaries */
SELECT Name FROM Employee WHERE Salary > 2000 AND Months < 10 ORDER BY Employee_Id; 

/* Type of Triangle */
SELECT CASE WHEN A = B AND B = C THEN 'Equilateral' WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'NOT A Triangle' WHEN A = B OR B = C OR A = C THEN 'Isosceles' ELSE 'Scalene' END FROM Triangles; 

/* The PADS - Example => Asyley(P) */
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')') FROM Occupations ORDER BY Name; 
/* The PADS - Example => There are a total of 7 professors. */
SELECT CONCAT('There are a total of ', COUNT(Occupation), ' ', LOWER(Occupation), 's.') FROM Occupations GROUP BY Occupation ORDER BY COUNT(Occupation), Occupation; 

/* Revising Aggregations - The Count Function */
SELECT COUNT(*) FROM City WHERE Population > 100000; 

/* Revising Aggregations - The Sum Function */
SELECT SUM(Population) FROM City WHERE District = N'California'; 

/* Revising Aggregations - Averages */
SELECT AVG(Population) FROM City WHERE District = N'California'; 

/* Average Population */
SELECT AVG(Population) FROM City; 

/* Japan Population */
SELECT SUM(Population) FROM City WHERE CountryCode = N'JPN'; 

/* Population Density Difference */
SELECT MAX(Population) - MIN(Population) FROM City; 

/* The Blunder */
SELECT CEILING(AVG(CAST(Salary as decimal)) - AVG(CAST(REPLACE(CAST(Salary as nvarchar), '0', '') as decimal))) FROM Employees;

/* Top Earners */
SELECT TOP 1 (Salary * Months), COUNT(Employee_Id) FROM Employee GROUP BY (Salary * Months) ORDER BY (Salary * Months) DESC; 

/* Weather Observation Station 2 */
SELECT CAST(SUM(Lat_N) as decimal(8,2)), CAST(SUM(Long_W) as decimal(8,2)) FROM Station; 

/* Weather Observation Station 13 */
SELECT CAST(SUM(Lat_N) as decimal(10,4)) FROM Station WHERE Lat_N BETWEEN 38.7880 AND 137.2345; 

/* Weather Observation Station 14 */
SELECT CAST(MAX(Lat_N) as decimal(10,4)) FROM Station WHERE Lat_N < 137.2345; 

/* Weather Observation Station 15 */
SELECT TOP 1 CAST(Long_W as decimal(10,4)) FROM Station WHERE Lat_N < 137.2345 ORDER BY Lat_N DESC; 

/* Weather Observation Station 16 */
SELECT TOP 1 CAST(Lat_N as decimal(10,4)) FROM Station WHERE Lat_N > 38.7780 ORDER BY Lat_N; 

/* Weather Observation Station 17 */
SELECT TOP 1 CONVERT(decimal(10,4), Long_W) FROM Station WHERE Lat_N > 38.7780 ORDER BY Lat_N; 

/* Weather Observation Station 18 */
SELECT CONVERT(decimal(9,4), ABS(MIN(Lat_N) - MAX(Lat_N)) - ABS(MIN(Long_W) - MAX(Long_W))) FROM Station; 

/* Weather Observation Station 19 */
SELECT CONVERT(decimal(9,4), SQRT(POWER(MAX(Lat_n) - MIN(Lat_N), 2) + POWER(MAX(Long_W) - MIN(Long_W), 2))) FROM Station; 

/* Population Census */
SELECT SUM(City.Population) FROM City JOIN Country on City.CountryCode = Country.Code WHERE Country.Continent = 'Asia'; 

/* African Cities */
SELECT City.Name FROM City JOIN Country on City.CountryCode = Country.Code WHERE Country.Continent = 'Africa'; 

/* Average Population of Each Continent */
SELECT Country.Continent, CEILING(AVG(City.Population)) FROM City JOIN Country on City.CountryCode = Country.Code GROUP BY Country.Continent; 

