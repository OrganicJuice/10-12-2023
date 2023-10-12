# 10/12/2023 class presentation 

library(dplyr)
library(DBI)
library(dbplyr)
library(odbc)

odbcListDrivers()

con <- DBI::dbConnect(odbc(),
                      Driver = "SQL Server",
                      Server = "mcobsql.business.nd.edu",
                      UID = "MSBAstudent",
                      PWD = "SQL%database!Mendoza",
                      Port = 3306, 
                      Database = "RecipesExample")

dbListFields(con, "Recipe_Classes")

dbListFields(con, "Recipes")