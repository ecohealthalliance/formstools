
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

### Extract the questions for `select_one` and `select_multiple` types of questions in a given/specified XLSForm

The `get_questions()` function extracts the questions for all or for
specified `select_one` and `select_multiple` types of questions. The
function can be used as follows:

``` r
## Load library
library(formstools)

## Extract all questions for all select_one and select_multiple types of questions
## in the example XLSForm ghana_community_form.xlsx
get_questions(
  xlsform = system.file("extdata", "ghana_community_form.xlsx", package = "formstools")
)
#> # A tibble: 104 × 5
#>    type       list_name  name       `label::English (en)` label::Some_other_la…¹
#>    <chr>      <chr>      <chr>      <chr>                 <lgl>                 
#>  1 select_one yes_no     consent_s… Consent Form Adminis… NA                    
#>  2 select_one region     com_id_re… Region:               NA                    
#>  3 select_one district   com_id_di… District:             NA                    
#>  4 select_one community  com_id_co… Community:            NA                    
#>  5 select_one gender     c01_gender 01. What is your gen… NA                    
#>  6 select_one pray       c02_pray   02. Where do you pra… NA                    
#>  7 select_one lived_here c04_long_… 04. How long have yo… NA                    
#>  8 select_one yes_no     c08_have_… I am going to read y… NA                    
#>  9 select_one yes_no     c06_tv     06. TV                NA                    
#> 10 select_one yes_no     c07_consi… 07. Consistent elect… NA                    
#> # ℹ 94 more rows
#> # ℹ abbreviated name: ¹​`label::Some_other_language`
```

The `get_questions` function can also extract questions for specific
`select_one` or `select_multiple` types of questions if the user knows
the `list_name` as shown below:

``` r
## Extract all questions for select_one and/or select_multiple types of questions
## in the example XLSForm ghana_community_form.xlsx for the list_name gender
get_questions(
  xlsform = system.file("extdata", "ghana_community_form.xlsx", package = "formstools"),
  choice_name = "gender"
)
#> # A tibble: 1 × 5
#>   type       list_name name       `label::English (en)`   label::Some_other_la…¹
#>   <chr>      <chr>     <chr>      <chr>                   <lgl>                 
#> 1 select_one gender    c01_gender 01. What is your gender NA                    
#> # ℹ abbreviated name: ¹​`label::Some_other_language`
```

### Extract the choices for `select_one` and `select_multiple` types of questions in a given/specified XLSForm

The `get_choices()` function extracts the choices for all or for
specified `select_one` and `select_multiple` types of questions. The
function can be used as follows:

``` r
## Extract all choices for all select_one and select_multiple types of questions
## in the example XLSForm ghana_community_form.xlsx
get_choices(
  xlsform = system.file("extdata", "ghana_community_form.xlsx", package = "formstools")
)
#> # A tibble: 731 × 3
#>    list_name  name              `label::English (en)`             
#>    <chr>      <chr>             <chr>                             
#>  1 species_id H                 Human                             
#>  2 yes_no     1                 Yes                               
#>  3 yes_no     0                 No                                
#>  4 yes_no_idk 1                 Yes                               
#>  5 yes_no_idk 0                 No                                
#>  6 yes_no_idk idk               I don't know                      
#>  7 gender     female            Female                            
#>  8 gender     male              Male                              
#>  9 gender     non_binary        Non-Binary/Prefer to self describe
#> 10 gender     Prefer_not_to_say Prefer not to say                 
#> # ℹ 721 more rows
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

### Get choices for a specific form using a form schema extracted using `{ruODK}`

The form schema or codebook can be retrieved from ODK Central using
`{ruODK}` as follows:

``` r
## Setup ruODK
ruODK::ru_setup(
  pid = 1,
  fid = "pizza",
  url = "https://odk.eha.io/",
  un = Sys.getenv("ODK_CENTRAL_USERNAME"),
  pw = Sys.getenv("ODK_CENTRAL_PASSWORD")
)
```

``` r
## Retrieve form schema
pizza_schema <- ruODK::form_schema_ext()

