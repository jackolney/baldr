tabPanel("Plot",
    fluidPage(
        useShinyjs(),
        fluidRow(
            # LHS Column
            column(width = 4,
                wellPanel(
                    tags$div(style = "display:inline-block; width: 32.5%;",
                        numericInput(inputId = "time_from", label = "Start Time",
                            value = 0, min = 0, step = 1, width = "80%")
                    ),
                    tags$div(style = "display:inline-block; width: 32.5%;",
                        numericInput(inputId = "time_to", label = "Stop Time",
                            value = 50, min = 0, step = 1, width = "80%")
                    ),
                    tags$div(style = "display:inline-block; width: 32.5%;",
                        numericInput(inputId = "time_by", label = "Time Step",
                            value = 0.1, min = 1e-2, step = 1e-2, width = "80%")
                    ),
                    checkboxGroupInput(inputId = "selected_initial", label = "Initial",
                        choices = c("S", "I", "R"),
                        selected = c("S", "I", "R")
                    ),
                    checkboxGroupInput(inputId = "selected_parameters", label = "Parameters",
                        choices = c("mu", "beta", "sigma", "delta"),
                        selected = "mu"
                    ),
                    fluidRow(
                        column(width = 6,
                            bsButton(inputId = "run", label = "Run", icon = icon("play",
                                class = "fa-lg fa-fw", lib = "font-awesome"), style = "success",
                                size = "default", block = TRUE)
                        ),
                        column(width = 6,
                            bsButton(inputId = "reset", label = "Reset", icon = icon("refresh",
                                class = "fa-lg fa-fw", lib = "font-awesome"), style = "danger",
                                size = "default", block = TRUE)
                        )
                    )
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
