# Load required packages --------------------------------------------
library(ISLR)
library(purrr)
library(tidyverse)

# Exercise 9 --------------------------------------------------------

# This exercise involves the Auto data set studied in the lab. Make sure
# that the missing values have been removed from the data.

# Use na.omit() to remove rows with missing values. They are already removed from
# the Auto dataset in the ISLR package.

Auto <- na.omit(Auto)

# (a) Which of the predictors are quantitative, and which are qualitative?

# Quantitative variables take on numerical values.
# Qualitative variables take on values in one of K different classes, or categories.
# Predictors 'origin' and 'name' are qualitative. All other predictors are
# quantitative.

# (b) What is the range of each quantitative predictor? You can answer this using 
# the range() function.

# mpg: 9.0 - 46.6
# cylinders: 3 - 8
# displacement: 68 - 455
# horsepower: 46 - 230
# weight: 1613 - 5140
# acceleration: 8.0 - 24.8
# year: 70 - 82
map(Auto[, -c(8:9)], range)

# (c) What is the mean and standard deviation of each quantitative predictor?

# mpg: mean = 23.4, sd = 7.8
# cylinders: mean = 5.47, sd = 1.71 
# displacement: mean = 194.4, sd = 104.6
# horsepower: mean = 104.5, sd = 38.5
# weight: mean = 2978, sd = 849
# acceleration: mean = 15.5, sd = 2.8
# year: mean = 76.0, sd = 3.7
map(Auto[, 1:7], mean)
map(Auto[, 1:7], sd)
  
# (d) Now remove the 10th through 85th observations. What is the range, mean, and 
# standard deviation of each predictor in the subset of the data that remains?

Auto_subset <- Auto[-(10:85), ]

# mpg: mean = 24.4, sd = 7.9, range = 11.0 - 46.6
# cylinders: mean = 5.37, sd = 1.65, range = 3 - 8
# displacement: mean = 187.2, sd = 99.7, range = 68 - 455
# horsepower: mean = 100.7, sd = 35.7, range = 46 - 230
# weight: mean = 2936, sd = 811, range = 1649 - 4997
# acceleration: mean = 15.7, sd = 2.7, range = 8.5 - 24.8
# year: mean = 77.1, sd = 3.1, range = 70 - 82
map(Auto_subset[, 1:7], mean)
map(Auto_subset[, 1:7], sd)
map(Auto_subset[, 1:7], range)

# (e) Using the full data set, investigate the predictors graphically, using 
# scatterplots or other tools of your choice. Create some plots highlighting the
# relationships among the predictors. Comment on your findings.

# There is an inverse relationship between mpg and displacement (with higher 
# displacement for a greater number of cylinders)
ggplot(data = Auto, mapping = aes(x = displacement, y = mpg)) +
  geom_point(mapping = aes(colour = factor(cylinders))) +
  geom_smooth()

# horsepower and weight are positively correlated
ggplot(data = Auto, aes(x = horsepower, y = weight)) +
  geom_point(aes(colour = factor(origin))) +
  geom_smooth()

# Inverse relationship between mpg and horsepower
ggplot(data = Auto, mapping = aes(x = horsepower, y = mpg)) +
  geom_point() +
  geom_smooth()

# Positive correlation between mpg and horsepower
ggplot(data = Auto, mapping = aes(x = horsepower, y = displacement)) +
  geom_point() +
  geom_smooth()

# There is one outlier with high horsepower for a lower weight
Auto %>% 
  filter(weight < 3500 & horsepower > 200)

# (f) Suppose that we wish to predict gas mileage (mpg) on the basis of the other 
# variables. Do your plots suggest that any of the other variables might be useful
# in predicting mpg? Justify your answer.

# There is an inverse relationship between mpg and displacement and mpg and
# horsepower.

# Exercise 10 -------------------------------------------------------

# This exercise involves the Boston housing data set.

# (a) To begin, load in the Boston data set. The Boston data set is part of the 
# MASS library in R.
library(MASS)

# Now the data set is contained in the object Boston.
Boston

# Read about the data set:
?Boston

# How many rows are in this data set? How many columns? What do the rows and 
# columns represent?

# There are 506 rows and 14 columns.
# Each row represents a suburb of Boston
# The columns represent various demographics including the median value of owner-
# occupied homes in $1000s (medv)

# (b) Make some pairwise scatterplots of the predictors (columns) in this data set.
# Describe your findings.
pairs(Boston[, c(1:5, 14)])
pairs(Boston[, c(6:9, 14)])
pairs(Boston[, c(10:13, 14)])

# There appears to be a positive relationship between medv (median value of owner-
# occupied homes in $1000s) and rm (average number of rooms per dwelling) and 
# dis (weighted mean of distances to five Boston employment centres).

ggplot(Boston, aes(x = rm, y = medv)) +
  geom_point()

ggplot(Boston, aes(x = dis, y = medv)) +
  geom_point()

# There appears to be an inverse relationship between medv and nox (nitrogen oxide 
# concentration) and lstat(lower status of the population). 

ggplot(Boston, aes(x = nox, y = medv)) +
  geom_point()

ggplot(Boston, aes(x = lstat, y = medv)) +
  geom_point()

# Other relationships appear to be between nox and indus (proportion of residential
# land zoned for lots over 25,000 sq.ft.), nox and dis, and lstat and rm.

ggplot(Boston, aes(x = nox, y = indus)) +
  geom_point()

ggplot(Boston, aes(x = nox, y = dis)) +
  geom_point()

ggplot(Boston, aes(x = rm, y = lstat)) +
  geom_point()

# (c) Are any of the predictors associated with per capita crime rate? If so, 
# explain the relationship.

# (d) Do any of the suburbs of Boston appear to have particularly high crime rates?
# Tax rates? Pupil-teacher ratios? Comment on the range of each predictor.

# (e) How many of the suburbs in this data set bound the Charles river? What is the
# median pupil-teacher ratio among the towns in this data set?

# (g) Which suburb of Boston has lowest median value of owneroccupied homes? What 
# are the values of the other predictors for that suburb, and how do those values 
# compare to the overall ranges for those predictors? Comment on your findings.

# (h) In this data set, how many of the suburbs average more than seven rooms per 
# dwelling? More than eight rooms per dwelling? Comment on the suburbs that average
# more than eight rooms per dwelling.