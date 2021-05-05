# R_code_land_cover.r
library(raster) #require(raster)
library(RStoolbox)
library(ggplot2)
setwd("C:/lab/")

defor1<-brick("defor1.jpg") #carico il file defor1.jpg
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="Lin")
defor2<-brick("defor2.jpg") #carico il file defor2.jpg
ggRGB(defor2, r=1, g=2, b=3, stretch="Lin")
par(mfrow=c(1,2))
ggRGB(defor1, r=1, g=2, b=3, stretch="Lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="Lin")

install.packages("gridExtra") #mi serve per utilizzare ggplot per i raster
library(gridExtra)
#multiframe with ggplot2 and gridExtra
p1<-ggRGB(defor1, r=1, g=2, b=3, stretch="Lin")
p2<-ggRGB(defor2, r=1, g=2, b=3, stretch="Lin")
grid.arrange(p1, p2, nrow=2)


