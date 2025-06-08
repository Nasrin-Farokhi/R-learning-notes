############################################################
# 📌 Session 3: Data Importing, Cleaning, and Subsetting
############################################################
#
# This script demonstrates essential techniques for handling data in R,
# including:
# - Recognizing missing values and reserved keywords (e.g., NA, NULL)
# - Importing datasets from various formats (TXT, CSV, Excel, SAV, clipboard)
# - Exploring and cleaning data: structure, column names, data types
# - Subsetting data using conditions and logical operators
# - Creating new variables and removing unwanted ones
# - Exporting cleaned datasets to multiple formats
#
# The session uses real-world datasets (e.g., Iris, mtcars)
# and packages such as `rio`, `readxl`, and `psych` for practical hands-on learning.
#
# This file is part of the "R-learning-notes" repository and supports the
# journey of mastering environmental data analysis through structured practice.
#
# Designed to build strong foundations for data-driven research in environmental and forest sciences.
###############################################################################


# 🔸 Handling Missing Values & Reserved Keywords ------------------------------

# These keywords are used to represent missing or undefined data
NA
na
NULL
Missing

# Reference: Stat/Transfer (for converting file types)


# 🔸 Loading Required Packages ------------------------------------------------

library(rio)  # For importing and exporting various data formats

# List all current objects in memory
ls()
objects()

# Copy and remove objects
Iris.Final2 <- Iris.Final
rm(Iris.Final)
Iris.Final3 <- Iris.Final2
Iris.Final4 <- Iris.Final2
rm(Iris.Final3, Iris.Final4)


# 🔸 Working Directory Setup --------------------------------------------------

getwd()  # Get current working directory
setwd("G:/دوره نرم افزار جنگل 2023/دوره R پیشرفته/R WorkShop/MyProject")  # Set new working directory
list.files()  # List files in current directory


# 🔸 Importing Data Using rio -------------------------------------------------

Iris <- import("Iris.Final.xlsx")
rm(Iris)

Data <- import("datasets.xlsx")
Data <- import("datasets.xlsx", which = 1:4)

# Check sheet names in Excel file
install.packages("readxl")
library(readxl)
readxl::excel_sheets("datasets.xlsx")

# Import each sheet by name
Data1 <- import("datasets.xlsx", which = "iris")
Data2 <- import("datasets.xlsx", which = "mtcars")
Data3 <- import("datasets.xlsx", which = "chickwts")
Data4 <- import("datasets.xlsx", which = "quakes")

# Export multiple dataframes to a single Excel file
export(list(Iris = Data1, MATCARS = Data2), file = "Data.xlsx")


# 🔸 Importing Different File Formats -----------------------------------------

Data5 <- import("Iris.Final.sav")
Test <- import("test.txt")
Copy <- import("clipboard")

# Handle missing values during import
New_Data <- import("datasets2.xlsx", which = 1)
str(New_Data)

New_Data <- import("datasets2.xlsx", which = 1, na= c("NA", "na", "NULL", "Missing", "missing"))
str(New_Data)

# Import from URL (demo placeholder)
URL.Data <- import("www.example.com/URL.xlsx")

# Import CSV with semicolon separator
Tree <- import("matcars.csv", sep= ";")

# Import with specific cell range and NA handling
New_Data <- import("datasets2.xlsx",
                   which = 1,
                   na= c("NA", "na", "NULL", "Missing", "missing"),
                   range= "A1:E26")


# 🔸 Exporting Data -----------------------------------------------------------

getwd()
export(New_Data, "New_Data.sav")
export(New_Data, "New_Data.txt")
export(New_Data, "New_Data.csv")
export(New_Data, "New_Data.xlsx")

convert(in_file = "New_Data.sav", out_file = "testtt.txt")


# 🔸 Working with Lists of Data Frames ----------------------------------------

Dataset <- import_list("datasets.xlsx")
names(Dataset)
Dataset$mtcars


# 🔸 Data Structure and Summary -----------------------------------------------

names(Data4)
colnames(Data4)
str(Data4)

Test3 <- import("test3.txt")
Test3$Sepal.Length <- as.numeric(Test3$Sepal.Length)
str(Test3)

head(Data4)
tail(Data4)
head(Data4, n = 10)
tail(Data4, 3)

# Using psych package for combined view
pak::pak("psych")
library(psych)
headTail(Data4)
headTail(Data4, top = 10, bottom = 6)


# 🔸 Accessing and Manipulating Variables -------------------------------------

dim(Data4)
str(Data4)

names(Data4)
Data4$mag <- NULL  # Remove a column

# Create a new derived column
Data4$SQRT.Depth <- sqrt(Data4$depth)
head(Data4)

# Various ways to access columns
Data4[, 3]
Data4$depth
Data4[, "depth"]

# attach/detach to access variables directly
attach(Data4)
depth
mean(depth)
detach(Data4)


# 🔸 Subsetting and Filtering Data --------------------------------------------

# Using built-in 'trees' dataset
data("trees")
head(trees)
x11()
plot(Volume ~ Girth, data = trees)

# Subsetting examples using the iris dataset
names(Data1)
head(Data1)

Iris.Subset <- subset(Data1, Sepal.Length > 5)
Irris.Subset <- subset(Data1, Sepal.Length > 5 & Sepal.Width > 3.5)

# Class-based subsetting
table(Data1$Species)
Versicolor <- subset(Data1, Species == "versicolor")
Non_Versicolor <- subset(Data1, Species != "versicolor")
table(Non_Versicolor$Species)

Versicolor2 <- subset(Data1,
                      Sepal.Length > 6 & Species == "versicolor",
                      select = c(Sepal.Length, Species))
