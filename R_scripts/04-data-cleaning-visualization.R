
############################################################
# 📘 Session 4: Data Transformation, Cleaning, and Summarizing
############################################################

# This script is part of the R-learning-notes series.
# It covers essential data handling operations in R such as:
#
# 🔹 Importing and exploring datasets
# 🔹 Sorting and filtering rows using `arrange()` and `filter()`
# 🔹 Renaming and selecting columns
# 🔹 Creating new variables (e.g., log, sqrt transformations)
# 🔹 Conducting normality tests (Shapiro-Wilk)
# 🔹 Subsetting datasets
# 🔹 Exporting data to Excel
#
# 📦 Key packages used: `rio`, `tidyverse`, `rstatix`, `DataEditR`
# 📊 Datasets used: `trees`, `PlantGrowth`
#
# Each section of the code is modular and structured using
# RStudio-compatible section headers (#### ----) for easy navigation.

#### ---- 1. Set Working Directory and Load Packages ----
setwd("G:/دوره نرم افزار جنگل 2023/دوره R پیشرفته/R WorkShop/MyProject")

library(rio)
library(tidyverse)

#### ---- 2. Import Excel Data and Explore Structure ----
Data <- import("datasets.xlsx")

names(Data)
colnames(Data)
head(Data)
tail(Data)
dim(Data)
str(Data)

#### ---- 3. Load and Preview 'trees' Dataset ----
data(trees)
head(trees)

#### ---- 4. Basic Scatterplot with ggplot2 ----
x11()
ggplot(trees, aes(x = Girth, y = Volume)) +
  geom_point() +
  xlab("Diameter") +
  ylab("Volume (m3)")

#### ---- 5. Vector Operations and Pipe Examples ----
A <- 1:20
print(A)

B <- sqrt(A)
C <- sum(B)

1:20 %>% sqrt() %>% sum()
1:20 |> sqrt() |> sum()

#### ---- 6. Sorting a Numeric Vector ----
Test <- c(18, 15, 12, 19, 20, 10, 15, 11, 8, 7, 9, 20)
sort(Test)
sort(x = Test, decreasing = TRUE)

#### ---- 7. Sorting Rows with arrange() ----
head(trees, 15)

Trees2 <- trees %>% arrange(Height)
Trees3 <- trees %>% arrange(desc(Height))
Trees4 <- trees %>% arrange(desc(Height), desc(Volume))

#### ---- 8. Renaming Columns ----
names(trees)
trees <- trees %>% 
  rename(Ghotr = Girth,
         Ertefa = Height,
         Hajm = Volume)

names(trees)[1] <- "Diameter"
names(trees)

#### ---- 9. Manual Data Editing (GUI) ----
library(DataEditR)
trees <- data_edit(trees)

#### ---- 10. Shapiro-Wilk Normality Test ----
shapiro.test(trees$Diameter)
shapiro.test(trees$Height)
shapiro.test(trees$Volume)

trees$Volume.SQRT <- sqrt(trees$Volume)
shapiro.test(trees$Volume.SQRT)

#### ---- 11. Shapiro Test Using rstatix ----
install.packages("rstatix")
library(rstatix)

trees %>% shapiro_test(Volume.SQRT)

#### ---- 12. Log Transformation ----
trees <- trees %>% mutate(Volume.Log = log(Volume))

#### ---- 13. Subset Columns (Base and Tidyverse) ----
Tree1 <- trees[, 2:3]
Tree2 <- trees[, c(1, 3)]
Tree3 <- trees[, -c(4, 5)]

Tree4 <- trees %>% 
  dplyr::select(Diameter, Height)

#### ---- 14. Detach Conflicting Packages ----
library(pacman)
p_unload(dplyr)
p_unload(raster)
detach("package:dplyr", unload = TRUE)

#### ---- 15. Remove and Reorder Columns ----
trees <- trees %>% 
  dplyr::select(-Volume.SQRT)
trees$Volume.Log <- NULL

trees.New <- trees[, c(2, 1, 3)]

trees.New2 <- trees %>% 
  relocate(Diameter, .before = Height)

trees.New2 <- trees %>% 
  relocate(Height, .after = Volume)

#### ---- 16. Load and Explore PlantGrowth Dataset ----
data(PlantGrowth)
PlantGrowth
table(PlantGrowth$group)

export(PlantGrowth, "PlantGrowth.xlsx")

#### ---- 17. Filter Groups in Dataset ----
Control <- PlantGrowth %>% filter(group == "ctrl")
Non_Control <- PlantGrowth %>% filter(group != "ctrl")

Ctrl_Trt1 <- PlantGrowth %>% filter(group %in% c("ctrl", "trt1"))
Non_Ctrl_Trt1 <- PlantGrowth %>% filter(!group %in% c("ctrl", "trt1"))

#### ---- 18. Group-wise Statistical Summary ----
Stat.Summary <- PlantGrowth %>% 
  group_by(group) %>% 
  shapiro_test(weight)

Stat.Summary <- PlantGrowth %>% 
  group_by(group) %>% 
  get_summary_stats(weight, type = "full")
Stat.Summary
