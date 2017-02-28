# mu parameter detail

output$ui_mu <- renderUI({
    if ("mu" %in% input$selected_parameters) {
        wellPanel(
            tags$h5("mu"),
            sliderInput(inputId = "param_mu", label = "", min = 0, max = 0.1, value = 0.013,
                step = 0.001, round = FALSE, ticks = TRUE, width = NULL, sep = ","),
            tags$div(style = "display:inline-block",
                numericInput(inputId = "min_mu", label = "min", value = 0, width = "80%")
            ),
            tags$div(style = "display:inline-block",
                numericInput(inputId = "max_mu", label = "max", value = 0.1, width = "80%")
            ),
            tags$div(style = "display:inline-block",
                bsButton(inputId = "reset_mu", label = "Reset",
                    icon = icon("refresh", class = "fa-lg fa-fw", lib = "font-awesome"),
                    style = "danger", size = "small", block = FALSE)
            )
        )
    }
})


# observe max / min adjustments
observeEvent(input$min_mu, {
    updateSliderInput(session, inputId = "param_mu", min = input$min_mu)
})

observeEvent(input$max_mu, {
    updateSliderInput(session, inputId = "param_mu", max = input$max_mu)
})

# parameter reset
observeEvent(input$reset_mu, {
    shinyjs::reset("param_mu")
    shinyjs::reset("min_mu")
    shinyjs::reset("max_mu")
})
