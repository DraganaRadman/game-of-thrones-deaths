/*
=======================================================================
                        Game of Thrones Deaths Analysis
=======================================================================

Description:
------------
This script contains various SQL queries to analyze deaths in the
Game of Thrones series using data from the open-source dataset 
"game-of-thrones-deaths.xlsx" available at
https://data.world/makeovermonday/2019w27. The dataset has been processed, 
saved as a CSV file, and imported into the GameOfThronesDeaths table 
in a SQL Server database. The queries use the GameOfThronesDeaths table 
as the primary source, along with two views: vw_KillsByKiller and 
vw_KillsPerEpisode.

List of Queries:
--------
1. List of Killers by Victim Count
2. Top 10 Killers
3. Killers’ Methods by Kill Count
4. Top 10 Killers’ Methods
5. Killers’ Houses by Kill Count
6. Top 10 Killers’ Houses
7. Common Kill Methods by House
8. Most Common Cause of Death for Each House
9. List of Killing Locations by Kill Count
10. Top 5 Killing Locations
11. Most Common Killing Location by Season
12. Death Count by Episode and Location
13. Kills per Season
14. Kills per Episode
15. Episodes with the Highest Death Rate
16. Average Number of Kills per Killer
17. Killers with Most Diverse Methods
18. Most Frequent Killers in Each Season
19. Killers Active in Most Seasons
20. Top 5 Victims by Number of Seasons Appeared
21. Victims with Multiple Killers
22. Deaths by Allegiance
23. Murders among Allies - Killers Killing Their Own
24. Killers with the Most Different Victims' Allegiances
25. Deaths per Episode per House
26. Comparison of Deaths between Early and Late Seasons

=======================================================================
*/

USE [GameOfThronesDb]

-- List of Killers by Victim Count
SELECT * FROM [dbo].[vw_KillsByKiller] 
ORDER BY Kills DESC;

