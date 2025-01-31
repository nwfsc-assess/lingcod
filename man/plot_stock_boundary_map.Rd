% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_stock_boundary_map.R
\name{plot_stock_boundary_map}
\alias{plot_stock_boundary_map}
\title{Plot a map of the stock boundaries for the 2021 lingcod assessment}
\usage{
plot_stock_boundary_map(
  names = c("North", "South"),
  cols = NULL,
 
    caption = "Map of the investigated area. The dashed line and colors delineate the northern (blue) from the southern (red) assessed area",
 
    alttext = "Outline of U.S. west coast split at forty degrees ten minutes north latitude"
)
}
\arguments{
\item{names}{A vector of names for north and south areas}

\item{cols}{A vector of colors for north and south areas.}

\item{caption}{A character string providing the caption for the figure.
The caption should not contain any special LaTeX characters because escaping
is not performed within this function. As of now, please leave off the final
full stop because it is added by \link[sa4ss:add_figure]{sa4ss::add_figure}.}

\item{alttext}{A character string providing the alternative text for the figure.
The caption should not contain any special LaTeX characters because escaping
is not performed within this function. As of now, please leave off the final
full stop because it is added by \link[sa4ss:add_figure]{sa4ss::add_figure}.}
}
\description{
Slightly cleaned up from Yellowtail Rockfish map created in 2017:
https://github.com/iantaylor-NOAA/YTRK_doc/blob/master/Rcode/map_showing_areas_v2.R
It writes a PNG file to figures/map_of_stock_boundaries_40-10.png.
This depends on the mapdata package but I got an
Error: 'worldHiresMapEnv' is not an exported object from 'namespace:maps'
so include require(mapdata) in the function as a quick solution.
}
\examples{
# make map using colors used in data-raw/lingcod_catch.R
plot_stock_boundary_map()
}
\seealso{
\code{\link[=plot_map]{plot_map()}}
}
\author{
Ian G. Taylor
}
