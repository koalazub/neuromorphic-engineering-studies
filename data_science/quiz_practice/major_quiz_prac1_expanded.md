# R Programming Exercises for Quiz Preparation

Here are targeted exercises to help you prepare for your quiz, focusing on key concepts from your course materials.

## Basic Sequence and Vector Operations

```r
# Exercise 1: Create a vector of values from -10 to 10 in steps of 0.5
# Then calculate the sum of only the positive odd integers in this sequence

# Exercise 2: Generate a sequence that starts at 1 and doubles each time until it exceeds 1000
# Then find the mean of all values less than 500
```

## Function Return Values and Edge Cases

```r
# Exercise 3: Fix this function that should return the geometric mean of a vector
# The geometric mean is the nth root of the product of n numbers
geometric_mean  third quartile
# NA values should remain NA in the output
```

## Data Analysis with Loops and Conditions

```r
# Exercise 6: Write a function that finds outliers using Tukey's method
# Input: a numeric vector and a value for k (default 1.5)
# Output: a list containing:
#   - indices of outliers
#   - the outlier values
#   - the thresholds used (lower and upper)
```

## Working with Real Datasets

```r
# Exercise 7: Using the morley dataset (speed of light measurements):
# 1. Convert the measurements to km/s
# 2. Find which experimental runs (Expt column) had the most variability
# 3. Create a function to test if a new measurement would be considered an outlier
#    in any of the experimental runs
```

## Format Output and Visualisation

```r
# Exercise 8: Create a function that prints out statistics about a dataset
# in a nicely formatted table with borders
# The function should display:
# - Min and max values
# - Mean and median
# - Standard deviation and IQR
# - Count of NA values

# Exercise 9: Write a function that takes a numeric vector and produces
# both a histogram and boxplot in a single plot window using par(mfrow=c(1,2))
# Add appropriate titles and labels
```

## Comprehensive Script Exercise

```r
# Exercise 10: Write a script that simulates a T20 cricket match
# - Generate random scores for each over (between 0 and 20 runs)
# - Track wickets falling (with some random probability)
# - Display the scoreboard after each over using cat() with formatting
# - At the end, print match summary statistics
```

These exercises cover all the major topics from your course materials including variables, functions, flow control, data analysis, and visualisation. They also address the specific issues I noticed in your practice exercises, such as handling edge cases, proper return values, and correct initialisation of variables.
