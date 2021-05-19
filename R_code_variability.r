# R_code_variability.r
library(raster)
library(RStoolbox)
setwd("C:/lab/")
sent<-brick("sentinel.png")
#plotto con le bande NIR 1, red 2, green 3, 
# r=1, g=2, b=3
plotRGB(sent)
nir<-sent$sentilel.1
red<-sent$sentinel.2
green<-sent$sentinel.3
ndvi<-(nir-red)/(nir+red)
plot(ndvi)
#utilizzo la funzione "focal" che utilizza la moving window
ndvisd3<-focal(ndvi, w=matrix(1/9,nrow=3, ncol=3), fun=sd) #w=window, ovvero la matrice 3 x 3 #fun= function, sd= deviazione standard
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd)
#cambio la dimensione della finestra mobile
ndvisd5<-focal(ndvi, w=matrix(1/25,nrow=5, ncol=5), fun=sd) #w=window, ovvero la matrice 3 x 3 #fun= function, sd= deviazione standard
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd)
#uso la funzione mean
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)
#calcoliamo la pca e usiamo solo la componente principale
sentpca<-rasterPCA(sent)
plot(sentpca$map)
summary(sentpca$model)
#the first pc explain 67.36804% of the original information







