###############################################################
# 📊 Session 9: Descriptive Statistics and Date Handling in R
###############################################################

# ▶️ This session covers:
# - Importing Excel datasets using rio
# - Descriptive statistics: mean, median, range, IQR, variance, etc.
# - Using stat.desc() from pastecs for extended stats
# - Converting character to date formats
# - Extracting year and month from date
# - Grouped summaries with dplyr and rstatix
# - Working with mode and frequency tables

# 📁 Set working directory
setwd("G:/دوره نرم افزار جنگل 2023/دوره R پیشرفته/R WorkShop/session11")

# 📦 Load required packages
library(rio)
library(tidyverse)
library(rstatix)
install.packages("lsr")  # install once
library(lsr)

# 📥 Import dataset
Climate <- import("IRIMO_Data_2017.xlsx")

# 🧾 Explore dataset structure
names(Climate)
head(Climate)
str(Climate)
dim(Climate)

# 🔁 Rename columns for clarity
Climate <- Climate %>% rename(Temp_Max = tmax)

# 📈 Basic statistics
length(Climate$Temp_Max)
min(Climate$Temp_Max)
max(Climate$Temp_Max)
mean(Climate$Temp_Max)
median(Climate$Temp_Max)
range(Climate$Temp_Max)
quantile(Climate$Temp_Max)
IQR(Climate$Temp_Max)
var(Climate$Temp_Max)
sd(Climate$Temp_Max)

# 🧮 Coefficient of Variation (CV)
(6.431992 / 25.267) * 100  # Example manually calculated CV

# 📋 Summary and five-number summary
summary(Climate$Temp_Max)
fivenum(Climate$Temp_Max)

# 📊 Descriptive statistics using pastecs
library(pastecs)
Climate.Stat <- stat.desc(Climate)
options(scipen = 999)  # disable scientific notation
Climate.Stat <- round(Climate.Stat, digits = 2)

# 🗃 Row names to column and back
Climate.Stat <- Climate.Stat %>% rownames_to_column("Parameter")
Climate.Stat <- Climate.Stat %>% column_to_rownames("Parameter")

# 📤 Export stats to Excel
export(Climate.Stat, "Climate.Stat.xlsx")

# 🧠 Psych and rstatix summary
library(psych)
describe(Climate)
Climate %>% get_summary_stats(type = "common")
Climate %>% get_summary_stats(type = "full")

# 🧮 Aggregation with summarise
Climate %>% summarise(Mean_Temp_Max = mean(Temp_Max),
                      SD_Temp = sd(Temp_Max),
                      Median_Temp = median(Temp_Max))

# 📅 Convert character to date
Climate$Date <- as.character(Climate$date)
Climate$Date <- ymd(Climate$Date)
Climate$Year <- year(Climate$Date)
Climate$Month <- month(Climate$Date, label = TRUE, abbr = FALSE)

# 📆 Grouped summaries by time
by(Climate$Temp_Max, Climate$Month, mean)
aggregate(Temp_Max ~ Month, data = Climate, mean)

# 🌍 Grouped summaries by region
Climate %>% group_by(region_name) %>% get_summary_stats(Temp_Max, type = "full")
Climate %>% group_by(region_name, Month) %>% summarise(Mean_Temp = mean(Temp_Max, na.rm = TRUE))

# 📌 Mode of temperature
table(Climate$Temp_Max)
lsr::modeOf(Climate$Temp_Max)
