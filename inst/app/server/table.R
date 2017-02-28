output$table <- DT::renderDataTable({
    DT::datatable(cars)
})
