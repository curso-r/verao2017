install.packages("devtools", repos = "https://cran.rstudio.com")
devtools::install_github("rstudio/blogdown")
blogdown::install_hugo()
blogdown::build_site()
