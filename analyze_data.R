# analysis script

important_dataset <- data.frame(site_id = c("a","b","c"),
                                temp = c(23.2, 12.1, 20.5))

important_dataset$log_temp <- log(important_dataset$temp)

hist(important_dataset$log_temp)
