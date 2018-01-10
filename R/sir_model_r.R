#' run SIR model in native R
#'
#' @title run baldr example SIR model in R
#'
#' @export
sir_model_r <- function() {
    # define model function
    model <- function(t, y, parms) {

        # Derivatives
        dS <- parms[["Births"]] - parms[["mu"]] * y[["S"]] - parms[["beta"]] * y[["S"]] * y[["I"]] / parms[["N"]] + parms[["delta"]] * y[["R"]]
        dI <- parms[["beta"]] * y[["S"]] * y[["I"]] / parms[["N"]] - (parms[["mu"]] + parms[["sigma"]]) * y[["I"]]
        dR <- parms[["sigma"]] * y[["I"]] - parms[["mu"]] * y[["R"]] - parms[["delta"]] * y[["R"]]

        # reconstruct output
        out <- list(c(dS, dI, dR))
        out
    }

    # Initial conditions
    initial <- c(
        S = 1e7 - 1,
        I = 1,
        R = 0
    )

    # Parameters
    parameters <- c(
        N = 1e7,
        Births = 1e7 / 72,
        mu = 0.0139,
        beta = 24,
        sigma = 12,
        delta = 0.2
    )

    # define start, stop and time step
    tt <- seq(from = 0, to = 100, by = 0.1)

    out <- deSolve::ode(times = tt, y = initial, func = model, parms = parameters)
    as.data.frame(out)
}
