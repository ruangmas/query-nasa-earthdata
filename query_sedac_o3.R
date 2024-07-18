library("tidyverse")

date<-seq(as.Date("2014/1/1"), as.Date("2016/12/31"), "months")

datedf<-as.data.frame(date) |>
  mutate(year=as.character(year(date)), 
         month=str_pad(as.character(month(date)), 2, side="left", pad="0"),
         datechar=paste0("/aqdh-o3-concentrations-contiguous-us-1-km-v1-10-2000-2016-",year,month,"-geotiff.zip"),
         filename=paste0(year,month,"-geotiff.zip"))

# https://sedac.ciesin.columbia.edu/downloads/data/aqdh/aqdh-o3-concentrations-contiguous-us-1-km-v1-10-2000-2016/
# aqdh-o3-concentrations-contiguous-us-1-km-v1-10-2000-2016-201502-geotiff.zip

setwd("G:/My Drive/2024 Baltimore Crime/SEDAC O3")

for (i in 1:length(date)) {
  url<-paste0("https://sedac.ciesin.columbia.edu/downloads/data/aqdh/aqdh-o3-concentrations-contiguous-us-1-km-v1-10-2000-2016/", datedf$datechar[i])
  download.file(url, datedf$filename[i], mode = "wb")
  print(datedf$filename[i])
}

library("httr")
for (i in 3:(length(date)-1)) {
  url<-paste0("https://sedac.ciesin.columbia.edu/downloads/data/aqdh/aqdh-o3-concentrations-contiguous-us-1-km-v1-10-2000-2016/", 
              datedf$datechar[i])
  response <- GET(url, write_disk(datedf$filename[i], overwrite = TRUE), progress(),
                authenticate("truangmas1812", "FIRESAR00m#2207"), set_cookies("LC" = "cookies"))
}
