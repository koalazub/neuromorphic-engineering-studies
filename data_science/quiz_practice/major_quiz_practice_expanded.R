# create the sequence and iterate in 0.5 increments
sequence <- seq(from = -10, to = 10, by = 0.5)

# separate the positive integers
positive_integers <- sequence[sequence > 0 & sequence %% 1 == 0]
# further separate the positive odd integers
positive_odd_integers <- positive_integers[positive_integers %% 2 == 1]

result <- sum(positive_odd_integers)
print(result)

# generate sequences that start at 1 and double each time until it exceeds 1000

sequence <- c() # init vector
value <- 1
while (value <= 1000) {
  sequence <- c(sequence, value)
  value <- value * 2
}

# find the mean of all values less than 500
below_500 <- sequence[sequence < 500]
result <- mean(below_500) # note the `mean` keyword
print(result)
