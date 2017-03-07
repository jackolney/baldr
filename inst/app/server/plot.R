output$plot <- renderHighchart({
    # triggers
    input$run

    # build model
    # code = live model from Ace Editor
    mod <- isolate(build_model(code = input$live_code))

    # run model and adjust for parameter updates
    out <- isolate(run_model(model = mod))

    # subset if not all checkboxes ticked.
    out <- out[out$variable %in% input$selected_initial,]

    # don't proceed if the out data.frame is empty
    if (dim(out)[1] == 0) return()

    # highcharter thousandsSep
    hcopts <- getOption("highcharter.lang")
    hcopts$thousandsSep <- ","
    options(highcharter.lang = hcopts)

    # highcharter
    hchart(object = out, type = "line", hcaes(x = t, y = value, group = variable)) %>%
        hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 2, valueDecimals = 2) %>%
        hc_exporting(enabled = TRUE) %>%
        hc_chart(zoomType = "x") %>%
        hc_xAxis(title = list(text = "time"),
                 labels = list(style = list(fontSize = "12px"))
                ) %>%
        hc_yAxis(title = list(text = "value"),
                labels = list(style = list(fontSize = "12px"))
                ) %>%
        hc_legend(itemStyle = list(fontSize = "15px"))
})