pizza_schema
#> # A tibble: 10 × 7
#>    path             name       type      binary ruodk_name    label choices     
#>    <chr>            <chr>      <chr>     <lgl>  <chr>         <chr> <list>      
#>  1 /start           start      dateTime  NA     start         <NA>  <NULL>      
#>  2 /end             end        dateTime  NA     end           <NA>  <NULL>      
#>  3 /today           today      date      NA     today         <NA>  <NULL>      
#>  4 /pizza1          pizza1     string    NA     pizza1        Do y… <named list>
#>  5 /pizza2          pizza2     string    NA     pizza2        What… <named list>
#>  6 /pizza3          pizza3     string    NA     pizza3        What… <lgl [1]>   
#>  7 /closing         closing    string    NA     closing       Than… <lgl [1]>   
#>  8 /meta            meta       structure NA     meta          <NA>  <NULL>      
#>  9 /meta/audit      audit      binary    TRUE   meta_audit    <NA>  <NULL>      
#> 10 /meta/instanceID instanceID string    NA     meta_instanc… <NA>  <NULL>
```

The function `get_choices_ruodk()` can be used to process this form
schema to get the choices for `select_one` and `select_multiple` type of
questions in a similar format as the result in the approach described in
the previous functions. This function can be used as follows:

``` r
get_choices_ruodk(form_schema = pizza_schema)
#> # A tibble: 10 × 4
#>    var_name question                               values    labels   
#>    <chr>    <chr>                                  <chr>     <chr>    
#>  1 pizza1   Do you like pizza?                     1         Yes      
#>  2 pizza1   Do you like pizza?                     2         No       
#>  3 pizza2   What are you favourite pizza toppings? cheese    cheese   
#>  4 pizza2   What are you favourite pizza toppings? tomatoes  tomatoes 
#>  5 pizza2   What are you favourite pizza toppings? pepperoni pepperoni
#>  6 pizza2   What are you favourite pizza toppings? mushrooms mushrooms
#>  7 pizza2   What are you favourite pizza toppings? artichoke artichoke
#>  8 pizza2   What are you favourite pizza toppings? olives    olives   
#>  9 pizza2   What are you favourite pizza toppings? pineapple pineapple
#> 10 pizza2   What are you favourite pizza toppings? other     other
```

### Match `other` response/s to specified responses to a question in an ODK form

It is possible that enumerators enter an other response (usually in free
text) to a question with specified and distinct responses (either single
selection or multiple selection) that is the same or similar to the
accepted responses. It would be desirable to recode these responses to
correspond to the actual specified and distinct responses. The
`match_other_to_choices()` performs this operation as follows:

``` r
match_other_to_choices(
  form_schema = pizza_schema,
  form_data = ruODK::odata_submission_get(),
  var_name = "pizza2",
  other_var_name = "pizza3"
)
#> # A tibble: 17 × 9
#>    id        recoded_cheese recoded_tomatoes recoded_pepperoni recoded_mushrooms
#>    <chr>              <dbl>            <dbl>             <dbl>             <dbl>
#>  1 uuid:486…             NA               NA                NA                NA
#>  2 uuid:4b9…             NA               NA                NA                NA
#>  3 uuid:384…              0                0                 0                 0
#>  4 uuid:859…             NA               NA                NA                NA
#>  5 uuid:52a…             NA               NA                NA                NA
#>  6 uuid:b9f…             NA               NA                NA                NA
#>  7 uuid:592…             NA               NA                NA                NA
#>  8 uuid:40c…             NA               NA                NA                NA
#>  9 uuid:b5c…             NA               NA                NA                NA
#> 10 uuid:819…             NA               NA                NA                NA
#> 11 uuid:9ff…              0                0                 0                 0
#> 12 uuid:914…             NA               NA                NA                NA
#> 13 uuid:11f…              0                0                 0                 0
#> 14 uuid:dbb…              0                0                 0                 0
#> 15 uuid:d80…             NA               NA                NA                NA
#> 16 uuid:289…              0                0                 0                 0
#> 17 uuid:499…             NA               NA                NA                NA
#> # ℹ 4 more variables: recoded_artichoke <dbl>, recoded_olives <dbl>,
#> #   recoded_pineapple <dbl>, recoded_other <dbl>
```

The output of using this function is a data.frame/tibble with rows equal
to the number of rows as the form data and columns equal to the number
of specified and distinct choices of the question/variable of interest
plus identifying variable/s specified by the `id` argument. The columns
for response values are named by each of the choices prefixed by the
string `recode_`. Each column in this resulting data.frame provides
values of either `1` or `0` with `1` meaning that that specific choice
was detected from the other response for that specific row of data. This
information can then be used in the data cleaning/processing steps to
possibly add another response for the specific choice.

### Spread a vector of character responses/categorical values into a `data.frame`

Given a vector of categorical/character values, sometimes it is useful
to be able to create a data.frame with columns for each of the unique
values in the vector and rows equal to the length of the vector. The
columns for each of the unique values would indicate whether that value
was the response. For example:

``` r
## Pet owned
pet <- c("dog", "dog", "dog", "cat", "cat", NA)
```

It might be useful to convert this vector into a data.frame with columns
for each of the unique type of pet and with each row indicating which
type of pet it is. The `spread_vector_to_columns()` function can be used
for this as follows:

``` r
spread_vector_to_columns(
  x = pet,
  fill = c("dog", "cat", "monkey"),  ## All possible responses include monkey
  prefix = "pet"
)
#>   pet_cat pet_dog pet_monkey
#> 1       0       1          0
#> 2       0       1          0
#> 3       0       1          0
#> 4       1       0          0
#> 5       1       0          0
#> 6      NA      NA         NA
```

### Split ODK `select_multiple` type responses into a `data.frame`

Sometimes it is useful to split the ODK `select_multiple` type responses
into a data.frame with columns for each of the response and rows equal
to the length of the `select_multiple` type response vector. Using the
pizza toppings example, we can use the `split_select_multiples()`
function as follows:

``` r
split_multiple_responses(
  x = pizza_data$pizza2,
  fill = c("cheese", "tomatoes", "pepperoni", "mushrooms", "artichoke", "olives", "pineapple", "other"),
  prefix = "toppings"
)
#> # A tibble: 17 × 8
#>    toppings_artichoke toppings_cheese toppings_mushrooms toppings_olives
#>                 <dbl>           <dbl>              <dbl>           <dbl>
#>  1                  0               0                  0               0
#>  2                  0               1                  1               1
#>  3                  1               1                  0               0
#>  4                  1               1                  1               0
#>  5                  0               1                  1               1
#>  6                  1               1                  0               0
#>  7                  0               1                  0               0
#>  8                  0               1                  1               1
#>  9                  0               0                  1               0
#> 10                  0               1                  1               0
#> 11                  0               1                  1               1
#> 12                  0               1                  1               0
#> 13                  0               1                  0               1
#> 14                  0               0                  0               1
#> 15                  0               1                  0               0
#> 16                  0               1                  1               0
#> 17                  1               0                  1               0
#> # ℹ 4 more variables: toppings_other <dbl>, toppings_pepperoni <dbl>,
#> #   toppings_pineapple <dbl>, toppings_tomatoes <dbl>
```

This can also be useful in splitting free text responses which are
answers to questions that ask about other responses when not available
from existing list of options. For example, in the pizza data, we can
split the other responses for toppings as follows:

``` r
## Get all other responses provide by all respondents
all_other_choices <- stringr::str_split(pizza_data$pizza3, pattern = ",") |>
    unlist() |>
    stringr::str_trim() |>
    tolower() |>
    unique() |>
    (\(x) x[!is.na(x)])()
    

