# my first code in R for remote sensing

setwd("C:/lab/") #imposto la cartella lab come cartella di lavoro
library(raster) #carico il pacchetto raster all'interno del quale trovo brick
p224r63_2011 <- brick("p224r63_2011_masked.grd") #assegno ad una variabile interna un oggetto esterno, importo l'immagine satellitare

plot(p224r63_2011, col=cl) #stampo a video le immagini satellitari con scala di colore random di riflettanza
# B=blu B2= banda del verde, B3=rosso, B4=NIR, B5=SWIR (ShortWave IR), B6=TIR (Thermal IR), B7=SWIR2.
#colorRampPalette("black","grey","light grey") e dobbiamo racchiuderli in un vettore ed è una serie di caratteri, uso la c
cl<-colorRampPalette(c("black","grey","light grey"))(100) #il numero indica quanti livelli di colore ho e la assegno ad una variabile cl
#faccio il plot con il nuovo colore
plot(p224r63_2011,col=cl)#il primo arg. è l'immagine, il secondo è il colore che prendo dal vettore cl
#cambiamo colore
cl<-colorRampPalette(c("black","blue","green","orange","red"))(200)
plot(p224r63_2011,col=cl) #riplotto i nuovi colori
> p224r63_2011 #il path è il 224 e la riga è la 63
#class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax) #siamo a 80 km circa dal meridiano di riferimento del fuso e a 50 km a sud dell'equatore
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs sistema di riferimento #unità in metri #WGS84 come sistema di riferimento #proiezione utm per adagiarlo sul piano #fuso 22
#source     : C:/lab/p224r63_2011_masked.grd 
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
#max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634
