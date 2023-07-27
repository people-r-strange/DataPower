library(tidyverse)
library(readxl)
library(purrr)
library(janitor)
library(tidyr)
library(writexl)
library(openxlsx)

file.path <- "/Users/viviennemaxwell/Library/CloudStorage/Box-Box/Vivienne Maxwell/DataXPower/DataPower"
# Create the list of files present in that folder location
buildings.list <- list.files(path = file.path, pattern = '*.csv') #1:2

#load sheet 1
buildings.list.names <- lapply(buildings.list,read_csv) #2

# Example list of values to filter for
filter_values <- c("co2", "co", "so2", "no2", "ch4", "o3", "co2e_100yr", "co2e_20yr")

# Function to filter a data frame based on values in a column
filter_dataframe <- function(df, column_name, values) {
  if (column_name %in% colnames(df)) {
    df[df[[column_name]] %in% values, ]
  } else {
    message(paste("Column", column_name, "not found in the data frame. Skipping filtering."))
    df
  }
}


# Apply the filter_dataframe function to each data frame in the list
filtered_buildings_list <- lapply(buildings.list.names, filter_dataframe, column_name = "gas", values = filter_values) #135.1MB

#export as workbook 

write.xlsx(filtered_buildings_list, "FilteredData/Buildings_FilteredList.xlsx")
