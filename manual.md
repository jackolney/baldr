# manual :books:

This is a walkthrough and manual for the use of the `modelr` package for epidemiological modelling in R

## Introduction

This package is designed to ease the transition of students from [Berkeley Madonna](https://www.berkeleymadonna.com/), in which they were introduced to solving [Ordinary Differential Equations](https://en.wikipedia.org/wiki/Ordinary_differential_equation) (ODE's), to the statistical computing language, [R](https://www.r-project.org/).

See the [README](https://jackolney.github.io/modelr/) for details on installation and launching a hosted version of the package.

## Interface

- Will need to include a tonne of screenshots here...
- Basics of StartTime StopTime and TimeStep
- Inputting model
- Dynamic generation of initial values (for figure) and parameters
- Sliders automatically spawned for parameters (take default value with max of twice default)
- Adjusting sliders max / min will automatically redraw slider
- Resetting each slider will set it back to its default value (that from the beginning of the session)
- Clicking the Global Reset will reset all parameters and bring the model back to its initial state
- Refreshing the page will produce the same effect

## Syntax

When entering a model into `modelr` please follow the syntax specified by the [`odin`](https://github.com/richfitz/odin) package written by [Rich FitzJohn](https://richfitz.github.io/). Rich has put together a very detailed [**vignette**](https://richfitz.github.io/odin/vignettes/odin.html) on how to use odin.

Below is a brief table comparing expressions in the three languages:

| Expression | Berkeley Madonna | Odin | R |
|------------|------------------|------|---|
| Derivative of 'S' | `d/dt(S)` | `deriv(S)` | `dS` |
| Initial value of 'S' | `init S` | `initial(S)` | `deSolve::ode(y = initial)` |
| Parameter 'mu' | `mu = 1/75` | `mu <- user(1/75)` | `deSolve::ode(parms = c(mu = 1/75)` |

The code snippets below detail an [SIR](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology#The_SIR_model) model written in all three syntaxes. These pieces of code form entire programs, and can be copied into the relevant application to generate results. The purpose being to help users understand how the concepts translate across the three languages. For simplicity I have written exactly the same model in each language.

### Berkeley Madonna

```shell
{Model Setup}
METHOD RK4 ;integration method
STARTTIME = 0 ;model start time
STOPTIME = 100 ;model stop time
DT = 0.1 ;time step

{Derivatives}
d/dt(S) <- Births - mu * S - beta * S * I / N + delta * R
d/dt(I) <- beta * S * I / N - (mu + sigma) * I
d/dt(R) <- sigma * I - mu * R - delta * R

{Initial conditions}
init S = 1e7 - 1
init I = 1
init R = 0

{Parameters}
Births = 1e7 / 72
mu = 1 / 72
beta = 24
sigma = 12
delta = 0.2

{Clicking 'RUN' will compile and run the model automatically}
```

### Odin

```R
# Check for packages
if (!require("odin")) devtools::install_github("richfitz/odin")
if (!require("reshape2")) install.packages("reshape2")

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
    Births <- 1e7 / 72
    mu <- user(1 / 7)
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
out <- reshape2::melt(data = as.data.frame(y), id.vars = "t")
out

```

### R

```R
# Check for packages
if (!require("deSolve")) install.packages("deSolve")

model <- function(t, y, parms) {

    # Derivatives
    dS <- y[["Births"]] - parms[["mu"]] * y[["S"]] - parms[["beta"]] * y[["S"]] * y[["I"]] / y[["N"]] + parms[["delta"]] * y[["R"]]
    dI <- parms[["beta"]] * y[["S"]] * y[["I"]] / y[["N"]] - (parms[["mu"]] + parms[["sigma"]]) * y[["I"]]
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
    Births = 1e7 / 72,
    mu = 1 / 72,
    beta = 24,
    sigma = 12,
    delta = 0.2
)

# define start, stop and time step
tt <- seq(from = 0, to = 100, by = 0.1)

out <- deSolve::ode(times = tt, y = initial, func = model, parms = parameters)
out

```

## Tools

By default `modelr` generates a figure illustrating the numerical solution of each ODE between the
times set by the user. Clicking the [hamburger icon](https://en.wikipedia.org/wiki/Hamburger_button)
allows user to save an image of the figure. Additionally, clicking the 'table' tab will generate an
interactive table of the numerical solutions that can be downloaded as an Excel / CSV / PDF file.
