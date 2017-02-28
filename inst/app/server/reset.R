# global reset
observeEvent(input$reset, {
    shinyjs::reset("selected_initial")
    shinyjs::reset("selected_parameters")
    shinyjs::reset("param_mu")
})

# parameter reset
observeEvent(input$reset_mu, {
    shinyjs::reset("param_mu")
    shinyjs::reset("min_mu")
    shinyjs::reset("max_mu")
})
