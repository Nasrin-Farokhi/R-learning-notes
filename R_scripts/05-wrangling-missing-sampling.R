############################################################
# 📘 Session 5: Data Wrangling, Summarization, and NA Handling in R
############################################################

# This script continues from previous sessions and includes:
# 🔹 Reading Excel datasets and handling tibbles/dataframes
# 🔹 Selecting, arranging, and filtering data
# 🔹 Summarizing and grouping using dplyr
# 🔹 Handling missing data (NA detection, removal, replacement)
# 🔹 Sampling rows with slice, sample_n, and sample_frac
# 🔹 Creating new variables using mutate, recode, case_when, and cut
# 🔹 Working with Shapiro-Wilk test for normality
# 📦 Required libraries: rio, tidyverse, rstatix, psych

#### ---- 1. Load Required Libraries ----
library(rio)
library(tidyverse)
library(rstatix)
library(psych)
Select <- dplyr::select  # To avoid conflicts with base::select

#### ---- 2. Set Working Directory and Import Dataset ----
getwd()
setwd("G:/دوره نرم افزار جنگل 2023/دوره R پیشرفته/R WorkShop/MyProject")
Data <- import("Synoptic_Data.xlsx")

#### ---- 3. Explore Dataset ----
head(Data)
tail(Data)
headTail(Data)
names(Data)

#### ---- 4. Convert Between Tibble and Data Frame ----
Data_T <- as.tibble(Data)
class(Data)
class(Data_T)

print(Data_T, n = 15)
Data <- as.data.frame(Data_T)
class(Data)

#### ---- 5. Column Selection ----
Data %>% select(lat:January_TMin)
Data %>% Select(lat:January_TMin)

#### ---- 6. Row Name Operations and Filtering Unique Coordinates ----
names(Data)
row.names(Data)
head(Data)
Data <- Data %>% column_to_rownames(var = "station_name")

dim(Data)
Data_New <- Data %>% distinct(lat, lon, .keep_all = FALSE)
dim(Data_New)

Data_New <- Data %>% distinct(lat, lon, .keep_all = TRUE)
head(Data_New)

#### ---- 7. Column Selection and Reordering ----
Data2 <- Data %>% select(station_name, region_nam, lat:January_Prec)
head(Data2)

Data_New <- Data_New %>% column_to_rownames(var = "station_name")
Data_New <- Data_New %>% rownames_to_column(var = "station_name")

#### ---- 8. Grouping and Sorting ----
Data2 <- Data_New %>%
  column_to_rownames(var = "station_name") %>%
  Select(region_nam, lat:January_Prec) %>%
  rename(Province = region_nam, Longitude = lon, Latitude = lat) %>%
  group_by(Province) %>%
  arrange(Province, January_Prec)

print(Data2, n = 20)

Data2 <- Data_New %>%
  column_to_rownames(var = "station_name") %>%
  Select(region_nam, lat:January_Prec) %>%
  rename(Province = region_nam, Longitude = lon, Latitude = lat) %>%
  group_by(Province) %>%
  arrange(Province, January_Prec) %>%
  slice_max(order_by = January_Prec, n = 3)

#### ---- 9. Grouped Sorting by Multiple Variables ----
Data3 <- Data_New %>%
  Select(station_name, region_nam, lat:January_Prec) %>%
  rename(Province = region_nam, Longitude = lon, Latitude = lat) %>%
  group_by(Province, station_name) %>%
  arrange(Province, January_Prec)

#### ---- 10. Summary Statistics and Normality Testing ----
data(PlantGrowth)
PlantGrowth %>% group_by(group) %>% summarise(mean = mean(weight))
PlantGrowth %>% summarise(mean = mean(weight))
PlantGrowth %>% group_by(group) %>% shapiro_test(weight)

