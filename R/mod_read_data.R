# Module UI
 
#' @title mod_read_data_ui and mod_read_data_server
#' @description A shiny module that either get data from API or from a copy paste
#'              in the browser.
#' @import shiny
#' @import shinydashboard
#' @importFrom datamods import_copypaste_ui
#' @importFrom DT dataTableOutput
#' @noRd 
#' @keywords internal

mod_read_data_ui <- function(id) {
  ns <- NS(id)
  tabItem(
    tabName = "read_data",
    fluidRow(
        column(
          width = 12,
          shinydashboard::box(
            id = "box_2",
            title = "Data Import Options",
            solidHeader = T,
            collapsible = T,
            collapsed = F,
            width = 12,
            status = "primary",
            
            # "Either copy paste the data with the header 
            #   or load all the records from ActivityInfo API",
            #  or upload you regional ENG 5W import table 
            
            tabsetPanel(type = "tabs",
                        tabPanel(title= "Option 1: Copy-Paste Data in Browser",
                                 datamods::import_copypaste_ui(
                                   id = ns("myid"), 
                                   title = " Do not forget to paste with the header row
                                   so that the data can be properly recognised.",
                                   name_field = FALSE),
                                 verbatimTextOutput(outputId = ns("status"))
                        ),
                        tabPanel(title= "Option 2: Pull Data from ActivityInfo API",
                                 br(),
                                 "The action below will take a bit of time to complete.",
                                 br(),
                                 actionButton(
                                   inputId = ns("Run_Script"),
                                   label = "Pull from Activity Info (API) database ",
                                   icon = icon("cloud-arrow-down"),
                                   width = "600px" )
                                 )
            )
          )
        )
      ),
      fluidRow(
        column(
          width = 12,
        shinydashboard::box(
          id = "box_9",
          title = "Preview data",
          solidHeader = T,
          collapsible = T,
          collapsed = F,
          width = 12,
          status = "primary",
          DT::dataTableOutput( ns("Preview_Data"))
            )
        )
      ) #,
      # fluidRow(
      #   column(
      #     width = 12,
      #   shinydashboard::box(
      #     id = "box_15",
      #     title = "Control",
      #     solidHeader = T,
      #     collapsible = T,
      #     collapsed = T,
      #     width = 12,
      #     status = "primary",
      #     tags$b("Imported data:"),
      #     verbatimTextOutput(outputId = ns("status")),
      #     verbatimTextOutput(outputId = ns("data") )
      #   )
      #  )
      # )
  )
}

#' Module Server
#' @import shiny
#' @importFrom datamods import_copypaste_server
#' @importFrom DT renderDataTable
#' @importFrom dplyr mutate across arrange na_if
#' @noRd 
#' @keywords internal

mod_read_data_server <- function(input, output, session, AppReactiveValue) {
  ns <- session$ns
  
  
  ## option to import via copy paste
  imported <- datamods::import_copypaste_server(
    id = "myid",
    btn_show_data = FALSE)
  
  output$status <- renderPrint({
    if( is.null(imported$status()))
    { "IDLE" } else {
     # AppReactiveValue$result <- fct_read_data( data = imported$data)
      imported$status()
      #AppReactiveValue$result <- fct_read_data( data = imported$data)
      # Data(read_data_2023_local(imported$data()))
      ## load from API to get the reference
      resultapi <- fct_read_data()
      
      shiny::showNotification("Data Processing Complete",
                              duration = 10, 
                              type = "error")
      
      AppReactiveValue$result <- resultapi
      AppReactiveValue$countrieshere <- unique(AppReactiveValue$result$df5W$Country)
      
      ## Clean a bit
      pasted <- imported$data  
      colnames(pasted) <- c("Country",
                          "Admin1",
                          "Admin2",
                          "Appealing_org",
                          "Implementation",
                          "Implementing_partner",
                          "Month",
                          "Subsector",
                          "Indicator",
                          "Activity_Name",
                          "Activity_Description",
                          "RMRPActivity",
                          "CVA",
                          "Value",
                          "Delivery_mechanism",
                          "Quantity_output",
                          "Total_monthly",
                          "New_beneficiaries",
                          "IN_DESTINATION",
                          "IN_TRANSIT",
                          "Host_Communities",
                          "PENDULARS",
                          "Returnees",
                          "Girls",
                          "Boys",
                          "Women",
                          "Men",
                          "Other_under",
                          "Other_above")
      
      pasted <- pasted |>
        dplyr::mutate(
          dplyr::across( c(Value,
                    Quantity_output,
                    Total_monthly,
                    New_beneficiaries,
                    IN_DESTINATION,
                    IN_TRANSIT,
                    Host_Communities,
                    PENDULARS,
                    Returnees,
                    Girls,
                    Boys,
                    Women,
                    Men,
                    Other_under,
                    Other_above), as.numeric) ) |>
          dplyr::arrange(Country, Month) |>
          dplyr::na_if("")
        
      
      ## replace the 5W data with the pasted one
      AppReactiveValue$result[["df5W"]] <-   pasted 
      countrieshere <- unique(AppReactiveValue$resultapi$df5W$Country)
      
      ## update the filters based on the data..
      updateSelectInput(session = session,
                        inputId = "country_name",
                        choices = c("All", AppReactiveValue$countrieshere))
      
      updateSelectInput(session = session,
                        inputId ="country_name_agg" ,
                        choices = c("All", AppReactiveValue$countrieshere ))
      
    }
    })  
  
  
  ## option to import via API
  observeEvent(input$Run_Script, {
     resultapi <- fct_read_data()
    
    AppReactiveValue$result <- resultapi 
    AppReactiveValue$countrieshere <- unique(AppReactiveValue$result$df5W$Country)
    ## update the filters based on the data..
    updateSelectInput(session = session,
                      inputId = "country_name",
                      choices = c("All", AppReactiveValue$countrieshere))
    
    updateSelectInput(session = session,
                      inputId ="country_name_agg" ,
                       choices = c("All", AppReactiveValue$countrieshere ))
    
    shiny::showNotification(ui = "Data Import Complete",
                     duration = 10,
                     type = "error")
    })
  

  ## Data Preview
  output$Preview_Data <- DT::renderDataTable(
    expr = as.data.frame(AppReactiveValue$result[["df5W"]] ) ,
   # extensions = c("Buttons"),
    options = list(
      dom = 'lfrtip',
      # add B for button
      paging = TRUE,
      ordering = TRUE,
      lengthChange = TRUE,
      pageLength = 10,
      scrollX = TRUE,
      autowidth = TRUE,
      rownames = TRUE
    )
  )
  

  
}
 
## copy to body.R
# mod_read_data_ui("read_data_ui_1")
 
## copy to app_server.R
# callModule(mod_read_data_server, "read_data_ui_1")
 
## copy to sidebar.R
# menuItem("displayName",tabName = "read_data",icon = icon("user"))
 
