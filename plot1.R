#This is an R script  for Project 2 of Exploratory Data Analysis Course 
# This script is for Plot1  - Answearing Question 1
#1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system,
#make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008


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


#Create a Bar plot of the PM2.5 Emission values from all sources across the given years (199,2002,2005,2008)
#normalize by 10^6 
PM2_5_AllSources<-tapply(NEI$Emissions, NEI$year, sum) / 10^6

#Plot to PNG file 
png("plot1.png",width=480,height=480,units="px")
barplot(PM2_5_AllSources,col = "red",main = "PM2.5 US Emission Values From all sources along the years",xlab = "Years",ylab="PM2.5 emitted in Milion Tones (10^6)")

dev.off()