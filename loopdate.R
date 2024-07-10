library("tidyverse")

date<-seq(as.Date("2014/1/1"), as.Date("2016/12/31"), "days")
datedf<-as.data.frame(date) |>
  mutate(year=as.character(year(datedf$date)), 
         month=str_pad(as.character(month(datedf$date)), 2, side="left", pad="0"),
         day=str_pad(as.character(day(datedf$date)), 2, side="left", pad="0"),
         datechar=paste0(year,"/wrfout_d01_",year,month,day,".ARL"),
         filename=paste0(year,month,day,".ARL"))

#link<-"https://www.ready.noaa.gov/data/archives/wrf27km/avg/2014/wrfout_d01_20140119.ARL"

for (i in 1:length(date)) {
  url<-paste0("https://www.ready.noaa.gov/data/archives/wrf27km/avg/", datedf$datechar[i])
  download.file(link, datedf$filename[i], mode = "wb")
  print(datedf$filename[i])
}


