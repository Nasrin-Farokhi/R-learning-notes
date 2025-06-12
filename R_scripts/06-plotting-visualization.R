#########################################################
# 📘 Session 6: Plotting, Coloring, and Font Customization in R
#########################################################

# This session includes:
# 🔹 Row selection using top_n(), slice_max(), slice_min()
# 🔹 Data frame combining: rbind, cbind, bind_rows, bind_cols
# 🔹 Joins: inner, left, right, full, anti
# 🔹 Basic and advanced plotting
# 🔹 Using RColorBrewer and colourpicker for colors
# 🔹 Font and label customization (including Persian fonts)
# 🔹 Boxplots and saving plots to file

#--------------------------------------------------------
# 📦 Load Required Libraries
#--------------------------------------------------------
library(rio)
library(tidyverse)

#--------------------------------------------------------
# 📌 Row Selection: top_n(), slice_max(), slice_min()
#--------------------------------------------------------
data("PlantGrowth")
names(PlantGrowth)

# Top 2 weights in each group
PlantGrowth %>%
  group_by(group) %>%
  top_n(n = 2, wt = weight)

# Examples with numeric vector
df <- data.frame(x = c(6, 4, 1, 10, 3, 1, 1))
df %>% top_n(2)        # Highest 2
df %>% top_n(-2)       # Lowest 2
df %>% slice_max(x, n = 2)
df %>% slice_min(x, n = 2)

# Using proportion
df %>% top_frac(.5)
df %>% slice_max(x, prop = 0.5)

#--------------------------------------------------------
# 📌 Combining Data Frames: rbind, cbind, bind_*
#--------------------------------------------------------
Data1 <- data.frame(A = c(1, 2, 3), B = c(4, 5, 6))
Data2 <- data.frame(A = c(6, 10, 20), B = c(500, 600, 800))
Data3 <- data.frame(C = c(10, 20, 30), D = c(40, 50, 60))

rbind(Data1, Data2)
cbind(Data1, Data3)

# Tidyverse methods
bind_rows(Data1, Data2)
bind_cols(Data1, Data3)

#--------------------------------------------------------
# 📌 Joining Data Frames: merge(), join()
#--------------------------------------------------------
D1 <- data.frame(ID = c(1, 2), X1 = c("A1", "A2"))
D2 <- data.frame(ID = c(2, 3), X2 = c("B1", "B2"))

merge(D1, D2, by = "ID", all = FALSE)  # Inner
merge(D1, D2, by = "ID", all = TRUE)   # Full

left_join(D1, D2, by = "ID")
right_join(D1, D2, by = "ID")
inner_join(D1, D2, by = "ID")
full_join(D1, D2, by = "ID")
anti_join(D1, D2, by = "ID")

#--------------------------------------------------------
# 📊 Basic Scatter Plots
#--------------------------------------------------------
data(trees)
head(trees)

plot(Volume ~ Girth, data = trees)
plot(trees$Volume, trees$Girth)
plot(y = trees$Volume, x = trees$Girth)

#--------------------------------------------------------
# ✏️ Different Plot Types
#--------------------------------------------------------
A <- c(20, 25, 40)
B <- c(15, 18, 30)
C <- c(30, 40, 50)

plot(A, B, type = "p")  # Points
plot(A, B, type = "l")  # Lines
plot(A, B, type = "b")  # Both
plot(A, B, type = "o")  # Overplotted
plot(A, B, type = "s")  # Step
plot(A, B, type = "h")  # Histogram-like
plot(A, B, type = "n")  # No plot

#--------------------------------------------------------
# 🖌 Customize Axis, Labels, Lines
#--------------------------------------------------------
plot(A, B, type = "l", ylim = c(0, 55))
lines(A, C)
plot(A, B, main = "Plot A vs. B", adj = 0.5)

plot(A, B, xlab = "Diameter", ylab = "Volume",
     col.lab = "#FF0000", col.axis = "#3300FF", cex.lab = 1.5)

#--------------------------------------------------------
# 🎨 Using Color Palettes
#--------------------------------------------------------
install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()

MyColors <- brewer.pal(n = 6, name = "Set1")
MyColors

#--------------------------------------------------------
# 🎨 Using colourpicker
#--------------------------------------------------------
install.packages("colourpicker")
library(colourpicker)

colourpicker::colourPicker()

#--------------------------------------------------------
# 🌈 Built-in Color Functions
#--------------------------------------------------------
topo.colors(5)
heat.colors(10)
rainbow(10)

#--------------------------------------------------------
# 🎯 Styled Plots with Custom Elements
#--------------------------------------------------------
plot(Volume ~ Girth, data = trees, pch = 16, col = "#FF0099", cex = 1)
plot(Volume ~ Girth, data = trees, xlab = "Diameter", ylab = "Hajm",
     col.lab = "#FF0000", col.axis = "#3300FF")

plot(Volume ~ Girth, data = trees,
     main = "The relationship between \n Volume and DBH",
     col = "#3300FF", xlab = "Diameter", ylab = "Volume",
     col.lab = "#FF0000", col.axis = "#33FF00", cex.lab = 1.25,
     font.main = 4, font.lab = 2, family = "serif")

#--------------------------------------------------------
# 🆎 Using Persian Fonts (extrafont)
#--------------------------------------------------------
install.packages('extrafont')
library(extrafont)
# font_import()       # Uncomment if first time
# loadfonts(device = "win", quiet = TRUE)

plot(Volume ~ Girth, data = trees,
     xlab = "قطر درخت", ylab = "حجم درخت",
     main = "رابطه بین حجم و قطر درخت",
     family = "B Nazanin")

#--------------------------------------------------------
# 📦 Boxplots
#--------------------------------------------------------
boxplot(trees$Girth, ylab = "Diameter", col = "red")
boxplot(trees$Girth, col = "pink", border = "blue", horizontal = TRUE)

boxplot(weight ~ group, data = PlantGrowth,
        col = c("#00EE00", "#FFD700", "#FF69B4"),
        border = "blue", col.lab = "#FF0000", col.axis = "#CC00FF")

#--------------------------------------------------------
# 💾 Save Plot to File (PNG)
#--------------------------------------------------------
setwd("G:/دوره نرم افزار جنگل 2023/دوره R پیشرفته/R WorkShop/session8")

png("Boxplot.png", width = 20, height = 15, units = "cm", res = 600)
Box.Col <- c("#FF4040", "#A2CD5A", "#E066FF")
plot(weight ~ group, data = PlantGrowth, col = Box.Col)
dev.off()



