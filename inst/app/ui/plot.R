tabPanel("Plot",
    fluidPage(
        fluidRow(
            column(width = 4,
                wellPanel(
                    checkboxGroupInput(inputId = "selected_initial", label = "Initial",
                        choices = c("S", "I", "R"),
                        selected = c("S", "I", "R")
                    ),
                    checkboxGroupInput(inputId = "selected_parameters", label = "Parameters",
                        choices = c("alpha", "mu"),
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
            column(width = 8,
                # highchart output
                highchartOutput("plot",height = "500px"),
                # Each parameter has its own well?
                wellPanel(
                    tags$h5("parameter p"),
                    sliderInput(inputId = "param.p", label = "", min = 0, max = 1, value = 0.5,
                        step = 0.01, round = FALSE, ticks = TRUE, width = NULL, sep = ","),
                    tags$div(style = "display:inline-block",
                        numericInput(inputId = "min", label = "min", value = 0, width = "80%")
                    ),
                    tags$div(style = "display:inline-block",
                        numericInput(inputId = "max", label = "max", value = 1, width = "80%")
                    ),
                    tags$div(style = "display:inline-block",
                        bsButton(inputId = "reset.p", label = "Reset",
                            icon = icon("refresh", class = "fa-lg fa-fw", lib = "font-awesome"),
                            style = "danger", size = "small", block = FALSE)
                    )
                ),
                wellPanel(
                    tags$h5("parameter mu"),
                    sliderInput(inputId = "param.mu", label = "", min = 0, max = 1, value = 0.5,
                        step = 0.01, round = FALSE, ticks = TRUE, width = NULL, sep = ","),
                    tags$div(style = "display:inline-block",
                        numericInput(inputId = "min", label = "min", value = 0, width = "80%")
                    ),
                    tags$div(style = "display:inline-block",
                        numericInput(inputId = "max", label = "max", value = 1, width = "80%")
                    ),
                    tags$div(style = "display:inline-block",
                        bsButton(inputId = "reset.mu", label = "Reset",
                            icon = icon("refresh", class = "fa-lg fa-fw", lib = "font-awesome"),
                            style = "danger", size = "small", block = FALSE)
                    )
                )
            )
        )
    )
)
