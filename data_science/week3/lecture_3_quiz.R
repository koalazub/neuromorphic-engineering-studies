numbers <- c(1, 2, 5, 7, 8, 9, 11, 14, 16, 18)

is_even <- function(numbers) {
  for (x in numbers) {
    if (x %% 2 == 0) {
      TRUE
    } else {
      FALSE
    }
  }
}

is_even(numbers)

compute_relu <- function(x) {
  if (x > 0) {
    x
  } else {
    0
  }
}

compute_relus <- function() {
  for (n in -5:5) {
    result <- compute_relu(n)
    print(paste("ReLu(", n, ")", result))
  }
}

compute_relus()

is_even <- function(number) {
  if (number %% 2 == 0 || number < 0) {
    print("true")
  } else {
    print("false")
  }
}

# Write the previous switch example as an if statement

get_pet <- function(pet) {
  if (pet == "dog") {
    "puppy"
  } else if (pet == "cat") {
    "kitten"
  } else if (pet == "pig") {
    "piglet"
  } else {
    NULL
  }
}

get_pet("cat")

sum_elements <- function(w) {
  x <- 0
  for (a in w) {
    if (!is.na(a)) { # new function!
      x <- x + a
    }
  }
  print(paste("sum is ", x))
}
sum_elements(c(1, 2, NA, 3))
