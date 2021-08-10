# R_code_no2

# 1. set the working directory

setwd("C:/lab/EN/")
library(raster)
library(RStoolbox) #here for miltivariate analysis

# 2. Import the first image (single band)
# we will select band 1, but the raster function enables to select other single-bands
# [suggerimento studenti]
# https://www.rdocumentation.org/packages/raster/versions/3.4-10/topics/raster
#con brick importo tutto il blocco (tutte le immagini) con raster solo una di quelle
EN01<-raster("EN_0001.png") #importo solo l'immagine uno

# 3. Plot the first imported image with your preferred color ramp palette
#uso una rampPalette idonea per plottre il primo strato (banda 1)
cl<-colorRampPpalette(c("black","blue","green","yellow","red"))(150)
#cls <- colorRampPalette(c("black","red","pink","orange","yellow")) (200)
plot(EN01, col=cl)

# 4. Import the last image (13th) and plot it with the previous color ramp palette
EN13<-raster("EN00_13.png")

# 5. make the differenze between the two images and plot it
#eith March - January or viceversa
ENdiff<-EN01-EN13
plot(ENdiff, col=(c("white","orange","red")(200))

# 6. plot everything together
par(mfrow=c(3,1))
plot(EN01, col=cls, main="Gennaio")
plot(EN13, col=cls, main= "Marzo")
plot(ENdiff, col=cls, main="DIFFERENZA Gennaio - Marzo")

# 7. Import the whole set IMPORTANTE!!!!

rlist<-list.files(pattern="EN")
import<-lapply(rlist,raster)
EN <- stack(import)
plot(EN, col=cls)


# 8. Replicate the plot of images 1 and 13 using the stack
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cls)
plot(EN$EN_0013, col=cls)

# 9. PCA
EN_pca<-rasterPCA(EN)
summary(EN_pca$model)
plotrgb(EN_pca$map,r=1, g=2, b=3, stretch="Lin")

# 10. compute di variability (local standard deviation) of the first pca
EN_sd<-focal(EN_pca$map$PC1, w=matrix(1/9,nrow=3,ncol=3),fun=sd)
plot(EN_sd, col=cls)