#### ---- 11. Working with ToothGrowth Dataset ----
data("ToothGrowth")
head(ToothGrowth)
str(ToothGrowth)
levels(ToothGrowth$supp)
ToothGrowth$dose <- as.factor(ToothGrowth$dose)

ToothGrowth %>% group_by(supp) %>% summarise(Mean = mean(len))
ToothGrowth %>% group_by(supp, dose) %>% summarise(Mean = mean(len))
ToothGrowth %>% group_by(supp, dose) %>% summarise(frequency = n())
ToothGrowth %>% group_by(supp) %>% summarise(frequency = n())

#### ---- 12. Row Sampling Techniques ----
slice(PlantGrowth, 2)
slice(PlantGrowth, c(2, 4, 6))
slice_head(PlantGrowth, n = 4)
slice_tail(ToothGrowth, n = 4)

#### ---- 13. Filtering with slice_min and slice_max ----
slice_min(Data_New, order_by = January_Prec, n = 3)
slice_max(Data_New, order_by = January_Prec, n = 5)

Data_New %>% group_by(region_nam) %>% slice_max(order_by = January_Prec, n = 5)
Data_New %>% group_by(region_nam) %>% arrange(January_Prec) %>% slice(1:2)

#### ---- 14. Random Sampling ----
PlantGrowth %>% sample_n(size = 5)
PlantGrowth %>% group_by(group) %>% sample_n(size = 3)
Frac <- PlantGrowth %>% group_by(group) %>% sample_frac(size = 0.5)

#### ---- 15. Handling Missing Values ----
Rainfall <- c(120, 80, 120, 85, NA, NA, 200, 180, 220, 145, NA)
mean(Rainfall)
mean(Rainfall, na.rm = TRUE)
is.na(Rainfall)
sum(is.na(Rainfall))
which(is.na(Rainfall))
!is.na(Rainfall)

#### ---- 16. Import Dataset with NA Values ----
Data_NA <- import("datasets2.xlsx", na = c("NA", "na", "Missing", "missing"))
summary(Data_NA)
mean(Data_NA$Sepal.Length, na.rm = TRUE)

#### ---- 17. NA Removal and Filtering ----
Data_NA <- na.omit(Data_NA)
Data_NA <- Data_NA %>% na.omit()

Data_NA <- import("datasets2.xlsx", na = c("NA", "na", "missing", "Missing"))
Data_NA <- Data_NA %>% filter(is.na(Petal.Length))
Data_NA <- Data_NA %>% filter(!is.na(Petal.Length))

#### ---- 18. Replace NA with Constant ----
Data_NA2 <- Data_NA %>% mutate(Sepal.Length2 = replace_na(Sepal.Length, 5.858))
summary(Data_NA2)

#### ---- 19. Variable Recoding and Classification ----
Test <- data.frame(ID = 1:3, Class = c("A", "B", "C"), Score = c(20, 15, 10))

Test <- Test %>% mutate(Class_Recode = recode(Class,
                                              "A" = "Class A",
                                              "B" = "Class B",
                                              "C" = "Class C"))

Test <- Test %>% mutate(Class_Recode2 = case_when(
  Class == "A" ~ "Class A",
  Class == "B" ~ "Class B",
  Class == "C" ~ "Class C"))

#### ---- 20. Categorizing Elevation Data ----
Data_New <- Data_New %>%
  rename(Altitude = station_elevation) %>%
  mutate(Alt_Class = case_when(
    Altitude >= -25 & Altitude < 500 ~ "Low_Land",
    Altitude >= 500 & Altitude < 1500 ~ "Mid_Land",
    Altitude >= 1500 & Altitude < 2200 ~ "High_Land"))

Data_New <- Data_New %>% mutate(Alt_Class2 = if_else(Altitude > 1500, "High_Land", "Low_Land"))

Data_New$Alt_Class3 <- cut(Data_New$Altitude,
                           breaks = c(-25, 1000, 2000, 2500),
                           labels = c("AAA", "BBB", "CCC"))
