################################################################################
#
#'
#' Get choices used for select_one and select_multiple questions in an
#' XLSForm
#'
#' @param xlsform A character value for the path to the XLSForm
#' @param choice_name A character value or vector of values of names given to the
#'   set of choices in the supplied/specified XLSForm. Default to NULL in which
#'   case all sets of choices are returned.
#'
#' @return A tibble of the `list_name`, `name`, and `label` of the choices
#'   for the specified `select_one` and `select_multiple` type of questions
#'   in the specified XLSForm
#'
#' @examples
#' ## Get all choices
#' get_choices(
#'   xlsform = system.file(
#'     "extdata", "ghana_community_form.xlsx", package = "formstools"
#'   )
#' )
#'
#' ## Get choices for gender
#' get_choices(
#'   xlsform = system.file(
#'     "extdata", "ghana_community_form.xlsx", package = "formstools"
#'   ),
#'   choice_name = "gender"
#' )
#'
#'
#' @export
#'
#
#
################################################################################

get_choices <- function(xlsform, choice_name = NULL) {
  choices <- readxl::read_excel(
    path = xlsform, sheet = "choices"
  ) %>%
    dplyr::filter(!is.na(.data$list_name))

  if (!is.null(choice_name)) {
    choices <- choices %>%
      dplyr::filter(
        .data$list_name %in% choice_name
      )
  }

  choices <- choices %>%
    dplyr::select(
      "list_name", "name", dplyr::starts_with("label")
    )

  choices
}
