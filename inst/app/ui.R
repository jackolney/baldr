library(shinythemes)
library(shinyBS)

navbarPage(
	theme = shinytheme("paper"),
	title = "modelr",
	tabPanel("Plot",
		sidebarLayout(
			sidebarPanel(
			radioButtons("plotType", "Plot type", c("Scatter"="p", "Line"="l")),
			bsButton(inputId = "run", label = "Run", icon = icon("play", class = "fa-lg fa-fw",
				lib = "font-awesome"), style = "success", size = "default", block = TRUE)
			),
			mainPanel(
				plotOutput("plot")
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
