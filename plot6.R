################################################################################################
#This is an R script  for Project 2 of Exploratory Data Analysis Course 
# This script is for Plot6  - Answearing Question 6
#6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
#vehicle sources in Los Angeles County, California (fips=="06037"). 
#Which city has seen greater changes over time in 
#motor vehicle emissions?
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

######Data Handling 

#Create a sub data frame that has only the PM.2.5 emission values for Baltimore City, Maryland 
#and Los Angeles County, California
PM2_5_Baltimore_LosAngels<-NEI[NEI$fips=="24510" | NEI$fips=="06037",]  

#Filter records to those which contains the word Vehicles in SCC.Level.Two
Vhicle_Sources <- grepl("Vehicles", SCC$SCC.Level.Two, ignore.case=TRUE) 
SCC_Vhicle_Sources<- SCC[Vhicle_Sources,]
PM2_5_Vhicles_Los_Angels_Baltimore<-PM2_5_Baltimore_LosAngels[PM2_5_Baltimore_LosAngels$SCC %in% SCC_Vhicle_Sources$SCC,]

#Rename the fips to City/County nmaes 
PM2_5_Vhicles_Los_Angels_Baltimore$fips[PM2_5_Vhicles_Los_Angels_Baltimore$fips=="06037"]="Los Angles"
PM2_5_Vhicles_Los_Angels_Baltimore$fips[PM2_5_Vhicles_Los_Angels_Baltimore$fips=="24510"]="Baltimore"
colnames(PM2_5_Vhicles_Los_Angels_Baltimore)[1] <- "City"

#####Plot the Graph

#Plot to PNG file 
png("plot6.png")

#using ggplot create two bar plots based on the two locations  
ggplot(PM2_5_Vhicles_Los_Angels_Baltimore,aes(factor(year),Emissions,fill=City)) + geom_bar(stat="identity") + 
          facet_wrap(~ City) + 
          scale_fill_manual("legend", values = c("Baltimore" = "red", "Los Angles" = "blue")) +
          labs(x="Year", y="PM2.5. Emission (Million Tons)  ") + 
          labs(title="PM2.5 Emissions, 1999-2008 \n From Vhicles sources in Baltimore and Los Angles") 
      
dev.off()