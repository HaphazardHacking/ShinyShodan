# ShinyShodan
R-based Shodan platform with a web interface

Setup

Ubuntu 18.10
-update/upgrade

RStudio 
-CRAN Packages needed = `devtools, shiny, jsonlite, httr, rpostgreql`
devtools:
    sudo apt install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev
    sudo -i R
    install.packages('devtools')
    devtools::install_github('rstudio/shiny')
    devtools::install_github("RcppCore/Rcpp")
    devtools::install_github("rstats-db/DBI")
    devtools::install_github("rstats-db/RPostgres")

Postgresql + pgAdmin

`apt install postgresql postgresql-contrib`
