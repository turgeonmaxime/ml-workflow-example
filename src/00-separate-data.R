# Separate the raw data into a "modelling" dataset and a "prediction" dataset.
set.seed(20220915)
n_model <- 1000

library(readr)
library(dplyr)

raw_data <- read_csv("raw-data/wage_data.csv")

ind_model <- sample(nrow(raw_data), size = n_model)

model_data <- filter(raw_data, row_number() %in% ind_model)
pred_data <- filter(raw_data, !row_number() %in% ind_model)

write_csv(model_data, "data/wage_model.csv")
write_csv(pred_data, "data/wage_pred.csv")
