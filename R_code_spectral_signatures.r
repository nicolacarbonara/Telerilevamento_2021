# R_code_spectral_signatures.r

library(raster)
library(rgdal)
library(ggplot2)
setwd("C:/lab/")
defor2<-brick("defor2.jpg")
# defor2.1, defor2.2, defor2.3 
# NIR, red, green

plotRGB(defor2, r=1, g=2, b=3, stretch="hist") # plotto con stretch ad istogramma

click(defor2, id=T, xy=T, cell=T, type="point", pch=16, cex=4, col="blue") #prima cosa l'argomento (l'immagine), poi gli chiediamo di creare un ID per punto, # le coordinate # cell sul pixel #type 
    # è una funzione che ci permette di avere le info direttamente cliccando sull'area di interesse nell'immagine
#results 
#  x     y   cell defor2.1 defor2.2 defor2.3
#1 179.5 186.5 208827       53       63       98
      x     y   cell defor2.1 defor2.2 defor2.3
#1 647.5 237.5 172728       84       90      150
      x     y   cell defor2.1 defor2.2 defor2.3
#1 179.5 186.5 208827       53       63       98
#2 647.5 237.5 172728       84       90      150
#decido di fare una tabell con le varie bande
#define the columns of thedatset:
band<-c(1,2,3)
forest<-c(206,6,19)
water<-c(40,99,139)
spectral_s<-data.frame(band, forest, water) #faccio un dataframe

#plot the spectral signature
ggplot(spectral_s, aes(x=band)) + geom_line(aes(y=forest),color="green")+  #geom_line è il tipo di grafico, ggplot apre solo il plot, geom definisce il grafico
geom_line(aes(y=water),color="blue")+
labs(x="band",y="reflectance") #labs= labels

############################# MULTITEMPORAL

# facciamo l'analisi multitemporale
# va fatto sullo stesso pixel o stessa zona

defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="hist") # plotto con stretch ad istogramma

click(defor1, id=T, xy=T, cell=T, type="point", pch=16, cex=4, col="blue")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

# RESULTS
# x     y   cell defor1.1 defor1.2 defor1.3
#1 91.5 325.5 108620      204        3       21
#      x     y   cell defor1.1 defor1.2 defor1.3
#1 145.5 302.5 125096      201        6       20
#      x     y   cell defor1.1 defor1.2 defor1.3
#1 108.5 304.5 123631      217       25       38
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 89.5 285.5 137178      198       14       26
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 68.5 308.5 120735      206       22       34

plotRGB(defor2, r=1, g=2, b=3, stretch="LIN") # plotto con stretch ad istogramma
click(defor2, id=T, xy=T, cell=T, type="point", pch=16, cex=4, col="blue")

#RESULTS
# x     y  cell defor2.1 defor2.2 defor2.3
#1 90.5 345.5 94735      143       82       79
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 120.5 349.5 91897      168       98       86
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 137.5 321.5 111990      170       33       40
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 105.5 315.5 116260      120      125      105
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 136.5 285.5 137801      201       11       21

#colonne dataset
band<-c(1,2,3)
time1<-c(204,3,21)
time1p2<-c(201,6,20) #tempo 1 pixel 2
time2p2<-c(168,98,86) #tempo 2 pixel 2
time2<-c(143,82,79)
spectral_s<-data.frame(band, forest, water) #faccio un dataframe


spectral_st<-data.frame(band, time1, time2)

# plot spectral signatures
ggplot(spectral_st, aes(x=band)) + geom_line(aes(y=time1),color="red")+  #geom_line è il tipo di grafico, ggplot apre solo il plot, geom definisce il grafico
geom_line(aes(y=time2),color="blue")+
geom_line(aes(y=time1p2),color="grey")+
geom_line(aes(y=time2p2),color="black", linetype="dotted")+
labs(x="band",y="reflectance") #labs= labels

# image from Earth Observatory

caspio<-brick("caspian_2010.jpg")
plotRGB(caspio, 1,2,3, stretch="hist")
click(caspio, id=T, xy=T, cell=T, type="point", pch=16, cex=4, col="blue")

# results
#     x      y     cell caspian_2010.1 caspian_2010.2 caspian_2010.3
#1 3432.5 2810.5 12275033             47             77             75
#       x      y     cell caspian_2010.1 caspian_2010.2 caspian_2010.3
#1 1464.5 3002.5 11428265             67             83             47
#       x      y     cell caspian_2010.1 caspian_2010.2 caspian_2010.3
#1 1586.5 2018.5 15757987             99             94             64

band<-c(1,2,3)
stratum1<-c(47,77,75)
stratum2<-c(67,83,47) 
stratum3<-c(99,94,64)

spectralsg<-data.frame(band, stratum1, stratum2, stratum3) #faccio un dataframe

ggplot(spectralsg, aes(x=band)) + 
geom_line(aes(y=stratum1),color="red", linetype="dotted")+  #geom_line è il tipo di grafico, ggplot apre solo il plot, geom definisce il grafico
geom_line(aes(y=stratum2),color="blue", linetype="dotted")+
geom_line(aes(y=stratum3),color="grey", linetype="dotted")
labs(x="band",y="reflectance") #labs= labels
