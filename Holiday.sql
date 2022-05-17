
select Type, 
count(Type) as 'Count of Holiday' 
from dbo.Holiday where country = 'Spain' and Type in ('Regional Holiday', 'National Holiday')
group by Type 
order by 2 desc

select Type, 
count(Type) as 'Count of Holiday' 
from dbo.Holiday where country = 'afghanistan' and Type in ('Regional Holiday', 'National Holiday')
group by Type 
order by 2 desc

select Type, 
count(Type) as 'Count of Holiday' 
from dbo.Holiday where country = 'switzerland' and Type in ('Regional Holiday', 'National Holiday')
group by Type 
order by 2 desc

select country,count(*) as 'holiday for each country' from dbo.Holiday group by country order by 2 desc

select Day, count(*) as 'daycount' from dbo.Holiday group by Day order by 2 desc
