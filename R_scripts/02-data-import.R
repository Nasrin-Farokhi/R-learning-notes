##################################################
# 📊 Session 2: Data Structures & Importing Files
##################################################

# 🔹 Numeric vector
Stat.Score <- c(12, 20, 15, 18)
Stat.Score
print(Stat.Score)
length(Stat.Score)
Stat.Score[2]

# 🔹 Sequence and matrix
Data <- 1:20
Data
length(Data)
Data.Mat <- matrix(Data, ncol = 5)
Data.Mat
Data.Mat <- matrix(Data, ncol = 5, byrow = TRUE)
Data.Mat

# 🔹 Custom matrix from breakpoints
Mat <- c(0, 500, 1,
         500, 1000, 2,
         1000, 1500, 3,
         1500, 2500, 4)
Mat.Rec <- matrix(Mat, ncol = 3, byrow = TRUE)
Mat.Rec

# 🔹 Named matrix
mdat <- matrix(c(1, 2, 3, 11, 12, 13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3")))
mdat
dim(Mat.Rec)
Mat.Rec[1,]
Mat.Rec[2,]
Mat.Rec[,1]
Mat.Rec[,2]
Mat.Rec[1,3]
Mat.Rec[3,2]
Mat.Rec[,4]

# 🔹 Data Frame basics
Stat.Score <- c(12, 20, 15, 18)
Name <- c("A", "B", "C", "D")
Presence <- c(TRUE, TRUE, TRUE, TRUE)
DF <- data.frame(Name, Stat.Score, Presence)
DF <- data.frame(Name, Stat = Stat.Score, Presence)
class(DF)

# 🔹 Convert matrix to data.frame and back
mdat.DF <- as.data.frame(mdat)
class(mdat.DF)
mdat.Mat <- as.matrix(mdat.DF)
class(mdat.Mat)

# 🔹 Convert to tibble
library(tidyverse)
Data3 <- data.frame(x = 1:3, y = 4:6, z = 7:9)
Data3.TB <- as_tibble(Data3)
Data3.TB
class(Data3.TB)
dim(Data3.TB)
Data3.TB[,3]
Data3.TB[,1]
Data3.TB[1,1]

# 🔹 Create and edit empty data frame
Data4 <- edit(as.data.frame(NULL))
fix(Data4)

# 🔹 Interactive data editor
library(usethis)
library(devtools)
install_github("DillonHammill/DataEditR")
devtools::install_github("DillonHammill/rhandsontable")
library(DataEditR)

Data5 <- data_edit(c(10, 2))
Data6 <- data_edit(Data5, viewer = "dialog")
Data6 <- data_edit(Data6, viewer = "browser")
Data7 <- data_edit(DF)

# 🔹 File Import
choose.files()
Iris <- read.table("G:\دوره نرم افزار جنگل 2023\دوره R پیشرفته\R WorkShop\MyProject\Iris.txt",
                   header = TRUE,
                   sep = "\t")
Iris

getwd()
setwd("G:/دوره نرم افزار جنگل 2023/دوره R پیشرفته/R WorkShop/MyProject")
Iris2 <- read.table("Iris.txt", header = TRUE, sep = "\t")


# 🔹 Read CSV with specific separator and decimal
MTCARS <- read.table("MyProject/matcars.csv",
                     header = TRUE,
                     sep = ",",
                     dec = ".")
MTCARS2 <- read.csv("matcars.csv", header = TRUE)

# 🔹 Import/export with rio
library(rio)
Iris.Final <- import("Iris.txt")
export(Iris.Final, "Iris.Final.xlsx")
export(Iris.Final, "Iris.Final.sav")

# 🔹 Environment info
sessionInfo()
