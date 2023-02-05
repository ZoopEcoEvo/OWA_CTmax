# Load in required packages
library(rmarkdown)
library(knitr)
library(tidyverse)
library(dabestr)

#Determine which scripts should be run
process_all_data = F #Runs data analysis for all files, rather than just new files
make_report = T #Runs project summary
knit_manuscript = F #Compiles manuscript draft

# Runs data analysis (data is read in during the for loop; nothing to read in here)
source(file = "Scripts/01_data_processing.R")

##################################
### Read in the PROCESSED data ###
##################################
full_data = read.csv(file = "Output/Data/full_data.csv")
ramp_record = read.csv(file = "Output/Data/ramp_record.csv")
temp_record = read.csv(file = "Output/Data/temp_record.csv")

if(make_report == T){
  render(input = "Output/Reports/report.Rmd", #Input the path to your .Rmd file here
         output_format = "all")
  # 
  # quarto_render(input = "Output/Reports/report.qmd",
  #               output_format = "all")
}

##################################
### Read in the PROCESSED data ###
##################################

if(knit_manuscript == T){
  render(input = "Manuscript/manuscript_name.Rmd", #Input the path to your .Rmd file here
         output_file = paste("dev_draft_", Sys.Date(), sep = ""), #Name your file here; as it is, this line will create reports named with the date
         #NOTE: Any file with the dev_ prefix in the Drafts directory will be ignored. Remove "dev_" if you want to include draft files in the GitHub repo
         output_dir = "Output/Drafts/", #Set the path to the desired output directory here
         output_format = "all",
         clean = T)
}

