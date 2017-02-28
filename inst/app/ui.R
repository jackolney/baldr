library(shinythemes)
library(shinyBS)

navbarPage(
	theme = shinytheme("paper"),
	title = "modelr",
	tabPanel("Plot",
		fluidPage(
			fluidRow(
				column(width = 4,
					wellPanel(
						radioButtons("plotType", "Plot type", c("Scatter"="p", "Line"="l")),
						checkboxGroupInput(inputId = "selected_parameters", label = "Parameters",
				        	choices = c("alpha", "mu"),
        					selected = "mu"
      					),
      					checkboxGroupInput(inputId = "selected_initial", label = "Initial",
				        	choices = c("S", "I", "R"),
        					selected = NULL
      					),
						bsButton(inputId = "run", label = "Run", icon = icon("play",
							class = "fa-lg fa-fw", lib = "font-awesome"), style = "success",
							size = "default", block = TRUE),
						bsButton(inputId = "reset", label = "Reset", icon = icon("refresh",
							class = "fa-lg fa-fw", lib = "font-awesome"), style = "danger",
							size = "default", block = TRUE)
					)
				),
				column(width = 8,
					plotOutput("plot"),
					wellPanel(
						sliderInput(inputId = "param.p", label = "p", min = 0, max = 1, value = 0.5,
							step = 0.01, round = FALSE, ticks = TRUE, width = NULL, sep = ",")
					)
				)
			)
		)
	),
	tabPanel("Table",
		DT::dataTableOutput("table")
			),
		navbarMenu("More",
			tabPanel("Stuff",
				verbatimTextOutput("summary")
			),
			tabPanel("About",
				fluidRow(
				column(6,
					"some more text"
				)
			)
		)
	)
)
