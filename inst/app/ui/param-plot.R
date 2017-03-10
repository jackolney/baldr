tabPanel("Parameter Plot",
    fluidPage(
        useShinyjs(),
        fluidRow(
            # LHS Column
            column(width = 4,
                # TopPanel
                wellPanel(
                    h5("Parameter Selection"),
                    uiOutput(outputId = "ui_param_plot_selection", inline = FALSE),
                    uiOutput(outputId = "ui_param_plot_settings", inline = FALSE)
                ),
                wellPanel(
                    h5("Output Selection"),
                    uiOutput(outputId = "ui_param_plot_out_selection", inline = FALSE),
                    bsButton(inputId = "run_param_plot", label = "Run Parameter Plot",
                        icon = icon ("play", class = "fa-lg fa-fw", lib = "font-awesome"),
                        type = "action", style = "success", size = "default", block = TRUE)
                )
            ),
            # RHS Column
            column(width = 8,
                # highchart output
                highchartOutput("param_plot", height = "500px")
            )
        )
    )
)
