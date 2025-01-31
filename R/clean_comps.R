                                        #' change the column names in the data.frame of length or age comps
#'
#' aligns the  names from the various software tools and combines
#' data frames with sexed and unsexed comps into one
#'
#' @param comp data object in the lingcod package
#' @template verbose
#' @author Ian G. Taylor
#' @export
#' @seealso [add_data()]

clean_comps <- function(comp, type = "len"){
  if (is.null(comp)) {
    return()
  }

  # internal function to pad unsexed comps with zeros for the male columns
  add_zeros <- function(df){
    if(type == "len") {
      bins <- info_bins$length
      names(df)[-(1:6)] <- paste0("F-", bins)
    }
    if(type == "age") {
      bins <- info_bins$age
      names(df)[-(1:9)] <- paste0("F-", bins)
    }
    df.zeros <- data.frame(matrix(0,
                                  nrow = nrow(df),
                                  ncol = length(bins)))
    
    names(df.zeros) <- paste0("M-", bins)
    cbind(df, df.zeros)
  }
  
  len_bin_names <- c(paste0("f", info_bins$length),
                     paste0("m", info_bins$length))
  
  age_bin_names <- c(paste0("f", info_bins$age),
                     paste0("m", info_bins$age))

  ##########################################################################
  # format used by PacFIN.Utilities
  if ("FthenM" %in% names(comp)){
    newcomp <- rbind(comp$FthenM,
                     comp$Uout)

    # low-tech 2021 scheme to convert "TW" to 1 and "FG" to 2
    newcomp$fleet[newcomp$fleet == "TW"] <- 1
    newcomp$fleet[newcomp$fleet == "FG"] <- 2
    newcomp$fleet <- as.numeric(newcomp$fleet)

    # fix duplicate column names which created an error for dplyr
    names(newcomp) <- vctrs::vec_as_names(names(newcomp),
                                          repair = "unique",
                                          quiet = TRUE)
    if (!"ageErr" %in% names(comp$FthenM)) {
      # length comp (doesn't have ageErr in the column names)
      newcomp <- newcomp %>%
        dplyr::rename(year    = "fishyr"   , # use naming convention from add_data()
                      part    = "partition",
                      nsamp   = "Ntows"  # could also be Nsamps or InputN or something new
                      ) %>%
        dplyr::select(-c("Nsamps", "InputN"))
      # replace names for data columns
      names(newcomp)[-(1:6)] <- len_bin_names
    } else {
      # marginal age comps (does have ageErr in the column names)
      newcomp <- newcomp %>%
        dplyr::rename(year    = "fishyr"   , # use naming convention from add_data()
                      part    = "partition",
                      ageerr = "ageErr",
                      lbin_lo = "LbinLo",
                      lbin_hi = "LbinHi",
                      nsamp   = "Ntows"  # could also be Nsamps or InputN or something new
                      ) %>%
        dplyr::select(-c("Nsamps", "InputN"))
      # replace names for data columns
      names(newcomp)[-(1:9)] <- age_bin_names
      # update ageing error matrix (was 0)
      newcomp$ageerr <- 1
    }
  }
    
  ##########################################################################
  # format used for recreational comps and unexpanded marginal age comps
  if("comps" %in% names(comp)){
    # if processed like length comps with missing columns
    if(type == "age" && !"ageErr" %in% names(comp$comps)) {
      comp$comps <- data.frame(comp$comps[,1:6],
                               data.frame(ageErr = 1,
                                          agelow = -1,
                                          agehigh = -1),
                               comp$comps[,-(1:6)],
                               check.names = FALSE)
      if("comps_u" %in% names(comp)){
        comp$comps_u <- data.frame(comp$comps_u[,1:6],
                                   data.frame(ageErr = 1,
                                              agelow = -1,
                                              agehigh = -1),
                                   comp$comps_u[,-(1:6)],
                                   check.names = FALSE)
      }
    }

    newcomp <- comp$comps
    # add zeros to main comps (needed for lenCompS_CA_debHist)
    if ("U-10" %in% names(newcomp)) {
      newcomp <- add_zeros(newcomp)
    }
    if ("comps_u" %in% names(comp)) {
      newcomp <- rbind(newcomp,
                       add_zeros(comp$comps_u))
    }
    newcomp <- newcomp %>%
      dplyr::rename(year    = "year"   ,
                    part    = "partition",
                    nsamp   = "Nsamp")
    
    # replace names for data columns
    if (type == "len") {
      names(newcomp)[-(1:6)] <- len_bin_names
    }
    if (type == "age") {
      # these comps have all columns already
      newcomp <- newcomp %>%
        dplyr::rename(ageerr = "ageErr",
                      lbin_lo = "agelow",
                      lbin_hi = "agehigh")
      names(newcomp)[-(1:9)] <- age_bin_names
    }
  }

  ##########################################################################
  # format used by data processed using nwfscSurvey package (a single table)

  if(is.data.frame(comp) && "F10" %in% names(comp)) {
    if (type == "age") {
      comp <- comp %>%
        dplyr::rename(lbin_lo = "agelow",
                      lbin_hi = "agehigh")
    }
    newcomp <- comp %>%
      dplyr::rename(part = "partition") %>%
      dplyr::rename_with(.fn = tolower) # change Nsamp to nsamp and F10 to f10
  }

  ####################################################################
  # format used by all the CAAL comps
  if (length(comp) == 2 &&
      all(names(comp) == c("female", "male"))) {
    # files produced by PacFIN.Utilities need extra columns for sex not included
    if(ncol(comp$female) == 9 + length(info_bins$age)) {
      comp$female <- cbind(comp$female,
                           data.frame(matrix(0,
                                             nrow = nrow(comp$female),
                                             ncol = length(info_bins$age))))
      comp$male <- cbind(comp$male[,1:9],
                         data.frame(matrix(0,
                                           nrow = nrow(comp$male),
                                           ncol = length(info_bins$age))),
                         comp$male[,-(1:9)])
    }
    # rename all data columns so they match
    names(comp$female)[-(1:9)] <- age_bin_names
    names(comp$male)[-(1:9)] <- age_bin_names
    # bind the female and male tables and convert characters to numeric 
    newcomp <- type.convert(rbind(comp$female, comp$male), as.is = TRUE)

    # format used by nwfscSurvey
    if ("sex" %in% names(newcomp)) {
      newcomp <- newcomp %>%
        dplyr::rename(fleet = "Fleet",
                      part = "partition",
                      nsamp = "nSamps",
                      ageerr = "ageErr",
                      lbin_lo = "LbinLo",
                      lbin_hi = "LbinHi",
                      )
    }
    # format used by tools other than nwfscSurvey
    if ("Gender" %in% names(newcomp)) {
      newcomp <- newcomp %>%
        dplyr::rename(year = "Year",
                      month = "Seas",
                      fleet = "Fleet",
                      sex = "Gender",
                      part = "Partition",
                      ageerr = "AgeError",
                      lbin_lo = "LbinLo",
                      lbin_hi = "LbinHi",
                      nsamp = "nSamps")
    }

  }
  
  # return cleaned comps
  newcomp
}
