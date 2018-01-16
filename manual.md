# manual :books:

This is a walkthrough and manual for the use of the `baldr` package for epidemiological modelling in R

## Introduction

This package is designed to ease the transition of students from [Berkeley Madonna](https://www.berkeleymadonna.com/), in which they were introduced to solving [Ordinary Differential Equations](https://en.wikipedia.org/wiki/Ordinary_differential_equation) (ODE's), to the statistical computing language, [R](https://www.r-project.org/).

See the [README](https://jackolney.github.io/baldr/) for details on installation and launching a hosted version of the package.

## Interface

The interface to `baldr` was designed to require minimal explanation and just get out of the way so that code can be entered and simulations computed. However, I will detail each aspect of the tool below, starting with the landing page that you will see upon starting the tool:

![landing-page](https://user-images.githubusercontent.com/4134882/35013778-5764a3f6-fb06-11e7-975a-0d6613d11981.png)

### Plot

The most important controls are 'RUN' and 'RESET'. To start, the tool will compile and run any model that exists in the text input area. At the moment a simple [SIR](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology#The_SIR_model) model exists in here that is explained in detail in the [syntax section](https://jackolney.github.io/baldr/manual#syntax). Clicking the 'RUN' button will compile any available code, run the model and render an output figure to the screen. 'RESET' will reset all parameter values and settings back to the defaults (refreshing the page will produce a similar effect). The 'start time' of the simulation defines the start of the x-axis, the 'stop time', the end of the x-axis and the 'time step', the resolution of the lines to be drawn -- the integration time-step.

![start-stop](https://cloud.githubusercontent.com/assets/4134882/23713119/cd771d30-041c-11e7-885b-9b0d417d1889.jpg)

Below these controls we find the text editor section of the tool, where users can write code, or copy a model from elsewhere using the [_odin syntax_](https://richfitz.github.io/odin/vignettes/odin.html) written by [Rich FitzJohn](https://richfitz.github.io/). Please see the [syntax section](https://jackolney.github.io/baldr/manual#syntax) for further details on how to convert your model from Berkeley Madonna into Odin or native R.

![code](https://cloud.githubusercontent.com/assets/4134882/23713116/cd5aa36c-041c-11e7-9f61-34736457c580.jpg)

Below the code entry section of the tool is the model settings pane. To load a model written in a `.txt` or `.R` file, click the "Load Model" button, select the file and the editor will automatically update. To save any model entered into the editor click "Save Model" and a `.R` file will download automatically. The settings pane is automatically populated with the state variable and parameter names from any model entered. Clicking the checkbox on a state variable will add it to the plot on the screen. Clicking the checkbox by a parameter will bring up an interactive slider for that parameter just below the plot.

![settings](https://cloud.githubusercontent.com/assets/4134882/24242339/5cbc1002-0faf-11e7-8477-8b06d22b4b4d.png)

Sliders are a really useful tool for understanding the sensitivity of the model to variations in a particular parameter. By default the slider takes the value entered by the user as its middle setting, the maximum bound is twice that baseline value and the minimum is zero. However, users can adjust those upper and lower bounds by entering the desired values in the boxes provided and the slider will automatically be re-drawn. Hitting the rest button by a slider will reset the upper and lower bounds as well as the value the slider is set to. The global reset button (top left of the screen) does this for all parameters.

![slider](https://cloud.githubusercontent.com/assets/4134882/23713117/cd5ade68-041c-11e7-8eb0-33e71fe52eaa.jpg)

Moving to the main plot on the screen, this is interactive so when you mouse-over the plot a vertical bar appears with an info box describing the values of each line at that particular point along the x-axis.

![mouse-over](https://cloud.githubusercontent.com/assets/4134882/23713114/cd595584-041c-11e7-9f35-9229788058f3.jpg)

If you click and drag with the mouse (or spread two fingers out on an iOS device), the plot will zoom in on a particular point. On iOS use two fingers to drag the plot along the x-axis and pinch to zoom out.

![zoom](https://cloud.githubusercontent.com/assets/4134882/23713115/cd5a2338-041c-11e7-8ecc-ba8a5d188ee9.jpg)

Clicking the [hamburger icon](https://en.wikipedia.org/wiki/Hamburger_button) on the top right of the plot opens a menu for downloading the figure in many formats.

![chart-options](https://cloud.githubusercontent.com/assets/4134882/23713121/cd7e7d82-041c-11e7-8cd0-783d5332b05f.jpg)

### Table

Clicking the 'table' tab at the top of the screen produces an interactive table of the results generated by the model (akin to the table view in Berkeley Madonna). This values can be downloaded as an Excel or CSV file, or printed directly as a PDF.

![table](https://cloud.githubusercontent.com/assets/4134882/23713118/cd5bf42e-041c-11e7-91e1-66e99e39a8a6.jpg)

<!-- ![plot](https://cloud.githubusercontent.com/assets/4134882/23713120/cd7c4274-041c-11e7-8b21-7843e11ecb2f.jpg) -->

### Parameter Plot

The ability to perform a parameter plot or parameter sweep allows users to investigate how a model output changes in response to a particular parameter being moved over a range of values, assuming all else equal (_ceteris paribus_).

After a model has been entered in the 'Plot' tab, users can click the 'Parameter Plot' tab where they can specify the details of the plot. Users must select a parameter to sweep over from the drop-down list, and also a range and step size. By default these values are populated by taking the value of the parameter from the previous tab, doubling it and then dividing the range into five equal jumps starting at zero.

![pplot-setup](https://cloud.githubusercontent.com/assets/4134882/23863713/536c8328-0808-11e7-86c4-10028aa1da7b.jpg)

After the parameter to sweep has been selected, the output variable i.e. the derivative must be selected. Then users are able to specify whether they want to plot the parameter against the output or view the output over time for each simulation by checking the 'Parameter vs. Output' checkbox. Clicking 'Run Parameter Plot' will run the relevant simulations and generate the results plot on the right-hand side of the page. As before the hamburger icon allows the ability to view the data-table and download the plot. Below we see the parameter plot showing each output plotted over time:

![param-plot](https://cloud.githubusercontent.com/assets/4134882/23854058/89118bb6-07e7-11e7-9343-189edccffab4.jpg)

And then with the 'Parameter vs. Output' checkbox ticked, the tool plots the parameter along the x-axis and the output at the stop-time on the y-axis:

![param-plot-alt](https://cloud.githubusercontent.com/assets/4134882/23863712/5369ff2c-0808-11e7-89f7-98bbd462832e.jpg)

### More

The final tab, 'More', allows users to view this manual on the baldr website, and the second section is used to produce information on the current R session (this is mainly used for debugging)

## Syntax

When entering a model into `baldr` please follow the syntax specified by the [`odin`](https://github.com/richfitz/odin) package written by [Rich FitzJohn](https://richfitz.github.io/). Rich has put together a very detailed [vignette](https://richfitz.github.io/odin/vignettes/odin.html) on how to use odin.

Below is a brief table comparing expressions in the three languages:

Expression           | Berkeley Madonna | Odin                | R
-------------------- | ---------------- | ------------------- | -----------------------------------
Derivative of 'S'    | `d/dt(S)`        | `deriv(S)`          | `dS`
Initial value of 'S' | `init S = 100`   | `initial(S) <- 100` | `deSolve::ode(y = c(S = 100))`
Parameter 'mu'       | `mu = 1/75`      | `mu <- user(1/75)`  | `deSolve::ode(parms = c(mu = 1/75))`

The code snippets below detail an [SIR](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology#The_SIR_model) model written in all three syntaxes. These pieces of code form entire programs, and can be copied into the relevant application to generate results. The purpose being to help users understand how the concepts translate across the three languages. For simplicity I have written exactly the same model in each language.

### Berkeley Madonna

```css
{Model Setup}
METHOD RK4 ;integration method
STARTTIME = 0 ;model start time
STOPTIME = 100 ;model stop time
DT = 0.1 ;time step

{Derivatives}
d/dt(S) = Births - mu * S - beta * S * I / N + delta * R
d/dt(I) = beta * S * I / N - (mu + sigma) * I
d/dt(R) = sigma * I - mu * R - delta * R

{Initial conditions}
init S = 1e7 - 1
init I = 1
init R = 0

{Parameters}
N = 1e7
Births = 1e7 / 72
mu = 0.0139
beta = 24
sigma = 12
delta = 0.2

{Clicking 'RUN' will compile and run the model automatically}
```

### Odin

The function `baldr::sir_model_odin()` will run the following model:

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
    N <- 1e7
    Births <- 1e7 / 72
    mu <- user(0.0139)
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
out <- as.data.frame(y)
out
```

### R

The function `baldr::sir_model_r()` will run the following model:

```R
# Check for packages
if (!require("deSolve")) install.packages("deSolve")

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
out
```

## Tools

By default `baldr` generates a figure illustrating the numerical solution of each ODE between the
times set by the user. Clicking the [hamburger icon](https://en.wikipedia.org/wiki/Hamburger_button)
allows user to save an image of the figure. Additionally, clicking the 'table' tab will generate an
interactive table of the numerical solutions that can be downloaded as an Excel / CSV / PDF file.
