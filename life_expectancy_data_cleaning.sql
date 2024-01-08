SELECT *
FROM World_Life_Expectancy
;


 #Finding Duplicates
SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM World_Life_Expectancy
GROUP BY Country, Year , CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year))>1
;

SELECT *
FROM(
	SELECT Row_ID, 
	CONCAT(Country, Year), 
	ROW_NUMBER() OVER(partition by CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM World_Life_Expectancy) as Row_Table
    WHERE Row_Num>1;
    
    
#DELETING DUPLICATES
DELETE FROM World_Life_Expectancy
WHERE 
	Row_ID IN(
	SELECT Row_ID
FROM(
	SELECT Row_ID, 
	CONCAT(Country, Year), 
	ROW_NUMBER() OVER(partition by CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM World_Life_Expectancy) as Row_Table
    WHERE Row_Num>1);
    
    
    
    
#Filling all the blank status by distinct countries to 'developing' or 'developed' by using join and comparing each distinct countries to status 
SELECT DISTINCT(Status)
FROM World_Life_Expectancy
WHERE Status<>''
;

SELECT DISTINCT(Country)
FROM World_Life_Expectancy
WHERE Status='Developing';

#Changing to Developing
UPDATE World_Life_Expectancy t1
JOIN World_Life_Expectancy t2
ON t1.Country=t2.Country
SET t1.Status='Developing'
WHERE t1.Status=''
AND t2.Status !=''
AND t2.Status='Developing'
;    

#Double Checking
SELECT *
FROM World_Life_Expectancy
WHERE Country= 'United States of America'
;
    
#Changing to Developed
UPDATE World_Life_Expectancy t1
JOIN World_Life_Expectancy t2
ON t1.Country=t2.Country
SET t1.Status='Developed'
WHERE t1.Status=''
AND t2.Status !=''
AND t2.Status='Developed'
;    

#Filling blank life expectancy by average of two years between 
SELECT *
FROM World_Life_Expectancy
WHERE `Life expectancy`=''
;
    
#Checking the blanks in life expectancy
SELECT Country, Year, `Life expectancy` 
FROM World_Life_Expectancy
#WHERE `Life expectancy`=''
;



#SELF JOIN and then making the average
SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`, 
ROUND((t2.`Life expectancy`+t3.`Life expectancy`)/2,1)
FROM World_Life_Expectancy t1
JOIN World_Life_Expectancy t2
	ON t1.Country=t2.Country
    AND t1.YEAR=t2.Year-1
    JOIN World_Life_Expectancy t3
	ON t1.Country=t3.Country
    AND t1.YEAR=t3.Year+1
WHERE t1.`Life expectancy`=''
;
    
#SUBSTITUTING the blanks in the original table which is t1
UPDATE World_Life_Expectancy t1
JOIN World_Life_Expectancy t2
	ON t1.Country=t2.Country
    AND t1.YEAR=t2.Year-1
    JOIN World_Life_Expectancy t3
	ON t1.Country=t3.Country
    AND t1.YEAR=t3.Year+1
SET t1.`Life expectancy`=ROUND((t2.`Life expectancy`+t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy`='';


    
