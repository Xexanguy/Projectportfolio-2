USE portfolioproject

SELECT *

FROM dbo.CovidDeaths

select *
from dbo.CovidVaccinations

-- selection of data that we are working with 

SELECT 
	location,
	date,
	total_cases, 
	new_cases,
	total_deaths,
	population
FROM dbo.CovidDeaths
ORDER BY 1, 2 -- I, 2 in this case signifies column 1 and column 2

-- Looking at total cases vs total deaths

SELECT
	location,
	date,
	total_cases,
	total_deaths
	 FROM dbo.CovidDeaths
	 WHERE location LIKE '%states%'
ORDER BY 1, 2

-- Total cases vs population 

SELECT 
	location,
	MAX (total_cases) AS Highestinfection,
	population,
	MAX ((total_cases/population)) * 100 AS percentpopulationinfected
FROM dbo.CovidDeaths
-- WHERE location LIKE '%Nigeria%'
GROUP BY location, population
ORDER BY percentpopulationinfected DESC

-- Showing countries with highest death count per population

SELECT 
	location,
	MAX (CAST (total_deaths AS INT)) AS MaxTotalDeaths,
	population,
	MAX ((total_deaths/population)) * 100 AS totaldeathtopopulationratio
FROM dbo.CovidDeaths
-- WHERE location LIKE '%Nigeria%'
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY totaldeathtopopulationratio, MaxTotalDeaths, population DESC

-- Considering the Maximum death count by continent

SELECT 
	continent, 
	MAX (CAST (total_deaths AS int)) AS Totaldeathcount
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY Totaldeathcount DESC

--Showing the continent with the highest death count per population

SELECT 
	date,
	SUM (new_cases) AS [New Case],
	SUM (new_deaths) AS [New Death],
	SUM (New_cases)/ SUM (New_deaths) * 100
FROM DBO.CovidDeaths
GROUP BY Date
ORDER BY 1,2


-- I STOPPED AT 41:OO.. I WILL CONTINUE TOMMORROW BY GOD'S GRACE

-- GLOBAL DEATH


SELECT *
FROM DBO.CovidDeaths AS dea
INNER JOIN DBO.CovidVaccinations AS vac
ON dea.location = vac.location

--looking at the total population vs vaccination. 

SELECT 
	dea.population,
	dea.location,
	dea.date,
	dea.continent,
	vac.new_vaccinations
FROM DBO.CovidDeaths AS dea
INNER JOIN DBO.CovidVaccinations AS vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
