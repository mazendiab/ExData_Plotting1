# This codes generate plot1 in this assignment
rm(list=ls())
# load necessary packages
library(data.table)
library(lubridate)

# download the zipped file for the dataset  then unzip the file
file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(file.url,destfile='power_consumption.zip')
unzip('power_consumption.zip',overwrite=TRUE)

# read data from the dates 2007-02-01 and 2007-02-02
Classes<-c(rep('character',2),rep('numeric',7))
Electricpower.consumption<-read.table('household_power_consumption.txt',header=TRUE,sep=';',na.strings='?',colClasses=Classes)
Electricpower.consumption<- Electricpower.consumption[Electricpower.consumption$Date=='1/2/2007' | Electricpower.consumption$Date=='2/2/2007',]

Cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity','SubMetering1','SubMetering2','SubMetering3')
colnames(Electricpower.consumption)<-Cols
Electricpower.consumption$DateTime<-dmy(Electricpower.consumption$Date)+hms(Electricpower.consumption$Time)
Electricpower.consumption<-Electricpower.consumption[,c(10,3:9)]

# open device
png(filename='plot3.png',width=480,height=480,units='px')

# plot data
lncol<-c('black','red','blue')
lbls<-c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
plot(Electricpower.consumption$DateTime,Electricpower.consumption$SubMetering1,type='l',col=lncol[1],xlab='',ylab='Energy sub metering')
lines(Electricpower.consumption$DateTime,Electricpower.consumption$SubMetering2,col=lncol[2])
lines(Electricpower.consumption$DateTime,Electricpower.consumption$SubMetering3,col=lncol[3])

# add legend
legend('topright',legend=lbls,col=lncol,lty='solid')

# close device
x<-dev.off()