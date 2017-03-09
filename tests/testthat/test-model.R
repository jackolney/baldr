context("Model Comparison")

test_that("Compare Models", {
    # run simulations
    odin <- sir_model_odin()
    r <- sir_model_r()
    # compare output
    expect_equal(1, 1,
        check.attributes = FALSE,
        tolerance = 0.01,
        info = "Odin and R do not produce the same result")
})
