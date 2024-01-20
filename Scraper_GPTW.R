
#######################################
###  Scraper Great Place To Work ###
#######################################

rm(list=ls())

# Cargar librerías --------------------------------------------------------
library(rvest)      # HTML Hacking & Web Scraping
library(tidyverse)  # Data Manipulation
library(openxlsx)   # Excel manipulation
library(xopen)      # Opens URL in Browser
library(beepr)      # Notification sounds

# Guardar URL ------------------------------------------------------------------

url <- "https://www.greatplacetowork.com.pe/mejores-lugares-para-trabajar/los-mejores-lugares-para-trabajar-del-mundo/2022"
xopen(url)

# Leer HTML --------------------------------------------------------------------
page <- read_html(url)


# Almacenar nodos en una BD ----------------------------------------------------
df <- data.frame()

ranking       <- page |> html_nodes(".large") |> html_text()
empresa       <- page |> html_nodes(".h5") |> html_text()
localizacion  <- page |> html_nodes(".location li") |> html_text()
industria     <- page |> html_nodes(".industry li") |> html_text()
empleados     <- page |> html_nodes(".employee-count li") |> html_text()


df <- rbind(df, data.frame(ranking, empresa, localizacion, industria, empleados))


#Agrupar por años desde 2019 al 2023

for (page_result in seq(from = 2019, to = 2022, by = 1)) {
  
  url  <- paste0("https://www.greatplacetowork.com.pe/mejores-lugares-para-trabajar/los-mejores-lugares-para-trabajar-del-mundo/", page_result)
  page <- read_html(url)
  
  ranking       <- page |> html_nodes(".large") |> html_text()
  empresa       <- page |> html_nodes(".h5") |> html_text()
  localizacion  <- page |> html_nodes(".location li") |> html_text()
  industria     <- page |> html_nodes(".industry li") |> html_text()
  empleados     <- page |> html_nodes(".employee-count li") |> html_text()
  
  df <- rbind(df, data.frame(ranking, empresa, localizacion, industria, empleados))
  
  print(paste("Pagina:", (page_result-2019)+1))
  beep(2) # Notificar iteración exitosa
}

beep(8) # Notificar compilado exitoso

View(df)

#Quitar los espacios vacíos de las dos primeras columans

df <- as.data.frame(apply(df, 2, str_remove_all, " "))


# Exportar data como archivo excel ----
write.xlsx(df, "GPTW.xlsx")



# Initialize an empty data frame
df <- data.frame()

# Agrupar por años desde 2019 al 2022
for (page_result in seq(from = 2019, to = 2022, by = 1)) {
  
  url  <- paste0("https://www.greatplacetowork.com.pe/mejores-lugares-para-trabajar/los-mejores-lugares-para-trabajar-del-mundo/", page_result)
  page <- read_html(url)
  
  ranking       <- page |> html_nodes(".large") |> html_text()
  empresa       <- page |> html_nodes(".h5") |> html_text()
  localizacion  <- page |> html_nodes(".location li") |> html_text()
  industria     <- page |> html_nodes(".industry li") |> html_text()
  empleados     <- page |> html_nodes(".employee-count li") |> html_text()
  
  # Create a temporary data frame for the current page
  temp_df <- data.frame(ranking, empresa, localizacion, industria, empleados)
  
  # Bind the temporary data frame to the main data frame
  df <- rbind(df, temp_df)
  
  print(paste("Pagina:", (page_result-2019)+1))
}

# View the final data frame
View(df)




