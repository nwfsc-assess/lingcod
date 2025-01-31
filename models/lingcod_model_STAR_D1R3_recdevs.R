#Script to run alternative runs regarding recdevs requested by 
#STAR panel on day 1, Request 3

#3. Run the southern model with main recdevs starting in 1955. 
#Produce model comparison results and dynamic B0 for both models. 
#If the early devs are still "unusually" high (comparable to what 
#is seen in the base model at present), turn off
#the early devs for a 3rd run if time allows. 


####################
#South only
####################

newdir <- file.path("models", "2021.s.014.803_no_earlyDevs")

r4ss::copy_SS_inputs(dir.old = file.path("models", "2021.s.014.001_esth"),
                     dir.new = newdir,
                     use_ss_new = FALSE,
                     copy_par = FALSE,
                     copy_exe = TRUE, 
                     dir.exe = get_dir_exe(),
                     overwrite = FALSE,
                     verbose = TRUE)

inputs <- get_inputs_ling(id = get_id_ling(newdir)) 

#Change timing of recdevs
inputs$ctl$MainRdevYrFirst <- 1955
inputs$ctl$recdev_early_start <- 0

#add general comment
inputs$ctl$Comments <- c(inputs$ctl$Comments,
                         "#C STAR Panel request, Day 1, Request 3b: Set main recdevs to 1955 and exclude early devs")

# write new input files
write_inputs_ling(inputs,
                  # directory is same as source directory for inputs in this case
                  dir = newdir,
                  verbose = FALSE,
                  overwrite = TRUE)

#Run model, include hessian
r4ss::run_SS_models(dirvec = newdir,
                    skipfinished = FALSE)

# look at model output and check bias adj
output <- get_mod(area = "s", num = 14, sens = 803, plot = TRUE)
biasadj <- r4ss::SS_fitbiasramp(output, verbose = TRUE)


##
#Update bias adj
##
r4ss::copy_SS_inputs(dir.old = newdir,
                     dir.new = file.path("models", 
                       "2021.s.014.804_no_earlyDevs_biasAdj"),
                     use_ss_new = FALSE,
                     copy_par = FALSE,
                     copy_exe = TRUE, 
                     dir.exe = get_dir_exe(),
                     overwrite = FALSE,
                     verbose = TRUE)

inputs <- get_inputs_ling(id = get_id_ling(
  file.path("models", "2021.s.014.804_no_earlyDevs_biasAdj"))) 

#Update bias adj
inputs$ctl[c("last_early_yr_nobias_adj", "first_yr_fullbias_adj", 
            "last_yr_fullbias_adj","first_recent_yr_nobias_adj", 
            "max_bias_adj")] <- biasadj$newbias$par

#add general comment
inputs$ctl$Comments <- c(inputs$ctl$Comments,
                         "#C STAR Panel request, Day 1, Request 3b: Update bias adj")
# write new input files
write_inputs_ling(inputs,
                  # directory is same as source directory for inputs in this case
                  dir = inputs$dir,
                  verbose = FALSE,
                  overwrite = TRUE)

#Run model, include hessian
r4ss::run_SS_models(dirvec = inputs$dir,
                    skipfinished = FALSE)

# look at model output and update bias adj
output <- get_mod(area = "s", num = 14, sens = 804, plot = TRUE)


###
#Compare results with base
###
outs <- mapply(SIMPLIFY = FALSE, r4ss::SS_output,
               dir=file.path("models", 
                             c("2021.s.014.804_no_earlyDevs_biasAdj",
                               "2021.s.014.803_no_earlyDevs", 
                               "2021.s.014.001_esth")))
mid <- r4ss::SSsummarize(outs)
r4ss::SSplotComparisons(mid, print = TRUE, 
                        legendlabels = c("No early devs w/ bias adj", 
                                         "No early devs", "Base model"), 
                        plotdir = file.path("figures", "STAR_Day1_request3"))


