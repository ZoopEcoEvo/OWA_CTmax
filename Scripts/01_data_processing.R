# This script cycles through the time, temperature, and length data files collected for each individual replicate
# and combines them to estimate thermal limits (as CTmax)

cumul_data = data.frame()
temp_record = data.frame()
ramp_record = data.frame()
file_list = dir(path = "Data/time_data/") # full set of time data files

all_runs = str_split_fixed(file_list, pattern = "_time.csv", n = 2)[,1] # Pulls out just the date prefix from the file names
if(process_all_data == T){
  prev_runs = NA #Use this line the first time the script is run to process all files
  overwrite = "yes"
}else{
  prev_runs = read.table(file = "Output/Data/prev_runs.txt", header = T) # The time data files that have already been processed
  prev_runs = prev_runs$x
  overwrite = "no"
}

new_runs = all_runs[which(!(all_runs %in% prev_runs))] # Only the new time data files
runs = c()

if(length(new_runs) > 0){ # If there are new data files to process...
  for(f in 1:length(new_runs)){
    file_name = new_runs[f] 
    runs = c(runs, file_name)
    
    if(length(file_list) == 1){
      run_id = 1
    }else{
      run_id = sum(!is.na(prev_runs)) + f
    }
    
    # Loads data from temperature sensors (logging at 5 second intervals)
    temp_data = read_csv(paste("Data/temperature_data/", file_name, "_temp.CSV", collapse = "", sep = "")) %>% 
      mutate("Time" = lubridate::hms(Time),
             "Date" = lubridate::as_date(Date)) %>% 
      mutate("time_point" = row_number(), # Assigns each time point a sequential value
             "second_passed" = lubridate::time_length(Time - first(Time)), # Calculates the time passed in seconds since logging began
             "minute_passed" = second_passed / 60,
             "minute_interval" = floor(second_passed / 60)) %>% # Integer math to convert from seconds since logging began to minute time interval 
      pivot_longer(cols = c(Temp1, Temp2, Temp3), # Pivots data set so there's only one column of temperature data
                   names_to = "sensor",
                   values_to = "temp_C") %>% ungroup()
    
    time_data = read_csv(paste("Data/time_data/", file_name, "_time.csv", collapse = "", sep = "")) %>% 
      drop_na(minute) %>%
      mutate(time = (minute + (second / 60)) - 2, # Accounts for the two minute start up delay in the temperature logger
             "rank" = dense_rank(desc(time)))
    
    if(paste(file_name, "_length.csv", collapse = "", sep = "") %in% dir("Data/length_data/")){
      length_data = read_csv(paste("Data/length_data/", file_name, "_length.csv", collapse = "", sep = ""))
    }else{
      length_data = tibble("tube" = time_data$tube,
                           "length" = NA)}
    
    setup = read_csv(paste("Data/setups/", file_name, "_setup.csv", collapse = "", sep = ""))
    
    
    min_ramp = temp_data  %>% 
      group_by(sensor, minute_interval) %>% 
      group_modify(~ data.frame(
        "ramp_per_second" = unclass(
          coef(lm(data = .x, temp_C ~ second_passed))[2]))) %>% # Calculates rate of change for each sensor during each of the minute time intervals
      mutate(ramp_per_minute = ramp_per_second * 60, # Converts from change per second to change per minute
             run = run_id) # Gives each run a unique numeric ID
    
    ### Combine with time data to get CTmax values 
    ind_measurements = time_data %>% 
      group_by(tube) %>% 
      summarise("ctmax" = mean(filter(temp_data, minute_passed > (time - (0.1 * rank)) & minute_passed < time)$temp_C), # Average temperature of the uncertainty window for each individual
                "ramp_rate" = mean(filter(min_ramp, minute_interval > (time - 5) & minute_interval < time)$ramp_per_minute))
    
    ct_data = inner_join(time_data, ind_measurements, by = c("tube")) %>% 
      inner_join(length_data, by = c("tube")) %>% 
      inner_join(select(setup, -date), by = c("tube")) %>% 
      mutate(date = lubridate::as_date(str_replace_all(file_name, pattern = "_", "-")),
             run = run_id) %>% 
      select(date, user, run, tube, lineage, replicate, rank, length, time, ramp_rate, ctmax)
    
    write.csv(ct_data, file = paste("Output/Data/", file_name, "_ctmax.csv", sep = "", collapse = ""), row.names = F)
    
    cumul_data = bind_rows(cumul_data, ct_data) 
    
    temp_data$run = run_id
    temp_record = bind_rows(temp_record, temp_data)
    
    ramp_record = bind_rows(ramp_record, min_ramp)
  }
  
  full_data = cumul_data
  
  if(overwrite == "yes"){
    #Records full data set
    write.table(x = runs, file = "Output/Data/prev_runs.txt", row.names = F) 
    write.table(x = full_data, file = "Output/Data/full_data.csv", sep = ",", row.names = F)
    write.table(x = temp_record, file = "Output/Data/temp_record.csv", sep = ",", row.names = F)
    write.table(x = ramp_record, file = "Output/Data/ramp_record.csv",  sep = ",", row.names = F)
  }else{
    #Records full data set
    write.table(x = runs, file = "Output/Data/prev_runs.txt", row.names = F, col.names = F, append = T) 
    write.table(x = full_data, file = "Output/Data/full_data.csv", sep = ",", row.names = F,col.names =F, append = T)
    write.table(x = temp_record, file = "Output/Data/temp_record.csv", sep = ",", row.names = F,col.names =F, append = T)
    write.table(x = ramp_record, file = "Output/Data/ramp_record.csv",  sep = ",", row.names = F, col.names =F,  append = T)
  }
}
