build_model <- function(code) {

    # define the model
    sir <- baldr::build_odin(code)

    # build the model
    model <- sir()

    # set initial and parameter values
    vals$initial <- setdiff(model$names, "t")
    vals$params <- setdiff(names(formals(sir)), c("user", "use_dde"))
    vals$contents <- model$contents()
    vals$default <- model$contents()

    model
}

check_parameters <- function(model) {

    # baseline values from model
    base <- model$contents()

    # empty changes vector
    changes <- vector()

    # which sliders are active?
    params <- vals$params[vals$params %in% input$selected_parameters]

    # now we need to loop through them and add to our changes vector
    for (i in 1:length(params)) {
        # assign parameter name
        param_name <- paste0("param_", params[i])
        # compare against model$contents(), if different, then assign change
        if (!is.null(input[[param_name]])) {
            if (input[[param_name]] != base[[params[i]]]) {
                changes <- c(changes, input[[param_name]])
                if (is.null(names(changes)))
                    names(changes) <- params[i]
                else
                    names(changes)[which(names(changes) == "")] <- params[i]
            }
        }
    }
    changes
}

run_model <- function(model) {

    # parameter updates
    replace <- check_parameters(model)
    if (length(replace) > 0L)
        model$set_user(user = as.list(replace))

    # run the model
    tt <- seq(from = input$time_from, to = input$time_to, by = input$time_by)
    y <- model$run(tt)

    # assemble output
    df <- as.data.frame(y)
    out <- reshape2::melt(df, id.vars = "t")
    out
}
