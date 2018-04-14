get_filtered_dataset = function() {
        download.file(
                "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "powerconsumption.zip"
        )
        originalDS = read.table(
                unz(
                        "powerconsumption.zip",
                        "household_power_consumption.txt"
                ),
                header = T,
                sep = ";",
                na.strings = "?"
        )
        
        resultDS = subset(originalDS, Date == "1/2/2007" |
                                  Date == "2/2/2007")
        rm(originalDS)
        
        resultDS$DateTime = strptime(paste(resultDS$Date, resultDS$Time), format = "%d/%m/%Y %H:%M:%S")
        
        resultDS
}


workingDS = get_filtered_dataset()
plot(
        workingDS$DateTime,
        workingDS$Sub_metering_1,
        type = "n",
        ylab = "Energy Sub Metering",
        xlab = ""
)

lines(workingDS$DateTime,
      workingDS$Sub_metering_1)
lines(workingDS$DateTime,
      workingDS$Sub_metering_2, col = "red")
lines(workingDS$DateTime,
      workingDS$Sub_metering_3, col = "blue")
legend(
        "topright",
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lwd = 1,
        col = c("black", "red", "blue")
)

dev.copy(png,
         "plot3.png",
         width = 480,
         height = 480,
         units = "px")

dev.off()