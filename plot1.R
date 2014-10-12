plot1 <- function()
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
  
  ## Cast data type for date and time columns
  data$Date <- as.Date(data$Date, format="%d/%m/%y")
  data$Time <- strptime(data$Time, format="%H:%M:%S")
  
  ## Initialise a PNG device named plot1.png
  png(filename="plot1.png", width=480, height=480)
  
  ## Produce histogram of Global_active_power, set colour to red, set x-axis label text and title text.
  hist(data$Global_active_power,col="#ff2500",xlab="Global Active Power (kilowatts)",main="Global Active Power")
  
  ## Shut down the current device
  dev.off()

}