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
		  column(
		    width = 6,
		    shinydashboard::box(
		      id = "box_2",
		      title = "Error Report and cleaning scripts",
		      solidHeader = T,
		      collapsible = T,
		      collapsed = F,
		      width = 16,
		      status = "primary",
		      p("Configure cleaning script"),
		      br(),
  		    selectInput(inputId = ns("country_name"),
  		                    label = "Country Name", 
  		                    choices =  "NULL"  ),
		      br(),
		      actionButton( inputId = ns("run_err_report"),
		        label = "Run Script",
		        icon = icon("black-tie") ),
		      br(),
		      downloadButton(outputId =  ns("downloadprecleaned"),
		                     label = "Download Error report" )
		    )
		  ),
		  column(
		    width = 6,
		    shinydashboard::box(
		      id = "box_3",
		      title = "Summary Figures",
		      solidHeader = T,
		      collapsible = T,
		      collapsed = F,
		      width = 16,
		      status = "warning",
		      p("Number or Activities"),
		      h2(textOutput( ns("Number_of_Activities")  )),
		      p("Number of activities to review"),
		      h2(textOutput( ns("Number_of_Errors_Pre") )),
		      p("Percentage of errors"),
		      h2(textOutput(ns("Percentage_of_Errors") )),
		    )
		  )
		),
		
		fluidRow(
		  column(
		    width = 12,
		    shinydashboard::box(
		      id = "box_14",
		      title = "Plots  errors per Organisation and Country",
		      solidHeader = T,
		      collapsible = T,
		      collapsed = F,
		      width = 12,
		      status = "primary",
		      fluidRow(
		        column(
		          width = 6, 
		          plotly::plotlyOutput(ns("plot")) ),
		        column(
		          width = 6, 
		          plotly::plotlyOutput(ns("plot2") )
		          )
		        )
		    )
		  )
		),
		
		fluidRow(
		  column(
		    width = 12,
		    shinydashboard::box(
		      id = "box_4",
		      title = "Preview error report table",
		      solidHeader = T,
		      collapsible = T,
		      collapsed = F,
		      width = 12,
		      status = "primary",
		      DT::dataTableOutput( ns("Preview_Error_Report") )
		    )
		  )
		)
	)
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
	observeEvent(input$run_err_report,{
	  tocheck <- AppReactiveValue$result
	  Error_report <- fct_error_report(tocheck,
	                             countryname = input$country_name)
	  
	  Error_Download<- Error_report[["ErrorReportclean"]] 
	  AppReactiveValue$result <- Error_report 
	})
	  
	 #  output number of activities and error 
	 output$Number_of_Activities <- renderText({
	    nrow(Error_report$ErrorReportclean)
	    })
	  
	 output$Number_of_Errors_Pre <- renderText({
	    sum(!is.na(Error_report$ErrorReportclean$Review))
	    })
	  
	 output$Percentage_of_Errors <- renderText( {
	    round(
	      sum(!is.na(Error_report$ErrorReportclean$Review))
	          /nrow(Error_report$ErrorReportclean) * 100, 
	      digits = 1)
	   })
	  
	 # interactive plot with plotly
	  output$plot <- plotly::renderPlotly({
	    AppReactiveValue$result$ErrorReportclean |>
	      filter(!is.na(Review)) |>
	      ggplot() +
	      aes(x = Appealing_org, size = Review) +
	      geom_bar(fill = "#0c4c8a") +
	      coord_flip() +
	      theme_minimal()
	    })
	  
	  output$plot2 <- plotly::renderPlotly({
	    AppReactiveValue$result$ErrorReportclean |>
	      filter(!is.na(Review)) |>
	      ggplot() +
	      aes(x = Country, size = Review) +
	      geom_bar(fill = "#0c4c8a") +
	      coord_flip() +
	      theme_minimal()
	    })
	  
	showNotification("Successful",duration = 10, type = "error")
 
	## Download Error report
	output$downloadprecleaned <- downloadHandler(
	  filename = function() {
	    paste("Error Report", ".xlsx", sep = "")
	  },
	  content = function(file) {
	    writexl::write_xlsx(Error_Download(), file)
	  }
	)
	
	output$Preview_Error_Report <-  DT::renderDataTable(
	  expr = as.data.frame( Error_Download),
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
 
