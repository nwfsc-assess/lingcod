% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_draft.R
\name{write_draft}
\alias{write_draft}
\title{Write the draft assessment files for this species}
\usage{
write_draft(authors, dir, grepcopy = "00opts|^01a|^[i-s]")
}
\arguments{
\item{authors}{A vector of author names or a list of vectors
if you want to specify multiple files.}

\item{dir}{A directory where you want the results saved to.
The directory must be a full path or relative to your current
working directory. Regardless of which method you choose, the
creation of the directories is recursive and you can nest
directories as many layers as you want.}

\item{grepcopy}{A character string for pattern matching in the
draft folder of files to bring over from the template to the
main document folder. As you increasingly develop your stock
assessment document the amount of files you want to overwrite
will decrease. The default will bring a few files.}
}
\description{
Write draft assessment files for this species in a specified
directory based on \code{dir}.
}
\examples{
\dontrun{
# Bring more files than the default, this would be used in
# the beginning
write_draft(
  authors = "Kelli F. Johnson",
  dir = "doc",
  grepcopy = "[0-5]|^[i-z]"
)
}

}
\seealso{
Other write: 
\code{\link{write_introduction}()}
}
\author{
Kelli F. Johnson
}
\concept{write}
