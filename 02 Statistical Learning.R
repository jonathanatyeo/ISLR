# Load required packages --------------------------------------------
library(ISLR)

# Exercise 9 --------------------------------------------------------

# This exercise involves the Auto data set studied in the lab. Make sure
# that the missing values have been removed from the data.

# Use na.omit() to remove rows with missing values. They are already removed from
# the Auto dataset in the ISLR package.

Auto <- na.omit(Auto)

# (a) Which of the predictors are quantitative, and which are qualitative?

# Predictors 'origin' and 'name' are qualitative. All other predictors are
# quantitative.

# (b) What is the range of each quantitative predictor? You can answer this using 
# the range() function.

# mpg: 9.0 - 46.6
range(Auto$mpg)

# cylinders: 3 - 8
range(Auto$cylinders)

# displacement: 68 - 455
range(Auto$displacement)

# horsepower: 46 - 230
range(Auto$horsepower)

# weight: 1613 - 5140
range(Auto$weight)

# acceleration: 8.0 - 24.8
range(Auto$acceleration)

# year: 70 - 82
range(Auto$year)

# (c) What is the mean and standard deviation of each quantitative predictor?


  
  (d) Now remove the 10th through 85th observations. What is the
range, mean, and standard deviation of each predictor in the
subset of the data that remains?
  (e) Using the full data set, investigate the predictors graphically,
using scatterplots or other tools of your choice. Create some plots
highlighting the relationships among the predictors. Comment
on your findings.
(f) Suppose that we wish to predict gas mileage (mpg) on the basis
of the other variables. Do your plots suggest that any of the
other variables might be useful in predicting mpg? Justify your
answer.