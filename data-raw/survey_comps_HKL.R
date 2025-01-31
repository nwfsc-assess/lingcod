#######################################
#
#Scripts to generate length and age comps for the lingcod_2021 stock assessment from 
#the hook and line survey.
#
#Generates two comps: 1) females then males, and 2) unsexed fish
#
#Author: Brian Langseth
#Created: March 2, 2021
#
#######################################

##There are a few remaining tasks
#1. Need to define length bins (currently set to min/max of each dataset with bin size of 2) DONE
#2. Will need to specify survey timing (month 7), sex (currently 3 or 0), fleet number (8), partition (0), etc....

##------------------------------------Scripts----------------------------------------##

#These were saved as .rda within the package in lingcod_LW_LA.R and replace having to read in again
hnl = bio.HKL
hnl_ages = bio.HKLage.Lam

# #John Harms provided data in email on Feb 9, 2021.
# hnl_full = read.csv(file.path("data-raw", "qryGrandUnifiedThru2019_For2021Assessments_DWarehouse version_01072021.csv"), header = TRUE)
# hnl = hnl_full[hnl_full$common_name == "Lingcod",]
# 
# #No ages in this dataset
# table(hnl$age_years, useNA = "always")
# 
# #Laurel Lam provided ages on March 22, 2021 from 2017-2019 for hook and line survey
# hnl_ages = read.csv(file.path("data-raw", "H&L_Lingcod_ages.csv"), header = TRUE)

#Create subfolder in length and age directory
dir <- file.path("data-raw", c(sprintf("%sComps", c("len", "age")), "ageCAAL"), "HooknLine")
ignore <- mapply(dir.create, dir, MoreArgs = list(showWarnings = FALSE, recursive = TRUE))
stopifnot(file.exists(dir))


############################################################################################
#	Comps - all for southern model 
############################################################################################

#------------------------Length-----------------------------#

#Rename fields so they work with UnexpandedLFs.fn
hnl$Length_cm = hnl$length_cm
hnl$Sex = hnl$sex
hnl$Year = hnl$year

hnl$Trawl_id = 1:nrow(hnl)
nwfscSurvey::GetN.fn(dir = dir[1], dat = hnl, type = "length", species = 'others')
n = read.csv(file.path(dir[1], "forSS", "length_SampleSize.csv"))
n = n[,c('Year', 'All_Fish', 'Sexed_Fish', 'Unsexed_Fish')]
write.csv(n, file = file.path(dir[1], "hkl_samples.csv"), row.names = FALSE)
#Remove forSS file
unlink(file.path(dir[1],"forSS"), recursive = TRUE)

#Generate Comps
lfs = nwfscSurvey::UnexpandedLFs.fn(dir = dirname(dir[1]), #puts into "forSS" folder in this location
                       datL = hnl, lgthBins = info_bins[["length"]], printfolder = "HooknLine",
                       sex = 3,  partition = 0, fleet = get_fleet("Hook")$num, month = 7)
file.rename(from = file.path(dir[1], paste0("Survey_notExpanded_Length_comp_Sex_3_bin=", min(info_bins[["length"]]), "-", max(info_bins[["length"]]), ".csv")), 
            to = file.path(dir[1], paste0("south_HNL_notExpanded_Length_comp_Sex_3_bin=", min(info_bins[["length"]]), "-", max(info_bins[["length"]]), ".csv"))) 
file.rename(from = file.path(dir[1], paste0("Survey_notExpanded_Length_comp_Sex_0_bin=", min(info_bins[["length"]]), "-", max(info_bins[["length"]]), ".csv")), 
            to = file.path(dir[1], paste0("south_HNL_notExpanded_Length_comp_Sex_0_bin=", min(info_bins[["length"]]), "-", max(info_bins[["length"]]), ".csv"))) 

#Visualize
nwfscSurvey::PlotFreqData.fn(dir = dir[1],
                dat = lfs$comps, ylim=c(0, max(info_bins[["length"]])+4),
                main = "HNL lengths Male-Female", yaxs="i", ylab="Length (cm)", dopng = TRUE)
