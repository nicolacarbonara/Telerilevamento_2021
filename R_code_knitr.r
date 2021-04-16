# R_code_knitr.r
setwd("C:/lab/")  #imposto la working directory
library(knitr) #carico il pacchetto knitr
#stitch("R_code_Greenland", template=system.file("misc", "knitr-template.Rnw", package="knitr")) #stitch nome del file
stitch("R_code_Greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))




