# R code complete Telerilevamento Geo_Ecologico

#------------------------------------------------------------------------

# Summary:

# 1. Remote Sensing first code
# 2. R code Time series
# 3. R code Copernicus
# 4. R code knitr
# 5. R code Multivariate Analysis
# 6. R code Classification
# 7. R code ggplot2
# 8. R code Vegetation Indices
# 9. R code Land Cover
# 10. R code Variability


#------------------------------------------------------------------------

# 1. Remote Sensing first code

# my first code in R for remote sensing 
#immagini Landsat

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

install.packages("RStoolbox") #installo il pacchetto RStoolbox
library(RStoolbox) #carico il pacchetto
install.packages("ggplot2") #installo il pacchetto ggplot2
library(ggplot2)  #richiamo il pacchetto ggplot2

#image 1988
p224r63_1988<-brick("p224r63_1988_masked") #importo il file p224r63_1988_masked interamente con tutte le sue bande
plot(p224r63_1988) #plotto l'immagine con tutte le sue bande
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") #plotto in RGB con allargamento dei valori di riflettanza lineare (stretch=Lin)
#apro una immagine 2x2 confrontando le immagini del 1988 e 2011 con la banda r=IR e utilizzo dello stretch sia lineare che hist
pdf("confronto_1988-2011_2x2.pdf") #creo l'immagine in pdf
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

#bash scripting:
#pdftk *.pdf  cat output mergedfile.pdf

#------------------------------------------------------------------------

# R code Time series

#Time series analysis
#Greenland increase of temperature
#Data and code from Emanuela Cosma

setwd("C:/lab/Greenland") #imposto la cartella greenland come cartella di lavoro
library(raster) #carico il pacchetto raster all'interno del quale trovo brick
library(rasterVis) #carico il pacchetto rasterVis precedentemente installato
#stack è un insieme di dati raster
lst_2000<-raster("lst_2000.tif") #importo il dataset lst_2000.tif
plot(lst_2000) #plotto il dataset così com'è
lst_2005<-raster("lst_2005.tif")
plot(lst_2005)
lst_2010<-raster("lst_2010.tif")
plot(lst_2010)
lst_2015<-raster("lst_2015.tif")
plot(lst_2015)
#par
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#per importare tutte le immagini in maniera sincrona
rlist<-list.files(pattern="lst") #prendo lst come pattern comunne per caricare i file insieme
import<-lapply(rlist, raster) #applico la funzione raster a tutti i file contenuti nella rlist contemporaneamente e la associamo al dataset "import"
#facciamo un file unico dalla lista (un pacchetto di files)
TGr<-stack(import) #unisce tutti i file contenuti nella lista import
plot(TGr)
plotRGB(TGr,1,2,3, stretch="Lin") #utilizzo i canali green blue e red
# blocco intero e una sola legenda con LEVELPLOT
levelplot(TGr)
levelplot(TGr$lst_2000) #con il $ considero solo un sotto insieme del file, ovvero plotto solo lst_2000
#cambiamo la color palette
cl <- colorRampPalette(c("blue","light blue","pink","red"))(150) #associo alla scala dei valori i 4 colori con 150 gradi di sfumature
levelplot(TGr, col.regions=cl)
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #con names dò un nome progressivo ai vari livelli
levelplot(TGr,col.regions=cl, main="LST Variation in Time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #assegno anche un titolo con main
mlist<-list.files(pattern="melt") #creo una lista per raccogliere tutti i file che hanno melt come nome comune
import_m<-lapply(mlist, raster) #applico la funzione raster a tutti gli elementi della mlist
melt<-stack(import_m) #unisco (stack) tutti i file processati con la funzione raster di prima
levelplot(melt) #plotto melt così com'è
#icesheet differenze2007-1979
melt_amount<- melt$X2007annual_melt - melt$X1979annual_melt #faccio la differenza tra due sotto livelli di melt e l'associo a melt_amount
#creo una nuova ramppalette con colori più efficaci
cl2<-colorRampPalette(c("blue","white","dark red"))
levelplot(melt_amount,col.regions=cl2, main="ice loss from 1979 to 2007")

#------------------------------------------------------------------------

# 3. R code Copernicus

# R_code_copernicus
# Visualizing Copernicus data
# ci servono delle librerie per aprire i file scaricati
setwd("C:/lab/") #imposto la cartella lab come cartella di lavoro
library(raster)
library(ncdf4)
soil_w_index<-raster("c_gls_SWI1km_202104071200_CEURO_SCATSAR_V1.0.1.nc") # carico in R il file esterno
cls <- colorRampPalette(c('light blue','green','red','yellow'))(150) #assegno una ramp palette
plot(soil_w_index, col=cls, main="water index") #plotto con il titolo
soil_w_indexres<-aggregate(soil_w_index, fact=10) #ricampiono l'immagine di un fattore 10 (10x10 pixels e li trasformo in uno solo) e lo assegno a #soil_w_indexres linearmente
plot(soil_w_indexres, col=cls, main="soil water index")

#------------------------------------------------------------------------

# 4. R code knitr

# R_code_knitr.r
setwd("C:/lab/")  #imposto la working directory
library(knitr) #carico il pacchetto knitr
#stitch("R_code_Greenland", template=system.file("misc", "knitr-template.Rnw", package="knitr")) #stitch nome del file
stitch("R_code_Greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#------------------------------------------------------------------------

# 5. R code Multivariate Analysis

# R_code_multivaried_analysis
#serve per diminuire il set di variabili
#quando ci sono variabili non molto correlabili, prendo il file originale e faccio la pca
library(raster)
library(RStoolbox)

setwd("C:/lab/")

p224r63_2011<-brick("p224r63_2011_masked.grd") # brick mi carica tutto il set di dati, raster solo un una banda per volta
plot(p224r63_2011)
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col=red, pch=19, cex=2) #plotto dell'immagine, solo le bande b1 e b2 e vedo come sono correlati, Multicollinearità, cioè i punti sono ben correlati
#voglio vedere la correlazione tra tutte le variabili e plottarle a coppie e vedere quelle che si correlano
pairs(p224r63_2011)
#ricampionare il dato poichè col PCA è troppo impattante con la risoluzione originale e aggreghiamo i pixel con una media generando un solo pixel.
# essendo i pixel 30 x 30 m, fact è il fattore che utilizziamo per ingrandire il pixel.
# aggregate cells
p224r63_2011res<-aggregate(p224r63_2011, fact=10) #resampled #ingrandiamo il pixel e riduciamo la risoluzione dell'immagine di 10 volte
p224r63_2011res #avrò una immagine 300 x 300 pxl
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #banda deel rosso c'è IR, nel verde il rosso
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
# PCA principal component analysis for rasters, passiamo l'asse lungo la variabilità maggiore e a quella minore. 
p224r63_2011res_pca<-rasterPCA(p224r63_2011res)
summary(p224r63_2011res_pca$model) #ci dà un sommario del nostro modello
 # ecco il risultato 
 #Importance of components:
                          Comp.1      Comp.2       Comp.3       Comp.4
#Standard deviation     1.2050671 0.046154880 0.0151509516 4.575220e-03
#Proportion of Variance 0.9983595 0.001464535 0.0001578135 1.439091e-05 #la seconda banda aggiunge solo 0.1464535 % alla prima banda
#Cumulative Proportion  0.9983595 0.999824022 0.9999818357 9.999962e-01 #con la sola prima componente spiego il 99,83595%, mentre con quattro bande il 99,99962e-01  cioè quasi la totalità.  
                             Comp.5       Comp.6       Comp.7
#Standard deviation     1.841357e-03 1.233374e-03 7.595367e-04
#Proportion of Variance 2.330990e-06 1.045814e-06 3.966085e-07
#Cumulative Proportion  9.999986e-01 9.999996e-01 1.000000e+00 #100%
plot(p224r63_2011res_pca$map) #vedo che la prima banda già mi spiega molto
#faccio un plot rgb con le prime 3 bande
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="Lin")
plot(p224r63_2011res_pca$map$PCA1, p224r63_2011res_pca$map$PCA2)

