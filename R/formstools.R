################################################################################
#
#'
#' Tools for working with ODK XLSForms
#'
#' @docType package
#' @keywords internal
#' @name formstools
#' @importFrom dplyr %>% filter select starts_with pull bind_cols bind_rows
#' @importFrom stringr str_split str_remove_all str_replace_all
#' @importFrom readxl read_excel
#' @importFrom rlang .data
#' @importFrom tidyr unnest
#'
#
################################################################################
"_PACKAGE"


################################################################################
#
#'
#' An example ODK form schema retrieved using ruODK
#'
#' @format A tibble with 7 columns and 10 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *path* | XML path to question in ODK |
#' | *name* | Variable name used in XForm |
#' | *type* | Variable type |
#' | *binary* | Are the values for the question binary? |
#' | *ruodk_name* | Variable name used by ruODK |
#' | *label* | Question used in XForm |
#' | *choices* | Named list of choices for select_one and select_multiple questions |
#'
#' @examples
#' form_codebook
#'
#'
#
################################################################################
"form_codebook"


################################################################################
#
#'
#' An example data collected using ODK and aggregated using ODK Central
#'
#' @format A tibble with 21 columns and 17 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *id* | Identifier |
#' | *start* | Start date and time |
#' | *end* | End date and time |
#' | *today* | Date of data entry |
#' | *pizza1* | Do you like pizza? |
#' | *pizza2* | Pizza toppings you like (select multiple) |
#' | *pizza3* | Any other toppings? |
#' | *closing* | Closing statement |
#' | *meta_audit* | Meta audit |
#' | *meta_instance_id* | Meta instance ID |
#' | *system_submission_date* | System submission date |
#' | *system_updated_at* | System updated at |
#' | *system_submitter_id* | System submitter ID |
#' | *system_submitter_name* | System submitter name |
#' | *system_attachments_present* | System attachments present |
#' | *system_attachments_expected* | System attachments expected |
#' | *system_status* | System status |
#' | *system_review_state* | System review state |
#' | *system_device_id* | System device ID |
#' | *system_edits* | System edits |
#' | *odata_context* | OData context |
#'
#' @examples
#' pizza_data
#'
#
################################################################################
"pizza_data"

