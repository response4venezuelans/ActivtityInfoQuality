#'
#' This function is internally used to manage the body
#'
#' @import shiny
#' @import shinydashboard
#' @importFrom unhcrshiny theme_shinydashboard_unhcr
#' @noRd
#' @keywords internal
#' 
body <- function() {
  dashboardBody(
    unhcrshiny::theme_shinydashboard_unhcr(),
    tags$head(
      tags$script(src = "custom.js")
    ),
    tabItems(
      #Add ui module here - separated with a coma!
      mod_home_ui("home_ui_1"),
      mod_read_data_ui("read_data_ui_1"),
      mod_error_report_ui("error_report_ui_1"),
      mod_aggregate_data_ui("aggregate_data_ui_1")
      
    )
  )
}
