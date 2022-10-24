--THIS IS FOR COVID DEATHS

USE PortfolioProject	--this is like to select the database you want to use
SELECT Location, date, total_cases, new_cases, total_deaths, population --the columns we want to use
FROM dbo.CovidDeaths --the location
order by 1,2 --the first and second columns, 3,4 would be for the third and fourth columns.

-- Looking at Total Cases vs Total Deaths (keep this comment)
--bc we are looking at total cases vs td, we dont need new_cases and pop
--we also want to introduce a column called death %, we use the 'as' alias to name the colu,m
--the % shows the likelihood of you dying if you contact covid in your country
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM dbo.CovidDeaths
where location like '%states%'
order by total_cases desc 

--Looking at total cases vs population
--shows what % of the population has gotten covid

SELECT location, date, total_cases, population, (total_cases/population)*100 as population_percentage
from dbo.CovidDeaths
where location like '%States%'
order by total_cases desc

--Looking at countries with Highest Infection Rate compared to Population

SELECT location, population, max(total_cases) as highest_infection_count, max(total_cases/population)*100 as percentage_population_infected
from dbo.CovidDeaths
group by location, population
order by percentage_population_infected desc

--Showing countries with Highest Death Count per population

--**SELECT location, max(total_deaths) as highest_death_count
--when we run this, the highest_death_count is not ordered properly (in descending order) bc total_death is of nvarchar type and the max function works with int or float. so to change the type to int, we cast it.
SELECT location, max(cast(total_deaths as int)) as highest_death_count
from dbo.CovidDeaths
where continent is not null --africa, asia appears in our column, so we use this to remove them bc Nigeria shows continent as Africa, China shows as Asia, but Africa and Asia shows null
group by location
order by highest_death_count desc

--LET'S BREAK THINGS DOWN BY CONTINENT

--showing continents with the highest death count per population

SELECT continent, max(cast(total_deaths as int)) as highest_death_count
from dbo.CovidDeaths
where continent is not null 
group by continent
order by highest_death_count desc

--GLOBAL NUMBERS

--getting the total cases and deaths per day

SELECT date, SUM(new_cases) as total_new_cases, SUM(cast(new_deaths as int)) as total_new_deaths, (SUM(cast(new_deaths as int))/SUM(new_cases))*100 as new_death_percentage
FROM dbo.CovidDeaths
--where location like '%states%'
where continent is not null 
group by date
order by 1,2

--to get the total new cases and death, and new death percentage
SELECT SUM(new_cases) as total_new_cases, SUM(cast(new_deaths as int)) as total_new_deaths, (SUM(cast(new_deaths as int))/SUM(new_cases))*100 as new_death_percentage
FROM dbo.CovidDeaths
--where location like '%states%'
where continent is not null 
--group by date
order by 1,2


--THIS IS FOR COVID VACCINATIONS
USE PortfolioProject
SELECT *
FROM dbo.CovidVaccinations

--Looking at Total Population vs vaccinations
-- this is the percentage_population_vacc
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from dbo.CovidDeaths dea --this dea is a short form so we won't have to be writing CovidDeaths everytime
join dbo.CovidVaccinations vac --short form
	on dea.location = vac.location --dea.location means the location column in the dea (CovidDeaths) table.
	and dea.date = vac.date
where dea.continent is not null -- where continent in the dea is not null
order by 2,3

--i might not add the things he's saying from 1:00:00 because it's quite advanced but try and see if you like it

--WE CREATE VIEWS
Create View percentage_population_vacc as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from dbo.CovidDeaths dea --this dea is a short form so we won't have to be writing CovidDeaths everytime
join dbo.CovidVaccinations vac --short form
	on dea.location = vac.location --dea.location means the location column in the dea (CovidDeaths) table.
	and dea.date = vac.date
where dea.continent is not null -- where continent in the dea is not null
