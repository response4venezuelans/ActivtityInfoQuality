#' UI Side menau
#'
#' This function is internally used to manage the side menu
#'
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal
#'
sidebar <- function() {
  dashboardSidebar(
    sidebarMenu(
      ## Here the menu item entry to the first module 
      menuItem("About",tabName = "home",icon = icon("bookmark")),
      menuItem("Read Data",tabName = "read_data",icon = icon("database")),
      menuItem("Error Report",tabName = "error_report",icon = icon("bug")),
      menuItem("Aggregate data",tabName = "aggregate_data",icon = icon("calculator"))
      # - add more - separated by a comma!
    )
  )
}
