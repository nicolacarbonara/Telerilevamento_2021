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



