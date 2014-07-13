#  With the raw data file in the working directory, the file is read
#  in as csv2 because of semicolon separator
plotDF1 <- read.csv2("household_power_consumption.txt",stringsAsFactors=FALSE)
#  File is subsetted for the required dates: February 1st and 2nd, 2007
plotDF2 <- subset(plotDF1,plotDF1$Date=="1/2/2007"|plotDF1$Date=="2/2/2007")
#  Date and Time variables are combined, formatted, reordered and unnecessary
#  variables are dropped
plotDF2$datetime <- paste(plotDF2$Date,plotDF2$Time)
plotDF2$datetime <- strptime(plotDF2$datetime,format="%d/%m/%Y %H:%M:%S")
plotDF2$Date <- NULL
plotDF2$Time <- NULL
#  Other variables are converted to numeric
plotDF2 <- plotDF2[,c(8,1:7)]
index <- sapply(plotDF2,is.character)
plotDF2[index] <- lapply(plotDF2[index],as.numeric)
#  Plot1 is made.  Width and height are each 480 pixels by default.
png(file = "plot1.png")
hist(plotDF2$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",bty = "n")
#  turn png device off
dev.off()
