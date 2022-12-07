# read in functions defined in supportingFunctions.R
functionPath="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject/supportingFunctions.R"
source(functionPath)

# define directory and storage paths
Xpath="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject/Rproject2022/countryX"
Ypath="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject/Rproject2022/countryY"
storeX="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject/Rproject2022\\XData.csv"
storeY="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject/Rproject2022\\YData.csv"

# use csvConvert to convert country Y files to .csv
setwd(countryY)
csvConvert()
# use compileData to combine all country X files into one, all country Y files into one
countryX.csv=compileData(dirPath=Xpath, NAmode="remove", country="X", destPath=storeX)
countryY.csv=compileData(dirPath=Ypath, NAmode="remove", country="Y", destPath=storeY)
# combine country X and country Y files

# use function 3 to process the data included in the entire data set
# answer two questions
  # in which country did the disease outbreak likely begin?
  # if country Y develops a vaccine, is it likely to work for country X's citizens?
# provide graphical evidence for answers
# use comments in analysis.R to explain rational and how graphical evidence supports answers