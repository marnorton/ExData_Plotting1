plot4 <- function() 
{
  ## Read data into "data"
  if (!file.exists("data.zip")) 
  {
    download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile="data.zip",
                  method="curl")
    unzip("data.zip")
  }
  data <- read.csv("household_power_consumption.txt",skip=66637,nrows=2880,na.strings = "?",header=F,sep=";")
  
  ## Set names of columns the same as raw data
  names(data) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))
  
  ## Add column of date and time as a combined data type, to allow continuous plotting
  data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "),format="%d/%m/%Y %H:%M:%S")


  # Initialise a PNG device named plot3.png
  png(filename="plot4.png", width=480, height=480)
  
  # Set vector in which to put plots
  par(mfcol=c(2,2))
  
  # Plot 1
  plot(data$DateTime,data$Global_active_power,type="l",col="black",xlab="",ylab="Global Active Power (kilowatts)",
       main="")
  
  # Plot 2
  plot(data$DateTime,data$Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering",
       main="")
  lines(data$DateTime, data$Sub_metering_2, col="red")
  lines(data$DateTime, data$Sub_metering_3, col="blue")
  legend("topright",lwd=1,lty=1,col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", 
      "Sub_metering_3"))
  
  # Plot 3
  plot(data$DateTime,data$Voltage,type="l",col="black",xlab="datetime",ylab="Voltage",main="")
  
  # Plot 4
  plot(data$DateTime,data$Global_reactive_power,type="l",col="black",xlab="datetime",ylab="Global_reactive_power",
       main="")
  
  ## Shut down the current device
  dev.off()
  
  
}