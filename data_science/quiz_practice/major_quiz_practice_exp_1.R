numbers <- sequence(from = -10, to = 10, by = 2)

result <- 2^(2^2)

# How would you compute the sum of a geometric series:
# ∑ k = 0 n r k ∑  k=0 n r  k for a given r and n in R?
# I added some extra info in the google notebook for further clarity
# refer to `images/` for the working out and the explainer

r <- 0.5
n <- 10

sum_geo <- 0
for (k in 0:n) {
  sum_geo <- sum_geo + r^k
}

# Write code to compute and display the first and third quartiles of a dataset.

get_quartiles <- function(x) {
  data <- c(12, 4, 46, 676, 56, 23, 324, 2, 9)
  q1 <- quantile(data, probs = 0.25) # get 1st
  q3 <- quantile(data, probs = 0.75) # get 3rd
  cat("First", q1, "\nThird", q3)
}

# checksum is defined as a vlaue appended to a vector of integers to ensure
# data integrity
# How would you add a checksum to a vector of integers
# so that the sum of the resulting vector is a multiple of 10?

add_checksum <- function(v) {
  total_sum <- sum(v)
  remainder <- total_sum %% 10
  if (remainder == 0) {
    checksum <- 0
  } else {
    checksum <- 10 - remainder
  }
  c(v, checksum)
}