## Apply split_multiple_responses
split_multiple_responses(
  x = tolower(pizza_data$pizza3),
  sep = ",",
  fill = all_other_choices,
  prefix = "other"
)
#> # A tibble: 17 × 6
#>    other_broccoli other_chicken other_jalapeños other_onions other_sausage
#>             <dbl>         <dbl>           <dbl>        <dbl>         <dbl>
#>  1              0             0               0            0             0
#>  2              0             0               0            0             0
#>  3              0             1               0            0             0
#>  4              0             0               0            0             0
#>  5              0             0               0            0             0
#>  6              0             0               0            0             0
#>  7              0             0               0            0             0
#>  8              0             0               0            0             0
#>  9              0             0               0            0             0
#> 10              0             0               0            0             0
#> 11              0             0               1            0             0
#> 12              0             0               0            0             0
#> 13              1             0               0            0             0
#> 14              1             0               0            0             0
#> 15              0             0               0            0             0
#> 16              0             0               0            1             0
#> 17              0             0               0            0             0
#> # ℹ 1 more variable: other__sausage <dbl>
```

In the example above, we first create a vector (`all_other_choices`) of
all unique *others* responses in the data and then put these responses
in lower case. Then, we apply the split_multiple_responses to the others
responses in the pizza data, we set the `sep` argument to a comma (`,`),
use the `all_other_choices` vector for the `fill` argument, and use
*other* as the value for the `prefix` argument. We then are able to
create a tibble of *other* responses with each unique other response
having its own column in the output data.frame. For respondents who
report that specific response as *other*, then a value of 1 is recorded
for that variable.

<!---

```r
## Setup ruODK
ruODK::ru_setup(
  pid = 6,
  fid = "Pilot_CCHF_participant_questionnaire",
  url = "https://odk.eha.io/",
  un = Sys.getenv("ODK_CENTRAL_USERNAME"),
  pw = Sys.getenv("ODK_CENTRAL_PASSWORD")
)
```


```r
schema <- ruODK::form_schema_ext()

