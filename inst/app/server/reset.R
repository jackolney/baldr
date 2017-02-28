# global reset
observeEvent(input$reset, {
    shinyjs::reset("selected_initial")
    shinyjs::reset("selected_parameters")
    shinyjs::reset("param_mu")
})

# parameter reset
observeEvent(input$reset_mu, {
    shinyjs::reset("param_mu")
})
