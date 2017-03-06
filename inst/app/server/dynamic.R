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


# Dynamic Sliders
output$ui_sliders <- renderUI({

    # vals$params <- c("mu", "beta", "sigma", "delta")
    vals$params

    # dependent on the selections here too
    params <- vals$params[vals$params %in% input$selected_parameters]

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
})

# TO DO

# Max and Min values need to come from model$contents() - DONE.

# also need to define DYNAMICALLY:
# slider updates (MAX / MIN)
# RESET buttons

# observe max / min adjustments
# observeEvent(input$min_mu, {
#     updateSliderInput(session, inputId = "param_mu", min = input$min_mu)
# })

# observeEvent(input$max_mu, {
#     updateSliderInput(session, inputId = "param_mu", max = input$max_mu)
# })

# # parameter reset
# observeEvent(input$reset_mu, {
#     shinyjs::reset("param_mu")
#     shinyjs::reset("min_mu")
#     shinyjs::reset("max_mu")
# })



# reactive({
#     # dependent on the selections here too
#     params <- vals$params[vals$params %in% input$selected_parameters]
#     # Can I be super cheeky and put it in here?
#     for (i in 1:length(params)) {
#         print(paste0("input$min_", params[i]))
#         observeEvent(paste0("input$min_", params[i]), {
#             updateSliderInput(session, inputId = paste0("param_", params[i]),
#                 min = paste0("input$min_", params[i]))
#         })
#     }
# })


# eval(paste0("input$min_", params[i]))
