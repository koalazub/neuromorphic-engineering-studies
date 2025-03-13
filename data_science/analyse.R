library(ggplot2)

# Define constant for dataset URL
DATA_URL <- "http://staff.scm.uws.edu.au/~lapark/download/data/student-mat.csv"

# Rename data variable to something descriptive
student_data <- read.csv(DATA_URL, sep = ";")

# Extract the linear model into its own variable with a clear name
grade_vs_age_model <- lm(G3 ~ age, data = student_data)

# Plot data with clear labels
plot(
  student_data$age,
  student_data$G3,
  xlab = "Student Age",
  ylab = "Final Grade (G3)"
)

# Add regression line
abline(grade_vs_age_model)

# Display model summary
summary(grade_vs_age_model)