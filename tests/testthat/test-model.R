context("Model Comparison")

test_that("Compare Models", {
    expect_equal(sir_model_r(), sir_model_odin(),
        check.attributes = FALSE,
        tolerance = 0.01,
        info = "Odin and R do not produce the same result")
})
