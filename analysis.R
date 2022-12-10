# read in functions defined in supportingFunctions.R
functionPath="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject-anna/supportingFunctions.R"
source(functionPath)

# use csvConvert to convert country Y files to .csv
Ypath="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject-anna/Rproject2022/countryY"
setwd(Ypath)
csvConvert()

# use compileData to combine all country X files into one, all country Y files into one
Xpath="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject-anna/Rproject2022/countryX"
compileData(dirPath=Xpath, NAmode="remove", country="X", dataName="XData.csv")
Ypath="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject-anna/Rproject2022/countryY"
compileData(dirPath=Ypath, NAmode="remove", country="Y", dataName="YData.csv")
# combine country X and country Y files
setwd(Xpath)
Xdf=read.csv("XData.csv")
setwd(Ypath)
Ydf=read.csv("YData.csv")
compiledData=rbind(Xdf, Ydf)
dataPath="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject-anna/Rproject2022/"
setwd(dataPath)
write.csv(compiledData, file="compData.csv")

# use summData to process the data included in the entire data set
library(ggplot2)
summData("compData.csv")
# answer two questions
  # in which country did the disease outbreak likely begin?
  # if country Y develops a vaccine, is it likely to work for country X's citizens?
# provide graphical evidence for answers
# use comments in analysis.R to explain rational and how graphical evidence supports answers