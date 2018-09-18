###########################################################################################################
#This is an R script  for Project 2 of Exploratory Data Analysis Course 
# This script is for Plot4  - Answearing Question 4
#4.cross the United States, how have emissions from coal combustion-related sources changed from 1999–2008? 
############################################################################################################

#####Library load

#load library ggplot
library(ggplot2)

#####Data Load 

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


######Data Processing

#Create a sub data frame that has only the PM.2.5 emission values for Coal_Combustion_Related
#Filter records to those which contains the word 'coal' in Short.Name and comb in SCC.Level.One name
#Note this is my understanding of the question ---> coal in Short.Name and comb in SCC.Level.One 
coalRelated <- grepl("coal", SCC$Short.Name, ignore.case=TRUE) 
CombRealated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
Combustion_Coal_Comb <- SCC[CombRealated & coalRelated,]
PM2_5_Coal_Combustion_Related<-NEI[NEI$SCC %in% Combustion_Coal_Comb$SCC,]

####### Graph Plot 

#Plot to PNG file 
png("plot4.png")

#using ggplot create bar plot for the coal comb source related emission  
ggplot(PM2_5_Coal_Combustion_Related,aes(factor(year),Emissions/10^5)) + geom_bar(stat="identity",fill="red") + 
        labs(x="Year", y="PM2.5. Emission (Million Tons / 10 ^5)  ") + 
      labs(title="PM2.5 Emissions, 1999-2008 coal combustion-related sources")

dev.off()