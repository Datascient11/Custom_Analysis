-- Entering the Database Named World
USE world;

-- Display Entire Table
SELECT * FROM vgsales;

-- Display Distinct Genres
SELECT DISTINCT Genre 
FROM vgsales;

-- Maximum and Minimum Global Sales
SELECT MAX(Global_Sales), MIN(Global_Sales) 
FROM vgsales;

-- No of Shooter Games Released in Each Year
SELECT year, COUNT(Name) AS Shooter_Games_Count 
FROM vgsales 
Where Genre = "Shooter" 
group by year;

-- Year With The Most Shooter Games
Select year, count(*) as count 
from vgsales 
WHERE Genre = "Shooter" 
GROUP BY year 
ORDER BY count DESC 
limit 1;

-- Total No of Games Made For Different Gaming Platforms
SELECT platform, COUNT(platform) AS Total_Games 
FROM vgsales 
group by platform 
ORDER BY Total_Games DESC;

-- Global Sales Information on Different Publishers
SELECT publisher, ROUND(SUM(global_sales), 2) AS Total_Sales 
FROM vgsales 
GROUP BY publisher 
ORDER BY Total_Sales DESC;

-- Global Sales Information on Different Genres
SELECT Genre, ROUND(SUM(global_sales), 2) AS Total_Genre_Sales 
FROM vgsales 
GROUP BY Genre 
ORDER BY Total_Genre_Sales DESC;

-- Japan Sales Information on Different Genres
SELECT Genre, ROUND(SUM(Jp_sales), 2) AS JP_Genre_Sales 
FROM(Select Genre, jp_sales FROM vgsales) AS JP_Sales_Genre 
GROUP BY Genre 
ORDER BY JP_Genre_Sales DESC;

-- Japan's Top 5 Most Sold Genres
SELECT Genre, ROUND(SUM(Jp_sales), 2) AS JP_Genre_Sales 
FROM(Select Genre, jp_sales FROM vgsales) AS JP_Sales_Genre 
GROUP BY Genre 
ORDER BY JP_Genre_Sales DESC
LIMIT 5;

-- Max Sales Made In Japan
SELECT MAX(JP_Sales) AS Max_Japan_Sales
FROM vgsales;

-- Games That Are Sold Only In Japan
SELECT name, JP_Sales,Global_Sales, year, JP_Sales/Global_Sales*100 AS JP_Pct 
FROM vgsales 
WHERE JP_Sales != 0 AND JP_Sales = Global_sales 
ORDER BY JP_Pct DESC;

-- Least Sales Collection on Japan(Non 0)
SELECT * 
FROM vgsales 
WHERE jp_sales = (SELECT min(jp_sales) FROM vgsales WHERE jp_sales != 0);

-- North America Sales Information on Different Genres
SELECT Genre, ROUND(SUM(NA_sales), 2) AS NA_Genre_Sales 
FROM(Select Genre, NA_sales FROM vgsales) AS NA_Sales_Genre 
GROUP BY Genre 
ORDER BY NA_Genre_Sales DESC;

-- Europe Sales Information on Different Genres
SELECT Genre, ROUND(SUM(EU_sales), 2) AS EU_Genre_Sales 
FROM(Select Genre, EU_sales FROM vgsales) AS EU_Sales_Genre 
GROUP BY Genre 
ORDER BY EU_Genre_Sales DESC;

 -- Genre and their Regional Sales With Their Contribution to Global Sales in Numericals
SELECT Genre, ROUND(SUM(NA_sales), 2) AS NA, 
ROUND(SUM(JP_sales), 2) AS JP, ROUND(SUM(EU_sales), 2) AS EU,
ROUND(SUM(Other_sales), 2) AS Other, ROUND(SUM(Global_sales), 2) AS Global_Genre_Sales 
FROM(Select Genre, NA_sales, JP_sales, EU_Sales, Other_sales, Global_sales FROM vgsales) AS Sales_Genre 
GROUP BY Genre 
ORDER BY Global_Genre_Sales DESC;
 
 -- Genre and their Regional Sales With Their Contribution to Global Sales in Percentage
