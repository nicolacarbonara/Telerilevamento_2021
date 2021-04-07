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
TGr<-stack(import)
plot(TGr)
plotRGB(TGr,1,2,3, stretch="Lin") #utilizzo i canali green blue e red
