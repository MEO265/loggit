# Easy-to-use, dependencyless Logger for R

<!-- badges: start -->

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/loggit)](https://cran.r-project.org/package=loggit)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/loggit)](https://cran.r-project.org/package=loggit)
[![R-CMD-check](https://github.com/MEO265/loggit/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/MEO265/loggit/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/MEO265/loggit/graph/badge.svg)](https://codecov.io/gh/MEO265/loggit)
<!-- badges: end -->

------------------------------------------------------------------------

`loggit` is an easy-to-use
[`ndJSON`](https://github.com/ndjson/ndjson-spec) logging library for R
software, with *zero* external dependencies.

Please see below for some quick examples, and read the
[vignettes](https://cran.r-project.org/web/packages/loggit/vignettes/)
for the Getting Started guide.

## Why use `loggit`?

`loggit` takes a modern approach to logging in R:

- Opting to use the JSON format
- Highly flexible log streams
- Enables log data analysis on the same host
- *Zero* external dependencies

Additionally, the boilerplate to get going with `loggit` is minimal at
worst. No need to write custom formatters, handlers, levels, etc. –
***just loggit!***

## Usage

The quickest way to get up & running with `loggit` is to do nearly
nothing.

`loggit` provides a set of wrappings for base R’s `message()`,
`warning()`, and `stop()` functions that maintain identical
functionality, making it sufficient to import the `loggit` namespace,
for example by using `library("loggit")`, or by prefixing `loggit::` at
the desired locations.

``` r
loggit::message("This is a message")
#> {"timestamp": "2024-01-12T21:44:26+0100", "log_lvl": "INFO", "log_msg": "This is a message__LF__"}
#> This is a message
loggit::warning("This is a warning")
#> {"timestamp": "2024-01-12T21:44:26+0100", "log_lvl": "WARN", "log_msg": "This is a warning"}
#> Warning: This is a warning
loggit::stop("This is an error")
#> {"timestamp": "2024-01-12T21:44:26+0100", "log_lvl": "ERROR", "log_msg": "This is an error"}
#> Error in eval(expr, envir, enclos): This is an error
```

You can suppress the additional console output by using `echo = FALSE`
and you won’t notice any difference to the base functions (except that
the log will be filled in the background).

``` r
base::message("This is another message")
#> This is another message
loggit::message("This is another message", echo = FALSE)
#> This is another message

base::warning("This is another warning")
#> Warning: This is another warning
loggit::warning("This is another warning", echo = FALSE)
#> Warning: This is another warning

base::stop("This is another error")
#> Error in eval(expr, envir, enclos): This is another error
loggit::stop("This is another error", echo = FALSE)
#> Error in eval(expr, envir, enclos): This is another error
```

You can also use `loggit()` directly to compose much more custom logs,
including ***entirely custom fields*** (and prevent throwing actual
conditions). `loggit` doesn’t require that you set custom logger objects
or anything like that: just throw whatever you want at it, and it’ll
become a structured log.

``` r
loggit::loggit("ERROR", "This will log an error", anything_else = "you want to include")
#> {"timestamp": "2024-01-12T21:44:26+0100", "log_lvl": "ERROR", "log_msg": "This will log an error", "anything_else": "you want to include"}

# Read log file into data frame to implement logic based on entries
loggit::read_logs()
#>                  timestamp log_lvl                   log_msg       anything_else
#> 1 2024-01-12T21:44:26+0100    INFO       This is a message\n                    
#> 2 2024-01-12T21:44:26+0100    WARN         This is a warning                    
#> 3 2024-01-12T21:44:26+0100   ERROR          This is an error                    
#> 4 2024-01-12T21:44:26+0100    INFO This is another message\n                    
#> 5 2024-01-12T21:44:26+0100    WARN   This is another warning                    
#> 6 2024-01-12T21:44:26+0100   ERROR     This is another error                    
#> 7 2024-01-12T21:44:26+0100   ERROR    This will log an error you want to include
```

Check out the
[vignettes](https://cran.r-project.org/web/packages/loggit/vignettes/)
for more details.

## Installation

You can install the latest CRAN release of `loggit` via

    install.packages("loggit")

or, get the latest development version from GitHub via

    devtools::install_github("MEO265/loggit")

## Acknowledgments

This package is based on the [eponymous package by Ryan
Price](https://github.com/ryapric/loggit), specifically version 2.1.1.

Due to technical reasons, this repository is not a GitHub fork of
[Ryan’s repository](https://github.com/ryapric/loggit).