get_choices_ruodk(form_schema = schema, choice_name = "choices_english_(en)")
#> # A tibble: 424 × 4
#>    var_name                question values          labels                
#>    <chr>                   <chr>    <chr>           <chr>                 
#>  1 admin_language          <NA>     kiswahili       Kiswahili             
#>  2 admin_language          <NA>     maa             Maa                   
#>  3 admin_language          <NA>     english         English               
#>  4 admin_primary_informant <NA>     self            Self                  
#>  5 admin_primary_informant <NA>     parent_guardian Parent/Guardian       
#>  6 admin_primary_informant <NA>     other           Other                 
#>  7 admin_hh_position       <NA>     head_hh         Head of household     
#>  8 admin_hh_position       <NA>     other           Other household member
#>  9 p1_sex                  <NA>     male            Male                  
#> 10 p1_sex                  <NA>     female          Female                
#> # ℹ 414 more rows

match_other_to_choices(
  schema, ruODK::odata_submission_get(), 
  var_name = "p30_sick_care",
  choice_name = "choices_english_(en)",
  other_var_name = "p30_sick_care_other"
)
#> # A tibble: 25 × 9
#>    id       recoded_hosptial recoded_clinic recoded_pharmacy recoded_traditional
#>    <chr>    <lgl>            <lgl>          <lgl>            <lgl>              
#>  1 uuid:fa… NA               NA             NA               NA                 
#>  2 uuid:64… NA               NA             NA               NA                 
#>  3 uuid:22… NA               NA             NA               NA                 
#>  4 uuid:e4… NA               NA             NA               NA                 
#>  5 uuid:1d… NA               NA             NA               NA                 
#>  6 uuid:0d… NA               NA             NA               NA                 
#>  7 uuid:10… NA               NA             NA               NA                 
#>  8 uuid:5f… NA               NA             NA               NA                 
#>  9 uuid:eb… NA               NA             NA               NA                 
#> 10 uuid:0b… NA               NA             NA               NA                 
#> # ℹ 15 more rows
#> # ℹ 4 more variables: recoded_faith <lgl>, recoded_household <lgl>,
#> #   recoded_nothing <lgl>, recoded_other <lgl>
```
--->
