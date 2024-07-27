# Game of Thrones Deaths Analysis

## Project Overview

This project focuses on the statistical analysis of deaths in the *Game of Thrones* series using SQL Server and an open-source dataset. It aims to practice importing data from external files into SQL Server and practicing querying. The project includes SQL scripts and data files to recreate the database, import the dataset, and run various analysis queries.

## Components
 
* **game-of-thrones-deaths.csv:** The original dataset saved as a CSV file with "None" values replaced by NULL. This file should be imported into the SQL Server database into the ***GameOfThronesDeaths*** table.
* **update_data_errors.sql:** SQL script to correct known data errors. 
* **create_vw_KillsByKiller.sql:** SQL script to create the ***vw_KillsByKiller*** view.
* **create_vw_KillsPerEpisode.sql:** SQL script to create the ***vw_KillsPerEpisode*** view.
* **GameOfThronesDeathsAnalysis.sql:** A collection of SQL queries analyzing the Game of Thrones deaths dataset.

## Setup Instructions

1. **Create the Database**:
   - Open SQL Server Management Studio (SSMS) and connect to your SQL Server instance.
   - Execute the `CREATE DATABASE` command to create the ***GameOfThronesDb*** database.

2. **Import the CSV File**:
   - Right-click on the ***GameOfThronesDb*** database in SSMS.
   - Use the `Import Flat File...` option to import **game-of-thrones-deaths.csv** as a new table. Ensure the table is named accordingly and adjust columns as needed.

   ![GameOfThronesDeathsTableDiagram](https://github.com/user-attachments/assets/d95a27e3-2826-424c-819e-2e2f0d96d3dc)
             
3. **Update Data Errors**:
   - Execute the **update_data_errors.sql** script to correct any data inconsistencies.

   **Note:** If you discover additional errors or have suggestions for improvements, please feel free to contribute!
  
4. **Create Views**:
   - Run the **create_vw_KillsByKiller.sql** and **create_vw_KillsPerEpisode.sql** scripts to set up the views used in analysis.

## Analyze the Data

- **Run Queries**:
   - Use the **GameOfThronesDeathsAnalysis.sql** script to run various queries and analyze the dataset. 

## Additional Notes

- If you discover additional errors or have suggestions for improvements, please feel free to contribute!

## Links

- **Dataset Source**: [game-of-thrones-deaths.xlsx](https://data.world/makeovermonday/2019w27)