nwfscSurvey::PlotFreqData.fn(dir = dir[1],
                dat = lfs$comps_u, ylim=c(0, max(info_bins[["length"]])+4),
                main = "HNL lengths Unsexed", yaxs="i", ylab="Length (cm)", dopng = TRUE)
nwfscSurvey::PlotSexRatio.fn(dir = dir[1],
                dat = hnl, ylim = c(-0.1, 1.1), main = "HNL Sex Ratio", yaxs="i", dopng = TRUE)

suppressWarnings(
  age_representativeness_plot(hnl, file = file.path("figures", "HooknLine_agerepresentativeness.png"))
)

#Save as .rdas. Combined for sex3 (first element) and unsexed
lenCompS_HKL = lfs
usethis::use_data(lenCompS_HKL, overwrite = TRUE)

#------------------------Age-----------------------------#

#Set up required variable names
hnl_ages$Age = hnl_ages$age_years
hnl_ages$Length_cm = hnl_ages$length_cm
hnl_ages$Sex = hnl_ages$sex
hnl_ages$Year = hnl_ages$year

hnl_ages$Trawl_id = 1:nrow(hnl_ages)
nwfscSurvey::GetN.fn(dir = dir[2], dat = hnl_ages, type = "age", species = 'others')
n = read.csv(file.path(dir[2], "forSS", "age_SampleSize.csv"))
n = n[,c('Year', 'All_Fish', 'Sexed_Fish', 'Unsexed_Fish')]
write.csv(n, file = file.path(dir[2], "hkl_age_samples.csv"), row.names = FALSE)
#Remove forSS file
unlink(file.path(dir[2],"forSS"), recursive=TRUE)

afs = nwfscSurvey::UnexpandedAFs.fn(dir = dirname(dir[2]),  #Somehow stills prints to "forSS"
                       datA = hnl_ages, ageBins = info_bins[["age"]], printfolder = "HooknLine",
                       sex = 3, partition = 0, fleet = get_fleet("Hook")$num, month = 7, ageErr = 1)
file.rename(from = file.path(dirname(dir[2]), "forSS", "Survey_notExpanded_Age_comp_Sex_3_bin=0-20.csv"), 
            to= file.path(dir[2], "south_Survey_Sex3_Bins_0_20_AgeComps.csv")) 
if(dir.exists(file.path(dirname(dir[2]),"forSS"))) unlink(file.path(dirname(dir[2]), "forSS"),recursive = TRUE) #remove forSS file

nwfscSurvey::PlotFreqData.fn(dir = dir[2], dat = afs$comps, ylim=c(0, max(info_bins[["age"]]) + 1), inch = 0.10, main = "Hook and Line", yaxs="i", ylab="Age", dopng = TRUE)
nwfscSurvey::PlotSexRatio.fn(dir = dir[2], dat = hnl_ages, data.type = "age", dopng = TRUE, main = "Hook and Line")

#Save as .rdas. Just sex3 (there are no unsexed ages)
ageCompS_HKL = afs
usethis::use_data(ageCompS_HKL, overwrite = TRUE)


#------------------------CAAL-----------------------------#
#Rename fields so they work with create_caal_nonsurvey
hnl_ages$Len_Bin_FL = 2*floor(hnl_ages$Length_cm/2)
hnl_ages$Ages = hnl_ages$Age

ageCAAL_S_HKL = create_caal_nonsurvey(Data = hnl_ages, agebin = range(info_bins[["age"]]), lenbin = range(info_bins[["length"]]), wd = dir[3], 
                                      append = "south_Survey", seas = 7, fleet = get_fleet("Hook")$num, partition = 0, ageEr = 1)

usethis::use_data(ageCAAL_S_HKL, overwrite = TRUE)

ignore <- file.copy(
  recursive = TRUE,
  unlist(mapply(
    FUN = dir,
    dir,
    MoreArgs = list(recursive = TRUE, full.names = TRUE, pattern = "png")
  )),
  "figures"
)
