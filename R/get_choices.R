################################################################################
#
#'
#' Get choices used for select_one and select_multiple questions in an
#' XLSForm
#'
#' @param xlsform A character value for the path to the XLSForm
#' @param choice_name A character value or vector of values of names given to the
#'   set of choices in the supplied/specified XLSForm. Default to NULL in which
#'   case all `select_one` and `select_multiple` questions types are returned.
#'
#' @return A tibble of the the `list_name`, `name`, and `label` of the choices
#'   for the specified `select_one` and `select_multiple` type of questions
#'   in the specified XLSForm
#'
#' @examples
#' get_choices(
#'   xlsform = system.file(
#'     "extdata", "ghana_community_form.xlsx", package = "formstools"
#'   )
#' )
#'
#' @export
#'
#
#
################################################################################

get_choices <- function(xlsform, choice_name = NULL) {
  survey <- readxl::read_excel(
    path = xlsform, sheet = "survey"
  ) %>%
    dplyr::filter(
      !is.na(.data$type),
      stringr::str_detect(
        string = .data$type, pattern = "select"
      )
    ) %>%
    dplyr::mutate(
      list_name = stringr::str_remove_all(
        string = .data$type, pattern = "select_one |select_multiple "
      ),
      type = stringr::str_split(
        string = .data$type, pattern = " ", simplify = TRUE
      ) %>%
        data.frame() %>%
        dplyr::pull(1)
    ) %>%
    dplyr::select(
      "type", "list_name", "name", dplyr::starts_with("label")
    )

  if (!is.null(choice_name)) {
    survey <- survey %>%
      dplyr::filter(.data$list_name %in% choice_name)
  }

  choices <- readxl::read_excel(
    path = xlsform, sheet = "choices"
  ) %>%
    dplyr::filter(
      !is.na(.data$list_name), .data$list_name %in% survey$list_name
    ) |>
    dplyr::select(
      "list_name", "name", dplyr::starts_with("label")
    )

  choices
}
