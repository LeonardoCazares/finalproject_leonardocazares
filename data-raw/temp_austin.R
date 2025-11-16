## code to prepare `temp_austin` dataset goes here

temp_austin <- read.csv('data-raw/temp_austin.csv')

usethis::use_data(temp_austin, overwrite = TRUE)
