USE [GameOfThronesDb]
GO

CREATE VIEW vw_KillsByKiller AS

SELECT ISNULL(Killer, 'None') [Killer], ISNULL(KillersHouse, 'None') [Killer`s House], COUNT(DeathNo) [Kills] 
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Killer, KillersHouse






