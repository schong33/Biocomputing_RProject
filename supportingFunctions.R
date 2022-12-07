# Supporting Functions

# Function 1: convert tab-delimited files to comma-separated files
# usage: csvConvert(dirPath=directory)
    # directory="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject/Rproject2022/countryY"
# dirPath: string, path to directory of .txt files to convert
csvConvert<-function(){
  # identify .txt files in directory
  v1<-list.files(pattern=".txt")
  for (i in v1){
    # convert each file to dataframe
    v2<-read.table(file=i,sep=" ",header=TRUE)
    # rename each dataframe
    newname<-sub("txt","csv",i)
    # convert each dataframe to .csv
    write.csv(x=v2, file=newname, row.names=FALSE)   
  }
}

# Function 2: compile .csv files in a directory
# usage: compileData(dirPath=directory, NAmode="remove", country="X", destPath=destination)
      # directory="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject/Rproject2022/countryX"
      # destination="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject/Rproject2022\\compiledData.csv"
# dirPath: string, path to desired directory for function application
# NAmode: string, accepts "remove" "warn" or "include" commands, otherwise returns an error
# country: string, country name
# destPath: string, path to desired directory/filename for storage of compiled .csv file
compileData<-function(dirPath, NAmode="remove", country, destPath){
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
    # import .csv file as new dataframe
    newData=read.csv(fileNames[i],header=TRUE)
    # initial dataframe contains previously compiled data
    df1=initialData
    # new dataframe contains new data
    df2=newData
    # add country column to new data
    df2$country=(countryVar)
    # add dayOfYear column to new data
    df2$dayOfYear=(doy[i])
    # bind new dataframe with previous
    allData=rbind(df1, df2)
    # update initial dataframe to reflect most recent addition
    initialData=allData
  }
  
  # respond to user input
  if (NAmode=="remove"){
    for (r in 1:nrow(allData)){
      # search each row for presence of NA values
      if (anyNA(allData[r,])){
        # remove rows containing NAs
        allData=allData[(-r),]
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
  else {
    # return error
    print("Invalid input for NAMode")
  }
  # make allData dataframe a .csv file
  write.csv(x=allData, file=destPath)
}

# Function 3: summarize compiled data
# usage: summData(compData=dataPath)
    # dataPath="/Users/annamccartan/Library/CloudStorage/GoogleDrive-annamac2021@gmail.com/My Drive/School/Fall 2022/Biocomputing/R/Biocomputing_RProject/Rproject2022\\compiledData.csv"
# dataPath: path to compiled .csv data file
summData <- function(compData){
  DataSet<-read.table(compData, header=TRUE, sep=",", stringsAsFactors=FALSE)
  
  #Number of screens run can be determined by the number of rows(patients) in the DataSet
  NumberOfScreens <- nrow(DataSet)
  
  
  #Goal: Percent of patients screened that were infected
  #Patients with at least one marker are infected patients
  
  #create variables to hold the number of infected and notinfected patients
  Infected<-0
  NotInfected<-0
  
  #Add up the total number of infected and notinfected patients
  for(i in 1:nrow(DataSet)){
    SumRow<-sum(DataSet$marker01[i], DataSet$marker02[i],DataSet$marker03[i],DataSet$marker04[i], DataSet$marker05[i],DataSet$marker06[i],DataSet$marker07[i], DataSet$marker08[i],DataSet$marker09[i],DataSet$marker10[i])
    
    if(SumRow>0){
      
      Infected<-Infected+1
      
    }else{
      
      if(SumRow==0)
        NotInfected<-NotInfected+1
    }
  } 
  
  #Percent of population infected can be determined by Infected Patients/Total number of patients screened
  PercentInfected<-Infected/NumberOfScreens
  
  #Goal: Compарее Мale vs. Female infected patient percentages
  
  #Infected Male Patients
  MaleInfected<-0
  MaleNotInfected<-0
  
  #Add up the total number of Male infected and notinfected patients
  for(i in 1:nrow(DataSet)){
    if(DataSet$gender[i]=="male"){
      MSumRow<-sum(DataSet$marker01[i], DataSet$marker02[i],DataSet$marker03[i],DataSet$marker04[i], DataSet$marker05[i],DataSet$marker06[i],DataSet$marker07[i], DataSet$marker08[i],DataSet$marker09[i],DataSet$marker10[i])
      
      if(MSumRow>0){
        
        MaleInfected<-MaleInfected+1
        
      }else{
        
        if(MSumRow==0)
          MaleNotInfected<-MaleNotInfected+1
      }
    } 
    
  }
  MaleTotal=(MaleInfected+MaleNotInfected)
  
  #Percent of Male infected can be determined by Infected Patients/Total number of patients screened
  PercentMaleInfected<-MaleInfected/MaleTotal
  
  #Infected Female Patients
  FemaleInfected<-0
  FemaleNotInfected<-0
  
  #Add up the total number of Male infected and notinfected patients
  for(i in 1:nrow(DataSet)){
    if(DataSet$gender[i]=="female"){
      FSumRow<-sum(DataSet$marker01[i], DataSet$marker02[i],DataSet$marker03[i],DataSet$marker04[i], DataSet$marker05[i],DataSet$marker06[i],DataSet$marker07[i], DataSet$marker08[i],DataSet$marker09[i],DataSet$marker10[i])
      
      if(FSumRow>0){
        
        FemaleInfected<-FemaleInfected+1
        
      }else{
        
        if(FSumRow==0)
          FemaleNotInfected<-FemaleNotInfected+1
      }
    } 
    
  }
  FemaleTotal=(FemaleInfected+FemaleNotInfected)
  
  #Percent of Male infected can be determined by Infected Patients/Total number of patients screened
  PercentFemaleInfected<-FemaleInfected/FemaleTotal
  
  
  #Age distribution of all patients plotted
  ggplot(data=DataSet,aes(x=age))+
    geom_freqpoly()+
    theme_classic()+
    xlim(0,100)
  
  
  #create new data frame with infected patient data
  InfectedPlot=data.frame()
  
  for(i in 1:nrow(DataSet)){
    SumRow<-sum(DataSet$marker01[i], DataSet$marker02[i],DataSet$marker03[i],DataSet$marker04[i], DataSet$marker05[i],DataSet$marker06[i],DataSet$marker07[i], DataSet$marker08[i],DataSet$marker09[i],DataSet$marker10[i])
    
    if(SumRow>0){
      
      InfectedPlot= rbind(InfectedPlot, DataSet[i,])
      
    }
  }
  
  #Age distribution of all infected patients plotted
  ggplot(data=InfectedPlot,aes(x=age))+
    geom_freqpoly()+
    theme_classic()+
    xlim(0,100)
}

