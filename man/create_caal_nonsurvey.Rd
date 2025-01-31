% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_caal_nonsurvey.R
\name{create_caal_nonsurvey}
\alias{create_caal_nonsurvey}
\title{Generate CAAL compositions from any dataset}
\usage{
create_caal_nonsurvey(
  Data,
  agebin,
  lenbin,
  wd,
  append,
  seas,
  fleet,
  partition,
  ageEr
)
}
\arguments{
\item{Data}{A data frame with columns for "Year", "Sex", "Len_Bin_FL",
and "Ages"}

\item{agebin}{A vector of lower and upper age bins, i.e., the range.}

\item{lenbin}{A vector of lower and upper length bins, i.e., the range.}

\item{wd}{The directory where you want the output saved.}

\item{append}{A character value supplying text that will be appened to the
beginning of a standard file name.}

\item{seas}{A numeric value supplying the season for this fleet.}

\item{fleet}{An integer value for the fleet.}

\item{partition}{An integer value supplying the partition.}

\item{ageEr}{An integer value supplying the ageing error matrix to use
for this fleet.}
}
\description{
Generate CAAL compositions from any data, e.g., Laurel Lam's thesis data.
}
\author{
Brian J. Langseth modified code from Chatel R. Wetzel
}
