#This is an R script  for Project 2 of Exploratory Data Analysis Course 
# This script is for Plot2  - Answearing Question 2
#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.


##### Data load 

#Download the files and unzip them into a data directory  
if(!file.exists("data")) {
        dir.create("data")
}
if(!file.exists("./data/FNEI_data.zip")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileUrl, destfile="./data/FNEI_data.zip")
        if(file.exists("./data/FNEI_data.zip")) 
                unzip("./data/FNEI_data.zip",exdir="./data")
}



#Read the two files using the readRDS command
if(file.exists("./data/summarySCC_PM25.rds")) 
        NEI <- readRDS("./data/summarySCC_PM25.rds")
if(file.exists("./data/Source_Classification_Code.rds")) 
        SCC <- readRDS("./data/Source_Classification_Code.rds")

#####Data processing 

#Create a Bar plot of the PM2.5 Emission values from all sources across the given years (199,2002,2005,2008)
#for the for Baltimore City, Maryland (fips == "24510"|} 
#normalize by 10^6 
PM2_5_Maryland<-NEI[NEI$fips=="24510",]  
PM2_5_Maryland_All_Sources<-tapply(PM2_5_Maryland$Emissions, PM2_5_Maryland$year, sum) 

##### Graph plot 

#Plot to PNG file 
png("plot2.png",width=480,height=480,units="px")
barplot(PM2_5_Maryland_All_Sources,col = "blue",main = "PM2.5 Emission Values from Baltimore City, Maryland- \n From All sources along the years",xlab = "Years",ylab="PM2.5 emitted in Milion Tones ")

dev.off()