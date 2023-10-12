# 10/12/2023 class presentation 

library(dplyr)
library(DBI)
library(dbplyr)
library(odbc)

odbcListDrivers()

system.time({con <- DBI::dbConnect(odbc(),
                      Driver = "SQL Server",
                      Server = "mcobsql.business.nd.edu",
                      UID = "MSBAstudent",
                      PWD = "SQL%database!Mendoza",
                      Port = 3306, 
                      Database = "RecipesExample")

dbListFields(con, "Recipe_Classes")

dbListFields(con, "Recipes")

select_q <- dbSendQuery(
  conn = con, 
  statement = "SELECT RecipeClassDescription,
COUNT(RecipeClassDescription) AS Frequency
FROM Recipe_Classes rc
JOIN Recipes r ON r.RecipeClassID = rc.RecipeClassID
GROUP BY RecipeClassDescription
ORDER BY Frequency DESC "
)

select_res <- dbFetch(select_q)})

