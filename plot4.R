## Exploratory Data Analysis: Class 4 Project1 - Plot 4

## This Project uses data from the UC Irvine Machine Learning Repository. 

## Data Set: "Individual household electric power consumption Data Set". 

## Overall Description: Measurements of electric power consumption in one household
## with a one-minute sampling rate over a period of almost 4 years. Different
## electrical quantities and some sub-metering values are available.

## Variable Description: 9 variables
## 1) Date: Date in format dd/mm/yyyy
## 2) Time: time in format hh:mm:ss
## 3) Global_active_power: household global minute-averaged active power (in kilowatt)
## 4) Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
## 5) Voltage: minute-averaged voltage (in volt)
## 6) Global_intensity: household global minute-averaged current intensity (in ampere)
## 7) Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the
## kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
## 8) Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the
## laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
## 9) Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an 
## electric water-heater and an air-conditioner.

## Overall goal of project is to create an R script that reconstructs plots, all of which uses
## the base plotting system.

## Add the libraries
        install.packages("data.table")
        library(data.table)
        install.packages("datasets")
        library(datasets)
        install.packages("lubridate")
        library(lubridate)
        
## Read in all the data
        ##original properties include 2,075,259 obs. of 9 variables
        OrigData<-read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors=FALSE)

## Convert the Date and Time variables to Date/Time classes
        OrigData$Date<-as.Date(OrigData$Date,format="%d/%m/%Y")
        OrigData$Time<-strptime(OrigData$Time,format="%H:%M:%S")
        
## Convert the remaining variables to numeric classes
        OrigData$Global_active_power<-as.numeric(OrigData$Global_active_power)
        OrigData$Global_reactive_power<-as.numeric(OrigData$Global_reactive_power)
        OrigData$Voltage<-as.numeric(OrigData$Voltage)
        OrigData$Global_intensity<-as.numeric(OrigData$Global_intensity)
        OrigData$Sub_metering_1<-as.numeric(OrigData$Sub_metering_1)
        OrigData$Sub_metering_2<-as.numeric(OrigData$Sub_metering_2)
        OrigData$Sub_metering_3<-as.numeric(OrigData$Sub_metering_3)
        
## Subset the data, which will narrow it down to 2880 obs. of 9 variables
        SubsetData<-subset(OrigData,Date>="2007-02-01" & Date<="2007-02-02")
        
## Construct the plots and save it to a PNG file
        png(file ="plot4.png", width=480, height=480)
        
        ## configure so all plots are on one page
        par(mfcol=c(2,2)) 
        
##plot 1
        plot(SubsetData$Global_active_power, xaxt="n",type="l", xlab="", ylab="Global Active Power (kilowatts)")
        axis(1,at=c(1,1441,2880), labels=c("Thu", "Fri", "Sat"))
        
##plot 2
        plot(SubsetData$Sub_metering_1,xaxt="n",type="l", xlab="", ylab="Energy sub metering")
        lines(SubsetData$Sub_metering_1, col="black")
        lines(SubsetData$Sub_metering_2, col="red")
        lines(SubsetData$Sub_metering_3, col="blue")
        axis(1,at=c(1,1441,2880), labels=c("Thu", "Fri", "Sat")) 
        ##add the legend
        legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd=c(2,2,2),col=c("black", "red", "blue"),bty="n",cex=1)
        
##plot 3
        plot(SubsetData$Voltage, xaxt="n",type="l", xlab="datetime", ylab="Voltage")
        axis(1,at=c(1,1441,2880), labels=c("Thu", "Fri", "Sat"))
        
##plot 4
        plot(SubsetData$Global_reactive_power, xaxt="n",type="l", xlab="datetime", ylab="Global_reactive_power")
        axis(1,at=c(1,1441,2880), labels=c("Thu", "Fri", "Sat"))
        
        ##Don't forget to close the PNG device!
        dev.off() 
        
        
        
        
        