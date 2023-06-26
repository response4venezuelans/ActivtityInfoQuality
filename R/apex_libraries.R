
pkgs <- c(
  "unhcrshiny",
  "tidyverse",
  "golem",
  "shiny",
  "shinyjs",
  "shinyWidgets",
  "shinydashboard",
  "shinydashboardPlus"
)

for (i in pkgs) {
  library(i, character.only = TRUE)
}
