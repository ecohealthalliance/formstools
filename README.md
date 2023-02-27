
<!-- README.md is generated from README.Rmd. Please edit that file -->

# formstools: Tools for working with ODK XLSForms

<!-- badges: start -->

[![R-CMD-check](https://github.com/ecohealthalliance/formstools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ecohealthalliance/formstools/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Set of utility functions for use by EcoHealth Alliance researchers in
working with Open Data Kit XLSForms. These functions are aimed at aiding
users in the data cleaning and data validation process using information
found in the ODK XLSForms.

## Installation

You can install the development version of formstools like so:

``` r
if (!require(remotes)) install.packages("remotes")
remotes::install_github("ecohealthalliance/formstools)
```

## What does `formstools` do?

Currently, the `formstools` package can:

### Extract the choices `select_one` and `select_multiple` types of questions in a given/specified XLSForm

The `get_choices()` function extracts the choices for all or for
specified `select_one` and `select_multiple` types of questions. The can
be used as follows:

``` r
## Load library
library(formstools)

## Extract all choices for all select_one and select_multiple types of questions
## in the example XLSForm ghana_community_form.xlsx
get_choices(
  xlsform = system.file("extdata", "ghana_community_form.xlsx", package = "formstools")
)
#> # A tibble: 722 × 3
#>    list_name  name              `label::English (en)`             
#>    <chr>      <chr>             <chr>                             
#>  1 yes_no     1                 Yes                               
#>  2 yes_no     0                 No                                
#>  3 yes_no_idk 1                 Yes                               
#>  4 yes_no_idk 0                 No                                
#>  5 yes_no_idk idk               I don't know                      
#>  6 gender     female            Female                            
#>  7 gender     male              Male                              
#>  8 gender     non_binary        Non-Binary/Prefer to self describe
#>  9 gender     Prefer_not_to_say Prefer not to say                 
#> 10 pray       mosque            Mosque                            
#> # … with 712 more rows
```

The `get_choices` function can also extract choices for specific
`select_one` or `select_multiple` types of questions if the user knows
the `list_name` as shown below:

``` r
## Extract all choices for select_one and/or select_multiple types of questions
## in the example XLSForm ghana_community_form.xlsx for the list_name gender
get_choices(
  xlsform = system.file("extdata", "ghana_community_form.xlsx", package = "formstools"),
  choice_name = "gender"
)
#> # A tibble: 4 × 3
#>   list_name name              `label::English (en)`             
#>   <chr>     <chr>             <chr>                             
#> 1 gender    female            Female                            
#> 2 gender    male              Male                              
#> 3 gender    non_binary        Non-Binary/Prefer to self describe
#> 4 gender    Prefer_not_to_say Prefer not to say
```
