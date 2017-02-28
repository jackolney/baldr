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

run_model <- function(model) {
    # run the model
    tt <- seq(0, 100, length.out = 101)
    y <- model$run(tt)

    # assemble output
    df <- as.data.frame(y)
    out <- reshape2::melt(df, id.vars = "t")
    out
}

# mod <- build_model()

# # run the model
# tt <- seq(0, 100, length.out = 101)
# y <- mod$run(tt)

# mod$set_user(mu = 0)
# y2 <- mod$run(tt)

# testthat::expect_equal(y,y2)

# # assemble output
# df <- as.data.frame(y2)
# out <- reshape2::melt(df, id.vars = "t")
# out
# require(highcharter)
# hchart(object = out, type = "line", hcaes(x = t, y = value, group = variable)) %>%
#     hc_tooltip(crosshairs = TRUE, shared = TRUE, borderWidth = 2) %>%
#     hc_exporting(enabled = TRUE) %>%
#     hc_chart(zoomType = "x")
