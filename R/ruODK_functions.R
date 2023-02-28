################################################################################
#
#'
#' Get choices for a specified variable in an ODK form
#'
#' @param form_schema A form schema created by `ruODK::form_scheme_ext()`
#' @param var_name Specific variable name in ODK form to get choices of
#' @param choice_name Specific variable name in `form_schema` that holds
#'   the information on choices. Forms with multiple languages will have a
#'   `form_schema` with separate columns for choices for each language.
#'   Default is NULL which assumes that only one language is used in the form.
#'
#' @return A tibble with `var_name`, `question`, `values`, and `labels`
#'
#' @examples
#' ## Get all choices for select_one and select_multiple type questions
#' get_choices_ruodk(form_schema = form_codebook)
#'
#' ## Get choices for pizza2 variable
#' get_choices_ruodk(form_schema = form_codebook, var_name = "pizza2")
#'
#' @export
#'
#'
#
################################################################################

get_choices_ruodk <- function(form_schema,
                              var_name = NULL,
                              choice_name = NULL) {
  if (!is.null(var_name)) {
    form_schema <- form_schema %>%
      dplyr::filter(.data$ruodk_name %in% var_name)
  }

  if (!is.null(choice_name)) {
    suppressMessages(
      choices <- form_schema %>%
        dplyr::mutate(
          choices = lapply(.data[[choice_name]], dplyr::bind_cols)
        ) %>%
        tidyr::unnest(.data$choices) %>%
        dplyr::filter(!is.na(.data$values)) %>%
        dplyr::select("ruodk_name", "label", "values", "labels") %>%
        dplyr::rename(var_name = .data$ruodk_name, question = .data$label)
    )
  } else {
    suppressMessages(
      choices <- form_schema %>%
        dplyr::mutate(choices = lapply(.data$choices, dplyr::bind_cols)) %>%
        tidyr::unnest(.data$choices) %>%
        dplyr::filter(!is.na(.data$values)) %>%
        dplyr::select("ruodk_name", "label", "values", "labels") %>%
        dplyr::rename(var_name = .data$ruodk_name, question = .data$label)
    )
  }

  choices
}


################################################################################
#
#'
#' Match other responses to specified choices
#'
#' @param form_schema A form schema created by `ruODK::form_scheme_ext()`
#' @param form_data A tibble of the data retrieved from ODK Central using ruODK
#' @param var_name Specific variable name in ODK form to get choices of
#' @param choice_name Specific variable name in `form_schema` that holds
#'   the information on choices. Forms with multiple languages will have a
#'   `form_schema` with separate columns for choices for each language.
#'   Default is NULL which assumes that only one language is used in the form.
#' @param other_var_name Variable name in `form_data` for other response in
#'   `var_name`
#'
#' @return A tibble with number of columns the same as the number of possible
#'   choices for `var_name` in `form_data` and number of rows equal to the
#'   number of rows of data in `form_data`. Names of resulting tibble is the
#'   concatenation of `recode_` and the choice values for `var_name`
#'
#' @examples
#' ## Match other toppings responses (pizza3) to choices for
#' ## pizza toppings (pizza2)
#' match_other_to_choices(
#'   form_schema = form_codebook, form_data = pizza_data,
#'   var_name = "pizza2", other_var_name = "pizza3"
#' )
#'
#'
#' @export
#'
#'
#
################################################################################

match_other_to_choices <- function(form_schema, form_data,
                                   var_name, choice_name = NULL,
                                   other_var_name) {
  choices <- get_choices_ruodk(
    form_schema = form_schema, var_name = var_name, choice_name = choice_name
  ) %>%
    dplyr::pull(.data$values) %>%
    tolower()

  suppressMessages(
    recoded_vars <- lapply(
      X = choices,
      FUN = stringr::str_detect,
      string = tolower(form_data[[other_var_name]])
    ) %>%
      lapply(FUN = function(x) ifelse(x, 1, 0)) %>%
      dplyr::bind_cols()
  )

  names(recoded_vars) <- paste0("recoded_", choices)

  recoded_vars
}
