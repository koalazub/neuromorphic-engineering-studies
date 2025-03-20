setwd("week1/")
cleveland_data <- read.csv("./cleveland_processed.csv", sep = ";")
print("\n")
print("head of cleveland data")
head(cleveland_data, n = 3) # prints out first 6 rows

str(cleveland_data)
summary(cleveland_data)


# Preprocessing step
# massaging the data

# NA is a logical constant that contains a missing value.
# Kind of like nil in golang, I guess?


# this step applys a function per item in the list.
# See that it applies an anonymous function as an argument


print("\n\n missing values")
missing_values <- sapply(cleveland_data, function(x) sum(is.na(x)))
# print(missing_values) # nolint: commented_code_linter.

cleveland_clean <- na.omit(cleveland_data) # remove incomplete info
# print(cleveland_clean) # nolint: commented_code_linter.


