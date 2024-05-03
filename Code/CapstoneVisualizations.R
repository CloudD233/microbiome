library(readr)
sample <- read_csv("~/Downloads/sample.csv")

t2d <- subset(sample, type == "Disease")
healthy <- subset(sample, type == "Control")

t2d_cols <- c('ActinobacteriaRel',
              'BacteroidetesRel',
              'EuryarchaeotaRel',
              'FirmicutesRel',
              'FusobacteriaRel',
              'ProteobacteriaRel',
              'TenericutesRel',
              'VerrucomicrobiaRel',
              'OtherCountsRel')  # Specify the columns you want to select
T2D <- subset(t2d, select = t2d_cols)

healthy_cols <- c('ActinobacteriaRel',
              'BacteroidetesRel',
              'EuryarchaeotaRel',
              'FirmicutesRel',
              'FusobacteriaRel',
              'ProteobacteriaRel',
              'TenericutesRel',
              'VerrucomicrobiaRel',
              'OtherCountsRel')  # Specify the columns you want to select
Healthy <- subset(healthy, select = healthy_cols)


bar_colors <- rainbow(length(t2d_cols))

T2D <- T2D[1:40, ]
Healthy <- Healthy[1:40, ]

par(mfrow = c(1, 2))

barplot(t(T2D), 
        beside = FALSE, 
        main = "Relative Frequency Bar Plot - Type 2 Diabetes", 
        xlab = "Type 2 Diabetes Samples", 
        ylab = "Relative Frequency", 
        cex.main = 0.7,
        cex.lab = 0.7,
        col = bar_colors)

barplot(t(Healthy), 
        beside = FALSE, 
        main = "Relative Frequency Bar Plot - Healthy", 
        xlab = "Healthy Samples", 
        ylab = "", 
        cex.main = 0.7,
        cex.lab = 0.7,
        col = bar_colors)
plot_area <- par("usr")
legend(legend_x, legend_y, legend = colnames(T2D), fill = bar_colors, xpd = TRUE, bty = "n", y.intersp = 1)
par(mfrow = c(1, 1))




t2dcounts <- subset(sample, type == "Disease")
healthycounts <- subset(sample, type == "Control")

t2dcounts_cols <- c('ActinobacteriaCounts',
              'BacteroidetesCounts',
              'EuryarchaeotaCounts',
              'FirmicutesCounts',
              'FusobacteriaCounts',
              'ProteobacteriaCounts',
              'TenericutesCounts',
              'VerrucomicrobiaCounts',
              'OtherCounts')  # Specify the columns you want to select
T2DCounts <- subset(t2dcounts, select = t2dcounts_cols)

healthycounts_cols <- c('ActinobacteriaCounts',
                        'BacteroidetesCounts',
                        'EuryarchaeotaCounts',
                        'FirmicutesCounts',
                        'FusobacteriaCounts',
                        'ProteobacteriaCounts',
                        'TenericutesCounts',
                        'VerrucomicrobiaCounts',
                        'OtherCounts')
HealthyCounts <- subset(healthycounts, select = healthycounts_cols)

matching_columns <- c('ActinobacteriaCounts',
                      'BacteroidetesCounts',
                      'EuryarchaeotaCounts',
                      'FirmicutesCounts',
                      'FusobacteriaCounts',
                      'ProteobacteriaCounts',
                      'TenericutesCounts',
                      'VerrucomicrobiaCounts',
                      'OtherCounts')

exclude_top_n <- function(x, n) {
  sorted_x <- sort(x)
  excluded_values <- sorted_x[1:(length(sorted_x) - n)]
  return(excluded_values)
}

top_n_exclude <- 20

par(mfrow = c(3, 3))

column_colors <- c("ActinobacteriaCounts" = "skyblue",
                   "BacteroidetesCounts" = "lightgreen",
                   "EuryarchaeotaCounts" = "lightcoral",
                   "FirmicutesCounts" = "gold",
                   "FusobacteriaCounts" = "orchid",
                   "ProteobacteriaCounts" = "lightblue",
                   "TenericutesCounts" = "salmon",
                   "VerrucomicrobiaCounts" = "palegreen",
                   "OtherCounts" = "lightgrey")

for (col in matching_columns) {
  t2d_counts <- exclude_top_n(T2DCounts[[col]], top_n_exclude)
  healthy_counts <- exclude_top_n(HealthyCounts[[col]], top_n_exclude)
  
  boxplot(t2d_counts, healthy_counts,
          names = c("T2D", "Healthy"),
          main = paste(col),
          xlab = "Group",
          ylab = "Counts",
          col = c(column_colors[col], column_colors[col]),
          border = "black",
          notch = TRUE)
}

par(mfrow = c(1, 1))
