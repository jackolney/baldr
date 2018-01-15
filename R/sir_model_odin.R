#' run SIR model in odin
#'
#' @title run baldr example SIR model in odin
#'
#' @export
sir_model_odin <- function() {
    # setup model
    gen <- odin::odin({
        # Derivatives
        deriv(S) <- Births - mu * S - beta * S * I / N + delta * R
        deriv(I) <- beta * S * I / N - (mu + sigma) * I
        deriv(R) <- sigma * I - mu * R - delta * R

        # Initial conditions
        initial(S) <- 1e7 - 1
        initial(I) <- 1
        initial(R) <- 0

        # Parameters
        N <- 1e7
        Births <- 1e7 / 72
        mu <- user(0.0139)
        beta <- user(24)
        sigma <- user(12)
        delta <- user(0.2)

        # Name of model
        config(base) <- 'sir'
    })

    # compile model
    model <- gen()

    # define start, stop and time step
    tt <- seq(from = 0, to = 100, by = 0.1)

    # run the model
    y <- model$run(tt)

    # assemble output
    out <- as.data.frame(y)
    names(out)[1] <- "time"
    out
}
