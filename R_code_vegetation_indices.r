# R_code_vegetation_indices
library(raster) #require(raster)
library(RStoolbox)
library(rasterdiv)
library(rasterVis)
setwd("C:/lab/")


defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
# b1=nir, b2=r, b3=g
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
dvi1<-defor1$defor1.1-defor1$defor1.2 #calcolo l'indice di vegetazione
plot(dvi1)
dvi1norm<-(defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2) #dvi normalizzato (NIR-RED)/(NIR+RED)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1norm, col=cl)
plot(dvi1norm, col=cl, main="DVI at time 1") #assegno un titolo
dvi2norm<-(defor2$defor2.1-defor2$defor2.2)/(defor2$defor2.1+defor2$defor2.2) #1 vegetazione sana, -1 vegetazione pessima
plot(dvi2norm, col=cl, main="DVI at time 2")
par(mfrow=c(1,2))
plot(dvi1norm, col=cl, main="DVI at time 1")
plot(dvi2norm, col=cl, main="DVI at time 2")
difndvi<-dvi1norm-dvi2norm
#qual è la differenza tra le due mappe?
cld <- colorRampPalette(c('blue','white','red'))(150) #è la colorramppalette più comoda per far esaltare le differenze
plot(difndvi, col=cl, main="DVI at time 1-2")
# RStoolbox :: spectralindices
vi <- spectralIndices(defor1, green = 3, red = 2, nir = 1) #spectral indices è una funzione che calcola automaticamente il dvi dichiarando solo le bande
plot(vi, col=cl)
#plot(vi$NDVI, col=cl) sarebbe uguale a plot(dvi1norm, col=cl, main="DVI at time 1")
vi2<-spectralIndices(defor2, green = 3, red = 2, nir = 1)
vidif<- vi-vi2

plot(vidif, col=cld)
#world NDVI
plot(copNDVI)
#pixels with values 253, 254 and 255 (water) will be set as NA's
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
levelplot(copNDVI)
