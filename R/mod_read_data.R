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
            title = "Data Import",
            solidHeader = FALSE,
            collapsible = T,
            collapsed = F,
            width = 12,
            status = "primary",
            
            # "Either copy paste the data with the header 
            #   or load all the records from ActivityInfo API",
            #  or upload you regional ENG 5W import table 
            
            tabsetPanel(type = "tabs",
                        tabPanel(title= "Option 1: Pull & Filter Data already submitted to ActivityInfo",
                                 br(),
                                 "The action below will take a bit of time to complete if you do not use filter.",
                                 br(),
                                 radioButtons(inputId = ns("filter"),
                                             label = "Filter to use", 
                                             choices =  c("country", "partner") ,
                                             selected ="country"),
                                 selectInput(inputId = ns("value"),
                                             label = "select value for the filter", 
                                             choices = NULL ,
                                             selected ="All"),
                                 actionButton(
                                   inputId = ns("Run_Script"),
                                   label = "Pull from Activity Info (API) database - please wait a bit until you get the data preview below...",
                                   icon = icon("cloud-arrow-down"),
                                   width = "100%" )
                                 ),
                        
                        tabPanel(title= "Option 2: Alternatively upload your own Data File",
                                 # datamods::import_copypaste_ui(
                                 #   id = ns("myid"), 
                                 #   title = " Do not forget to paste with the header row
                                 #   so that the data can be properly recognised.",
                                 #   name_field = FALSE),
                                 
                                 datamods::import_file_ui( id = ns("myid"), 
                                                           file_extensions = c( ".xlsx")),
                                 
                                 verbatimTextOutput(outputId = ns("status")),
                                 actionButton(inputId = ns("local_data"),
                                              label = "Analyze your data",
                                              icon = icon("cloud-upload"),
                                              width = "100%")
                        )
            )
          )
        )
      ) ,
      fluidRow(
        column(
          width = 12,
        shinydashboard::box(
          id = "box_9",
          title = "Data Preview",
          solidHeader = FALSE,
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
  

  ## Filters for API Call
  observeEvent(input$filter, {
  updateSelectInput(session = session,
             inputId ="value" ,
             choices = c("All", 
                         if( input$filter == "country"){
                           AppReactiveValue$lookup_dfadmin1 |>
                             dplyr::select(Country) |>
                             dplyr::distinct() |>
                             dplyr::arrange()|>
                             dplyr::pull()
                         } else {
                           AppReactiveValue$lookup_dfpartner |>
                             dplyr::select(Name) |>
                             dplyr::distinct() |>
                             dplyr::arrange()|>
                             dplyr::pull()
                         }
                         ))
  })
  
  ## option to import via API
  observeEvent(input$Run_Script, {
     if ( input$value == "All") {
         df5W <- fct_read_data() 
       } else {
         df5W <- fct_read_data( filter = input$filter,
                                value = input$value)
       }
    
    
    ### Create a country filter to the final aggregate report
    if ( input$filter == "country" & !( input$value == "All")) {
      AppReactiveValue$CountryFilter <- input$value
    } else {
      AppReactiveValue$CountryFilter <- NULL
    }
    
    ## Get this within the reactive value
    AppReactiveValue$df5W <- df5W 
     ## Precompile in the reactive value the rest of the app with default value..
     error_report <- fct_error_report(df5W, 
                                   AppReactiveValue$lookup_dfadmin1, 
                                   AppReactiveValue$lookup_dfadmin2, 
                                   AppReactiveValue$lookup_dfindicator, 
                                   AppReactiveValue$lookup_dfpartner)
    AppReactiveValue$error_report <- error_report 
    
    ## Get key metrics
    AppReactiveValue$vActivities  <- nrow(error_report[["ErrorReportclean"]])
    AppReactiveValue$vErrors <- sum(!is.na(error_report[["ErrorReportclean"]]$Review2))
    AppReactiveValue$vPercentage <- round(
                    sum(!is.na(error_report[["ErrorReportclean"]]$Review2))
                    /nrow(error_report[["ErrorReportclean"]]) * 100, 
                    digits = 1)
    
    ## precompile aggregate per default
    aggregate <- fct_aggregate_data(AppReactiveValue$df5W,
                                       AppReactiveValue$lookup_dfindicator, 
                                       proportions = "pin",  
                                       totalmodel = "sum"   )
    
    if( is.null(AppReactiveValue$CountryFilter) ){
      AppReactiveValue$aggregate <- aggregate
    } else {
    AppReactiveValue$aggregate <- aggregate |>
                                  dplyr::filter( Country == AppReactiveValue$CountryFilter)
    }
      
      
    
    # shiny::showNotification(ui = "Data Import Complete",
    #                  duration = 10,
    #                  type = "error")
    
    })
  
  ### Alternative upload offline data
  ## option to import via copy paste
  # imported <- datamods::import_copypaste_server(
  #   id = "myid",
  #   btn_show_data = FALSE)
  
  ## Import via file
  imported <- datamods::import_file_server(id = "myid",
                                           show_data_in = "modal",
                                           return_class = "data.frame")
  
  # output$status <- renderPrint({
  #   if( is.null(imported$status()))
  #   { "IDLE" } else {
  #     # AppReactiveValue$result <- fct_read_data( data = imported$data)
  #     imported$status() 
  #   }
  # })  
  
  output$status <- renderPrint({
    
    ## Get this within the reactive value
    AppReactiveValue$df5W <- imported$data()
    # ## And finally display status..... 
    imported$status()
  })
    
  observeEvent(input$local_data, {
  #observeEvent(input$container_confirm_btn , {
    # ## Precompile in the reactive value the rest of the app with default value..
    AppReactiveValue$error_report  <- fct_error_report(AppReactiveValue$df5W,
                                     AppReactiveValue$lookup_dfadmin1,
                                     AppReactiveValue$lookup_dfadmin2,
                                     AppReactiveValue$lookup_dfindicator,
                                     AppReactiveValue$lookup_dfpartner)

    # ## Get key metrics
    AppReactiveValue$vActivities  <- nrow(AppReactiveValue$error_report[["ErrorReportclean"]])
    AppReactiveValue$vErrors <- sum(!is.na(AppReactiveValue$error_report[["ErrorReportclean"]]$Review2))
    AppReactiveValue$vPercentage <- round(
      sum(!is.na(AppReactiveValue$error_report[["ErrorReportclean"]]$Review2))
      /nrow(AppReactiveValue$error_report[["ErrorReportclean"]]) * 100,
      digits = 1)
    
    # ## precompile aggregate per default
    AppReactiveValue$aggregate <- fct_aggregate_data(AppReactiveValue$df5W,
                                    AppReactiveValue$lookup_dfindicator,
                                    proportions = "pin",
                                    totalmodel = "sum"    ) 
  })
  
  
  
  #pasted <- imported$data   # |>
  #           dplyr::select(
  #           tidyselect::any_of(Country,
  #                         Admin1,
  #                         Admin2,
  #                         Appealing_org,
  #                         Implementation,
  #                         Implementing_partner,
  #                         Month,
  #                         Subsector,
  #                         Indicator,
  #                         Activity_Name,
  #                         Activity_Description,
  #                         RMRPActivity,
  #                         CVA,
  #                         Value,
  #                         Delivery_mechanism,
  #                         Quantity_output,
  #                         Total_monthly,
  #                         New_beneficiaries,
  #                         IN_DESTINATION,
  #                         IN_TRANSIT,
  #                         Host_Communities,
  #                         PENDULARS,
  #                         Returnees,
  #                         Girls,
  #                         Boys,
  #                         Women,
  #                         Men,
  #                         Other_under,
  #                         Other_above))
  
  #           )
  # colnames(pasted) <- c("Country",
  #                     "Admin1",
  #                     "Admin2",
  #                     "Appealing_org",
  #                     "Implementation",
  #                     "Implementing_partner",
  #                     "Month",
  #                     "Subsector",
  #                     "Indicator",
  #                     "Activity_Name",
  #                     "Activity_Description",
  #                     "RMRPActivity",
  #                     "CVA",
  #                     "Value",
  #                     "Delivery_mechanism",
  #                     "Quantity_output",
  #                     "Total_monthly",
  #                     "New_beneficiaries",
  #                     "IN_DESTINATION",
  #                     "IN_TRANSIT",
  #                     "Host_Communities",
  #                     "PENDULARS",
  #                     "Returnees",
  #                     "Girls",
  #                     "Boys",
  #                     "Women",
  #                     "Men",
  #                     "Other_under",
  #                     "Other_above")
  
  # pasted <- pasted |>
  #   dplyr::mutate(
  #     dplyr::across( c(Value,
  #                      Quantity_output,
  #                      Total_monthly,
  #                      New_beneficiaries,
  #                      IN_DESTINATION,
  #                      IN_TRANSIT,
  #                      Host_Communities,
  #                      PENDULARS,
  #                      Returnees,
  #                      Girls,
  #                      Boys,
  #                      Women,
  #                      Men,
  #                      Other_under,
  #                      Other_above), as.numeric) ) |>
  #   dplyr::arrange(Country, Month) |>
  #   dplyr::na_if("")
  # AppReactiveValue$pasted <- pasted
  
  
  ## Data Preview
  output$Preview_Data <- DT::renderDataTable(
    expr = as.data.frame(AppReactiveValue$df5W ) ,
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
 