#------------------------------------------------------------------------

# 6. R code Classification

#R_code_classification.r
setwd("C:/lab/")
library(raster)
library(RStoolbox)
#carico la libreria raster
so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #importo l'immagine multibanda esterna all'ambiente R e le metto insieme
# visualize rgb levels
plotRGB(so, 1, 2, 3, stretch="lin")
#classificatione non supervisionata in base solo alle riflettanze (unsupervised classification)
#nsample è il numero di campioni
soc<-unsuperClass(so, nClasses=3) #associamo le classi ad un oggetto
#plottiamo la mappa delle classi
plot(soc$map) #ho una mappa delle classi ma in scala continua e la classificazione non è replicabile
set.seed(42) # mi rende le classi intere
soc20<-unsuperClass(so, nClasses=3)
cl <- colorRampPalette(c('yellow','red','brown'))(150)
plot(soc20$map,col=cl)
#altra immagine
so3<-brick("sun.jpg")
sun3<-unsuperClass(so3, nClasses=3)
plot(sun3$map)
 
# Grand Canyon 
# carichiamo l'immagine rgb
gc<-brick("dolansprings_oli_2013088_canyon_lrg") #associamo l'immagine all'oggetto cg
plotRGB(gc, r=1, g=2, b=3, stretch="Lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist") #Option to stretch the values to increase the contrast of the image: "lin" or "hist"
gcc<-unsuperClass(gc, nClasses=2) #associamo la riflettanza di ogni pixel a delle classi e la associo all'oggetto gcc
# serve per il riconoscimento generico delle litologie
plot(gcc$map,col=cl) #plot della mappa contenuta nel plot
gcc4<-unsuperClass(so, nClasses=4) #4 classi

#------------------------------------------------------------------------

# 7. R code ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#------------------------------------------------------------------------

# 8. R code Vegetation Indices

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

#------------------------------------------------------------------------

# 9. R code Land Cover

# abbiamo utilizzato gli algoritmi di classificazione delle immagini e abbiamo fatto una analisi multitemporale della variazione della copertura del suolo 

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

#------------------------------------------------------------------------

# 10. R code Variability

# variabilità del paesaggio, mappe di variabilità ecc

# R_code_variability.r
library(raster)
library(RStoolbox)
library(viridis)
library(gridExtra)
library(ggplot2)
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
pc1<-sentpca$map$PC1
pc1st5<-focal(pc1,w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clst<-colorRampPalette(c('blue', 'red', 'yellow', 'green', 'black'))(150)
plot(pc1st5, col=clst, stretch="lin")
# source function
source("source_test_lezione.r") #inserisco un pezzo di codice e lo carico direttamente tramite la funzione source, calcola la deviazione standard con matrice 7x7
source("source_ggplot.r")
p1<-ggplot()+ #ggplot() apre una finestra in cui contenere un oggetto ggplot
geom_raster(pc1st5, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis()#aes=aestetics, riempimento il layer

p2<-ggplot()+ #ggplot() apre una finestra in cui contenere un oggetto ggplot
geom_raster(pc1st5, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis(option="magma")

p3<-ggplot()+ #ggplot() apre una finestra in cui contenere un oggetto ggplot
geom_raster(pc1st5, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis(option="turbo")
#più grafici in una pagina con gridarrange
grid.arrange(p1,p2,p3, nrow=1)

#------------------------------------------------------------------------





