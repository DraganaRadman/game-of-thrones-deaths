USE [GameOfThronesDb]
GO

CREATE VIEW vw_KillsPerEpisode AS
SELECT Season, Episode, COUNT(DeathNo) [Kills per Episode]   
FROM [dbo].[GameOfThronesDeaths]
GROUP BY Season, Episode


 