
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
#>    type       list_name  name                       label::English (en…¹ label…²
#>    <chr>      <chr>      <chr>                      <chr>                <lgl>  
#>  1 select_one yes_no     consent_signed             Consent Form Admini… NA     
#>  2 select_one region     com_id_region              Region:              NA     
#>  3 select_one district   com_id_district            District:            NA     
#>  4 select_one community  com_id_commun              Community:           NA     
#>  5 select_one gender     c01_gender                 01. What is your ge… NA     
#>  6 select_one pray       c02_pray                   02. Where do you pr… NA     
#>  7 select_one lived_here c04_long_lived_here        04. How long have y… NA     
#>  8 select_one yes_no     c08_have_in_home           I am going to read … NA     
#>  9 select_one yes_no     c06_tv                     06. TV               NA     
#> 10 select_one yes_no     c07_consistent_electricity 07. Consistent elec… NA     
#> # … with 94 more rows, and abbreviated variable names ¹​`label::English (en)`,
#> #   ²​`label::Some_other_language`
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
#> # … with abbreviated variable name ¹​`label::Some_other_language`
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
#> # … with 721 more rows
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
#> # A tibble: 17 × 8
#>    recoded_cheese recoded_toma…¹ recod…² recod…³ recod…⁴ recod…⁵ recod…⁶ recod…⁷
#>             <dbl>          <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#>  1             NA             NA      NA      NA      NA      NA      NA      NA
#>  2             NA             NA      NA      NA      NA      NA      NA      NA
#>  3              0              0       0       0       0       0       0       0
#>  4             NA             NA      NA      NA      NA      NA      NA      NA
#>  5             NA             NA      NA      NA      NA      NA      NA      NA
#>  6             NA             NA      NA      NA      NA      NA      NA      NA
#>  7             NA             NA      NA      NA      NA      NA      NA      NA
#>  8             NA             NA      NA      NA      NA      NA      NA      NA
#>  9             NA             NA      NA      NA      NA      NA      NA      NA
#> 10             NA             NA      NA      NA      NA      NA      NA      NA
#> 11              0              0       0       0       0       0       0       0
#> 12             NA             NA      NA      NA      NA      NA      NA      NA
#> 13              0              0       0       0       0       0       0       0
#> 14              0              0       0       0       0       0       0       0
#> 15             NA             NA      NA      NA      NA      NA      NA      NA
#> 16              0              0       0       0       0       0       0       0
#> 17             NA             NA      NA      NA      NA      NA      NA      NA
#> # … with abbreviated variable names ¹​recoded_tomatoes, ²​recoded_pepperoni,
#> #   ³​recoded_mushrooms, ⁴​recoded_artichoke, ⁵​recoded_olives,
#> #   ⁶​recoded_pineapple, ⁷​recoded_other
```

The output of using this function is a data.frame/tibble with rows equal
to the number of rows as the form data and columns equal to the number
of specified and distinct choices of the question/variable of interest.
The columns are named by each of the choices prefixed by the string
`recode_`. Each column in this resulting data.frame provides values of
either `1` or `0` with `1` meaning that that specific choice was
detected from the other response for that specific row of data. This
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
split_select_multiples(
  x = pizza_data$pizza2,
  fill = c("cheese", "tomatoes", "pepperoni", "mushrooms", "artichoke", "olives", "pineapple", "other"),
  prefix = "toppings"
)
#> # A tibble: 17 × 8
#>    toppings_artichoke toppings…¹ toppi…² toppi…³ toppi…⁴ toppi…⁵ toppi…⁶ toppi…⁷
#>                 <dbl>      <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#>  1                  0          0       0       0       0       1       0       1
#>  2                  0          1       1       1       0       0       0       0
#>  3                  1          1       0       0       1       1       0       0
#>  4                  1          1       1       0       0       0       0       0
#>  5                  0          1       1       1       0       0       0       1
#>  6                  1          1       0       0       0       1       0       1
#>  7                  0          1       0       0       0       1       1       0
#>  8                  0          1       1       1       0       0       0       1
#>  9                  0          0       1       0       0       0       0       0
#> 10                  0          1       1       0       0       1       0       0
#> 11                  0          1       1       1       1       1       0       1
#> 12                  0          1       1       0       0       1       0       0
#> 13                  0          1       0       1       1       0       1       1
#> 14                  0          0       0       1       1       0       1       1
#> 15                  0          1       0       0       0       1       0       1
#> 16                  0          1       1       0       1       0       0       1
#> 17                  1          0       1       0       0       1       0       0
#> # … with abbreviated variable names ¹​toppings_cheese, ²​toppings_mushrooms,
#> #   ³​toppings_olives, ⁴​toppings_other, ⁵​toppings_pepperoni,
#> #   ⁶​toppings_pineapple, ⁷​toppings_tomatoes
```

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
#> # … with 414 more rows

match_other_to_choices(
  schema, ruODK::odata_submission_get(), 
  var_name = "p30_sick_care",
  choice_name = "choices_english_(en)",
  other_var_name = "p30_sick_care_other"
)
#> # A tibble: 25 × 8
#>    recoded_hosptial recoded_cl…¹ recod…² recod…³ recod…⁴ recod…⁵ recod…⁶ recod…⁷
#>    <lgl>            <lgl>        <lgl>   <lgl>   <lgl>   <lgl>   <lgl>   <lgl>  
#>  1 NA               NA           NA      NA      NA      NA      NA      NA     
#>  2 NA               NA           NA      NA      NA      NA      NA      NA     
#>  3 NA               NA           NA      NA      NA      NA      NA      NA     
#>  4 NA               NA           NA      NA      NA      NA      NA      NA     
#>  5 NA               NA           NA      NA      NA      NA      NA      NA     
#>  6 NA               NA           NA      NA      NA      NA      NA      NA     
#>  7 NA               NA           NA      NA      NA      NA      NA      NA     
#>  8 NA               NA           NA      NA      NA      NA      NA      NA     
#>  9 NA               NA           NA      NA      NA      NA      NA      NA     
#> 10 NA               NA           NA      NA      NA      NA      NA      NA     
#> # … with 15 more rows, and abbreviated variable names ¹​recoded_clinic,
#> #   ²​recoded_pharmacy, ³​recoded_traditional, ⁴​recoded_faith,
#> #   ⁵​recoded_household, ⁶​recoded_nothing, ⁷​recoded_other
```
--->
