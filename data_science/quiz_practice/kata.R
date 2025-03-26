# speed of light analysis
data(morley)

# examine the structure
str(morley)

# get first few rows(6 on default)
head(morley)

# find the dimensions of the dataset

# get Speed column
speed <- morley$Speed

speed_in_kms <- speed / 10
cat(speed_in_kms)

speed_mean <- mean(speed)
speed_std <- sd(speed)
speed_min <- min(speed)
speed_max <- max(speed)
speed_1st_quart <- quantile(
  speed,
  probs = seq(0, 1, 0.25), na.rm = FALSE
)
speed_3rd_quart <- quantile(
  speed,
  probs = seq(0, 1, 0.75), na.rm = FALSE
)

# histogram stuff

light_speed_kms <- speed + 299000

hist(light_speed_kms,
  main = "Histogram speed of Light measurements",
  xlab = "Speed (km/s)",
  col = "blue",
  breaks = 10,
  probability = TRUE
)

# term by term calculation
# geometric series

r <- 0.5
n <- 10

# numeric creates vector with terms stored
terms <- numeric(n + 1)
for (k in 0:n) {
  terms[k + 1] <- r^k
  cat("r^", k, " = ", terms[k + 1], "\n", sep = "")
}

terms <- r^(0:n) # calculates all terms at once
print(terms)

