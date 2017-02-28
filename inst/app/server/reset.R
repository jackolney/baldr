# global reset
observeEvent(input$reset, {
    shinyjs::reset("selected_initial")
    if ("mu" %in% input$selected_parameters)
        shinyjs::reset("param_mu")
    if ("beta" %in% input$selected_parameters)
        shinyjs::reset("param_beta")
    if ("sigma" %in% input$selected_parameters)
        shinyjs::reset("param_sigma")
    if ("delta" %in% input$selected_parameters)
        shinyjs::reset("param_delta")
    shinyjs::reset("selected_parameters")
})
