#' run modelr
#'
#' @title run modelr interactive ODE solver
#'
#' @export
run <- function() {
    cat("Press ESC (or Ctrl-C) to get back to the R session\n")
    wd <- system.file("app", package = "modelr")
    if (wd == "") {
        stop("Could not find app. Try re-installing `modelr`.", call. = FALSE)
    }
    shiny::runApp(wd, quiet = FALSE, display.mode = "normal")
}
