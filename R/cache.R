cache <- new.env(parent = emptyenv())

## NOTE: See https://github.com/mrc-ide/odin/issues/54 for what is
## needed for a more comprehensive solution to this.  The number of
## DLLs loaded will become an issue unfortunately.
build_odin <- function(code) {
    hash <- digest::digest(code)
    if (!identical(cache$hash, hash)) {
        cache$model <- odin::odin_(code)
        cache$hash <- hash
    }
    cache$model
}
