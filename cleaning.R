###Clean data using R####

library(stringr)

str_trim("    Elías  A   ")
str_pad("739", width=5, side = "left", pad = "0")
str_detect

df
data_new <- apply(df, 2, str_remove_all, " ")
data_new
