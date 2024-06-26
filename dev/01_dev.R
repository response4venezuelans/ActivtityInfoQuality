## Add basic dependencies
pkgs <- c(
  "unhcrshiny",
  "tidyverse",
  "ggplot2",
  "golem",
  "shiny",
  "shinyjs",
  "shinyWidgets",
  "shinydashboard",
  "shinydashboardPlus"
)

for (i in pkgs) {
  usethis::use_package(i)
}

## Add manifest for CI/CD
rsconnect::writeManifest()

## Go to run_dev.R and ensure the empty dashboard loads
rstudioapi::navigateToFile("dev/run_dev.R")

## Alternatively you can run golem::run_dev()

## Now start adding modules from console
# Name of the module - "my_first_module"
# graveler::level_up(name = "my_first_module") 
# graveler::level_up(name = "read_data") 
# graveler::level_up(name = "error_report") 
# graveler::level_up(name = "aggregate_data") 

## Make sure to update imported libraries in the package namespace
attachment::att_amend_desc()


## Build the html package documentation for your utilities functions from the 
pkgdown::build_site()