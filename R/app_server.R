#' Server
#'
#' This function is internally used to manage the shinyServer
#'
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal
app_server <- function(input, output, session) {
  
  ## add a reactive value object to pass by elements between objects
  AppReactiveValue <-  reactiveValues(
    
    lookup_dfadmin1 = fct_read_lookup(type = "admin1"),
    lookup_dfadmin2 = fct_read_lookup(type = "admin2"),
    lookup_dfindicator =  fct_read_lookup(type = "indicator"),
    lookup_dfpartner =  fct_read_lookup(type = "partner"),
    
    ## Default value... 
    # result = fct_error_report( result =fct_read_data()),
    # countrieshere = NULL,
    
    vActivities  =  0,
    vErrors = 0,
    vPercentage = 0
  ) 
  # pins::board_register() # connect to pin board if needed
  callModule(mod_home_server, "home_ui_1")
  callModule(mod_read_data_server, "read_data_ui_1", AppReactiveValue)
  callModule(mod_error_report_server, "error_report_ui_1", AppReactiveValue)
  callModule(mod_aggregate_data_server, "aggregate_data_ui_1", AppReactiveValue)
  
}
