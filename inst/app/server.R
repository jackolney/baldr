function(input, output, session) {

    output$plot <- renderPlot({
        plot(cars, type = input$plotType)
    }, width = "auto", height = 500)

    output$summary <- renderPrint({
        summary(cars)
    })

    output$table <- DT::renderDataTable({
        DT::datatable(cars)
    })
}
