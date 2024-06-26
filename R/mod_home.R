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
      
      tabsetPanel(type = "tabs",
                  tabPanel(title= "English",
                           ### Get the name for your tool
                           p(
                             tags$span("Quality Control and Aggregation of Monitoring Data", style = "font-size: 60px"),
                             tags$span("ActivityInfo - 5W and Consolidated Report 2024", style = "font-size: 24px")
                           ),
                           br(),
                           ### Then a short explainer
                           p("Although Activity Info permit to put restrictions and validation 
		          rules, some of those can be overwritten, especially when bulk
		          uploading data.",
                             style = "font-size: 20px"),
                           br(),
                           p("This app is designed to check existing data in ActivityInfo or to 
        quickly check offline data before bulk-uploading it.",
                             style = "font-size: 20px"),
                           br(),
                           p("After Quality Assurance (QA), user can then download an aggregated 
        version of their dataset according to context-specific method and use 
        this data for the creation of the R4V Consolidated Report on reached 
        population by sector.",
                             style = "font-size: 20px"),
                           
                           br(), 
                           p(tags$i( class = "fa fa-github"),
                             "App built with ",
                             tags$a(href="https://edouard-legoupil.github.io/graveler/",
                                    "{graveler}" ),
                             " -- report ",
                             tags$a(href="https://github.com/response4venezuelans/ActivtityInfoQuality/issues",
                                    "issues here or directly to the Regional platform Info Mngnt team." ,
                             ),
                             style = "font-size: 10px")
                           
                 ),
                  
                  tabPanel(title= "Spanish",
                           
                           ### Get the name for your tool SPA
                           p(
                             tags$span("Control de calidad y agregacion de datos de monitoreo", style = "font-size: 60px"),
                             tags$span("ActivityInfo R4V – 5W y Reporte Consolidado 2024", style = "font-size: 24px")
                           ),
                           br(),
                           ### Then a short explainer SPA
                           p("Aunque ActivityInfo permite poner restricciones y reglas de validacion, 
      algunas de ellas se pueden sobrescribir, especialmente cuando se cargan datos
        de forma masiva.",
                             style = "font-size: 20px"),
                           br(),
                           p("Esta aplicacion esta disenada para verificar los datos existentes en ActivityInfo
        o para verificar rapidamente los datos sin conexion antes de cargarlos en masa.",
                             style = "font-size: 20px"),
                           br(),
                           p("Despues del proceso del chequeo de calidad (QA), el usuario puede descargar una version 
        agregada de su conjunto de datos de acuerdo con el metodo especifico del contexto y usar
        estos datos para la creacion del Reporte Consolidado sobre poblacion alcanzada por sector.",
                             style = "font-size: 20px"),
                           br(),
                           p(tags$i( class = "fa fa-github"), "App built with ",
                             tags$a(href="https://edouard-legoupil.github.io/graveler/",
                                    "{graveler}" ),
                             " -- report ", tags$a(href="https://github.com/response4venezuelans/ActivtityInfoQuality/issues",
                                    "issues here or directly to the Regional platform Info Mngnt team." ,
                             ),
                             style = "font-size: 10px")
                           
                    )
      )
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
 
