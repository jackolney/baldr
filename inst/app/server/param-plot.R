# dynamic UI for param-plot

output$ui_param_plot_selection <- renderUI({
    selectInput(inputId = "selected_param_plot",
        label = NULL,
        choices = vals$params,
        selected = NULL,
        multiple = FALSE,
        selectize = TRUE,
        width = NULL,
        size = NULL)
})

output$ui_param_plot_out_selection <- renderUI({
    selectInput(inputId = "selected_param_out",
        label = NULL,
        choices = vals$initial,
        selected = NULL,
        multiple = FALSE,
        selectize = TRUE,
        width = NULL,
        size = NULL)
})

output$ui_param_plot_settings <- renderUI({
    param_plot_settings <- list()
    param_plot_settings[[1]] <- tags$div(style = "display:inline-block; width: 32.5%;",
        numericInput(inputId = "param_from", label = "From",
            value = 0, min = 0, step = 1, width = "80%")
    )
    param_plot_settings[[2]] <- tags$div(style = "display:inline-block; width: 32.5%;",
        numericInput(inputId = "param_to", label = "To",
            value = 10, min = 0, width = "80%")
    )
    param_plot_settings[[3]] <- tags$div(style = "display:inline-block; width: 32.5%;",
        numericInput(inputId = "param_by", label = "By",
            value = 0.1, min = 1e-2, step = 1e-2, width = "80%")
    )
    tagList(param_plot_settings)
})

# observeEvent on input$selected_param_plot
observeEvent(input$selected_param_plot, {
    updateNumericInput(session, inputId = "param_to",
        value = vals$contents[[input$selected_param_plot]] * 2)
    updateNumericInput(session, inputId = "param_by",
        value = vals$contents[[input$selected_param_plot]] * 0.4)
})

# draft definition for parameter plot function
run_parameter_plot <- function(model) {

    # parameter updates from sliders
    replace <- check_parameters(model)

    # parameter setup
    pplot_seq <- seq(from = input$param_from, to = input$param_to, by = input$param_by)

    # set times
    # tt <- seq(from = 0, to = 10, by = 0.1)
    tt <- seq(from = input$time_from, to = input$time_to, by = input$time_by)

    # output list
    pplot_out <- list()

    for (i in 1:length(pplot_seq)) {

        # replace will not be empty if sliders are moved
        if (length(replace) > 0L) {
            # check if any active slider is selected parameter for pplot, then overwrite
            # else add to vector, else create new vector
            if (any(names(replace) == input$selected_param_plot)) {
                replace[[which(names(replace) == input$selected_param_plot)]] <- pplot_seq[i]
            } else {
                replace <- c(replace, pplot_seq[i])
                names(replace)[which(names(replace) == "")] <- input$selected_param_plot
            }
        } else {
            replace <- pplot_seq[i]
            names(replace) <- input$selected_param_plot
        }

        # set in model
        model$set_user(user = as.list(replace))

        # run the model
        y <- model$run(tt)

        # use input$selected_param_out to select the desired output to keep
        pplot_out[[paste0("out_", i)]] <- y[,input$selected_param_out]
    }

    # convert to data.frame
    out <- as.data.frame(pplot_out)

    # add time column
    out$t <- seq(from = input$time_from, to = input$time_to, by = input$time_by)

    # melt around time (t)
    theOut <- reshape2::melt(out, id.vars = "t")
    theOut
}

output$param_plot <- renderHighchart({
    if (input$run_param_plot > 0) {
        # build model
        # code = live model from Ace Editor
        mod <- isolate(build_model(code = input$live_code))

        # run parameter plot function
        out <- isolate(run_parameter_plot(model = mod))

        # determine number of colors to include in figure
        cols <- length(unique(out$variable))

        # define colorGradient
        colors = c("#FF2700", "#008FD5", "#77AB43", "#636464", "#C4C4C4")
        colfunc <- colorRampPalette(colors)

        # highcharter
        # hchart(object = cars, type = "scatter", hcaes(x = speed, y = dist))
        hchart(object = out, type = "line", hcaes(x = t, y = value, group = variable)) %>%
            hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 1.5, valueDecimals = 2,
                style = list(fontSize = "12px")) %>%
            hc_exporting(enabled = TRUE, filename = "modelr-output",
                buttons = list(contextButton = list(align = "right", x = -10, y = 1))) %>%
            hc_chart(zoomType = "x",
                resetZoomButton = list(position = list(align = "right", x = -40))) %>%
            hc_xAxis(title = list(text = "time"),
                labels = list(style = list(fontSize = "12px"))) %>%
            hc_yAxis(title = list(text = "value"), maxPadding = 0.05, endOnTick = FALSE,
                labels = list(style = list(fontSize = "12px"))) %>%
            hc_legend(itemStyle = list(fontSize = "15px")) %>%
            hc_add_theme(hc_theme_modelr(colors = colfunc(cols)))
    }
})
