build_model <- function() {
    # SIR
    sir <- odin::odin({
        # Derivatives
        deriv(S) <- Births - b * S - beta * S * I / N + delta * R
        deriv(I) <- beta * S * I / N - (b + sigma) * I
        deriv(R) <- sigma * I - b * R - delta * R

        # Initial conditions
        initial(S) <- N - I0
        initial(I) <- I0
        initial(R) <- 0

        # Parameters
        Births <- N / 75
        b <- 1 / 75
        N <- 1e7
        I0 <- user(1)
        beta <- user(24)
        sigma <- 12
        delta <- 1 / 5

        # bit confused about this
        config(base) <- "sir"
    })

    # build the model
    model <- sir()
    model
}

run_model <- function(model) {
    # run the model
    tt <- seq(0, 100, length.out = 101)
    y <- model$run(tt)

    # assemble output
    df <- as.data.frame(y)
    out <- reshape2::melt(df, id.vars = "t")
    out
}
