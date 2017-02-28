output$plot <- renderHighchart({

    # generate some rndom data
    year <- seq(2010, 2020)
    value <- sample(10:40, length(year) * 2)
    category <- c(rep("a", 11), rep("b", 11))
    df <- data.frame(year, value, category)

    # highcharter
    hchart(object = df, type = "line", hcaes(x = year, y = value, group = category)) %>%
        hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 2) %>%
        hc_exporting(enabled = TRUE)
})

output$summary <- renderPrint({
    devtools::session_info()
})

output$table <- DT::renderDataTable({
    DT::datatable(cars)
})
