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

# Name of model
config(base) <- 'sir'
