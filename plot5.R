################################################################################################
#This is an R script  for Project 2 of Exploratory Data Analysis Course 
# This script is for Plot5  - Answearing Question 5
#5.How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 
################################################################################################

### Special Library Load 

#load library ggplot2
library(ggplot2)

#### Data Load 

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

####Data Processing

#Create a sub data frame that has only the PM.2.5 emission values for Baltimore City, Maryland-
PM2_5_Maryland<-NEI[NEI$fips=="24510",]  

#Filter records to those which contains the word Vehicles in SCC.Level.Two
Vhicle_Sources <- grepl("Vehicles", SCC$SCC.Level.Two, ignore.case=TRUE) 
SCC_Vhicle_Sources<- SCC[Vhicle_Sources,]
PM2_5_Vhicles_Sources<-PM2_5_Maryland[PM2_5_Maryland$SCC %in% SCC_Vhicle_Sources$SCC,]

######Plot The Graph

#Plot to PNG file 
png("plot5.png")

#using ggplot create bar plot for the coal comb source related emission  
ggplot(PM2_5_Vhicles_Sources,aes(factor(year),Emissions)) + geom_bar(stat="identity",fill="blue") + 
        labs(x="Year", y="PM2.5. Emission (Million Tons)  ") + 
      labs(title="PM2.5 Emissions, 1999-2008 Vhicles  sources in Baltimore City")

dev.off()