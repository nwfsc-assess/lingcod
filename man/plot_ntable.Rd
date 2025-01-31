% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_ntable.R
\name{plot_ntable}
\alias{plot_ntable}
\title{Plot sample sizes by group horizontally}
\usage{
plot_ntable(
  data,
  dodge_n = 0.9,
  font_family = "sans",
  title_fill = "",
  file,
  file_width = 15
)
}
\arguments{
\item{data}{A data frame with the following columns:
\itemize{
\item survey: sampling group
\item area: geographic area
\item measurement: type of measurement
\item values: stores the sample sizes
}}

\item{dodge_n}{A value between 0 and 1.0 that determines how
far apart the text values are with respect to their group on
the y axis such that long numbers do not overlap when the
samples sizes are small. In short, how much of the vertical
space within your y-axis group do you want to use when printing
the sample sizes. A large value means that there is no chance
for overlap because each value will have a unique height and
zero will place all values within a single plane. The default
is fairly large and will space the numbers vertically.}

\item{font_family}{The font family used for the sample size
information that is printed on the figure.}

\item{title_fill}{A character entry specifying the title for
the fill legend. The default of \code{""} removes the title.}

\item{file}{A file path to save the figure to.
The path should end in \code{.png}.}

\item{file_width}{The width in inches that you wish the resulting
figure that is saved to the disk to be. The default of 15 results
in a wide figure.}
}
\value{
A \pkg{ggplot2} object is returned.
If \code{file} is specified then a the same returned figure is
also saved to the disk given the specified name using
\link[ggplot2:ggsave]{ggplot2::ggsave}.
}
\description{
Plot sample sizes by area (y axis, line color), survey (color),
and measurement type (vertical panels) with text
providing the number of samples per group.
The horizontal stacked bar plots are helpful for relative
comparisons between areas and surveys.
}
\examples{
ninfo <- data.frame(
  survey = rep(c("WCGBTS", "Triennial", "Hook and Line"), each = 6),
  area = rep(c("North", "South"), 9),
  measurement = rep(rep(c("Length", "Weight", "Age"), each = 2), 3),
  values = c(
    14360, 10917, 7869, 5548, 4655, 2905,
    3539, 1622, 2238, 939, 1731, 802,
    NA, 825, NA, 825, NA, 187
  )
)
x <- plot_ntable(data = ninfo, file = "n_surveybiological.png")
print(x)
unlink("n_surveybiological.png")

}
\author{
Kelli F. Johnson
}
