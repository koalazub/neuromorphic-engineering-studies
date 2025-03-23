my_function <- function(x) {
  if (x > 5) {
    result <- "greater"
  } else if (x < 0) {
    result <- "negative"
  }
  result
}

my_function(5)

# 2. error. result isn't initialised


sum_odd <- function(numbers) {
  total <- 0
  for (n in numbers) {
    if (n %% 2 != 0) {
      total <- total + n
    }
  }
  total
}
# 3. 0

count_even <- function(numbers) {
  count <- 0
  for (x in numbers) {
    if (x %% 2 == 0) {
      count <- count + 1
    } else {
      count <- count
    }
  }
}

# 4. it's adding 1 to the even number, making it odd

get_season <- function(month) {
  switch(month,
    "December" = "Summer",
    "January" = "Summer",
    "February" = "Summer",
    "March" = "Autumn",
    "April" = "Autumn",
    "May" = "Autumn",
    "June" = "Winter",
    "July" = "Winter",
    "August" = "Winter",
    "September" = "Spring",
    "October" = "Spring",
    "November" = "Spring",
    "Unknown"
  )
}

get_season_if <- function(month) {
  if (month == "December" || month == "January" || month == "February") {
    "Summer"
  } else if (month == "March" || month == "April" || month == "May") {
    "Autumn"
  } else if (month == "June" || month == "July" || month == "August") {
    "Winter"
  } else if (
    month == "September" ||
      month == "October" ||
      month == "November") {
    "Spring"
  } else {
    "Unknown"
  }
}

# 5. all done to ifs

evaluate <- function(operation, x, y) {
  if (operation == "add") {
    x + y
  } else if (operation == "subtract") {
    x - y
  } else if (operation == "multiply") {
    x * y
  } else if (operation == "divide") {
    if (y == 0) {
      NA
    } else {
      x / y
    }
  } else {
    NULL
  }
}

evaluate("divide", 10, 0)
# 6. NA

# c(1, NA, 3, NA, 5) as args

count_valid <- function(vector) {
  count <- 0
  for (element in vector) {
    if (!is.na(element)) {
      count <- count + 1
    }
  }
  count
}

count_valid(c(1, NA, 3, NA, 5))

# 3

multiply_elements <- function(vector) {
  result <- 1
  for (element in vector) {
    if (!is.na(element)) {
      result <- result * element
    }
  }
  result
}

# 8. add check for it to not be na

strange_function <- function(x) {
  if (x > 0) {
    print("Positive")
  } else {
    print("Non-postiive")
  }
}

result <- strange_function(5)

# 9. postive

func_largest_even <- function(numbers) {
  largest <- 0
  for (n in numbers) {
    if (n %% 2 == 0 && n > largest) {
      largest <- n
    }
  }
}

# 10. no return


# optimise vectorised result
double_values <- function(vector) {
  result <- c()
  for (i in 1:length(vector)) {
    result[i] <- vector[i] * 2
  }
  result
}
