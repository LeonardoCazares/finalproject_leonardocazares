
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dynamicAutoregCV

<!-- badges: start -->

<!-- badges: end -->

The goal of dynamicAutoregCV is to create a linear ridge autoregression
algorithm for time-series forecasting with dynamic training. The main
features of the package include:

- A cross-validation scheme that allows us to find the best
  regularization parameter (for ridge regression) and the number of lags
  considered for the autogressive settings.
- Dynamic forecasting for the test set, moving forward the training
  window training epoch.

To acomplish the two features mentioned above we implemented we prepared
a dataset of average daily temperature in Austin, TX (extracted from the
National Centers for Environmental Information (NCEI)). The dataset
covers the period from 2016-01-01 to 2025-08-25, with measurements in
°F.

Providing some functions, data spliting into training and testing sets
that is

``` r
train_test_data <- train_test_split(temps, dates, p = 0.05)
```

![Cross-validation for time series.](man/figures/rep_comp_project.jpeg)
![Time series out-of-sample forecasting.](man/figures/forecasting.jpg)

## Installation

You can install the development version of dynamicAutoregCV from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("LeonardoCazares/finalproject_leonardocazares")
```

## Work to be done…

For the rest of the project the task will be completed:

- Using the functions created, apply the cross-validation algorithm to a
  grid of values for the regularization parameter in the ridge
  regression and for the number of lags.
- Create and apply a function for the dynamic training/prediction step.
- Complete the remaining vignettes.
- \[EXTRA\] If possible, apply a conformal prediction algorithm for the
  uncertainty quantification of the time-series forecasts.
