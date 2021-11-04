# How many repeats are there per bird per year?
# Steps to find out
# for each year, for each BirdID, how many repeats?
# table(d$BirdID)
# could create a table with year as row names and BirdID as column names
YearDuplicateCount <- d %>% count(Year,BirdID, sort=FALSE)
# YearDuplicateCount %>% count(n) 