SELECT Genre, round((sum(global_sales)/Sum(global_sales)*100),2) AS Gspct, 
round((SUM(NA_Sales)/SUM(Global_Sales)*100),2) AS NSPCT, 
round((SUM(EU_Sales)/SUM(Global_Sales)*100),2) AS ESPCT, 
round((SUM(JP_Sales)/SUM(Global_Sales)*100),2) AS JSPCT, 
round((SUM(Other_Sales)/SUM(Global_Sales)*100),2) AS OSPCT 
FROM vgsales 
GROUP BY Genre;

-- Publishers and their Regional Sales With Their Contribution to Global Sales in Percentage
SELECT Publisher, round((sum(global_sales)/Sum(global_sales)*100),2) AS Gspct, 
round((SUM(NA_Sales)/SUM(Global_Sales)*100),2) AS NSPCT, 
round((SUM(EU_Sales)/SUM(Global_Sales)*100),2) AS ESPCT, 
round((SUM(JP_Sales)/SUM(Global_Sales)*100),2) AS JSPCT, 
round((SUM(Other_Sales)/SUM(Global_Sales)*100),2) AS OSPCT 
FROM vgsales 
GROUP BY Publisher 
ORDER BY GSPCT DESC;

-- All Publishers with their Total_Sales
SELECT Publisher, Round(sum(global_sales), 4) AS Total_Sales 
FROM vgsales 
GROUP BY Publisher 
ORDER BY Total_Sales DESC;

-- Identifying Top 5 Publisher in Terms of Total Sales
SELECT * 
FROM(SELECT Publisher, Round(sum(global_sales), 4) AS Total_Sales FROM vgsales GROUP BY Publisher ORDER BY Total_Sales DESC) AS Publisher 
LIMIT 5;

-- Average No of Games Produced By Each Publishers
SELECT * 
FROM (SELECT Publisher, avg(count1) AS Avg_No_of_Games FROM (SELECT Publisher, COUNT(name) AS COUNT1 FROM vgsales GROUP BY Publisher) AS Total_Count GROUP BY Publisher ORDER BY Avg_No_of_Games DESC) AS ABC;

-- Median of the Average No of Games Produced By Each Publishers
SELECT * 
FROM (SELECT Publisher, avg(count1) AS count FROM (SELECT Publisher, COUNT(name) AS COUNT1 FROM vgsales GROUP BY Publisher) AS Total_Count GROUP BY Publisher ORDER BY count DESC) AS ABC 
LIMIT 1 offset 288;

-- Identifying Publishers with top Global_Sales
SELECT Publisher, ROUND(SUM(Global_Sales), 2) AS Global_Sales 
FROM vgsales 
GROUP BY Publisher 
ORDER BY Global_Sales DESC LIMIT 5;

-- Identifying Publishers with the Least Global_Sales
SELECT Publisher, ROUND(SUM(Global_Sales), 2) AS Global_Sales 
FROM vgsales 
GROUP BY Publisher 
ORDER BY Global_Sales ASC 
LIMIT 5;

-- Nintendo Global Sales Contribution By Different Regions
SELECT Genre, Count(Genre) AS Nintendo_Game_Count, 
SUM(NA_Sales) AS Total_NA_Sales, 
SUM(EU_Sales) AS Total_EU_Sales, 
SUM(JP_Sales) AS Total_JP_Sales, 
SUM(Other_Sales) as Total_Other_sales, 
SUM(Global_Sales) AS Global_Sales  
FROM vgsales 
WHERE Publisher = "Nintendo" 
GROUP BY Genre 
ORDER BY Nintendo_Game_Count DESC;

-- Electronic Arts Global Sales Contribution By Different Regions
SELECT Genre, Count(Genre) AS EA_Game_Count, 
SUM(NA_Sales) AS Total_NA_Sales, 
SUM(EU_Sales) AS Total_EU_Sales, 
SUM(JP_Sales) AS Total_JP_Sales, 
SUM(Other_Sales) as Total_Other_sales, 
SUM(Global_Sales) AS Global_Sales  
FROM vgsales 
WHERE Publisher = "Electronic Arts" 
GROUP BY Genre 
ORDER BY EA_Game_Count DESC;

