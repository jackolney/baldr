# beta parameter detail

output$ui_beta <- renderUI({
    if ("beta" %in% input$selected_parameters) {
        wellPanel(
            tags$h5("beta"),
            sliderInput(inputId = "param_beta", label = "", min = 0, max = 50, value = 24,
                step = 0.001, round = FALSE, ticks = TRUE, width = NULL, sep = ","),
            tags$div(style = "display:inline-block",
                numericInput(inputId = "min_beta", label = "min", value = 0, width = "80%")
            ),
            tags$div(style = "display:inline-block",
                numericInput(inputId = "max_beta", label = "max", value = 50, width = "80%")
            ),
            tags$div(style = "display:inline-block",
                bsButton(inputId = "reset_beta", label = "Reset",
                    icon = icon("refresh", class = "fa-lg fa-fw", lib = "font-awesome"),
                    style = "danger", size = "small", block = FALSE)
            )
        )
    }
})


# observe max / min adjustments
observeEvent(input$min_beta, {
    updateSliderInput(session, inputId = "param_beta", min = input$min_beta)
})

observeEvent(input$max_beta, {
    updateSliderInput(session, inputId = "param_beta", max = input$max_beta)
})

# parameter reset
observeEvent(input$reset_beta, {
    shinyjs::reset("param_beta")
    shinyjs::reset("min_beta")
    shinyjs::reset("max_beta")
})
