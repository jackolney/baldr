# manual :books:

This is a walkthrough and manual for the use of the `modelr` package for epidemiological modelling
in R

## Introduction

This package is designed to ease the transition of students from [Berkeley Madonna](https://www.berkeleymadonna.com/),
in which they were introduced to solving Ordinary Differential Equations (ODE's), to the statistical
computing language, [R](https://www.r-project.org/).

See the [README](https://jackolney.github.io/modelr/) for details on installation and launching a
hosted version of the package.

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

When entering a model into `modelr` please follow the syntax specified by the [`odin`](https://github.com/richfitz/odin)
package written by [Rich FitzJohn](https://richfitz.github.io/). Rich has put together a very detailed [vignette](https://richfitz.github.io/odin/vignettes/odin.html)
on how to use odin.

#### [odin vignette](https://richfitz.github.io/odin/vignettes/odin.html)

| Expression | Berkeley Madonna | Odin | R |
|------------|------------------|------|---|
| Derivative of 'S' | `d/dt(S)` | `deriv(S)` | `dS` |
| Initial value of 'S' | `init S` | `initial(S)` | `deSolve::ode(y = initial)` |
| Parameter 'mu' | `mu = 1/75` | `mu <- user(1/75)` | `deSolve::ode(parms = c(mu = 1/75)` |

A full example vignette detailing an [SIR](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology#The_SIR_model) model written in all three syntaxes will soon be available here.

## Tools

By default `modelr` generates a figure illustrating the numerical solution of each ODE between the
times set by the user. Clicking the [hamburger icon](https://en.wikipedia.org/wiki/Hamburger_button)
allows user to save an image of the figure. Additionally, clicking the 'table' tab will generate an
interactive table of the numerical solutions that can be downloaded as an Excel / CSV / PDF file.
