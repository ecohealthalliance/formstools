## Load libraries
library(dplyr)

## Setup ruODK
ruODK::ru_setup(
  pid = 1,
  fid = "pizza",
  url = "https://odk.eha.io/",
  un = Sys.getenv("ODK_CENTRAL_USERNAME"),
  pw = Sys.getenv("ODK_CENTRAL_PASSWORD")
)

## Get form extended schema
form_codebook <- ruODK::form_schema_ext()
usethis::use_data(form_codebook, compress = "xz")

## Get form data
pizza_data <- ruODK::odata_submission_get()
usethis::use_data(pizza_data, compress = "xz")


