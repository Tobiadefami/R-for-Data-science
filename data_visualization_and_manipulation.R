# R FOR DATA SCIENCE
library(tidyverse)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + geom_point(mapping = aes(x = model, y = trans, color = class ))
write.csv(mpg, file = "cars_data.csv", row.names = FALSE)
# Aesthetic mappings
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class)) 
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, colour = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, stroke = cyl))

# setting the aesthetics of your geom manuallly 
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# mapping an aesthetic to something other than a variable name
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

# FACETS
# for one variable
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap( ~ class, nrow = 2)
# for two variables
ggplot(data  = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
# facet without the row or column dimensions
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(data = mpg) + geom_point(mapping = aes(x = drv, y = cyl))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

# geometric objects

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))

# setting the linetype of a line#
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# displaayin multiple geom functions to ggplot()
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
# to avoid duplication in our code, a set of mapping arguments can be passed to the ggplot function
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()
# using the same idea above to specify different data for each layer
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"),
              se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

# Recreate R code necessary to generate the following graphs
#1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(size = class), show.legend = FALSE) +
  geom_smooth(se = FALSE)
#2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(size = class), show.legend = FALSE) +
  geom_smooth(mapping = aes(line = drv), se = FALSE, show.legend = FALSE)
#3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(line = drv, color = drv), se = FALSE)
# or
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
#4
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se = FALSE)
#5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv), se = FALSE)
#6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point()
#  i recreated the R codes yo!!!


# Stastical Transformations
write.csv(diamonds, file = "diamonds_data.csv", row.names = FALSE)
ggplot(data = diamonds) +
  geom_bar(mapping = aes(cut))
# geoms and stats can be used interchangeably
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))
# overriding the default stat
demo <- tribble(
  ~a,      ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)
ggplot(data = demo) +
  geom_bar(mapping = aes(x = a, y = b), stat = "identity")
# overriding the default mapping from transformed variables to aesthetics
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x =cut, y = ..prop.., group = 1)
  )
# drawing greater attention to the stastical transformation in your code
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = color, y = ..prop..)
  )

# Position adjustments
#adding colors to a bar chart using color or fill
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))
#or
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))
# mapping thr fill aesthetic to another variable creates automatically stacked bars
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

# if you dont want a stacked bar

#setting position = "identity"
ggplot(data = diamonds,
       mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")
#setting fill = NA
ggplot(data = diamonds,
       mapping = aes(x = cut, color = clarity)) +
  geom_bar(fill = NA, position = "identity")
#setting position = "fill"
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "fill"
  )
#setting position = "dodge"
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "dodge"
  )


# using jitter
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),
             position = "jitter")

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = "jitter")

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_boxplot(position = "dodge2")

# coordinate systems
ggplot(mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
# flipping the coordinates
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()
# using polar coordinates
bar <- ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut),
           show.legend = FALSE,
           width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()

# DATA TRANSFORMATION WITH DPLYR
library(nycflights13)
library(tidyverse)

# filter rows with filter()
filter(flights, month == 1, day == 1)

#saving the result to an object
jan1 <- filter(flights, month == 1, day == 1)

# to save to an objevt or print the results at the same time
(dec25 <- filter(flights, month == 12, day == 25))

# Comparison

# the following code finds all the flghts that departed in november or december

view(filter(flights, month == 11 | month == 12))
#or
nov_dec <- filter(flights, month %in% c(11, 12))

# De morgan's law in practice; !( x & y) = !x | !y, !(x | y) = !x & !y 

#finding flights that weren't delayed by more than two hours
filter(flights, !(arr_delay > 120 | dep_delay > 120))
#or
filter(flights, arr_delay <= 120, dep_delay <+ 120)

# Missing values
df <- tibble(x = c(1, NA, 3))
filter(df, x > 3)
# asking for missing values explicitly
filter(df, is.na(x) | x > 1)
view(df)

# EXERCISE

#find all flights;

#that had an arrival delay of two or more hours
filter(flights, !(arr_delay <= 120))
# or
filter(flights, arr_delay >= 120)

# Flew to Houston (IAH or HOU)
filter(flights, dest == "IAH" | dest == "HOU")

#were operated by united, american, or delta
flights$carrier
# use airlines to look up abbreviations
airlines
# now use filter
filter(flights, carrier %in% c("UA", "AA", "DL"))

