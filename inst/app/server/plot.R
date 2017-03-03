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

    # highcharter thousandsSep
    hcopts <- getOption("highcharter.lang")
    hcopts$thousandsSep <- ","
    options(highcharter.lang = hcopts)

    # highcharter
    hchart(object = out, type = "line", hcaes(x = t, y = value, group = variable)) %>%
        hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 2, valueDecimals = 2) %>%
        hc_exporting(enabled = TRUE) %>%
        hc_chart(zoomType = "x")
})
