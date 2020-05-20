library(highcharter)
library(tidyverse)
library(htmlwidgets)

mapdata <- get_data_from_map(download_map_data("custom/africa"))

options(browser = "/usr/bin/firefox")

test_data <- read_csv("../african_latest_testing_data.csv")
test_data$cum_tot_per_mil <- test_data$`Cumulative total per thousand` / 1000
test_data$`iso-a3` <- test_data$`ISO code`
test_data$cum_tot_per_thousand <- test_data$`Cumulative total per thousand`


## graphic

x <- c("Country - Test Type", "Cumulative Total Tests per Thousand")
y <- c( "{point.Entity}" , "{point.cum_tot_per_thousand}")

tltip <- tooltip_table(x, y)

carmine <- "#960018"
dark_midnight_blue <- "#003366"
white <- "#FFFFFF"
milken <- "#0066CC"

## 
map <- hcmap("custom/africa", data = test_data, value = "cum_tot_per_thousand",
             joinBy = c("iso-a3"), name = "Cumulative Tests per Million",
             borderColor = "#FAFAFA", borderWidth = 0.1) %>%
    hc_tooltip(useHTML = TRUE, headerFormat = "", pointFormat = tltip) %>%
    hc_legend(align = "center", layout = "horizontal", verticalAlign = "middle", x = -160, y= 120, valueDecimals = 0) %>%
    hc_colorAxis(minColor = "#FFFFFF", maxColor = milken, type = "logarithmic")

map

### tooltip = list(valueDecimals = 2, valuePrefix = "", valueSuffix = "")) %>%     ### dataLabels = list(enabled = TRUE, format = '{point.name}'),

## Save vis
saveWidget(map, file="map_tests_per_thousand.html")
