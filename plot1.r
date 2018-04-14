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
hist(
      workingDS$Global_active_power,
      main = "Global Active Power",
      col = "red",
      xlab = "Global Active Power(kilowatts)"
)
dev.copy(png,
         "plot1.png",
         width = 480,
         height = 480,
         units = "px")
dev.off()
