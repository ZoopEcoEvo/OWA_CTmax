library(tidyverse)

tubes = read_csv(file = "Data/method_valid/tube_pH.csv")

ggplot(tubes, aes(x = time, y = pH, group = tube, colour = temp, linetype = cover)) + 
  facet_wrap(volume~.) +  
  geom_line(size = 2) + 
  theme_bw()
