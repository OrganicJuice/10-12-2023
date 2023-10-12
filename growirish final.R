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

Recipe_Class_Count <- dbFetch(select_q)})
dbClearResult(select_q)

library(ggplot2)

ggplot(data=Recipe_Class_Count, aes(x=reorder(RecipeClassDescription, -Frequency), y=Frequency, fill = RecipeClassDescription)) +
  geom_bar(stat = "identity") + 
  labs(x = "Recipe Class") +
  theme_minimal()


# NEXT 

dbListFields(con, "Ingredient_Classes")

dbListFields(con, "Ingredient")

select_r <- dbSendQuery(
  conn = con, 
  statement = " SELECT IngredientClassDescription,
COUNT(IngredientClassDescription) AS Frequency
FROM Ingredient_Classes ic
JOIN Ingredients i ON i.IngredientClassID = ic.IngredientClassID
GROUP BY IngredientClassDescription
ORDER BY Frequency DESC "
)

Ingredient_Class_Count <- dbFetch(select_r)

library(ggplot2)

ggplot(data=Ingredient_Class_Count, aes(x=reorder(IngredientClassDescription, -Frequency), y=Frequency, fill = IngredientClassDescription)) +
  geom_bar(stat = "identity") + 
  labs(x = "Ingredient Class") +
  theme_minimal()





