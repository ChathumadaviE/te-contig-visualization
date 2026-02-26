# contig_repeat_landscape.R
# Visualize repeat annotations along a contig, colored by repeat class.

#-----------------------------
# Setup
#-----------------------------
# Required package:
# install.packages("readxl")

library(readxl)
require(grDevices)

#-----------------------------
# User-configurable parameters
#-----------------------------
input_file      <- "CombinedTEs_contig1.xlsx"
contig_length   <- 43684797
start_col_name  <- "begin"
end_col_name    <- "end"
class_col_name  <- "matching repeat"

background_color <- "thistle"

# Color mapping for repeat classes
repeat_colors <- list(
  DNA       = "red",
  LTR       = "green",
  LINE      = "yellow",
  Satellite = "black",
  Unknown   = "brown",
  Unique    = "violet"   # entries beginning with "R=" (unique repeats)
)

#-----------------------------
# Load data
#-----------------------------
my_data <- read_excel(input_file)

x1 <- as.numeric(my_data[[start_col_name]])
x2 <- as.numeric(my_data[[end_col_name]])
cl <- as.character(my_data[[class_col_name]])

#-----------------------------
# Assign colors by repeat type
#-----------------------------
color <- rep(NA_character_, length(cl))

for (i in seq_along(cl)) {
  c <- cl[i]

  if (grepl("^DNA",  c)) {
    color[i] <- repeat_colors$DNA
  } else if (grepl("^LTR", c)) {
    color[i] <- repeat_colors$LTR
  } else if (grepl("^LINE", c)) {
    color[i] <- repeat_colors$LINE
  } else if (identical(c, "Satellite")) {
    color[i] <- repeat_colors$Satellite
  } else if (identical(c, "Unknown")) {
    color[i] <- repeat_colors$Unknown
  } else if (grepl("^R=", c)) {
    color[i] <- repeat_colors$Unique
  } else {
    color[i] <- "white"   # default / unclassified
  }
}

#-----------------------------
# Plot
#-----------------------------
op <- par(bg = background_color)

plot(
  x = c(1, contig_length),
  y = c(0, 5),
  type = "n",
  xlab = "Genomic position",
  ylab = "Contig 1",
  main = "Repeat landscape along contig 1"
)

# Contig backbone
rect(1, 0, contig_length, 1, border = "black", col = "white")

# Repeats
rect(x1, 0, x2, 1, density = 50, col = color)
rect(1, 0, contig_length, 1, border = "black")

# Legend
legend(
  "topright",
  legend = c("DNA", "LTR class", "LINE class", "Satellite", "Unknown", "Unique repeats"),
  col    = c(
    repeat_colors$DNA,
    repeat_colors$LTR,
    repeat_colors$LINE,
    repeat_colors$Satellite,
    repeat_colors$Unknown,
    repeat_colors$Unique
  ),
  lty = 1,
  cex = 0.8
