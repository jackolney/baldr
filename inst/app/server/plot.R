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
        hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 1.5, valueDecimals = 2,
            style = list(fontSize = "12px")) %>%
        hc_exporting(enabled = TRUE, filename = "modelr-output",
            buttons = list(contextButton = list(align = "right", x = -10, y = 1))) %>%
        hc_chart(zoomType = "x",
            resetZoomButton = list(position = list(align = "right", x = -40))) %>%
        hc_xAxis(title = list(text = "time"),
            labels = list(style = list(fontSize = "12px"))) %>%
        hc_yAxis(title = list(text = "value"),
            labels = list(style = list(fontSize = "12px"))) %>%
        hc_legend(itemStyle = list(fontSize = "15px")) %>%
        hc_add_theme(hc_theme_modelr)
})

# custom highcharter theme (modified from hc_theme_smpl, with colors from hc_theme_538)
hc_theme_modelr <- hc_theme(
    colors = c("#FF2700", "#008FD5", "#77AB43", "#636464", "#C4C4C4"),
    chart = list(style = list(fontFamily = "Roboto")),
    title = list(align = "left", style = list(fontFamily = "Roboto Condensed", fontWeight = "bold")),
    subtitle = list(align = "left", style = list(fontFamily = "Roboto Condensed")),
    legend = list(align = "center", verticalAlign = "bottom"),
    xAxis = list(gridLineWidth = 1, gridLineColor = "#D7D7D8",
        labels = list(style = list(fontFamily = "Roboto",
            color = "#3C3C3C")), lineColor = "#D7D7D8", minorGridLineColor = "#505053",
        tickColor = "#D7D7D8", tickWidth = 1, title = list(style = list(color = "#A0A0A3"))),
    yAxis = list(gridLineColor = "#D7D7D8", labels = list(style = list(fontFamily = "Roboto",
        color = "#3C3C3C")), lineColor = "#D7D7D8", minorGridLineColor = "#505053",
        tickColor = "#D7D7D8", tickWidth = 1, title = list(style = list(color = "#A0A0A3"))),
    labels = list(style = list(color = "#D7D7D8")),
    plotOptions = list(line = list(marker = list(enabled = FALSE),
        states = list(hover = list(lineWidthPlus = 1))),
        spline = list(marker = list(enabled = FALSE), states = list(hover = list(lineWidthPlus = 1))),
        area = list(marker = list(enabled = FALSE), states = list(hover = list(lineWidthPlus = 1))),
        areaspline = list(marker = list(enabled = FALSE),
            states = list(hover = list(lineWidthPlus = 1))))
)
