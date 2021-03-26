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
cl<-colorRampPalette(c("black","blue","green","orange","red"))(200) #con 200 gradi di variazione di colore
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
#B1: BLU, B2: VERDE, B3: ROSSO, B4:NIR, B5: MEDIO IR, B6:IR TERMICO, B7: MEDIO IR.

#voglio plottare solo la banda del blu
dev.off() #clean the current graph
plot(p224r63_2011$B1_sre) #plotto solo il sottoinsieme della banda blu
#ora plotto la banda 1 con i colori nuovi definiti
cl<-colorRampPalette(c("blue","yellow","red","green"))(200)
plot(p224r63_2011$B1_sre,col=cl) #riplotto i nuovi colori solo per la banda blu
dev.off()
#vogliamo un grafico con delle bande specifiche, MultiFrame
par(mfrow=c(1,2)) #prepara un grafico con 1 riga e 2 colonne
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

par(mfrow=c(2,1)) #prepara un grafico con 2 righe e 1 colonna
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#con mfrow definisco prima il numero delle righe nel vettore c
#rifaccio il plot con la nuova gamma di colori
par(mfrow=c(2,1)) #prepara un grafico con 2 righe e 1 colonna
plot(p224r63_2011$B1_sre,col=cl) 
plot(p224r63_2011$B2_sre,col=cl)
#plot the first four bands of Landsat
par(mfrow=c(4,1)) #plotto le 4 bande in una sola colonna
plot(p224r63_2011$B1_sre,col=cl)
plot(p224r63_2011$B2_sre,col=cl)
plot(p224r63_2011$B3_sre,col=cl)
plot(p224r63_2011$B4_sre,col=cl)
par(mfrow=c(2,2)) #plotto le 4 bande in una 2 colonne e 2 righe
clb<-colorRampPalette(c("dark blue", "blue", "purple"))(200) #definisco nuovi colori
plot(p224r63_2011$B1_sre,col=clb)
clg<-colorRampPalette(c("dark green", "green", "light green"))(200)
plot(p224r63_2011$B2_sre,col=clg)
clr<-colorRampPalette(c("dark red", "red", "light pink"))(200)
plot(p224r63_2011$B3_sre,col=clr)
clnir<-colorRampPalette(c("red", "orange", "yellow"))(200)
plot(p224r63_2011$B4_sre,col=clnir)

#visualizing RBG
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="LIN") #associo al red la terza banda, al green la seconda e al blu la prima #stretch allarga i valori di riflettanza in maniera lineare
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #montiamo l'infrarosso nella componente red quindi diventa rosso
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #sposto l'IR sulla banda green
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") #sposto l'IR sulla banda blue
# mount a 2x2 multiframe
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="LIN")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

pdf("il_mio_primo_pdf.pdf") #creo l'immagine in pdf
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="LIN")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #cambio il tipo di stretch, non lineare ed enfatizzo i valori centrali

#par natural colours,false colours and false colours with histogram stretch
par(mfrow=c(3,1)) #creo una immagine con 3 immagine su una colonna
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")
