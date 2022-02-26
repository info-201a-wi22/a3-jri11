#adding necessary packages 
library(dplyr)
library(ggplot2)

#reading the csv file with sorted data
incarceration_trend <- read.csv(".\\a3-jri11\\source\\LA_OP_INCAR.csv")

# Chart one, a trend that shows jail incarceration rate over time for black 
#individuals in the the Orleans Parish. 
ggplot(incarceration_trend) + 
  geom_line(
    mapping = aes(x = year, y = black_jail_pop)
  )

#The second chat shows the difference between black jail population, and white 
#jail population, also within the Louisiana Orleans Parish 
ggplot() + 
 geom_line(data = incarceration_trend, mapping = aes(x = year, y = black_jail_pop), color = "orange")+
  geom_point(data = incarceration_trend, mapping = aes(x = year, y = black_jail_pop), color = "orange")+
  geom_line(data = incarceration_trend, mapping = aes(x = year, y = white_jail_pop), color = "red")+
  geom_point(data = incarceration_trend, mapping = aes(x = year, y = white_jail_pop), color = "red")+
  labs(x = "Year", y = "Black jail population (orange) and white jail population (red)", title = "Black and White Population Incarceration Trends")
  
#The map will exemplify this disproportionate incarceration trend, in all of 
#Louisiana, not just the Orleans Parish. 
library(ggplot2)
library(dplyr)
library(maps)
library(viridis)

state <- c("Louisiana")
world_map <- map_data("world", region = state)

region.lab.data <- state %>%
  group_by(region) %>%
  summarise(long = mean(long), lat = mean(lat))

LAI <- LA_INCAR_trends %>%
  select(V2, V29) %>%
  
  mutate(
    region = ifelse(region == "USA")
  )

world_map <- map_data("world")
LAI <- left_join(LAI, world_map, by = "region")

ggplot()
ggplot(LAI, aes(long, lat, ,group = group)) +
  geom_polygon(aes(fil = LA_INCAR_trends), color = "orange")+
  scale_fill_viridis_c(option = "C")
  

