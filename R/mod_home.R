# Module UI
 
# Module UI

#' @title mod_home_ui and mod_home_server
#' @description A shiny module.
#' @import shiny
#' @import shinydashboard
#' @noRd 
#' @keywords internal


mod_home_ui <- function(id) {
  ns <- NS(id)
  tabItem(
    tabName = "home",
    absolutePanel(  ## refers to a css class
      id = "splash_panel", top = 0, left = 0, right = 0, bottom = 0,
      ### Get the name for your tool
      p(
        tags$span("Data Quality Control & Aggregation", style = "font-size: 60px"),
        tags$span("ActivityInfo - R4V - 2023", style = "font-size: 24px")
      ),
      br(),
      ### Then a short explainer
      p("Although Activity Info permit to put restrictions and validation 
		          rules, some of those can be overwritten, especially when bulk
		          uploading data.",
        style = "font-size: 20px"),
      br(),
      p("This app is designed to quickly check your data before bulk-uploading them. 
		      It also aggregate dataset based on different scenarios",
        style = "font-size: 20px"),
      br(),
      p("Please report issues to the Regional platform IM team",
        style = "font-size: 12px"),
      br(),
      
      fluidRow(
        actionButton(NS(id, "go_to_firstmod"),
                     label = "Get Data", 
                     width = "150px",
                     style='font-size: 16px; color: #18375F',
                     icon = icon("chevron-right")),
        style = "font-size: 18px; text-align: right;"
      ),
      br()
    ) 
  )
}
 
#'  Module Server
#' @import shiny
#' @import shinydashboard
#' @noRd 
#' @keywords internal


mod_home_server <- function(input, output, session) {
  ns <- session$ns
  # This create the links for the button that allow to go to the next module
  observeEvent(input$go_to_firstmod, {
    shinydashboard::updateTabItems(
      session = session,
      inputId = "tab_selected",
      selected = "get_data"
    )
  })
}
 
## copy to body.R
# mod_home_ui("home_ui_1")
 
## copy to app_server.R
# callModule(mod_home_server, "home_ui_1")
 
## copy to sidebar.R
# menuItem("displayName",tabName = "home",icon = icon("user"))
 
