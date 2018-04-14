###
### This script will generate the plot4.png file with QAP/datetime plotter
###
## Function that:
## * obtains the household power consumption dataset
## * stores locally
## * and filters by 2007/02/01 and 2007/02/02
## returing this subset
get_filtered_dataset = function() {
        # downloading the zip file
        download.file(
                "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "powerconsumption.zip"
        )
        # Reading, after unzipping, the file and storing on a temp dataset 
        # as we will only use 2 days of data. The missing data marked as ? is replaced
        # by NAs
        originalDS = read.table(
                unz(
                        "powerconsumption.zip",
                        "household_power_consumption.txt"
                ),
                header = T,
                sep = ";",
                na.strings = "?"
        )
        # Subsetting the original data frame by the two days asked at the assigment
        resultDS = subset(originalDS, Date == "1/2/2007" |
                                  Date == "2/2/2007")
        # Removing the original DS to free the memory
        rm(originalDS)
        # Creating new datetime columns combining Date and time ones
        resultDS$DateTime = strptime(paste(resultDS$Date, resultDS$Time), format = "%d/%m/%Y %H:%M:%S")
        # Returning the resulting dataset
        resultDS
}

# Downloading the file and transforming it in a filtered dataset
workingDS = get_filtered_dataset()
# Initializing empty with the labels
plot(workingDS$DateTime,
     workingDS$Global_active_power, type="n", ylab = "Global Active Power(kilowatts)", xlab="")
# Adding the line
lines( workingDS$DateTime,
       workingDS$Global_active_power
)
# Copying the result to the Png device and saving it
dev.copy(png,
         "plot2.png",
         width = 480,
         height = 480,
         units = "px")
# Closing the device
dev.off()