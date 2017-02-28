# sigma parameter detail

output$ui_sigma <- renderUI({
    if ("sigma" %in% input$selected_parameters) {
        wellPanel(
            tags$h5("sigma"),
            sliderInput(inputId = "param_sigma", label = "", min = 0, max = 20, value = 12,
                step = 0.001, round = FALSE, ticks = TRUE, width = NULL, sep = ","),
            tags$div(style = "display:inline-block",
                numericInput(inputId = "min_sigma", label = "min", value = 0, width = "80%")
            ),
            tags$div(style = "display:inline-block",
                numericInput(inputId = "max_sigma", label = "max", value = 20, width = "80%")
            ),
            tags$div(style = "display:inline-block",
                bsButton(inputId = "reset_sigma", label = "Reset",
                    icon = icon("refresh", class = "fa-lg fa-fw", lib = "font-awesome"),
                    style = "danger", size = "small", block = FALSE)
            )
        )
    }
})


# observe max / min adjustments
observeEvent(input$min_sigma, {
    updateSliderInput(session, inputId = "param_sigma", min = input$min_sigma)
})

observeEvent(input$max_sigma, {
    updateSliderInput(session, inputId = "param_sigma", max = input$max_sigma)
})

# parameter reset
observeEvent(input$reset_sigma, {
    shinyjs::reset("param_sigma")
    shinyjs::reset("min_sigma")
    shinyjs::reset("max_sigma")
})
