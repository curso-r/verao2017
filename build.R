library(magrittr)
# Baixar todos os Power Ups -----------------------------------------------

# Obter os repositórios dos power ups do DESCRIPTION
power_ups <- desc::desc_get('PowerUps') %>%
  stringr::str_split(",") %>%
  unlist() %>%
  stringr::str_trim()

download_and_extract_pu <- function(power_up){
  
  # Obter o nome do pu
  pu_name <- power_up %>%
    stringr::str_extract('pu.*$')
  
  file <- tempfile()
  res <- httr::GET(
    sprintf('https://github.com/%s/archive/content.zip', power_up),
    httr::write_disk(file)
  )
  
  unzip(file, exdir = 'content/')
  system(sprintf(
    'mv content/%s-content content/%s/', 
    pu_name, 
    stringr::str_replace(pu_name, '^pu.', '')
  ))
  file.remove(file)
}
purrr::walk(power_ups, download_and_extract_pu)

# install hugo & build site
blogdown::install_hugo(version = "0.17")
blogdown::build_site()
