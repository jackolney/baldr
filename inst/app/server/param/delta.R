# delta parameter detail

output$ui_delta <- renderUI({
    if ("delta" %in% input$selected_parameters) {
        wellPanel(
            tags$h5("delta"),
            sliderInput(inputId = "param_delta", label = "", min = 0, max = 1, value = 0.2,
                step = 0.001, round = FALSE, ticks = TRUE, width = NULL, sep = ","),
            tags$div(style = "display:inline-block",
                numericInput(inputId = "min_delta", label = "min", value = 0, width = "80%")
            ),
            tags$div(style = "display:inline-block",
                numericInput(inputId = "max_delta", label = "max", value = 1, width = "80%")
            ),
            tags$div(style = "display:inline-block",
                bsButton(inputId = "reset_delta", label = "Reset",
                    icon = icon("refresh", class = "fa-lg fa-fw", lib = "font-awesome"),
                    style = "danger", size = "small", block = FALSE)
            )
        )
    }
})


# observe max / min adjustments
observeEvent(input$min_delta, {
    updateSliderInput(session, inputId = "param_delta", min = input$min_delta)
})

observeEvent(input$max_delta, {
    updateSliderInput(session, inputId = "param_delta", max = input$max_delta)
})

# parameter reset
observeEvent(input$reset_delta, {
    shinyjs::reset("param_delta")
    shinyjs::reset("min_delta")
    shinyjs::reset("max_delta")
})
