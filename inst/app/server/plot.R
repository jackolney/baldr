output$plot <- renderHighchart({
    # triggers
    input$run

    # build model
    mod <- build_model()

    # run model and adjust for parameter updates
    out <- run_model(model = mod)

    # subset if not all checkboxes ticked.
    out <- out[out$variable %in% input$selected_initial,]

    # highcharter
    hchart(object = out, type = "line", hcaes(x = t, y = value, group = variable)) %>%
        hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 2) %>%
        hc_exporting(enabled = TRUE) %>%
        hc_chart(zoomType = "x")
})
