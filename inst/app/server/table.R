output$table <- DT::renderDataTable({
    # build model
    mod <- build_model(code = input$live_code)

    # run model and adjust for parameter updates
    out <- run_model(model = mod)

    # subset if not all checkboxes ticked.
    out <- out[out$variable %in% input$selected_initial,]

    # recast the data.frame
    # render at DT
    DT::datatable(reshape2::dcast(out, t ~ variable),
        rownames = FALSE,
        style = 'bootstrap',
        extensions = 'Buttons',
        options = list(
            dom = 'Bfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
            pageLength = 25,
            scrollX = TRUE,
            autoWidth = FALSE)
        )
})


