
app_server <- function(input, output, session) {
  
  ## add a reactive value object to pass by elements between objects
  AppReactiveValue <-  reactiveValues(
    result = list(),
    countrieshere = NULL,
    vActivities  = 0,
    vErrors = 0,
    vPercentage = 0
  ) 
  # pins::board_register() # connect to pin board if needed
  callModule(mod_home_server, "home_ui_1")
  callModule(mod_read_data_server, "read_data_ui_1", AppReactiveValue)
  callModule(mod_error_report_server, "error_report_ui_1", AppReactiveValue)
  callModule(mod_aggregate_data_server, "aggregate_data_ui_1")
  
}
