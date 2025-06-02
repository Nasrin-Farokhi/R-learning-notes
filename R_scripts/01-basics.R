#############################################################
# 📦 Section 1: Install and Load Packages
#############################################################

# Update all installed packages (without asking confirmation)
update.packages(ask = FALSE)

# Check available CRAN packages
dim(available.packages())

# Install spatial and statistical packages
install.packages("terra")
install.packages("terra", dependencies = TRUE)
install.packages("terra", repos = "https://rspatial.r-universe.dev")
install.packages(c("terra", "raster", "rio", "rstatix"))

# Load main packages
library(terra)
library(raster)

# Install and load with pak and pacman
install.packages("pak")
library(pak)
pak("rio")

install.packages("pacman")
library(pacman)
p_load(car)
library(car)

# Install from GitHub
library(devtools)
install_github("rspatial/terra")
library(remotes)
remotes::install_github("tidyverse/tidyverse")

# Load tidyverse and check select function
library(tidyverse)
dplyr::select()
raster::select()

# Help command for function
?select


#############################################################
# 📊 Section 2: Explore Built-in Datasets
#############################################################

data("trees")
data("PlantGrowth")
data("airquality")
data("iris")

?trees  # Help documentation

#############################################################
# 📁 Section 3: Import Excel Data (Persian Path Example)
#############################################################

# Install file format support for rio
library(rio)
install_formats()

# Import using Persian path (handles both styles)
Data <- import("G:\\دوره نرم افزار جنگل 2023\\دوره R پیشرفته\\4\\4\\datasets.xlsx")
Data2 <- import("G:/دوره نرم افزار جنگل 2023/دوره R پیشرفته/4/4/datasets.xlsx")

# Optional file chooser (opens file dialog)
choose.files()

#############################################################
# 🧮 Section 4: Vector Basics
#############################################################

# Numeric vector
Stat.Score <- c(20, 15, 18, 20, 20, 12)
print(Stat.Score)

# Character vector
Name <- c("A", "B", "C", "D", "E", "F")
print(Name)

# Logical vector
Presence <- c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE)
print(Presence)

# Repetition and sequence functions
rep("A", 5)
seq(from = 0, to = 20, by = 2)
seq(from = 0, to = 20, length = 5)
seq(from = 0, to = 20, length = 12)
seq(0, 10, 3)

# Vector indexing
length(Stat.Score)
Stat.Score[3]
Stat.Score[6]
Stat.Score[2:4]
1:10

#############################################################
# ✍️ Section 5: Naming Conventions
#############################################################

# Common naming styles in R
# camelCase    → e.g., myVariable
# PascalCase   → e.g., MyVariable
# snake_case   → e.g., my_variable

