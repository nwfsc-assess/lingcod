% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_figure_ling.R
\name{add_figure_ling}
\alias{add_figure_ling}
\title{Add a data frame of figures.}
\usage{
add_figure_ling(csv, grep = ".+", caption, alt_caption)
}
\arguments{
\item{csv}{The csv file with all of the information per figure in rows.}

\item{grep}{The labels you want.}

\item{caption}{A vector of alternative captions.
Only needs to be supplied if you want to change the values in \code{csv}.}

\item{alt_caption}{A vector of alternative alt text.
Only needs to be supplied if you want to change the values in \code{csv}.}
}
\description{
A wrapper for \link[sa4ss:add_figure]{sa4ss::add_figure}.
}
\examples{
\dontrun{
add_figure_ling(csv=figurecsv, "data_plot")
}
}
\author{
Kelli F. Johnson
}
