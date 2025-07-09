# Session 11: T-tests and ANOVA (One-way and Two-way) with Assumption Checks

# Set working directory (adjust to your system)
setwd("G:/دوره نرم افزار جنگل 2023/دوره R پیشرفته/R WorkShop/MyProject")

# Load required packages
library(datarium)     # for sample datasets
library(rio)          # for data import/export
library(tidyverse)    # for data wrangling and visualization
library(rstatix)      # for statistical functions
library(report)       # for easy-to-read test reports
library(nortest)      # for normality tests
library(car)          # for Levene’s test and Anova()
library(agricolae)    # for HSD.test
library(pacman)       # package management
library(raster)       # for data manipulation
library(ggplot2)      # plotting

# Load and export genderweight dataset
data("genderweight")
export(genderweight, "genderweight.xlsx")
genderweight <- import("genderweight.xlsx")

# Descriptive statistics by group
Weight.Stat <- genderweight %>%
  group_by(group) %>%
  get_summary_stats(weight, type = "common")
print(Weight.Stat)

# Boxplot of weight by group
x11()
ggplot(data = genderweight, aes(x = group, y = weight, fill = group)) +
  geom_boxplot()

# Independent t-test (Welch's by default)
t.test(weight ~ group, data = genderweight)

# Levene’s test for equal variance
leveneTest(weight ~ group, data = genderweight)

# Re-run t-test with unequal variance assumption
t.test(weight ~ group, data = genderweight, var.equal = FALSE)

# Check normality for each group
genderweight %>%
  group_by(group) %>%
  shapiro_test(weight)

# Full report of t-test
T.Test <- t.test(weight ~ group, data = genderweight, var.equal = FALSE)
report(T.Test)

# Check for outliers
genderweight %>%
  group_by(group) %>%
  identify_outliers(weight)

# --- Paired t-test Example ---

# Define paired measurements
Upper_L <- c(4, 5.2, 5.7, 4.2, 4.8, 3.9, 4.1, 3, 4.6, 6.8)
Lower_L <- c(4.4, 3.7, 4.7, 2.8, 4.2, 4.3, 3.5, 3.7, 3.1, 1.9)
Legum <- data.frame(Lower_L, Upper_L)

# Add ID and reorder columns
Legum <- Legum %>%
  mutate(ID = row_number()) %>%
  relocate(ID, .before = Lower_L)

# Paired t-test
t.test(Legum$Lower_L, Legum$Upper_L, paired = TRUE, conf.level = 0.95)

# Calculate difference manually
Legum <- Legum %>%
  mutate(Diff = Lower_L - Upper_L)

# Remove unnecessary columns
Legum$Diff2 <- NULL
Legum <- Legum %>% dplyr::select(-ID)

# Test normality of differences
Legum %>% shapiro_test(Diff)

# Square root transformation (if needed)
Legum <- Legum %>%
  mutate(Lower.SQRT = sqrt(Lower_L),
         Upper.SQRT = sqrt(Upper_L))

# Summary statistics
Legum %>% get_summary_stats(Lower_L, Upper_L, type = "full")

# --- One-Way ANOVA Example ---

data("PlantGrowth")
table(PlantGrowth$group)

# Summary stats
PlantGrowth %>%
  group_by(group) %>%
  get_summary_stats(weight, type = "full")

# Shapiro-Wilk normality test
PlantGrowth %>%
  group_by(group) %>%
  shapiro_test(weight)

# Levene’s test for equal variance
leveneTest(weight ~ group, data = PlantGrowth)

# One-way ANOVA
AOV.Plant <- aov(weight ~ group, data = PlantGrowth)
summary(AOV.Plant)
report(AOV.Plant)

# Boxplot
x11()
ggplot(data = PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot()

# Tukey’s HSD test using agricolae
HSD <- HSD.test(y = AOV.Plant, trt = "group")
print(HSD)
HSD.Results <- HSD$groups

# Plot group differences
x11()
bar.group(HSD.Results, ylim = c(0, 7), col = "lightblue", border = "red")

# Alternative: TukeyHSD base R
TukeyHSD(x = AOV.Plant, which = "group")

# --- Two-Way ANOVA Example ---

data("jobsatisfaction")
table(jobsatisfaction$gender, jobsatisfaction$education_level)

# Two-way ANOVA using aov()
Job.AOV <- aov(score ~ gender * education_level, data = jobsatisfaction)
summary(Job.AOV)

# Linear model and Type III ANOVA using car::Anova
Job.LM <- lm(score ~ gender * education_level, data = jobsatisfaction)
Anova(Job.LM, type = 3)

# Normality and homogeneity assumptions
qqPlot(Job.LM)
shapiro.test(resid(Job.LM))
leveneTest(Job.LM)

# Summary statistics by group
jobsatisfaction %>%
  group_by(gender, education_level) %>%
  get_summary_stats(score, type = "full")

# Post-hoc Tukey HSD test using agricolae (on aov model)
Job.AOV.HSD <- HSD.test(Job.AOV, trt = c("gender", "education_level"))
print(Job.AOV.HSD)

x11()
bar.group(Job.AOV.HSD$groups, ylim = c(0, 11), col = "#00EE76", border = "#FF4500")

# Alternative: HSD test on lm model
Job.LM.HSD <- HSD.test(Job.LM, trt = c("gender", "education_level"))
print(Job.LM.HSD)

x11()
bar.group(Job.LM.HSD$groups, ylim = c(0, 11), col = "pink", border = "blue",
          density = 30, angle = 90)
