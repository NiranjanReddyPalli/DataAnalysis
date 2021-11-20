/* ##COVID-19 Data Analysis

#Skills used : Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types */


use covid;

show tables;

desc deaths;
desc vaccinations;

-- Exploring the data
select * from covid.deaths
limit 5;

select * from covid.vaccinations
limit 5;

-- Selecting the data required for our analysis
select continent, location, date, population, total_cases, new_cases, total_deaths 
from covid.deaths
order by 2; 

-- Number of cases in each location
select location, max(total_cases) as no_of_cases
from covid.deaths
-- where location = 'india'
group by location
order by no_of_cases desc;

-- Number of cases in each continent
select continent, sum( total_cases_by_loc) as total_cases_by_continent
from 
( 
select continent, location, max(total_cases) as total_cases_by_loc 
from covid.deaths 
group by location, continent
) as temp
-- where continent like 'a__a'
group by continent
order by total_cases_by_continent desc;

-- Number of deaths in each location
select location, max(cast(total_deaths as float)) as no_of_deaths 
from covid.deaths
-- where location like 'i%a'
group by location
order by no_of_deaths desc;

-- Number of deaths in each continent
select loc.continent as continent, sum(deaths_by_loc) as no_of_deaths 
from (
select continent, location, max(cast(total_deaths as float)) as deaths_by_loc 
from covid.deaths
group by location
) as loc
-- where continent = 'asia'
group by continent
order by no_of_deaths desc;


-- Total cases in the world
select sum(new_cases) as no_of_cases_in_world 
from covid.deaths; 

-- infected death percentage in the world
select sum(new_cases) as cases, sum(cast(new_deaths as float)) as deaths, sum(cast(new_deaths as float))/sum(new_cases)*100 as death_percentage
from covid.deaths;

-- population infected percentage in each location by date
select location, date, population, total_cases, (total_cases/population)*100 as infection_percentage 
from covid.deaths;

-- population death percentage in each location by date
select location, date, population, total_deaths, (total_deaths/population)*100 as death_percentage 
from covid.deaths;

-- death percentage by location
select location, sum(new_cases) as cases, sum(new_deaths) as deaths, sum(new_deaths)/sum(new_cases)*100 as death_percentage 
from covid.deaths
-- where location = 'India' (can refer required location)
group by location
order by death_percentage desc,location;

-- population vs vaccinations
select d.continent, d.location, d.date, d.population, v.people_vaccinated, 
max(cast(v.people_vaccinated as float)) over (partition by d.location) as total_people_vaccinated 
from covid.deaths d
inner join covid.vaccinations v
on d.date = v.date and d.location = v.location
order by 2,5 ;

-- percentage of people vaccinated
-- by using Common Table Expression [CTE]
with dcte (location, date, population, people_vaccinated, total_people_vaccinated)
as 
(
select d.location, d.date, d.population, v.people_vaccinated, 
max(cast(v.people_vaccinated as float)) over (partition by d.location) as total_people_vaccinated
from covid.deaths d
inner join covid.vaccinations v
on d.date = v.date and d.location = v.location
)
select *, total_people_vaccinated/population*100 as 'percent of people vaccinated' 
from dcte;


-- by using temp tables
drop table if exists temp_table;
create temporary table temp_table
(
location text,
date text,
population text,
people_vaccinated text,
total_people_vaccinated text
);
insert into temp_table
select d.location, d.date, d.population, v.people_vaccinated, 
max(cast(v.people_vaccinated as float)) over (partition by d.location) as total_people_vaccinated
from covid.deaths d
inner join covid.vaccinations v
on d.date = v.date and d.location = v.location;
select *, total_people_vaccinated/population*100 as 'percentage of people vaccinated'
from temp_table;


-- creating views
create view ppv as
select d.location, d.date, d.population, v.people_vaccinated, 
max(cast(v.people_vaccinated as float)) over (partition by d.location) as total_people_vaccinated from covid.deaths d
inner join covid.vaccinations v
on d.date = v.date and d.location = v.location;

-- calling view ppv
select * from ppv;
