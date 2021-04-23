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

