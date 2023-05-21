--Looking at cars table for useful information
select *
from cars
order by year 



--Looking at average of cars by each brands
Select manufacturer, Avg(price) as Avg_price
from cars
WHERE year < 2010
Group by manufacturer
Order by Avg_price


--Looking at most reliable car brands
select overall_score, make, quality_index, Compound_Reliability_Score, 3years_unschedule_repair
from reliability
order by Compound_Reliability_Score desc

--Looking at most reliable car model 
select make, make_model, MAX(Compound_Reliability_Score) as top_score
from dbo.reliability
group by make, make_model
order by top_score desc

--Looking at the least repair cost over 3 years
Select make, make_model, cost*threeyears_unschedule_repair AS total_cost_repair, Compound_Reliability_Score
from reliability
ORDER by cost*threeyears_unschedule_repair


--Looking at total cost of repair over 3 years of unschedule repairs, and reliability score
Select make, make_model, cost*threeyears_unschedule_repair AS total_cost_repair, Compound_Reliability_Score
from reliability
ORDER by cost*threeyears_unschedule_repair

--Trying out group by and aggregate functions
select make, make_model, MAX(Compound_Reliability_Score) as top_score
from dbo.reliability
group by make, make_model
order by top_score desc

Select make, make_model, cost*threeyears_unschedule_repair AS total_cost_repair
from reliability
ORDER by cost*threeyears_unschedule_repair

SELECT cars.manufacturer, cars.model,reliability.cost, quality_index
from cars
join reliability
on cars.manufacturer = reliability.Make
and cars.model = reliability.Model
order by reliability.overall_score desc
