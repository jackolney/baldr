# modelr
Epidemiological modelling in R

[![Travis-CI Build Status](https://travis-ci.org/jackolney/modelr.svg?branch=master)](https://travis-ci.org/jackolney/modelr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/jackolney/modelr?branch=master&svg=true)](https://ci.appveyor.com/project/jackolney/modelr)

The purpose of this package is a base for the development of an open-source framework for running ODE-based mathematical models of infectious diseases in R

I will make heavy use of the shiny package and wrap this in an R-package

## Roadmap

1. Test build of layout using shiny to generate a figure (basic layout of code on left, figure on right, parameter sliders underneath)

2.  Migrate to highcharts for interactive JS-based figure

3. Hard-code basic SIR model into package

4. Move toward allowing ODE's to be written in the shiny app (if possible) using `richfitz::odin`

5. Want to end up with a framework that other models can be easily inserted into -- develop a simple set of files that will be read and will convey the model to the app
