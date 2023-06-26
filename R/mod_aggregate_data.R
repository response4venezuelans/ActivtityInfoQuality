# Module UI
 
#' @title mod_aggregate_data_ui and mod_aggregate_data_server
#' @description A shiny module.
 
mod_aggregate_data_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "aggregate_data",
		fluidRow(
			
		)
	)
}
 
# Module Server
 
mod_aggregate_data_server <- function(input, output, session) {
	ns <- session$ns
}
 
## copy to body.R
# mod_aggregate_data_ui("aggregate_data_ui_1")
 
## copy to app_server.R
# callModule(mod_aggregate_data_server, "aggregate_data_ui_1")
 
## copy to sidebar.R
# menuItem("displayName",tabName = "aggregate_data",icon = icon("user"))
 
