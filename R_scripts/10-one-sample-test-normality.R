# 📁 Session 10: One-Sample t-tests, Normality Check & Effect Size Estimation

# 1. Define the datasets
# -----------------------
# Production: numeric vector representing sample values
Production <- c(225, 181, 190, 318, 216, 234, 217, 235, 176, 239)

# Score: another sample dataset for comparison
Score <- c(20, 18, 20, 18, 20, 9, 10, 6, 18, 11, 12)

# 2. Compute basic descriptive statistics
# ---------------------------------------
mean(Production)     # Mean of Production
sd(Production)       # Standard deviation

# 3. Perform one-sample t-tests
# -----------------------------
# H0: The population mean is 205
Test1 <- t.test(x = Production, mu = 205, alternative = "two.sided")
print(Test1)

# H0: The population mean is 5 (Score dataset)
Test2 <- t.test(x = Score, mu = 5)
print(Test2)

# 4. Generate detailed statistical reports
# ----------------------------------------
library(report)
report(Test1)
report(Test2)

# 5. Visualize data distribution
# ------------------------------
x11()                  # Open a new graphics device (for Windows)
boxplot(Production)    # Boxplot of Production
mean(Production)       # Re-check mean
median(Production)     # Median

# 6. Descriptive summary using pastecs
# -------------------------------------
library(pastecs)
stat.desc(Production, norm = TRUE)

# 7. Check data normality
# ------------------------
library(car)
qqPlot(Production)        # Q-Q plot (from 'car')

library(ggpubr)
ggqqplot(Production)      # Q-Q plot using ggplot2 style

library(rstatix)
shapiro_test(Production)  # Shapiro-Wilk test for normality

# Detect outliers
identify_outliers(data.frame(Production))

# Additional normality test
library(nortest)
lillie.test(Production)   # Lilliefors test

# 8. Power analysis for one-sample t-test
# ---------------------------------------
library(pwr)
# Given sample size = 10, and large effect size = 1
pwr.t.test(n = 10, d = 1, sig.level = 0.05, type = "one.sample", alternative = "two.sided")

# Given desired power = 0.6, compute required sample size
pwr.t.test(power = 0.6, d = 1, sig.level = 0.05, type = "one.sample", alternative = "two.sided")

# 9. Effect size estimation
# --------------------------
library(lsr)
# One-sample t-test with effect size
oneSampleTTest(x = Production, mu = 250, one.sided = FALSE, conf.level = 0.95)