-- Activision Global Sales Contribution By Different Regions
SELECT Genre, Count(Genre) AS Activision_Game_Count, 
SUM(NA_Sales) AS Total_NA_Sales, 
SUM(EU_Sales) AS Total_EU_Sales, 
SUM(JP_Sales) AS Total_JP_Sales, 
SUM(Other_Sales) as Total_Other_sales, 
SUM(Global_Sales) AS Global_Sales 
FROM vgsales 
WHERE Publisher = "Activision" 
GROUP BY Genre 
ORDER BY Activision_Game_Count DESC;

-- Year With The Most Sales
SELECT Year, ROUND(SUM(Global_Sales),2) AS Global_Sales FROM vgsales GROUP BY Year ORDER BY Year DESC;

-- Comparing Games Releases Through Out the Decades
SELECT CASE 
WHEN Year > 2009 THEN "2010s"
WHEN Year > 1999 THEN "2000s"
WHEN Year > 1989 THEN "1990s"
WHEN Year > 1979 THEN "1980s"
END AS Time_Period,
COUNT(*) AS Games_Released
FROM vgsales
GROUP BY Time_Period
ORDER BY Games_Released DESC;

-- No of Games Released From 2000 to 2009(Maximum No of Games Released), Categorized By Genres
SELECT vgsales.Genre, COUNT(Games_Released) AS Games_Released FROM(
SELECT CASE 
WHEN Year > 2009 THEN "2010s"
WHEN Year > 1999 THEN "2000s"
WHEN Year > 1989 THEN "1990s"
WHEN Year > 1979 THEN "1980s"
END AS Time_Period,
COUNT(*) AS Games_Released
FROM vgsales
GROUP BY Time_Period
ORDER BY Games_Released DESC) AS Timee Join vgsales 
WHERE Timee.Time_Period = "2000s" 
GROUP BY vgsales.Genre;

SELECT CASE
WHEN Year > 2009 THEN "2010s"
WHEN Year > 1999 THEN "2000s"
WHEN Year > 1989 THEN "1990s"
WHEN Year > 1979 THEN "1980s"
END AS Time_Period,
Round(SUM(Global_Sales),2) AS Total_Sales
FROM vgsales
GROUP BY Time_Period;

SELECT vgsales.Genre, SUM(Total_Sales) AS Total_Sales 
FROM(
SELECT CASE
WHEN Year > 2009 THEN "2010s"
WHEN Year > 1999 THEN "2000s"
WHEN Year > 1989 THEN "1990s"
WHEN Year > 1979 THEN "1980s"
END AS Time_Period,
Round(SUM(Global_Sales),2) AS Total_Sales
FROM vgsales
GROUP BY Time_Period) AS Timee JOIN vgsales 
WHERE Timee.time_period = "1990s" 
GROUP BY vgsales.Genre;

-- Total Action Games Global Sales
SELECT SUM(Global_Sales) AS Total_Action_Game_Sales
FROM vgsales 
WHERE Genre = "Action";

-- Games Sold on the Year Between 1990 & 1999 in Different Genre
SELECT Genre, SUM(Global_Sales) AS Total_Sales
FROM vgsales
WHERE Year BETWEEN 1990 AND 1999
GROUP BY Genre
ORDER BY Total_Sales DESC;

-- Top 5 Games From Platform Genre During The Year 1990 - 1999
SELECT Name, Genre, Global_Sales 
FROM vgsales 
WHERE Genre = "Platform" AND 
Year Between 1990 AND 1999 
ORDER BY Global_Sales DESC
LIMIT 5;

SELECT COUNT(name) FROM vgsales;

-- Game with Most Global Sales During The Year 1990 to 1999
SELECT Name, Genre, Global_Sales 
FROM vgsales 
WHERE year between 1990 AND 1999 
ORDER BY Global_Sales DESC 
limit 1;

