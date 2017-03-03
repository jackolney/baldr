build_model <- function(code) {

    # define the model
    sir <- odin::odin_(x = code)

    # build the model
    model <- sir()

    # set initial and parameter values
    vals$initial <- setdiff(model$names, "t")
    vals$params <- setdiff(names(formals(sir)), c("user", "use_dde"))
    vals$contents <- model$contents()

    model
}

check_parameters <- function(model) {

    # baseline values from model
    base <- model$contents()

    # empty changes vector
    changes <- vector()

    # require the following
    # req(input$param_mu, input$param_mu)

    # mu
    if ("mu" %in% input$selected_parameters & !is.null(input$param_mu)) {
        if (input$param_mu != base[["mu"]]) {
            changes <- c(changes, mu = input$param_mu)
        }
    }

    # beta
    if ("beta" %in% input$selected_parameters & !is.null(input$param_beta)) {
        if (input$param_beta != base[["beta"]]) {
            changes <- c(changes, beta = input$param_beta)
        }
    }

    # sigma
    if ("sigma" %in% input$selected_parameters & !is.null(input$param_sigma)) {
        if (input$param_sigma != base[["sigma"]]) {
            changes <- c(changes, sigma = input$param_sigma)
        }
    }

    # delta
    if ("delta" %in% input$selected_parameters & !is.null(input$param_delta)) {
        if (input$param_delta != base[["delta"]]) {
            changes <- c(changes, delta = input$param_delta)
        }
    }

    changes
}

run_model <- function(model) {

    # parameter updates
    replace <- check_parameters(model)

    editable <- c("mu", "beta", "sigma", "delta")
    if (length(replace) > 0L) {
        stopifnot(is.numeric(replace))
        stopifnot(all(names(replace) %in% editable))
        model$set_user(user = as.list(replace))
    }

    # run the model
    tt <- seq(from = input$time_from, to = input$time_to, by = input$time_by)
    y <- model$run(tt)

    # assemble output
    df <- as.data.frame(y)
    out <- reshape2::melt(df, id.vars = "t")
    out
}
