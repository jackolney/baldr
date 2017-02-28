output$summary <- renderPrint({
    devtools::session_info()
})
