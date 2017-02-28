# mu
observeEvent(input$min_mu, {
    updateSliderInput(session, inputId = "param_mu", min = input$min_mu)
})

observeEvent(input$max_mu, {
    updateSliderInput(session, inputId = "param_mu", max = input$max_mu)
})
