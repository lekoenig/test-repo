# analysis script

important_dataset <- data.frame(site_id = c("a","b","c"),
                                temp = c(23.2, 12.1, 20.5))

important_dataset$log_temp <- log(important_dataset$temp)

hist(important_dataset$log_temp, main = "awesome histogram")

# pretend we fix a bug now

# pretend we add a new feature, like another type of plot
