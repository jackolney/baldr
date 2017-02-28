output$plot <- renderHighchart({
    hchart(cars, "scatter", hcaes(x = speed, y = dist))
})

output$summary <- renderPrint({
    summary(cars)
})

output$table <- DT::renderDataTable({
    DT::datatable(cars)
})
