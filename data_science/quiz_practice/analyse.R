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
