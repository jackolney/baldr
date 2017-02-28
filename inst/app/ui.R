library(shinythemes)

navbarPage(
	theme = shinytheme("paper"),
	title = "modelr",
	tabPanel("Plot",
		sidebarLayout(
			sidebarPanel(
			radioButtons(
				"plotType",
				"Plot type",
				c("Scatter"="p", "Line"="l")
				)
			),
			mainPanel(
				plotOutput("plot")
			)
		)
	),
	tabPanel("Summary",
		verbatimTextOutput("summary")
			),
		navbarMenu("More",
		tabPanel("Table",
		DT::dataTableOutput("table")
	),
	tabPanel("About",
		fluidRow(
			column(6,
			"some more text"
		),
		column(3,
			"hey buddy"
			)
		)
	)
)
)
