library(ggplot2)

data_url <- "https://staff.scm.uws.edu.au/~lapark/download/data/student-mat.csv"

student_data <- read.csv(data_url, sep = ";")
grade_vs_age_model <- lm(G3 ~ age, data = student_data)

plot(
  student_data$age,
  student_data$G3,
  xlab = "Student Age",
  ylab = "Final Grade (G3)"
)

abline(grade_vs_age_model)

summary(grade_vs_age_model)
categorise_values <- function(x) {
  if (all(is.na(x))) {
    return(rep(NA, length(x)))
  }

  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  for (i in seq_along(x)) {
    if (is.na(x)) {
      result[i] <- NA
    } else if (x[i] < q1) {
      result[i] <- "Low"
    } else if (x[i] > q3) {
      result[i] <- "High"
    } else {
      # this way we don't need to consider medium if we put it as the last case
      result <- "Medium"
    }
  }
}
