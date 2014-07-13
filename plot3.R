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
#  Plot3 is made.  Width and Height are each 480 pixels by default.
png(file = "plot3.png")
plot(plotDF2$datetime,plotDF2$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(plotDF2$datetime,plotDF2$Sub_metering_2,col = "red")
lines(plotDF2$datetime,plotDF2$Sub_metering_3,col = "blue")
legend("topright",lty = c(1,1,1),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"))
#  turn png device off
dev.off()
