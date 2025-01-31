% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dir_recent.R
\name{dir_recent}
\alias{dir_recent}
\title{Find the most recent file in a directory that matches the pattern}
\usage{
dir_recent(dir = getwd(), pattern, casespecific = FALSE, verbose = FALSE)
}
\arguments{
\item{dir}{The directory that you would like to search,
either a full or relative path will work.
The default is your current working directory.}

\item{pattern}{A character string that you want to search for within
\code{dir} using \link{grep}.}

\item{casespecific}{A logical value specifying if the call to \link{grep}
should be case specific. If \code{FALSE}, which is the default, then
\code{ignore.case = TRUE}, i.e., \code{ignore.case = !casespecific}.}

\item{verbose}{A logical value specifying if output should be printed
to the console or not. The default is \code{FALSE}, which will suppress messages.}
}
\value{
A single file path to the most recent file within \code{dir} that
matches the character string in \code{pattern}. The full path will be provided.
}
\description{
Use the \link{dir} function and \link[utils:head]{utils::tail} to get the most recent file
in a directory based on the saved name. This is only helpful when files
are saved with a sequential naming system, typically this will be a
form of the date as it is for PacFIN.Utilities when it saves .RData files.
}
\examples{
\dontrun{
dir_recent("data-raw", pattern = "Pac.+bds", verbose = TRUE)
dir_recent("data-raw", pattern = "Pac.+ft")
}
}
\author{
Kelli Faye Johnson
}