-- Total Games Released For Particular Platform
SELECT Platform, COUNT(*) AS COUNT 
FROM vgsales 
GROUP BY Platform 
ORDER BY COUNT DESC;

-- Console with the Most Games
SELECT Platform, COUNT(*) AS COUNT
FROM vgsales
WHERE Platform Like "PS%" GROUP BY Platform ORDER BY COUNT DESC;

-- 10year Moving Average On Global Sales
SELECT Year, Round(avg(Global_Sales) OVER ( ORDER BY YEAR ROWS BETWEEN 9 Preceding AND CURRENT ROW), 2) AS 10Yr_Moving_Avg 
FROM (SELECT year, Round(SUM(Global_Sales),2) AS Global_Sales FROM vgsales GROUP BY Year ORDER BY Global_Sales DESC) AS MMA ORDER BY Year ASC;

-- 10year Moving Average On North America Sales
SELECT year, ROUND(AVG(Total_NA_Sales) OVER( ORDER BY year ROWS BETWEEN 9 PRECEDING AND CURRENT ROW),2) AS NA_Sales_10Yr_Moving_Avg 
FROM (SELECT year, ROUND(SUM(NA_Sales),2) AS Total_NA_Sales FROM vgsales GROUP BY year ORDER BY year asc) AS MA;

-- 10 year Moving Average on Europe Sales
SELECT year, ROUND(avg(Total_EUSales) OVER ( ORDER BY year ROWS BETWEEN 9 PRECEDING AND CURRENT ROW),2) AS EU_Sales_10yr_Moving_Avg 
FROM (SELECT year, ROUND(sum(EU_Sales),2) AS Total_EUSales FROM vgsales GROUP BY year) AS movavg;

-- Comparing PS2 & PS4 Game Count & Global Sales 
SELECT platform, 
pd.game_count,
ROUND((pd.game_count/16324) * 100, 2) AS Total_Games_Pct,
ROUND(pd.total_sales,2) AS Total_Sales, 
ROUND((pd.total_sales/8820.31)*100,2)AS Total_Sales_pct 
FROM (SELECT Platform, COUNT(Name) AS game_count, SUM(Global_Sales) AS total_sales FROM vgsales WHERE Platform IN ('PS2', 'PS4') GROUP BY Platform) AS pd;


SELECT * FROM vgsales WHERE Name Like "GRAND THEFT%";

SELECT Platform, COUNT(*), SUM(global_sales) FROM vgsales 
WHERE Platform LIKE 'P%' OR Platform LIKE 'X%' GROUP BY Platform;

SELECT Platform, SUM(Global_Sales) 
FROM vgsales 
WHERE Platform 
IN ("PC", "PSP", "PS2", "PS3", "PS4", "PS5", "X360", "XONE") 
GROUP BY Platform;

-- Categorizing Games In Different Tiers In Terms Of Global_Sales
SELECT CASE
WHEN global_sales > 75 THEN "Tier 1 Game"
WHEN global_sales > 50 THEN "Tier 2 Game"
WHEN global_Sales > 25 THEN "Tier 3 Game"
ELSE "Tier 4 Games"
END AS Tier,
COUNT(*) AS No_Of_Games,
ROUND(SUM(global_Sales),2) AS Total_Sales
FROM vgsales
GROUP BY Tier;

-- Games That Are Both Released In PC And PS4
SELECT a.name, a.platform, b.platform 
FROM vgsales a JOIN vgsales b ON a.name = b.name 
WHERE a.platform = "PC" AND b.platform = "PS4";

-- Top 5 Games across platform in terms of Global Sales
SELECT name, sum(global_sales) as global_sales from vgsales WHERE name like "Call of Duty%" group by name order by global_sales DESC;
SELECT name, SUM(Global_Sales) as total from vgsales WHERE name like "Grand Theft Auto%" GROUP BY name ORDER By total DESC;

SELECT SUM(Global_Sales) AS Total_Sales
FROM vgsales
WHERE name LIKE "Call of Duty%";

SELECT distinct name from vgsales;