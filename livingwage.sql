'Source: https://www.kaggle.com/brandonconrady/living-wage-top-100-cities'


'Checking out all columns'
SELECT 
    *
FROM
    livingwage;

'Turning the rank_2020 to a primary key'    
alter table livingwage add primary key (rank_2020);

'checking for distinct state columns which is 34 in total'
select distinct (state) from livingwage;
    
'checking for city column which is equal to 100 representative of the primary key'
select distinct (city) from livingwage;

'checking for the state that has most entries in the dataset which is california'
SELECT 
    state, COUNT(*) AS 'state count'
FROM
    livingwage
GROUP BY state
ORDER BY 2 DESC;

'calculating percentage in population from 2010 to 2020 and we can see Irvine California witnessed a 50% increment'
SELECT 
    rank_2020,
    city,
    state,
    population_2010,
    population_2020,
    concat((population_2020 - population_2010) / population_2010 * 100,'%') AS 'Percentage Change in Population from 2010 to 2020'
FROM
    livingwage
ORDER BY 6 DESC;

'comparing total adults with kids and no kids for each city'
SELECT 
    city,
    ROUND((one_adult_no_kids_living_wage + two_adults_one_working_no_kids_living_wage + two_adults_both_working_no_kids_living_wage),
            2) AS 'Total Adults with no kids',
    ROUND((one_adult_one_kid_living_wage + one_adult_two_kids_living_wage + one_adult_three_kids_living_wage + two_adults_one_working_one_kid_living_wage + two_adults_one_working_two_kids_living_wage + two_adults_one_working_three_kids_living_wage + two_adults_both_working_one_kid_living_wage + two_adults_both_working_two_kids_living_wage + two_adults_both_working_three_kids_living_wage),
            2) AS 'Total Adults with kids'
FROM
    livingwage order by 3 desc;
    
'breaking down the above code by state'
    SELECT 
    state,
    SUM(ROUND((one_adult_no_kids_living_wage + two_adults_one_working_no_kids_living_wage + two_adults_both_working_no_kids_living_wage),
            2)) AS 'Total Adults with no kids',
    SUM(ROUND((one_adult_one_kid_living_wage + one_adult_two_kids_living_wage + one_adult_three_kids_living_wage + two_adults_one_working_one_kid_living_wage + two_adults_one_working_two_kids_living_wage + two_adults_one_working_three_kids_living_wage + two_adults_both_working_one_kid_living_wage + two_adults_both_working_two_kids_living_wage + two_adults_both_working_three_kids_living_wage),
            2)) AS 'Total Adults with kids'
FROM
    livingwage
GROUP BY state
ORDER BY 2 DESC;

'how population increased or decreased for each state: the population of michigan, alaska and maryland decreased between 2010 and 2020'
SELECT 
    state,
    SUM(population_2010),
    SUM(population_2020),
    CASE
        WHEN SUM(population_2010) > SUM(population_2020) THEN 'population decreased over time'
        ELSE 'population increased over time'
    END AS 'Population Pattern'
FROM
    livingwage
GROUP BY state
ORDER BY 4 ASC;