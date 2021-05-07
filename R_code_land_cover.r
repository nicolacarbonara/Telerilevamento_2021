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

#unsupervised classification
d1c<- unsuperClass(defor1, nClasses=2)
d2c<- unsuperClass(defor2, nClasses=2)
# set.seed(43) would allow you to attain the same results
# class 1: agricolture
# class 2: forest
# forest soil loss and pixels frequency 
freq(d1c$map)
 #value  count
#[1,]     1  35373
#[2,]     2 305919
# calcoliamo la proporzione
s1<- 35373+305919
prop1<- freq(d1c$map)/s1 #89.9% di foresta e 10.1% di agricolo
freq(d2c$map)
 #value  count
#[1,]     1  35373
#[2,]     2 305919
s2<- 164243+178483
prop2<- freq(d2c$map)/s2 #foresta 52.1% agricoltura 47.9%
# facciamo un dataframe
pecentagescover <- c("Forest","Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)  
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
#grafico con ggplot2
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover))+geom_bar(stat="identity", fill="red")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover))+geom_bar(stat="identity", fill="cyan")
graf1<-ggplot(percentages, aes(x=cover, y=percent_1992, color=cover))+geom_bar(stat="identity", fill="red") #aes = aestetics
graf2<-ggplot(percentages, aes(x=cover, y=percent_2006, color=cover))+geom_bar(stat="identity", fill="cyan")
grid.arrange(graf1, graf2, nrow=2)
