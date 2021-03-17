# my first code in R for remote sensing

setwd("C:/lab/") #imposto la cartella lab come cartella di lavoro
library(raster) #carico il pacchetto raster all'interno del quale trovo brick
p224r63_2011 <- brick("p224r63_2011_masked.grd") #assegno ad una variabile interna un oggetto esterno, importo l'immagine satellitare

plot(p224r63_2011, col=cl) #stampo a video le immagini satellitari con scala di colore random di riflettanza
# B=blu B2= banda del verde, B3=rosso, B4=NIR, B5=MIR, B6=TIR, B7=MIR2.
#colorRampPalette("black","grey","light grey") e dobbiamo racchiuderli in un vettore ed è una serie di caratteri, uso la c
cl<-colorRampPalette(c("black","grey","light grey"))(100) #il numero indica quanti livelli di colore ho e la assegno ad una variabile cl
#faccio il plot con il nuovo colore
plot(p224r63_2011,col=cl)#il primo arg. è l'immagine, il secondo è il colore che prendo dal vettore cl
#cambiamo colore
cl<-colorRampPalette(c("black","blue","green","orange","red"))(200)
plot(p224r63_2011,col=cl) #riplotto i nuovi colori

