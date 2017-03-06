# dynamic UI
# initial values
# parameters
# eventually piped to plot function

# We actually can hopefully just pipe back the values here

vals <- reactiveValues()

output$ui_initial <- renderUI({
    checkboxGroupInput(inputId = "selected_initial", label = "Initial",
                       choices = vals$initial,
                       selected = vals$initial
                    )
})

output$ui_params <- renderUI({
    checkboxGroupInput(inputId = "selected_parameters", label = "Parameters",
                       choices = vals$params,
                       selected = "mu"
                    )
})

# slider UI ShinyTag function
create_sliders <- function(params) {
    slider_ui <- list()
    for (i in 1:length(params)) {
        slider_ui[[i]] <- wellPanel(
                            tags$h5(params[i]),
                            sliderInput(inputId = paste0("param_", params[i]),
                                label = "",
                                min = 0,
                                max = vals$contents[[params[i]]] * 2,
                                value = vals$contents[[params[i]]],
                                step = 0.001, round = FALSE, ticks = TRUE, width = NULL, sep = ","),
                            tags$div(style = "display:inline-block",
                                numericInput(inputId = paste0("min_", params[i]),
                                    label = "min",
                                    value = 0,
                                    width = "80%")
                            ),
                            tags$div(style = "display:inline-block",
                                numericInput(inputId = paste0("max_", params[i]),
                                    label = "max",
                                    value = vals$contents[[params[i]]] * 2,
                                    width = "80%")
                            ),
                            tags$div(style = "display:inline-block",
                                bsButton(inputId = paste0("reset_", params[i]), label = "Reset",
                                    icon = icon("refresh", class = "fa-lg fa-fw", lib = "font-awesome"),
                                    style = "danger", size = "small", block = FALSE)
                            )
                        )
    }

    # tagList allows you to take this list and return a whole shinyTag object
    tagList(slider_ui)
}

# reactiveEvent to build UI
slider_ui_generator <- eventReactive(input$selected_parameters, {

    # vals$params <- c("mu", "beta", "sigma", "delta")
    vals$params

    # dependent on the selections here too
    params <- vals$params[vals$params %in% input$selected_parameters]

    # run create_slider shinyTag function
    sliders <- create_sliders(params)

    # Observation Loop
    # This is nifty.
    for (i in 1:length(params)) {
        local({

            # define parameters
            param_name <- paste0("param_", params[i])

            # observeEvent minimums
            input_name_min <- paste0("min_", params[i])
            observeEvent(input[[input_name_min]], {
                updateSliderInput(session,
                    inputId = param_name,
                    min = input[[input_name_min]])
            })

            # observeEvent maximums
            input_name_max <- paste0("max_", params[i])
            observeEvent(input[[input_name_max]], {
                updateSliderInput(session,
                    inputId = param_name,
                    max = input[[input_name_max]])
            })

            # observeEvent reset
            reset_name <- paste0("reset_", params[i])
            observeEvent(input[[reset_name]], {
                shinyjs::reset(param_name)
                shinyjs::reset(input_name_min)
                shinyjs::reset(input_name_max)
            })

        })
    }

    div(id = "ui_sliders", sliders)
})

# Call to renderUI
output$ui_sliders <- renderUI({
    slider_ui_generator()
})
