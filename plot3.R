##################################################################################################
#This is an R script  for Project 2 of Exploratory Data Analysis Course 
# This script is for Plot3  - Answearing Question 3
#3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system 
#to make a plot answer this question.
##################################################################################################

#####Library load

#load library ggplot
library(ggplot2)

#Data Load 

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

#Data Processing

#Create a sub data frame that has only the PM.2.5 emission values for Baltimore City, Maryland-
PM2_5_Maryland<-NEI[NEI$fips=="24510",]  

#Graph Plot 

#Plot to PNG file 
png("plot3.png")

#using qplot create four sub bar plot , each sub plot has a diffrent source type , along the year 
ggplot(PM2_5_Maryland,aes(factor(year),Emissions,fill=type)) + 
        geom_bar(stat="identity")+  facet_wrap(~ type, ncol = 2) + 
        scale_fill_manual("Source Type", values = c("NON-ROAD" = "red", "NONPOINT" = "orange", "ON-ROAD" = "blue","POINT" = "green")) +
        labs(x="Year", y="PM2.5. Emission (Tons)") + 
        labs(title="PM2.5 Emissions, Baltimore City, Maryland 1999-2008 by Source Type")

dev.off()