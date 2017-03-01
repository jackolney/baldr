build_model <- function() {
    # SIR
    sir <- odin::odin({
        # Derivatives
        deriv(S) <- Births - mu * S - beta * S * I / N + delta * R
        deriv(I) <- beta * S * I / N - (mu + sigma) * I
        deriv(R) <- sigma * I - mu * R - delta * R

        # Initial conditions
        initial(S) <- N - I0
        initial(I) <- I0
        initial(R) <- 0

        # Parameters
        I0 <- 1
        N <- 1e7
        Births <- N / 72
        mu <- user(0.013)
        beta <- user(24)
        sigma <- user(12)
        delta <- user(0.2)

        # bit confused about this
        config(base) <- "sir"
    })

    # build the model
    model <- sir()
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
