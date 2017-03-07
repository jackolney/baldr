output$diagnostics <- renderPrint({
    devtools::session_info()
})
