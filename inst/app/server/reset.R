# global reset
observeEvent(input$reset, {
    shinyjs::reset("selected_parameters")
    shinyjs::reset("selected_initial")
    shinyjs::reset("time_from")
    shinyjs::reset("time_to")
    shinyjs::reset("time_by")
})
