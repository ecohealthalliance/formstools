% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_questions.R
\name{get_questions}
\alias{get_questions}
\title{Get questions used for select_one and select_multiple questions in an
XLSForm}
\usage{
get_questions(xlsform, choice_name = NULL)
}
\arguments{
\item{xlsform}{A character value for the path to the XLSForm}

\item{choice_name}{A character value or vector of values of names given to
the set of choices in the supplied/specified XLSForm. Default to NULL in
which case all `select_one` and `select_multiple` questions types are
returned.}
}
\value{
A tibble of the `type`, `list_name`, `name`, and `label` of the
  choices for the specified `select_one` and `select_multiple` type of
  questions in the specified XLSForm
}
\description{
Get questions used for select_one and select_multiple questions in an
XLSForm
}
\examples{
## Get all select_one and select_multiple question types
get_questions(
  xlsform = system.file(
    "extdata", "ghana_community_form.xlsx", package = "formstools"
  )
)

## Get all select_one and select_multiple question types for gender list_name
get_questions(
  xlsform = system.file(
    "extdata", "ghana_community_form.xlsx", package = "formstools"
  ),
  choice_name = "gender"
)

}
