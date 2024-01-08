SELECT * 
FROM World_Life_Expectancy
;

#Looking the country which have the best life expectancy 
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`),1) AS Life_Increase
FROM World_Life_Expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) != 0
AND MAX(`Life expectancy`) != 0
ORDER BY Life_Increase desc
;


#Looking the Year of life expectancy 
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM World_Life_Expectancy
WHERE `Life expectancy` != 0
AND `Life expectancy` !=0
GROUP BY Year
ORDER BY Year
;


SELECT * 
FROM World_Life_Expectancy
;

#Comparing life expectancy and GDP by country
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM World_Life_Expectancy
GROUP BY Country
HAVING Life_Exp>0
AND GDP>0
ORDER BY GDP desc
;

#AVERAGE Life Expectancy where GDP>=1500 and <=1500
SELECT 
SUM(CASE WHEN GDP>=1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP>=1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_expectancy,
SUM(CASE WHEN GDP<=1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP<=1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_expectancy
FROM World_Life_Expectancy
;

SELECT * 
FROM World_Life_Expectancy
;


SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM World_Life_Expectancy
GROUP BY Status
;

#Counting the developed countries and developing countries and finding the average of life expecting by each status
SELECT Status, COUNT(Distinct Country), ROUND(AVG(`Life expectancy`),1) 
FROM World_Life_Expectancy
GROUP BY Status
;

#Comparing the BMI and life expectancy by country
SELECT Country,  ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM World_Life_Expectancy
GROUP BY Country
HAVING Life_Exp>0
AND BMI>0
ORDER BY BMI asc
;


#Looking how many people died comparing in life expectancy by country
SELECT Country, 
Year,
`Life expectancy`, 
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM World_Life_Expectancy
WHERE Country LIKE '%United%'
;



