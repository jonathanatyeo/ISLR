# load libraries ----------------------------------------------------
library(MASS)
library(ISLR)
library(car) # for vif() function

# Simple linear regression ------------------------------------------
# From the Boston dataset we will seek to predict medv (median house value) using
# 13 predictors
attach(Boston)

# Fit a simple linear regression model with medv as response and lstat (percent of 
# households with low socioeconomic status) as predictor.
lm.fit <- lm(medv ~ lstat, data = Boston)

# Information about the model fit
summary(lm.fit)

# Use names() to find out what other pieces of information are stored in lm.fit()
names(lm.fit)
coef(lm.fit)

# Obtain a confidence interval for the coefficient estimates
confint(lm.fit)

# Calculate confidence and prediction intervals with predict()
predict(lm.fit, data.frame(lstat = c(5, 10, 15)), interval = "confidence")
predict(lm.fit, data.frame(lstat = c(5, 10, 15)), interval = "prediction")

# Plot medv and lstat alongside the least squares regression line
plot(lstat, medv)
abline(lm.fit)

# Experiment with additional ways to draw lines and points. lwd = 3 causes the width
# of the abline to increase by a factor of 3.
abline(lm.fit, lwd = 3)
abline(lm.fit, lwd = 3, col = "red")
plot(lstat, medv, col = "red")
plot(lstat, medv, pch = 20)
plot(lstat, medv, pch = "+")
plot(1:20, 1:20, pch =1:20)

# Four diagnostic plots using plot(lm.fit). Use par() to split the plotting region.
par(mfrow = c(2, 2))
plot(lm.fit)
par(mfrow = c(1, 1))

# Alternatively compute the residuals using the residuals() and rstudent() functions
plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))

# Leverage statistics can be computed with the hatvalues() function
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))

# Multiple linear regression ----------------------------------------

# Add age to the linear regression model
lm.fit <- lm(medv ~ lstat + age, data = Boston)
summary(lm.fit)

# Fit a regression model on all predictors
lm.fit <- lm(medv ~ ., data = Boston)
summary(lm.fit)

# Compute variance inflation factors (VIF) using the vif() function in the car
# package
vif(lm.fit)

# Perform a regression on all predictors except age
lm.fit1 <- lm(medv ~ . - age, data = Boston)
summary(lm.fit1)

# Alternatively the update() function can be used
lm.fit1 <- update(lm.fit, ~ . - age)

# Interaction terms -------------------------------------------------

# Include the interaction term lstat x age 
# (lstat * age is shorthand for lstat + age + lstat:age)
summary(lm(medv ~ lstat * age, data = Boston))

# Non-linear transformation of the predictiors ----------------------

# Perform a regression of medv on lstat and lstat ^ 2
# (Note: use I() as ^ has a special meaning in a formula)
lm.fit2 <- lm(medv ~ lstat + I(lstat ^ 2), data = Boston)
summary(lm.fit2)

# Use the anova() function to further quantify the extent to which a quadratic fit
# is superior to a linear fit
lm.fit <- lm(medv ~ lstat, data = Boston)
anova(lm.fit, lm.fit2)

# Plot the residuals
par(mfrow = c(2,2))
plot(lm.fit2)

# Use the poly() function to create a polynomial within lm()
lm.fit5 <- lm(medv ~ poly(lstat, 5), data = Boston)
summary(lm.fit5)

# Or we can use a log transformation
summary(lm(medv ~ log(rm), data = Boston))

# Qualitative predictors --------------------------------------------

# Use the Carseats dataset to predict sales (child car seat sales) fitting a 
# multiple regression model that includes some interaction terms.

lm.fit <- lm(Sales ~ . + Income:Advertising + Price:Age, data = Carseats)
summary(lm.fit)

# The contrasts() function returns the coding that R uses for dummy variables
attach(Carseats)
contrasts(ShelveLoc)
