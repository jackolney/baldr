output$plot <- renderHighchart({

    # run_model() call
    mod <- build_model()
    out <- run_model(model = mod)

    # subset if not all checkboxes ticked.
    out <- out[out$variable %in% input$selected_initial,]

    # highcharter
    hchart(object = out, type = "line", hcaes(x = t, y = value, group = variable)) %>%
        hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 2) %>%
        hc_exporting(enabled = TRUE) %>%
        hc_chart(zoomType = "x")
})
