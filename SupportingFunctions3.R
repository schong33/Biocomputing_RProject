#Biocomputing R Project Notes
#1. In which country (X or Y) did the disease outbreak likely begin?
#2. If Country Y develops a vaccine for the disease, is it likely to work for citizens of Country X?
#presence or absence of ten markers specific to an immunologically active protein

#Custom Function 3
#summarize the compiled data set 
#number of screens run=count rows
#percent of patients screened that were infected=patients with at least one marker/total patients
#male vs. female patients=if male infected male/total male, else female infected female/total female
#and the age distribution of patients=plot?

DataSet<-read.table("allData.csv",header=TRUE, sep=",", stringsAsFactors=TRUE)
NumberOfScreens <- length()

