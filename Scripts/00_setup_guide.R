# To generate the setup guide:
# Update this value when you run the script by replacing the three letters inside the quotation marks
user = "MCS" #First, middle, and last initial

# Hit the "Source" button in the top right corner of this window

#############################################
### Do not alter anything below this line ###
#############################################

date = Sys.Date() + 1
lineages = c("AA", "AH", "HA", "HH")
n = 10

guide = data.frame(user, date, tube = c(1:n),
                   lineage = sample(lineages, size = n, replace = T),
                   replicate = NA)

file_name = gsub(x = date, pattern = "-", replacement = "_")

write.csv(guide, file = paste(file_name, "_setup", ".csv", sep = ""), row.names = F)
