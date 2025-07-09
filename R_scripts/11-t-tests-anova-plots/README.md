# 📊 Session 11: One-way and Two-way ANOVA with Visualization

This session focuses on performing one-way and two-way ANOVA (Analysis of Variance), validating assumptions, and visualizing group differences using post-hoc comparisons and residual diagnostics.

---

## 📌 1. `geom_boxplot`

A **boxplot** comparing weight between two groups (`F`, `M`) using `ggplot2`.

- Shows medians, interquartile ranges, and outliers
- Useful for visually checking distribution and spread

📎 `geom_boxplot.png`

---

## 📌 2. `geom_boxplot_PlantGrowth`

Boxplot of **PlantGrowth** dataset using `ggplot2`, comparing three treatment groups.

- Helps visualize distribution and detect any outliers
- Often used before running ANOVA

📎 `geom_boxplot_PlantGrowth.png`
---

## 📌 3. `bar.group(HSD.Results)`

A bar chart of group means from a **one-way ANOVA** (PlantGrowth dataset) followed by **Tukey HSD post-hoc** test.

- Bars represent treatment groups (`ctrl`, `trt1`, `trt2`)
- Letters (a, ab, b) indicate significance groupings (groups sharing letters are not significantly different)

📎 `bar.group(HSD.Results).png`

---

## 📌 4. `qqPlot(Job.LM)`

Q-Q plot for **checking normality of residuals** from the linear model `Job.LM`.

- If residuals lie along the line, the normality assumption is satisfied

📎 `qqPlot(Job.LM).png`

---

## 📌 5. `bar.group(Job.AOV.HSD$groups)`

Bar chart from a **two-way ANOVA** (`gender * education_level`) showing post-hoc group differences.

- Groups like `male:university`, `female:college`, etc.
- Letters show group significance based on **Tukey HSD**

📎 `bar.group(Job.AOV.HSD$groups).png`

---

## 📌 6. `bar.group(Job.LM.HSD$groups)`

Same analysis as above but generated after creating a **linear model** using `lm()` and then applying `HSD.test`.

- Bars are styled with `density` and `angle` for pattern fill
- Letters (a–d) indicate group differences

📎 `bar.group(Job.LM.HSD$groups).png`
---

**Summary**: This session combines statistical testing (ANOVA) with visual diagnostics to ensure validity and interpretability of group comparisons.
