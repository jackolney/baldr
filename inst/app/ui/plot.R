tabPanel("Plot",
    fluidPage(
        useShinyjs(),
        fluidRow(
            # LHS Column
            column(width = 4,
                wellPanel(
                    checkboxGroupInput(inputId = "selected_initial", label = "Initial",
                        choices = c("S", "I", "R"),
                        selected = c("S", "I", "R")
                    ),
                    checkboxGroupInput(inputId = "selected_parameters", label = "Parameters",
                        choices = c("mu", "beta", "sigma", "delta"),
                        selected = "mu"
                    ),
                    bsButton(inputId = "run", label = "Run", icon = icon("play",
                        class = "fa-lg fa-fw", lib = "font-awesome"), style = "success",
                        size = "default", block = TRUE),
                    bsButton(inputId = "reset", label = "Reset", icon = icon("refresh",
                        class = "fa-lg fa-fw", lib = "font-awesome"), style = "danger",
                        size = "default", block = TRUE)
                )
            ),
            # RHS Column
            column(width = 8,

                # highchart output
                highchartOutput("plot",height = "500px"),

                # Each parameter has its own well?
                uiOutput(outputId = "ui_mu",    inline = FALSE),
                uiOutput(outputId = "ui_beta",  inline = FALSE),
                uiOutput(outputId = "ui_sigma", inline = FALSE),
                uiOutput(outputId = "ui_delta", inline = FALSE)
            )
        )
    )
)
