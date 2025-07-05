##############################################################
# 📊 Session 8: Advanced Boxplots, Patterns, and Scatterplots
##############################################################

# ▶ This session covers:
#   - Basic and advanced boxplots using `ggplot2` and `ggpattern`
#   - Custom pattern styles and themes for grouping variables
#   - Labeling and customizing factor levels
#   - Bar plots with pattern fills
#   - Exporting ggplot objects to PNG and PowerPoint
#   - Using `cowplot`, `gridExtra`, and `patchwork` for multiple plots
#   - Enhancing scatterplots with smoothing lines and themes
#   - Histogram customization with grouping
#   - Adding regression equation and R² to ggplot

# 📦 Load and inspect dataset
data("PlantGrowth")
head(PlantGrowth)

# 📚 Load required libraries
library(ggplot2)
library(tidyverse)

# 📊 Basic boxplot
ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot(fill = "red", alpha = 0.3)

# 📊 Boxplot with group fill
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot()

# 📦 Install required packages
install.packages("ggpattern", dependencies = TRUE)
install.packages("gridExtra")
library(ggpattern)

# 🎨 Boxplot with pattern
x11()
ggplot(data = PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot_pattern()

# 🖌️ Custom pattern and color
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot_pattern(fill = "red", color = "blue")

# 🔲 Pattern transparency and colors
x11()
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot_pattern(pattern_fill = "black",
                       pattern_color = "white",
                       alpha = 0.5,
                       pattern_alpha = 0.5)

# 🔁 Pattern aesthetics by group
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot_pattern(aes(pattern = group),
                       pattern_fill = "#d3d3d3",
                       pattern_color = "blue",
                       alpha = 0.5,
                       pattern_alpha = 0.8)

# ↩️ Add angle
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot_pattern(aes(pattern = group, pattern_angle = group),
                       pattern_fill = "#d3d3d3",
                       pattern_color = "blue",
                       alpha = 0.5,
                       pattern_alpha = 0.8)

# ↕️ Add spacing
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
  geom_boxplot_pattern(aes(pattern = group, pattern_angle = group, pattern_spacing = group),
                       pattern_fill = "#d3d3d3",
                       pattern_color = "blue",
                       alpha = 0.5,
                       pattern_alpha = 0.8)

# 🧬 Factor relabeling
PlantGrowth$Group <- factor(PlantGrowth$group,
                            levels = c("ctrl", "trt1", "trt2"),
                            labels = c("Control", "Treatment1", "Treatment2"))

# 🎨 Final boxplot with relabeled group
x11()
ggplot(PlantGrowth, aes(x = Group, y = weight, fill = Group)) +
  geom_boxplot_pattern(aes(pattern = Group, pattern_angle = Group, pattern_spacing = Group),
                       pattern_fill = "#d3d3d3",
                       pattern_color = "blue",
                       pattern_alpha = 0.8,
                       alpha = 0.5)

# 📈 Summary statistics
library(rstatix)
PlantGrowth.Stat <- PlantGrowth %>%
  group_by(Group) %>%
  get_summary_stats(type = "common")

# 📊 Bar plot with summary stats
x11()
Bar_Plot_With_Pattern <- ggplot(PlantGrowth.Stat, aes(x = Group, y = mean, fill = Group)) +
  geom_col_pattern(aes(pattern = Group))
print(Bar_Plot_With_Pattern)

# 💾 Save as PNG
setwd("G:/دوره نرم افزار جنگل 2023/دوره R پیشرفته/R WorkShop/session10")
png("Bar_Plot_With_Patter.png", width = 20, height = 20, units = "cm", res = 600)
print(Bar_Plot_With_Pattern)
dev.off()

# 💾 Save to PowerPoint
install.packages("export")
library(export)
devtools::install_github("tomwenseleers/export")
graph2ppt(x = Bar_Plot_With_Pattern, file = "Thesis_Graphs.pptx")

# 🧱 Combine plots (cowplot)
library(cowplot)
BoxPlot_With_Pattern <- ggplot(PlantGrowth, aes(x = Group, y = weight, fill = Group)) +
  geom_boxplot_pattern(aes(pattern = Group, pattern_angle = Group, pattern_spacing = Group),
                       pattern_fill = "#d3d3d3",
                       pattern_color = "blue",
                       pattern_alpha = 0.8,
                       alpha = 0.5)

plot_grid(Bar_Plot_With_Pattern, BoxPlot_With_Pattern, labels = c("A", "B"), label_size = 12)

# ➕ Combine plots (patchwork)
library(patchwork)
Bar_Plot_With_Pattern + BoxPlot_With_Pattern

Bar_Plot_With_Pattern / BoxPlot_With_Pattern

(Bar_Plot_With_Pattern + BoxPlot_With_Pattern) / Bar_Plot_With_Pattern

# 🎨 Theme variations
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) + geom_boxplot() + theme_bw()
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) + geom_boxplot() + theme_classic()
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) + geom_boxplot() + theme_light()
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) + geom_boxplot() + theme_void()

install.packages("ggthemes")
library(ggthemes)
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) + geom_boxplot() + theme_wsj()
ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) + geom_boxplot() + theme_gdocs()

# 🌲 Scatterplots
data(trees)
Scatterplot <- ggplot(trees, aes(x = Girth, y = Volume)) +
  geom_point(color = "red", size = 3, shape = 21, fill = "blue", alpha = 0.3) +
  scale_x_continuous(limits = c(5, 25), breaks = seq(5, 25, 3)) +
  scale_y_continuous(limits = c(0, 85), breaks = seq(0, 85, 5))
Scatterplot

# ➕ Regression line
ggplot(trees, aes(x = Girth, y = Volume)) +
  geom_point(color = "red", size = 3, shape = 21, fill = "blue", alpha = 0.3) +
  geom_smooth(method = "lm", fill = "red", alpha = 0.2, se = FALSE, linetype = 1, linewidth = 3)

# 📍 Mean with error bar
ggplot(PlantGrowth, aes(x = Group, y = weight)) +
  stat_summary(fun = "mean", geom = "point", color = "red", size = 2) +
  stat_summary(fun.data = "mean_se", geom = "errorbar", color = "blue", width = 0.2)

# 📐 Correlation and regression line with ggpubr
install.packages("ggpubr", type = "source")
library(ggpubr)
ggscatter(trees, x = "Girth", y = "Volume", add = "reg.line") +
  stat_cor(label.x = 12, label.y = 55) +
  stat_regline_equation(label.x = 12, label.y = 60)

# ➕ Equation label
eq <- function(x,y) {
  m <- lm(y ~ x)
  as.character(
    as.expression(
      substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2,
                 list(a = format(coef(m)[1], digits = 4),
                      b = format(coef(m)[2], digits = 4),
                      r2 = format(summary(m)$r.squared, digits = 3)))
    )
  )
}

ggplot(trees, aes(x = Girth, y = Volume)) +
  geom_point() +
  geom_smooth(method = "lm", se=FALSE) +
  geom_text(x = 15, y = 60, label = eq(trees$Volume,trees$Girth), parse = TRUE)
