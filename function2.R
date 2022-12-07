# compilation function
# usage: compileData(dirPath, NAmode, country)
  # dirPath: string, path to desired directory for function application
  # NAmode: string, accepts "remove" "warn" or "include" commands, otherwise returns an error
  # country: string, country name
compileData=function(dirPath, NAmode="remove", country){
  # set working directory
  setwd(dirPath)
  # set variables
    # fileNames: a list of all .csv files in the directory
    fileNames=list.files(path=dirPath, pattern=".csv")
    # country: transfer user input to countryVar
    countryVar=country
    # doy: extract day of year from list of file names
    doy=sub("screen_","",fileNames)
    doy=sub(".csv","",doy)
  # create empty dataframe
  initialData=data.frame()
  
  for(i in 1:length(fileNames)){
    newData=read.csv(fileNames[i],header=TRUE)
    df1=initialData
    df2=newData
    # add country column
    df2$country=(countryVar)
    # add dayOfYear column
    df2$dayOfYear=(doy[i])
    # bind .csv file with previous data
    allData=rbind(df1, df2)
    initialData=allData
  }
  
  # respond to user input
  if (NAmode=="remove"){
    # search by row & column for "NA"
    for (r in allData){
      if is.na(allData[r]){
        allData[(-r),]
      }
    }
  }
  else if (NAmode=="warn"){
    # print warning message
    print("Warning: NAs are included in compiled data.")
  }
  else if (NAmode=="include"){
    # no change
  }
  
  return (allData)
}

directory="/Users/annamccartan/Google Drive/My Drive/School/Fall 2022/Biocomputing/R/RProject/RProject2022/countryX"
runFunction=compileData(dirPath=directory, NAmode="warn", country="X")
# make allData dataframe a .csv file
write.csv(x=runFunction, file="/Users/annamccartan/Google Drive/My Drive/School/Fall 2022/Biocomputing/R/RProject/RProject22/allData.csv")

