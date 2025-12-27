USE BMWDATASET;

SELECT COUNT(*) FROM AIR_QUALITY;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cities_air_quality_water_pollution.csv'
INTO TABLE AIR_QUALITY
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Display all records from the table.
select * from air_quality;
-- Show only City, Country, and AirQuality.
SELECT City,COUNTRY,AIRQUALITY FROM AIR_QUALITY;
ALTER TABLE air_quality
RENAME COLUMN Region TO Country1;
ALTER TABLE air_quality
RENAME COLUMN Country TO Region;
ALTER TABLE air_quality
RENAME COLUMN Country1 TO Country;

ALTER TABLE air_quality
RENAME COLUMN `"Region"` TO REGION;

ALTER TABLE AIR_QUALITY
RENAME COLUMN `"COUNTRY"` TO COUNTRY;
ALTER TABLE AIR_QUALITY
RENAME COLUMN `"AIRQUALITY"` TO AIRQUALITY;
ALTER TABLE AIR_QUALITY 
RENAME  COLUMN `"WATERPOLLUTION"` TO WATER_POLLUTION;
-- Find total number of cities in the dataset.
select  distinct(count(city)) from air_quality;
-- List all unique countries present.
select distinct country from air_quality;
-- Count number of cities per country.
select country, count(*) as total_city 
from air_quality
where country="Germany"
group by country;
SELECT DISTINCT country
FROM air_quality
WHERE country = 'Germany';
UPDATE air_quality
SET country = TRIM(country);
UPDATE air_quality
SET country = TRIM(City);
UPDATE air_quality
SET country = TRIM(Region);
set sql_safe_updates=0;

SELECT DISTINCT country, LENGTH(country)
FROM air_quality
WHERE country LIKE '%United%';
select * from air_quality;
UPDATE air_quality
SET country = TRIM(country);
UPDATE air_quality
SET country = TRIM(City);
SELECT country
FROM air_quality
WHERE country = ' United States of America';
SELECT DISTINCT country
FROM air_quality
WHERE country = ' United States of America';
SELECT country, COUNT(*) AS total_city
FROM air_quality
WHERE country =' Germany'
GROUP BY country;
select count(*) from air_quality;
-- Find cities where Region is NULL or empty.
select Region,city from air_quality
where region="none";
-- Find cities with AirQuality greater than 70.

select city, airquality from air_quality
where  airquality >70;
-- Find cities with WaterPollution greater than 60.
select city,waterpollution from  air_quality
where waterpollution > 60;
-- Find cities where both AirQuality < 30 and WaterPollution > 70.
select city, airquality, waterpollution from air_quality
where  (airquality<30 and waterpollution>70);
-- Sort cities by AirQuality (highest to lowest).
select city, airquality from air_quality
order by airquality desc;
-- Sort cities by WaterPollution (lowest to highest).
select city, waterpollution from air_quality
order by waterpollution;
-- Find top 10 cities with best AirQuality.
select  city, airquality
from air_quality
order by airquality asc
limit 10;
-- Find bottom 10 cities with worst AirQuality.
select city,airquality
from air_quality
order by airquality desc
limit 10;

-- Count how many cities belong to India.
select count(*)
from air_quality
where country=" India";
select * from air_quality;
select trim(country)from air_quality;
select count(*)
from air_quality
where country=" India";
-- Count cities from United States of America.
select country, count(*) from air_quality
where country=" United States of America";
-- ⚙️ INTERMEDIATE SQL QUESTIONS (Analytical)

-- Find average AirQuality by country.
select country, avg(airquality) from air_quality
group by country;
-- Find average WaterPollution by country.
select country, avg(waterpollution) from 
air_quality
group by country;
-- List countries having average AirQuality above 60.
select country from air_quality
group by country
having avg(airquality)>60;
-- Find country with the highest average WaterPollution.
select country,avg(waterpollution) as maxwater
 from air_quality
group by country
order by maxwater desc;

-- Find country with the lowest average AirQuality.
select country, avg(airquality) as air from air_quality          
group by country
order by air;
-- Find total number of cities per region.
select region, count(city) from 
air_quality
group by region;
-- Find regions having more than 5 cities.
select region,count(*) region_city
from air_quality
group by region
having region_city>5;
-- Calculate AirQuality – WaterPollution difference for each city.
select city, airquality,
waterpollution,
(airquality-waterpollution) as air_water_diffrence from air_quality;

-- Classify cities as:
alter table air_quality
add column airqaulity_cetegory varchar(20);
-- Good if AirQuality ≥ 70
select city,
airquality,
waterpollution,
(airquality-waterpollution) as air_water_diffrence,
case 
  when airquality>=70 then 'good'
  when airquality between 40 and 69 then 'moderate'
  else 'poor'
end as airqaulity_cetegory
from air_quality
;
ALTER TABLE air_quality
CHANGE airqaulity_cetegory airquality_category VARCHAR(20);

-- Moderate if 40–69
SELECT city, airquality, airqaulity_cetegory
FROM air_quality
LIMIT 10;
SET sql_safe_updates = 0;
SHOW COLUMNS FROM air_quality;
SET sql_safe_updates = 0;

UPDATE air_quality
SET airquality_category =
    CASE
        WHEN AirQuality >= 70 THEN 'Good'
        WHEN AirQuality BETWEEN 40 AND 69 THEN 'Moderate'
        ELSE 'Poor'
    END;


-- Poor if < 40
SELECT city, airquality
FROM air_quality
LIMIT 10;

