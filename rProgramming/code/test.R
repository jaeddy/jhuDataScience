f <- function(x) {
  g <- function(y) {
    y + z
  }
  z <- 4
  x + g(x)
}