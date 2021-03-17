# my first code in R for remote sensing

setwd("C:/lab/") #imposto la cartella lab come cartella di lavoro
library(raster) #carico il pacchetto raster all'interno del quale trovo brick
p224r63_2011 <- brick("p224r63_2011_masked.grd") #assegno ad una variabile interna un oggetto esterno, importo l'immagine satellitare

plot(p224r63_2011, col=cl) #stampo a video le immagini satellitari

