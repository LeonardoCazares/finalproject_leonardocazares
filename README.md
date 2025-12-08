
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dynamicAutoregCV

<!-- badges: start -->

<!-- badges: end -->

## Objective

The goal of dynamicAutoregCV is to create a linear ridge autoregression
algorithm for time-series forecasting with dynamic training. The main
features of the package include:

- A cross-validation scheme that allows us to find the best
  regularization parameter (for ridge regression) and the number of lags
  considered for the autogressive settings.

<figure>
<img src="man/figures/rep_comp_project.jpeg"
alt="Cross-validation for time series." />
<figcaption aria-hidden="true">Cross-validation for time
series.</figcaption>
</figure>

- Dynamic forecasting for the test set, moving forward the training
  window training epoch.

<figure>
<img src="man/figures/forecasting.jpg"
alt="Time series out-of-sample forecasting." />
<figcaption aria-hidden="true">Time series out-of-sample
forecasting.</figcaption>
</figure>

## Data

To acomplish the two features mentioned above we prepared a dataset of
average daily temperature in Austin, TX (extracted from the National
Centers for Environmental Information
[NCEI](https://www.ncei.noaa.gov)). The dataset covers the period from
2016-01-01 to 2025-08-25, with measurements in °F.

## Functions

The function created for the project covers:

### `train_test_split()`

Splits a univariate time series into training and testing sets based on
a percentage cutoff.  
Also returns aligned date vectors for convenient plotting and
evaluation.

### `fit_ar_l2()`

Fits an autoregressive model with L2 (ridge) regularization.  
Takes a univariate time series and a set of lags, solves the closed-form
ridge estimator, and returns fitted values, coefficients, and error
metrics.

### `cv_ar_l2()`

Performs K-fold cross-validation over a grid of regularization
parameters and/or lag values.  
Returns the mean validation error for each combination and identifies
the optimal hyperparameters.

### `dynamic_regression()`

Implements dynamic (rolling-window) training and forecasting.  
At each time step, the model is re-trained using only the most recent
observations in a sliding window.  
Returns rolling predictions, error metrics, and the model sequence.

``` r
train_test_data <- train_test_split(temps, dates, p = 0.05)
```

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
