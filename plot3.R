plot3 <- function() 
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
  
  ## Initialise a PNG device named plot3.png
  png(filename="plot3.png", width=480, height=480)
  
  ## Produce plot of Sub_metering_1 vs DateTime, set colour to black, set x-axis label to blank, y-axis lable to
  ## "Energy sub metering", and title text to blank
  plot(data$DateTime,data$Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering",main="")
  
  ## Change line colours for Sub_metering_2 and Sub_metering_3 to red and blue respectively
  lines(data$DateTime, data$Sub_metering_2, col="red")
  lines(data$DateTime, data$Sub_metering_3, col="blue")
  
  ## Add legend to plot
  legend("topright",lwd=1,lty=1,col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", 
        "Sub_metering_3"))
  
  ## Shut down the current device
  dev.off()
  
}