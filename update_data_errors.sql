USE [GameOfThronesDb]

UPDATE dbo.GameOfThronesDeaths
SET KillersHouse = 'White Walkers'
WHERE DeathNo = 1; 

UPDATE dbo.GameOfThronesDeaths
SET KillersHouse = 'White Walkers'
WHERE DeathNo = 2; 

UPDATE dbo.GameOfThronesDeaths
SET VictimsAllegiance = 'White Walkers'
WHERE Victim = 'White Walker'; 