-- overall data, highest mortality rate ever in history
SELECT Entity as country, year, Under_five_mortality_rate
FROM [children mortality rate].dbo.[child-mortality]
order by 3 desc

-- country with the highest infant mortality rate in year 2020
SELECT Entity as country, year, Under_five_mortality_rate
FROM [children mortality rate].dbo.[child-mortality]
WHERE [Year]=2020 and Entity != 'world'
order by 3 desc 

-- Countries with their highest ever mortality rate 
SELECT 
    Entity as Country,
    Year,
    Under_five_mortality_rate 
FROM (
    SELECT 
        Entity,
        Year,
       Under_five_mortality_rate, 
        ROW_NUMBER() OVER (PARTITION BY entity ORDER BY Under_five_mortality_rate DESC) AS rn
    FROM 
        [children mortality rate].dbo.[child-mortality]
) AS ranked
WHERE 
    rn = 1
ORDER BY 
    Country;

    -- mortality rate around the world by year
 SELECT Entity, year, Under_five_mortality_rate
FROM [children mortality rate].dbo.[child-mortality]
where Entity = 'world'
order by [Year]

--mortality rate in Nepal by year
SELECT Entity as country, year, Under_five_mortality_rate
FROM [children mortality rate].dbo.[child-mortality]
where Entity = 'Nepal'
order by [Year]

-- mortality rate in nepal vs usa, null values of nepal from 1933 to 1949 means data not available

SELECT 
    MAX(CASE WHEN Entity = 'Nepal' THEN Under_five_mortality_rate END) AS NepalInfantMortalityRate, Year,
    MAX(CASE WHEN Entity = 'United states' THEN Under_five_mortality_rate END) AS USAInfantMortalityRate
FROM 
    [children mortality rate].dbo.[child-mortality]
WHERE 
    Entity IN ('Nepal', 'United states') 
GROUP BY 
    Year
ORDER BY 
    Year;

--- InfantMortalityRate around the world in time series
SELECT entity, year, Under_five_mortality_rate
from [children mortality rate].dbo.[child-mortality]
WHERE Entity = 'world'
order by 2 ASC
  
