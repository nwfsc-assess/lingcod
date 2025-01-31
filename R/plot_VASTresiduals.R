#' Plot VAST residuals
#'
#' @param working_dir Where the VAST files are located.
#' @param nrow The number of rows.
#' @author Kelli F. Johnson
#' @examples
#' \dontrun {
#' mapply(plot_VASTresiduals,
#'  dir("data-raw", pattern = "_gamma$", full = TRUE)
#' )
#' }
plot_VASTresiduals <- function(working_dir) {

  # Find a way to check if VAST needs to be loaded
  VASTversion <- gsub("\\.cpp", "", 
    dir("data-raw", pattern = "VAST_.+\\.cpp", full.names = TRUE)
  )
  dyn.load(TMB::dynlib(VASTversion))

  load(file.path(working_dir, "Save.RData"))
  
  # REALLY BAD practice, but it won't work unless it is in the parent environment
  fit <<- out
  fit <- out
  secretwd <<- working_dir
  secretwd <- working_dir
  on.exit(rm(fit, secretwd), add = TRUE)

  dharmaRes = summary( fit, what="residuals", working_dir=secretwd, type=1)
  PlotDF = cbind( "Lat"=fit$data_frame[,'Lat_i'], "Lon"=fit$data_frame[,'Lon_i'], "x2i"=1:fit$data_list$n_i, "Include"=TRUE)
  Y_gt = matrix(NA, nrow=nrow(fit$data_frame), ncol=fit$data_list$n_t )
  Y_gt[ cbind(1:fit$data_list$n_i,fit$data_list$t_i+1) ] = dharmaRes$scaledResiduals
  Y_gt = Y_gt[,fit$years_to_plot,drop=FALSE]

colnames(Y_gt) <- fit$year_labels[fit$years_to_plot]
test <- data.frame(PlotDF, Y_gt) %>% 
  tidyr::gather(key = "Year", value = "Residual", -Lat, -Lon, -x2i, -Include) %>% 
  dplyr::mutate(Year = gsub("^X", "", Year)) %>%
  dplyr::filter(!is.na(Residual))

regions <- if (grepl("North", working_dir)) {
  c("California", "Oregon", "Washington")
} else { c("California")}

states_map <- ggplot2::map_data("state", regions = regions)
gg <- ggplot2::ggplot(states_map, ggplot2::aes(x = long, y = lat)) +
  ggplot2::coord_fixed() +
  ggplot2::geom_polygon(
    ggplot2::aes(group = group),
    fill = NA, 
    col = "black"
  ) +
  ggplot2::geom_point(
    data = test,
    cex = 1.5,
    alpha = 0.5,
    ggplot2::aes(y = Lat, x = Lon, colour = Residual-mean(Residual)
    )
  ) +
  coord_sf(
    xlim = c(floor(min(test$Lon)) - 1, ceiling(max(test$Lon)) + 2),
    ylim = range(test$Lat) + c(-0.5, 0.5),
    expand = FALSE
  ) +
  plot_theme() +
  ggplot2::facet_wrap("Year") + 
  ggplot2::scale_colour_gradient2(low = "darkblue", mid = "white", high = "red") +
  ggplot2::theme(legend.position = "none") +
  xlab("Longitude (dd)") + ylab("Latitude (dd)") +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90))

  pngname <- file.path(working_dir, "VASTWestCoast_scaledresidualsmap.png")
  print(gg)
  ggplot2::ggsave(
    filename = pngname
  )
  dev.off()
}



