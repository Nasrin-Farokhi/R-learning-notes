###########################################################
# 📊 Session 7: Advanced Plotting and Customization in R
###########################################################

# This session covers:
# ▶ Scatter plots using base R and ggplot2
# ▶ Boxplots with advanced fill and outline styles
# ▶ Custom color palettes (manual and RColorBrewer)
# ▶ Bar plots and point plots with annotations
# ▶ Themes, fonts, legends, and label styling

# ---------------------------------------------------------
# 📂 Load Required Libraries
# ---------------------------------------------------------
library(tidyverse)
library(RColorBrewer)

# ---------------------------------------------------------
# 🌳 Scatter Plots with trees dataset
# ---------------------------------------------------------
data(trees)
names(trees)

# Basic ggplot
MyGraph <- ggplot(trees, aes(x = Girth, y = Volume))
x11(); print(MyGraph)

# Scatter with red points
MyGraph <- MyGraph +
  geom_point(color = "red", shape = 16, size = 3)
x11(); print(MyGraph)

# Add title and axis labels
MyGraph <- ggplot(trees, aes(x = Girth, y = Volume)) +
  geom_point(color = "red", shape = 16, size = 1.25) +
  ggtitle("The relationship") +
  xlab("Diameter") +
  ylab("Volume (m3)")
x11(); print(MyGraph)

# ---------------------------------------------------------
# 📊 Boxplots with PlantGrowth dataset
# ---------------------------------------------------------
data("PlantGrowth")
head(PlantGrowth)

# Base R boxplot
x11()
boxplot(weight ~ group, data = PlantGrowth,
        col = c("#BCEE68", "#EEAEEE", "#B0E2FF"))

# ggplot boxplot with title
My_Boxplot <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot() +
  labs(title = "The boxplot for Plant Growth Data",
       x = "Treatment", y = "Weight (kg)")
x11(); print(My_Boxplot)

# Flipped boxplot
x11()
print(My_Boxplot + coord_flip())

# Notched + outlier styling
My_Boxplot <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot(outlier.color = "red", notch = TRUE)
x11(); print(My_Boxplot)

# Fill with manual colors
My_Boxplot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot() +
  scale_fill_manual(values = c("#76EE00", "#FF0000", "#FFFF00"))
x11(); print(My_Boxplot)

# ---------------------------------------------------------
# 🎨 Using RColorBrewer palettes
# ---------------------------------------------------------
display.brewer.all()

My_Boxplot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Set1")
x11(); print(My_Boxplot)

# Legend formatting
My_Boxplot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot() +
  scale_x_discrete(limits = c("trt2", "ctrl", "trt1")) +
  scale_fill_discrete(name = "Treatment", labels = c("Control", "Treatment1", "Treatment2")) +
  theme(legend.position = c(1,1),
        legend.justification = c(1,1),
        legend.title = element_text(color = "red"))
x11(); print(My_Boxplot)

# Theme variations
x11(); print(My_Boxplot + theme_classic())
x11(); print(My_Boxplot + theme_dark())
x11(); print(My_Boxplot + theme_void())

# ---------------------------------------------------------
# 📊 Bar Charts with Tree data
# ---------------------------------------------------------
Tree <- data.frame(
  Species = c("Quercus_castaneifolia", "Tilia_begonifilia", "Ptrecaria fraxinifolia"),
  DBH = c(75, 80, 70),
  Height = c(30, 25, 15),
  Status = c("Alive", "Dead", "Broken")
)

My_Colors <- c("#76EEC6", "#BCEE68", "#FFAEB9")

My_Graph_Bar <- ggplot(Tree, aes(x = Species, y = DBH, fill = Species)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(values = My_Colors) +
  theme(axis.text.x = element_text(angle = 45, color = "red"),
        axis.text.y = element_text(color = "blue"),
        plot.title = element_text(color = "red", size = 14, face = "bold.italic", hjust = 0.5)) +
  ggtitle("Species and DBH")
x11(); print(My_Graph_Bar)

# ---------------------------------------------------------
# 🎫 Point Plot with Text Labels
# ---------------------------------------------------------
My_Graph_Point <- ggplot(Tree, aes(x = Species, y = DBH)) +
  geom_point(color = "red", shape = 16, size = 2) +
  geom_label(aes(label = Status), color = "blue", hjust = 1, vjust = -1)
x11(); print(My_Graph_Point)