#departed in summer (July, August, September)
filter(flights, month == 7 | month == 8 | month == 9)
#or
filter(flights, month %in% c(7, 8, 9))

# Arrived more than 2 hours late, but didnt leave late
filter(flights, arr_time > 120 | sched_dep_time < 120)

# ARRANGE ROWS WITH arrange()
arrange(flights, year, month, day )

write.csv(flights, file = "nycflights13.csv", row.names = FALSE)

# desc() is used to reorder by a column in descending order
arrange(flights, desc(arr_delay))
# missing values are always sorted at the end
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

#Exercise

arrange(flights, is.na(year))

arrange(flights, desc(dep_delay))


# SELECT COLUMNS WITH select()

# select columns by name
select(flights, year, month, day)

# select all columns between year and day
select(flights, year:day)

# select columns exccept from year to day
select(flights, -(year:day))
# list of helper functions that can be used as a select argument
select(flights, starts_with("yea"))
select(flights, ends_with("nth"))
select(flights, contains("delay"))
select(flights, matches("(.)\\1"))
select(flights, num_range("x", 1:3))
# to rename a variable use renamis.na(arrange(flights), drop = FALSE)e()
rename(flights, tail_num = tailnum)
# use the everything() helper function to move a handful of variables to the start of the data frame
select(flights, time_hour, air_time, everything())

# Exercise
select(flights, dep_time)
select(flights, year, year, year) #Returns only one variable
# using the one_of() helper function
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights,  one_of(vars))

select(flights, contains("TIME"))

# ADD A NEW VARIABLE WITH MUTATE

# it is often useful to add new columns that are functions of existing columns

flights_sml <- select(flights, year:day, ends_with("delay"),
                      distance, air_time)
mutate(flights_sml, 
       gain = arr_delay - dep_delay,
       speed = distance / air_time  * 60)
# you can also refer to columns you just created
view(mutate(flights_sml,
            gain = arr_delay - dep_delay,
            hours = air_time / 60,
            gain_per_hour = gain / hours))

# if you only want to keep the new variables, use transmute()
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)
  
# USEFUL CREATION FUNCTONS
# modular arithmetic (%/% and %%)
transmute(flights, dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

# Useful creation functions
#modular arithmetic (%/5 and %%)
transmute(flights, 
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)
# offsets lead() and lag
x <- 1:10
lead(x)
lag(x)

#cummulative and rolling aggregates
cumsum(x)
cummean(x)

#Ranking
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

# Grouped summaries with summarize()
summarize(flights, delay = mean(dep_delay, na.rm = TRUE))

# pairing summarize() with group_by()
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# Combining multiple operations with the Pipe
#exploring the relationship between the distance and average delay for each location

by_dest <- group_by(flights, dest) # group flights by destination
delay <- summarise(by_dest, count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)) # summarize to compute distance, average delay, and number of flights

delay <- filter(delay, count > 20, dest != "HNL") # filter to remove noisy points and Honolulu airport, which is almost twice as far away as the next closest airport

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# using pipe to create the data above 
delays <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distsnce, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")

# Missing Values
flights %>% 
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay)) # without the na.rm = TRUE argument, we'll be getting s lotta missing values

# a case where missing values represent cancelled flights
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay)) # problem is tackeled by first removing the cancelled flights

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

# Counts
#lets look at the planes (identified by their tail numbers) that have the highest average delays

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10) #this plot shows that there are some planes that have an average delay of 5 hours

# we can get more insight from a scatterplot of number of flights versus average delay
 delays <- not_cancelled %>%
    group_by(tailnum) %>%
    summarize(
      delay = mean(arr_delay, na.rm = TRUE),
       n = n()
      ) 


 ggplot(data = delays, mapping = aes(x = n, y = delay)) +
   geom_point(alpha = 1/10)
 
 # filtering out the group with the smallest number of obervations
 delays %>%
   filter(n > 25) %>%
   ggplot(mapping = aes(x = n, y = delay)) +
   geom_point(alpha = 1/10)
 
 # Another variation of the type of pattern shown above
 batting <- as_tibble(Lahman::Batting)
 
 batters <- batting %>%
   group_by(playerID) %>%
   summarise(
     ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
     ab = sum(AB, na.rm = TRUE)
   )
 
 batters %>%
   filter(ab > 100) %>%
   ggplot(mapping = aes(x = ab, y = ba)) +
   geom_point() +
   geom_smooth(se = FALSE)

 
