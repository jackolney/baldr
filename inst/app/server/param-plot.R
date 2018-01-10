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

# function to get latest set of parameters (reads vals$contents and checks for live sliders)
get_parameters <- function() {

    # baseline values from reactiveVector vals
    base <- vals$contents

    # empty changes vector
    changes <- vector()

    # which sliders are active?
    params <- vals$params[vals$params %in% input$selected_parameters]

    # now we need to loop through them and add to our changes vector
    for (i in 1:length(params)) {
        # assign parameter name
        param_name <- paste0("param_", params[i])
        # compare against model$contents(), if different, then assign change
        if (!is.null(input[[param_name]])) {
            if (input[[param_name]] != base[[params[i]]]) {
                changes <- c(changes, input[[param_name]])
                if (is.null(names(changes)))
                    names(changes) <- params[i]
                else
                    names(changes)[which(names(changes) == "")] <- params[i]
            }
        }
    }

    # now loop over changes, and assign to base, return base
    if (length(changes) != 0) {
        for (i in 1:length(changes)) {
            base[[names(changes)[i]]] <- changes[[i]]
        }
    }
    base
}

# observeEvent on input$selected_param_plot
observeEvent(input$selected_param_plot, {
    # get latest model parameters
    params <- get_parameters()
    # update inputs
    updateNumericInput(session, inputId = "param_to",
        value = params[[input$selected_param_plot]] * 2)
    updateNumericInput(session, inputId = "param_by",
        value = params[[input$selected_param_plot]] * 0.4)
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

        # check if we should be plotting parameter vs. output
        if (input$check_param_output) {
            # convert to data.frame
            out.df <- as.data.frame(y)
            # take output at end of simulation
            pplot_out[[i]] <- out.df[out.df$t == input$time_to, input$selected_param_out]
        } else {
            # use input$selected_param_out to select the desired output to keep
            pplot_out[[paste0("out_", i)]] <- y[,input$selected_param_out]
        }
    }

    # if plotting parameter vs. output
    if (input$check_param_output) {
        # convert to data.frame
        theOut <- as.data.frame(unlist(pplot_out))
        # add time column
        theOut$t <- pplot_seq
        # rename data.frame columns (output / parameter)
        names(theOut) <- c(input$selected_param_out, input$selected_param_plot)
    } else {
        # convert to data.frame
        out <- as.data.frame(pplot_out)
        # add time column
        out$t <- seq(from = input$time_from, to = input$time_to, by = input$time_by)
        # melt around time (t)
        theOut <- reshape2::melt(out, id.vars = "t")
    }
    theOut
}

output$param_plot <- renderHighchart({
    if (input$run_param_plot > 0) {
        # build model
        # code = live model from Ace Editor
        mod <- isolate(build_model(code = input$live_code))

        # run parameter plot function
        out <- isolate(run_parameter_plot(model = mod))

        # if plotting parameter vs. output
        if (input$check_param_output) {
            # highcharter (using hcaes_string)
            hchart(object = out, type = "line",
                hcaes_string(
                    x = isolate(input$selected_param_plot),
                    y = isolate(input$selected_param_out))) %>%
                hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 1.5, valueDecimals = 2,
                    style = list(fontSize = "12px")) %>%
                hc_exporting(enabled = TRUE, filename = "baldr-output",
                    buttons = list(contextButton = list(align = "right", x = -10, y = 1))) %>%
                hc_chart(zoomType = "x",
                    resetZoomButton = list(position = list(align = "right", x = -40))) %>%
                hc_xAxis(title = list(text = isolate(input$selected_param_plot)),
                    labels = list(style = list(fontSize = "12px"))) %>%
                hc_yAxis(title = list(text = isolate(input$selected_param_out)),
                    maxPadding = 0.05, endOnTick = FALSE,
                    labels = list(style = list(fontSize = "12px"))) %>%
                hc_legend(itemStyle = list(fontSize = "15px")) %>%
                hc_add_theme(hc_theme_baldr())
        } else {
            # determine number of colors to include in figure
            cols <- length(unique(out$variable))
            # define colorGradient (colors from hc_theme)
            # colors = c("#FF2700", "#008FD5", "#77AB43", "#636464", "#C4C4C4")
            colors <- RColorBrewer::brewer.pal(11, "Spectral")
            colfunc <- colorRampPalette(colors)
            # highcharter
            hchart(object = out, type = "line", hcaes(x = t, y = value, group = variable)) %>%
                hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 1.5, valueDecimals = 2,
                    style = list(fontSize = "12px")) %>%
                hc_exporting(enabled = TRUE, filename = "baldr-output",
                    buttons = list(contextButton = list(align = "right", x = -10, y = 1))) %>%
                hc_chart(zoomType = "x",
                    resetZoomButton = list(position = list(align = "right", x = -40))) %>%
                hc_xAxis(title = list(text = "time"),
                    labels = list(style = list(fontSize = "12px"))) %>%
                hc_yAxis(title = list(text = "value"), maxPadding = 0.05, endOnTick = FALSE,
                    labels = list(style = list(fontSize = "12px"))) %>%
                hc_legend(itemStyle = list(fontSize = "15px")) %>%
                hc_add_theme(hc_theme_baldr(colors = colfunc(cols)))
        }
    }
})

# hcaes_string() similar to ggplot2::aes_string() but for highcharter
hcaes_string <- function(x, y, ...) {
    mapping <- list(...)
    if (!missing(x))
        mapping["x"] <- list(x)
    if (!missing(y))
        mapping["y"] <- list(y)
    mapping <- lapply(mapping, function(x) {
        if (is.character(x)) {
            parse(text = x)[[1]]
        } else {
            x
        }
    })
    mapping <- structure(mapping, class = "uneval")
    mapping <- mapping[names(mapping) != ""]
    class(mapping) <- c("hcaes", class(mapping))
    mapping
}
