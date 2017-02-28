function(input, output, session) {

	output$plot <- renderPlot({
		plot(cars, type = "p")
	}, width = "auto", height = "auto")

	output$summary <- renderPrint({
		summary(cars)
	})

	output$table <- DT::renderDataTable({
		DT::datatable(cars)
	})
}
