plot2 <- function() 
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

  ## Initialise a PNG device named plot2.png
  png(filename="plot2.png", width=480, height=480)
  
  ## Produce plot of Global_active_power vs DateTime, set colour to red, set x-axis label and title text
  plot(data$DateTime,data$Global_active_power,type="l",col="black",xlab="",ylab="Global Active Power (kilowatts)",
       main="")
  
  ## Shut down the current device
  dev.off()
}