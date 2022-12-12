library(tidyverse)

#Previous body size data 
sizes = read.csv(file = "Data/Body_size_data_complete.txt", sep = "\t")

adults = sizes %>%  
  filter(Stage != "C1") %>%  
  mutate("sex" = if_else(str_detect(Stage, pattern = "M"), "male", "female"))

ggplot(adults, aes(x = Generation, y = Length, colour = sex)) + 
  facet_wrap(Treatment~.) + 
  geom_point() + 
  geom_smooth()

adults %>%  
  filter(Generation == 25) %>% 
  ggplot(aes(x = Treatment, y = Length, fill = Treatment)) + 
  facet_wrap(sex~.) + 
  geom_boxplot() + 
  theme_bw(base_size = 20) + 
  theme(legend.position = "none",
        panel.grid = element_blank())
             