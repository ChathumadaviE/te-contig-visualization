# contig_te_visualization.R
# Visualize transposable element (TE) annotations along a contig.

# Required packages:
#   install.packages("readxl")

library(readxl)
require(grDevices)

#-----------------------------
# User inputs
#-----------------------------
input_file  <- "Contig1_Known_TEs.xlsx"
contig_len  <- 43684797
feature_col <- "repeat class/family"
start_col   <- "original begin"
end_col     <- "original end"
feature_pattern <- "^SINE"   # pattern to highlight (e.g. "^LINE", "^LTR")

#-----------------------------
# Load data
#-----------------------------
my_data <- read_excel(input_file)

x1 <- as.numeric(unlist(my_data[[start_col]]))
x2 <- as.numeric(unlist(my_data[[end_col]]))
cl <- unlist(my_data[[feature_col]])

#-----------------------------
# Set colors
#-----------------------------
color <- character(length(cl))
for (i in seq_along(cl)) {
  if (grepl(feature_pattern, cl[i])) {
    color[i] <- "purple"
  } else {
    color[i] <- "white"
  }
}

#-----------------------------
# Plot
#-----------------------------
op <- par(bg = "thistle")

plot(c(1, contig_len),
     c(0, 5),
     type = "n",
     xlab = "Genomic position",
     ylab = "Contig 1")

rect(1, 0, contig_len, 1, border = "black", col = "white")
rect(x1, 0, x2, 1, density = 50, col = color)
rect(1, 0, contig_len, 1, border = "black")

legend("topright",
       legend = c("SINE"),
       col    = c("purple"),
       lty    = 1,
       cex    = 0.8)

par(op)
