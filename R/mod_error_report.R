# Module UI
 
#' @title mod_error_report_ui and mod_error_report_server
#' @description A shiny module.
#' @import shiny
#' @import shinydashboard
#' @importFrom DT dataTableOutput
#' @importFrom plotly plotlyOutput
#' @noRd 
#' @keywords internal
 
mod_error_report_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "error_report",
		fluidRow(
		  shinydashboard::box(
		    id = "box_2",
		    title = "Data Quality Assurance",
		    solidHeader = FALSE,
		    collapsible = T,
		    collapsed = F,
		    width = 12,
		    status = "primary",
		    fluidRow(
		     column(
		     width = 3,
		     # p("Configure cleaning"),
		      br(),
		      br() #,
		      # downloadButton(outputId =  ns("downloadprecleaned"),
		      #                label = "Download Error report" ) 
		     ),
		     column(
		       width = 3,
		      valueBoxOutput(
		        outputId = ns("vActivities"),
		        width = NULL) 
		      ),
		     column(
		       width = 3,
		      valueBoxOutput(
		        outputId = ns("vErrors"),
		        width = NULL)
		     ),
		     column(
		       width = 3,
		      valueBoxOutput(
		        outputId = ns("vPercentage"),
		        width = NULL)
		     ) 
		    )
		  )
		 # ) ,
		  # column(
		  #   width = 6,
		  #   shinydashboard::box(
		  #     id = "box_3",
		  #     title = "Summary Figures",
		  #     solidHeader = F,
		  #     collapsible = T,
		  #     collapsed = F,
		  #     width = 16,
		  #     status = "warning",
		  #     p("Number or Activities"),
		  #     h2(textOutput( ns("Number_of_Activities")  )),
		  #     p("Number of activities to review"),
		  #     h2(textOutput( ns("Number_of_Errors_Pre") )),
		  #     p("Percentage of errors"),
		  #     h2(textOutput(ns("Percentage_of_Errors") )),
		  #   )
		  # )
		),
		fluidRow(
		  column(
		    width = 12,
		    shinydashboard::box(
		      id = "box_14",
		      title = "Output",
		      solidHeader = FALSE,
		      collapsible = T,
		      collapsed = F,
		      width = 12,
		      status = "primary",
		      tabsetPanel(type = "tabs",
		                  tabPanel(title= "Plots Errors by Country",
		                               plotly::plotlyOutput(
		                                 outputId = ns("plot") ,
		                                 height = "750px") ),
		                  tabPanel(title= "Plots Errors by Org", 
		                           plotly::plotlyOutput(
		                             outputId = ns("plot2"),
		                             height = "750px" ) ),
		                  tabPanel(title= "Table", 
		                           downloadButton(outputId =  ns("downloadprecleaned"),
		                                          label = "Download Error report" ) ,
		                           DT::dataTableOutput( ns("Preview_Error_Report") ) )
		      )
		    ) # box
		  ) # column
		) # row
	) # tab
}
 
#' Module Server
#' @import shiny
#' @import ggplot2
#' @importFrom plotly renderPlotly
#' @importFrom DT renderDataTable
#' @importFrom writexl write_xlsx
#' @noRd 
#' @keywords internal
 
mod_error_report_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns

	## trigger the function for error check
	# observeEvent(input$run_err_report,{
	#   #tocheck <- AppReactiveValue$result
	#   #AppReactiveValue$result <- Error_report 
	#   AppReactiveValue$result <- fct_error_report(
	#                              result = AppReactiveValue$result,
	#                              countryname = input$countryname)
	#   
	# })
	 
	 #  output number of activities and error 
	 output$vActivities <- renderValueBox({
	   valueBox(
	     value =  AppReactiveValue$vActivities ,
	     subtitle =  "Number or Activities",
    	   icon = icon("location-dot"),
    	   color = "aqua"
    	   )
	 })
	 
	 output$vErrors <- renderValueBox({
	   valueBox(
	     value = AppReactiveValue$vErrors , 
	     subtitle = "Activities to review", 
    	   icon = icon("list"),
    	   color = "orange"
    	   )
	 })
	 
	 output$vPercentage <- renderValueBox({
	   valueBox(
	     value =  AppReactiveValue$vPercentage,
	     subtitle =  "Percentage of errors", 
    	   icon = icon("triangle-exclamation"),
    	   color = "purple"
    	   )
	 })
	  
	 # interactive plot with plotly
	  output$plot <- plotly::renderPlotly({
	    AppReactiveValue$error_report$plot_Country
	    })
	  
	  output$plot2 <- plotly::renderPlotly({
	    AppReactiveValue$error_report$plot_Appealing
	    })
	  
	#showNotification("Successful",duration = 10, type = "error")
 
	## Download Error report
	output$downloadprecleaned <- downloadHandler(
	  filename = function() {
	    paste("Error Report", ".xlsx", sep = "")
	  },
	  content = function(file) {
	    writexl::write_xlsx(AppReactiveValue$error_report[["ErrorReportclean"]], file)
	  }
	)
	
	output$Preview_Error_Report <-  DT::renderDataTable(
	  expr = as.data.frame( AppReactiveValue$error_report[["ErrorReportclean"]]),
  	#extensions = c("Buttons"),
  	options = list(
  	  dom = 'lfrtip',
  	  paging = TRUE,
  	  ordering = TRUE,
  	  lengthChange = TRUE,
  	  pageLength = 10,
  	  scrollX = TRUE,
  	  autowidth = TRUE,
  	  rownames = TRUE)
	 	)
}
 
## copy to body.R
# mod_error_report_ui("error_report_ui_1")
 
## copy to app_server.R
# callModule(mod_error_report_server, "error_report_ui_1")
 
## copy to sidebar.R
# menuItem("displayName",tabName = "error_report",icon = icon("user"))
 
