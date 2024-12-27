DROP TABLE IF EXISTS `world_population`;

CREATE TABLE `world_population` (
  `Rank` int DEFAULT NULL,
  `CCA3` text,
  `Country/Territory` text,
  `Capital` text,
  `continent` text,
  `2022 Population` int DEFAULT NULL,
  `2020 Population` int DEFAULT NULL,
  `2015 Population` int DEFAULT NULL,
  `2010 Population` int DEFAULT NULL,
  `2000 Population` int DEFAULT NULL,
  `1990 Population` int DEFAULT NULL,
  `1980 Population` int DEFAULT NULL,
  `1970 Population` int DEFAULT NULL,
  `Area (kmÂ²)` int DEFAULT NULL,
  `Density (per kmÂ²)` double DEFAULT NULL,
  `Growth Rate` double DEFAULT NULL,
  `World Population Percentage` double DEFAULT NULL
);

SELECT continent, count(*) Total_No FROM world_population
group by continent
order by Total_No;

-- Question 1: Calculate the average growth rate for each continent and rank them in descending order.
WITH ContinentGrowthRate AS (
    SELECT Continent, round(AVG(`Growth Rate`),2) AS Avg_Growth_Rate
    FROM world_population
    GROUP BY Continent
)
SELECT Continent, Avg_Growth_Rate
FROM ContinentGrowthRate
ORDER BY Avg_Growth_Rate DESC;

-- EPLANATION 
-- This query calculates the average growth rate for each continent and ranks them in descending order of their growth rates.

-- Question 2: Find the top 3 countries with the highest population growth between 2020 and 2022.
WITH PopulationGrowth AS (
    SELECT `Country/Territory`, Capital, `2022 Population` - `2020 Population` AS Population_Growth
    FROM world_population
)
SELECT `Country/Territory`, Capital, Population_Growth
FROM PopulationGrowth
ORDER BY Population_Growth DESC
LIMIT 3;

-- EXPLANATION
-- This query identifies the top 3 countries with the highest population growth between 2020 and 2022.

-- Question 3: Identify countries where the population has consistently increased from 1970 to 2022.
SELECT `Country/Territory`, Capital
FROM world_population
WHERE `2022 Population` > `2020 Population`
  AND `2020 Population` > `2015 Population`
  AND `2015 Population` > `2010 Population`
  AND `2010 Population` > `2000 Population`
  AND `2000 Population` > `1990 Population`
  AND `1990 Population` > `1980 Population`
  AND `1980 Population` > `1970 Population`;
  
-- EXPLANATION
-- This query identifies countries where the population has consistently increased from 1970 to 2022.

-- Question 4: Calculate the total land area and population density for each continent.
WITH ContinentAreaPopulation AS (
    SELECT Continent, SUM(`Area (kmÂ²)`) AS Total_Area, SUM(`2022 Population`) AS Total_Population
    FROM world_population
    GROUP BY Continent
)
SELECT Continent, Total_Area, Total_Population, (Total_Population / Total_Area) AS Population_Density
FROM ContinentAreaPopulation;

-- EXPLANATION
-- his query calculates the total land area and population density for each continent by summing up the respective values for all countries within each continent.

-- Question 5: Identify the top 5 countries with the highest population density and their respective continents.
WITH CountryDensity AS (
    SELECT `Country/Territory`, Capital, Continent, `Density (per kmÂ²)`
    FROM world_population
)
SELECT `Country/Territory`, Capital, Continent, `Density (per kmÂ²)`
FROM CountryDensity
ORDER BY `Density (per kmÂ²)` DESC
LIMIT 5;

-- EXPLANATION
-- This query identifies the top 5 countries with the highest population density along with their respective continents.

-- Question 6: Determine the country with the largest increase in population from 1990 to 2022.

WITH PopulationIncrease AS (
    SELECT `Country/Territory`, Capital, `2022 Population` - `1990 Population` AS Population_Increase
    FROM world_population
)
SELECT `Country/Territory`, Capital, Population_Increase
FROM PopulationIncrease
ORDER BY Population_Increase DESC
LIMIT 1;

-- EXPLANATION
-- This query determines the country with the largest increase in population from 1990 to 2022.

-- Question 7: Find the percentage contribution of each country to the total population of its continent in 2022.
WITH ContinentPopulation AS (
    SELECT Continent, SUM(`2022 Population`) AS Continent_Total_Population
    FROM world_population
    GROUP BY Continent
),
CountryContribution AS (
    SELECT a.`Country/Territory`, a.Capital, a.Continent, a.`2022 Population`, b.Continent_Total_Population,
           (a.`2022 Population` / b.Continent_Total_Population) * 100 AS Percentage_Contribution
    FROM world_population a
    JOIN ContinentPopulation b ON a.Continent = b.Continent
)
SELECT `Country/Territory`, Capital, Continent, Percentage_Contribution
FROM CountryContribution
ORDER BY Percentage_Contribution DESC;

create table `students` (std_id int primary key, name varchar(50) not null, 
age int check (age >= 18));

select * from students;
create index idx_name on students(std_id);