-- Top 5 Killers
SELECT TOP 5 Killer [Top Killers], [Killer`s House], [Kills] 
FROM [dbo].[vw_KillsByKiller]
ORDER BY Kills DESC;

-- Killers` Methods by Kill Count
SELECT Method [Killer`s Method], COUNT(Method) AS [Kills by Method] 
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Method
ORDER BY COUNT(Method) DESC;

-- Top 5 Killers` Methods
SELECT TOP 5 Method [Top Killers` Methods], COUNT(Method) AS [Kills by Method] 
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Method
ORDER BY COUNT(Method) DESC;

-- Killers` Houses by Kill Count
SELECT KillersHouse [Killer`s House], COUNT(DeathNo) [Kills by House] 
FROM [dbo].[GameOfThronesDeaths]
GROUP BY KillersHouse
ORDER BY COUNT(DeathNo) DESC;

-- Top 5 Killers` Houses
SELECT TOP 5 KillersHouse [Top 5 Killers` Houses], COUNT(DeathNo) [Kills by House] 
FROM [dbo].[GameOfThronesDeaths]
GROUP BY KillersHouse
ORDER BY COUNT(DeathNo) DESC;

-- Common Kill Methods by House
SELECT ISNULL(KillersHouse, 'None') [Killer`s House], Method [Kill Method], COUNT(DeathNo) [Deaths by Method]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY KillersHouse, Method
ORDER BY KillersHouse, [Deaths by Method] DESC;

-- Most Common Cause of Death for Each House
SELECT ISNULL(VictimsAllegiance, 'None') [House], Method [Cause of Death], COUNT(DeathNo) [Death Count]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY VictimsAllegiance, Method
ORDER BY VictimsAllegiance, [Death Count] DESC;

-- List of Killing Locations by Kill Count
SELECT Location [Killing Location], COUNT(DeathNo) [Kills by Location] 
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Location
ORDER BY COUNT(DeathNo) DESC;

-- Top 5 Killing Locations
SELECT TOP 5 Location [Top 5 Killing Locations], COUNT(DeathNo) [Kills by Location] 
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Location
ORDER BY COUNT(DeathNo) DESC;

-- Most Common Killing Location by Season
SELECT Season, Location, COUNT(DeathNo) [Death Count]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Season, Location
ORDER BY Season, [Death Count] DESC;

-- Death Count by Episode and Location
SELECT Season, Episode, Location, COUNT(DeathNo) [Death Count]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Season, Episode, Location
ORDER BY Season, Episode, [Death Count] DESC;

-- Kills per Season
SELECT Season, COUNT(DeathNo) [Kills per Season]   
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Season
ORDER BY Season;

-- Kills per Episode
SELECT Season, Episode, COUNT(DeathNo) [Kills per Episode]   
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Season, Episode
ORDER BY Season, Episode;

-- Episodes with the Highest Death Rate
SELECT TOP 5 Season, Episode, [Kills per Episode]   
FROM [dbo].[vw_KillsPerEpisode]
GROUP BY Season, Episode, [Kills per Episode] 
ORDER BY [Kills per Episode] DESC;

-- Average Number of Kills per Killer
SELECT AVG(Kills) [Average Kills per Killer] 
FROM (
    SELECT Killer, COUNT(DeathNo) [Kills]
    FROM [dbo].[GameOfThronesDeaths]
    GROUP BY Killer	
) AS KillerStats;

-- Killers with Most Diverse Methods
SELECT Killer, COUNT(DISTINCT Method) [Method Variety]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Killer
ORDER BY [Method Variety] DESC;

-- Most Frequent Killers in Each Season
SELECT Season, Killer, COUNT(DeathNo) [Kill Count]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Season, Killer
ORDER BY Season, [Kill Count] DESC;

-- Killers Active in Most Seasons
SELECT ISNULL(Killer, 'None') [Killer], COUNT(DISTINCT Season) [Active Seasons]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Killer
ORDER BY [Active Seasons] DESC;

-- Top 5 Victims by Number of Seasons Appeared
SELECT TOP 5 Victim, COUNT(DISTINCT Season) [Seasons Appeared]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Victim
ORDER BY [Seasons Appeared] DESC;

-- Victims with Multiple Killers
SELECT Victim, COUNT(DISTINCT Killer) [Killer Count]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Victim
HAVING COUNT(DISTINCT Killer) > 1
ORDER BY [Killer Count] DESC;

-- Deaths by Allegiance
SELECT ISNULL(VictimsAllegiance, 'None') [Victim`s Allegiance], COUNT(DeathNo) [Death Count]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY VictimsAllegiance
ORDER BY COUNT(DeathNo) DESC;

-- Murders among Allies - Killers Killing Their Own
SELECT Killer, Victim, KillersHouse [House]
FROM [dbo].[GameOfThronesDeaths] 
WHERE KillersHouse = VictimsAllegiance
ORDER BY KillersHouse;

-- Killers with the Most Different Victims' Allegiances
SELECT ISNULL(Killer, 'None') [Killer], COUNT(DISTINCT VictimsAllegiance) [Distinct Victims' Allegiances]
FROM [dbo].[GameOfThronesDeaths] 
GROUP BY Killer
ORDER BY [Distinct Victims' Allegiances] DESC;

-- Deaths per Episode per House
SELECT Season, Episode, ISNULL(VictimsAllegiance, 'None') [House], COUNT(DeathNo) [Deaths per House]
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Season, Episode, VictimsAllegiance
ORDER BY Season, Episode, [Deaths per House] DESC;

-- Comparison of Deaths between Early and Late Seasons
SELECT 
    CASE 
        WHEN Season <= 4 THEN 'Early Seasons'
        ELSE 'Late Seasons'
    END AS [Season Period],
    COUNT(DeathNo) AS [Death Count]
FROM GameOfThronesDeaths
GROUP BY 
    CASE 
        WHEN Season <= 4 THEN 'Early Seasons'
        ELSE 'Late Seasons'
    END
ORDER BY [Season Period];






 



 










 