-- Find count of cities in each AirQuality category.
select airquality_category,count(*) from air_quality
group by airquality_category;
-- Find cities where WaterPollution is above country average.
select city, waterpollution from air_quality
where waterpollution >(select avg(waterpollution) from air_quality);
-- Find top 5 most polluted cities by WaterPollution.
select city, avg(waterpollution) from air_quality
group by city
order by avg(waterpollution) desc
limit 5;
-- Find cities with both AirQuality and WaterPollution above 50.
select city,airquality,waterpollution from air_quality
where airquality> 50 and waterpollution>50;
-- Find countries where all cities have AirQuality above 50.
select country,airquality
from air_quality
where airquality>50;
-- Find countries having at least one city with WaterPollution > 80.
select country from air_quality
group by country
having max(waterpollution) >80;

-- 🔗 SUBQUERIES & FILTERING

-- Find cities with AirQuality greater than overall average.
select city,airquality from air_quality where 
airquality > (select avg(airquality) from air_quality);
-- Find cities with WaterPollution less than overall average.
select city, waterpollution from air_quality where airquality
<(select avg(waterpollution) from air_quality);
-- Find city with maximum AirQuality in each country.
select country,city,airquality from air_quality
where airquality =(select max(airquality) from air_quality);
-- Find city with minimum AirQuality in each country.
select country,city ,airquality from air_quality where
airquality =(select min(airquality) from air_quality);
-- Find top polluted city per country.
SELECT a.country, a.city, a.waterpollution
FROM air_quality a
WHERE a.waterpollution = (
    SELECT MAX(b.waterpollution)
    FROM air_quality b
    where b.country=a.country
);



-- Find countries whose average WaterPollution is higher than global average.
select country,avg(waterpollution) from air_quality
group by country
having avg(waterpollution) > (select avg(waterpollution)
from air_quality);
-- Find cities belonging to countries where average AirQuality < 40.
select city,country,airquality
from air_quality
where country in (select country from air_quality group by country
having avg(airquality)<40);
-- Find cities with the same AirQuality value within the same country.
SELECT a.country,
       a.airquality,
       a.city AS city_1,
       b.city AS city_2
FROM air_quality a
JOIN air_quality b
  ON a.country = b.country
 AND a.airquality = b.airquality
 AND a.city <> b.city
ORDER BY a.country, a.airquality;

-- Find cities whose WaterPollution is in top 10% overall.
select city, country,waterpollution from 
(select city,country,
waterpollution,
percent_rank() over (order by waterpollution) as pr from air_quality)t
where pr>=0.9
order by waterpollution desc;
-- Find countries with more than 10 cities in dataset.
select country,count(city) as city_count
from air_quality
group by country
having count(city) >10;
-- 🚀 ADVANCED SQL / WINDOW FUNCTIONS

-- Rank cities by AirQuality within each country.
select country,city,airquality,rank() over (partition by country order by airquality desc)
from air_quality;
-- Rank cities by WaterPollution (highest first).
select city,waterpollution,
rank()
over (partition by city order by waterpollution desc)as highest_rnk
from air_quality;
-- Find top 3 cleanest cities per country.
select country, city, airquality
from (select country,
city,
airquality,
dense_rank() over (partition by country order by airquality desc )as rnk
from air_quality)t
where rnk<=3
order by country,rnk;
-- Find top 3 most polluted cities per country.
select country,city,airquality from (select city, country,airquality,
dense_rank() over (partition by country order by airquality desc) as rnk
from  air_quality)t
where rnk<=3
order by rnk desc;

-- Calculate running average AirQuality by country.
select country,city,airquality,avg(airquality) over (
partition by country
order by city
rows between unbounded  preceding and current row ) as running_avg_airquality
from air_quality;
-- Use ROW_NUMBER() to remove duplicate city names.
select * from (select *, row_number() over (partition by city
order by country
)as rn
from air_quality)t
where rn =1;
-- Find second highest AirQuality city in each country.
select country,city,airquality
from (select country,city,airquality,dense_rank()
over (partition by country order by airquality desc)
as rnk
from air_quality)t
where rnk=2;
-- Compare each city’s AirQuality with country average (above/below).
select country,city,airquality,avg(airquality)over 
(partition by country) as country_avg,
case when airquality >avg(airquality) over (partition by country) then 'Above Country avg'
when airquality< avg(airquality) over(partition by country)
then 'below country avg'
else 'Equal to country avg'
end as comparison_result
from air_quality;

-- Find percentage contribution of each city’s WaterPollution to its country.
select country,
city,
waterpollution,round(
waterpollution*100.0
/sum(waterpollution) over (partition by country),2
)as water_pct
from air_quality;
-- Identify outlier cities where WaterPollution is 2× country average.

-- 🧠 REAL INTERVIEW / CASE-STUDY QUESTIONS

-- Which country has best overall environmental quality (high AirQuality + low WaterPollution)?
select country,
avg(airquality) as avg_airquality,
avg(waterpollution) as avg_waterpollution,
(avg(airquality)- avg(waterpollution)) as environmental_score
from air_quality
group by country
order by environmental_score desc
limit 1;
-- Identify high-risk cities (AirQuality < 30 AND WaterPollution > 70).
select city,
country,
airquality,waterpollution
from air_quality
where airquality <30
and waterpollution >70;
-- Which Indian city has the worst WaterPollution?
select city,waterpollution
from air_quality
where country=' India'
order by waterpollution desc
limit 10;
-- Compare average AirQuality of Europe vs Asia.
select region,round(avg(airquality),2) as avg_airquality
from air_quality
where region in (' Europe',' Asia')
group by region;
-- Create a KPI flag: Safe / Unsafe based on thresholds.
select city,
country,
airquality,
waterpollution,
case 
  when airquality >=50 and waterpollution <=50
   then 'Safe'
 else 'Unsafe'
 end as kpi_flag
from air_quality;

