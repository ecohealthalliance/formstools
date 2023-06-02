################################################################################
#
#'
#' Split a vector of values from an ODK select multiple type of response
#'
#' @param x A select_multiple response or vector of responses with multiple
#'   responses
#' @param sep Separator used to separate multiple responses. Default to " ".
#'   Regular expressions can be used to detect more than one possible separator.
#' @param fill A vector of all the possible responses to the select multiple
#'   question
#' @param na_rm Logical. Should an NA response be reported in its own column?
#'   Default to FALSE.
#' @param prefix A character value for prefix to append to names of resulting
#'   data.frame.
#'
#' @return A tibble with number of columns the same as the number of possible
#'   choices for the select multiple question (same as lenght of `fill`) and
#'   number of rows equal to the length of `x`. Names of resulting tibble is the
#'   concatenation of the `prefix` and the values for `fill`
#'
#' @examples
#' ## Split the multiple responses of pizza toppings
#' split_multiple_responses(
#'   x = pizza_data$pizza2,
#'   sep = ", ",
#'   fill = c("cheese", "tomatoes", "pepperoni", "mushrooms",
#'            "artichoke", "olives", "pineapple", "other"),
#'   prefix = "toppings"
#' )
#'
#' @export
#'
#' @rdname split_multiple
#'
#
################################################################################

split_multiple_response <- function(x, sep = " ", fill, na_rm = FALSE, prefix) {
  if (na_rm) {
    if (is.na(x)) {
      rep(NA_character_, times = length(fill)) %>%
        (\(x) { names(x) <- paste0(prefix, "_", fill); x })()
    } else {
      stringr::str_split(x, pattern = sep) %>%
        unlist() %>%
        #as.integer() |>
        spread_vector_to_columns(fill = fill, prefix = prefix) %>%
        colSums(na.rm = TRUE)
    }
  } else {
    stringr::str_split(x, pattern = sep) %>%
      unlist() %>%
      #as.integer() |>
      spread_vector_to_columns(fill = fill, prefix = prefix) %>%
      colSums(na.rm = TRUE)
  }
}

#
#' @export
#' @rdname split_multiple
#

split_multiple_responses <- function(x, sep = " ", fill,
                                     na_rm = FALSE, prefix) {
  lapply(
    X = x,
    FUN = split_multiple_response,
    sep = sep,
    fill = fill,
    na_rm = na_rm,
    prefix = prefix
  ) %>%
    dplyr::bind_rows()
}

################################################################################
#
#'
#' Convert character vector of categorical responses into unique variables
#'
#' Function transforms a vector of categorical responses into `n` number of
#' new columns/variables equal to the number of unique categorical values.
#'
#' @param x Vector of categorical values
#' @param fill A vector of all the possible responses to the select multiple
#'   question
#' @param na_rm Logical. Should an NA response be reported in its own column?
#'   Default to FALSE.
#' @param prefix A character string to prepend to the names of the new columns
#'   to be created
#'
#' @return A tibble with number of columns the same as the number of unique
#'   values `x` and number of rows equal to the length of `x`. Names of
#'   resulting tibble is the concatenation of the `prefix` and the values of `x`
#'
#' @examples
#' spread_vector_to_columns(
#'   x = c("cat", "cat", "dog", "dog", "dog", NA_character_),
#'   fill = c("cat", "dog", "monkey"),
#'   na_rm = TRUE,
#'   prefix = "pets"
#' )
#'
#' @export
#'
#
################################################################################

spread_vector_to_columns <- function(x, fill = NULL, na_rm = FALSE, prefix) {
  values <- sort(unique(x), na.last = ifelse(na_rm, TRUE, NA))

  if (!is.null(fill)) {
    values <- c(values, fill[!fill %in% values]) %>%
      sort(na.last = ifelse(na_rm, TRUE, NA))
  }

  values <- values %>%
    stringr::str_replace_all(
      pattern = " ", replacement = "_"
    )

  col_names <- paste(prefix, values, sep = "_")

  lapply(
    X = x,
    FUN = function(x, y) ifelse(x == y, 1, 0),
    y = values
  ) %>%
    (\(x) do.call(rbind, x))() %>%
    data.frame() %>%
    (\(x) { names(x) <- col_names; x })()
}
