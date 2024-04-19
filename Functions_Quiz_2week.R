# getwd()
# directory <- "specdata"
# directory <- list.files(file.path(getwd(), directory))
# directory
# id = 44: 56
# id
# length(id)
# directory[10]
# directory <- list.files(file.path(getwd(), directory))
# directory
# file <- read.csv(directory[1])
# 
# 
# for (id_i in id) {
#     file <- read.csv(file.path(),directory[id_i])
#     print(id_i)
#     if (exists("file_bind") ){
#         file_bind <- rbind(file_bind,file)
#     } else {
#         file_bind <- file
#     }
# }
# 
# directory <- "specdata"
# directory <- file.path(getwd(), directory)
# directory
# File.list <- list.files(directory)
#File.list[1]

pollutantmean <- function(directory, pollutant, id = 1:332) {
    file_bind <- unite.files(directory, id)
    mean(file_bind[,pollutant], na.rm = TRUE)
}

pollutantmean("specdata", "sulfate", 1:10)


file <- as.data.frame(read.csv(file.path(directory, File.list[1])))
file
file1 <- file
file1

exists("file_bind")
file_bind <- NULL  # Initialize file_bind as NULL
exists("file_bind")
unite.files <- function (directory,id = 1:332) {
    directory <- file.path(getwd(), directory)
    File.list <- list.files(directory)
    for (id_i in id) {
        file <- as.data.frame(read.csv(file.path(directory, File.list[id_i])))
        if (exists("file_bind")) {
            file_bind <- rbind(file_bind,file)
        } else {
            file_bind <- file
        }
    }
    return(file_bind)
}
pollutantmean("specdata", "sulfate", 1:10)

# ?read.csv
complete <- function (directory, id = 1:332) {
    file_bind <- unite.files(directory, id)
    list.IDs <- unique(file_bind$ID)
    df.complete.obs <- data.frame(id = numeric(0), nobs = numeric(0))
    for (i in list.IDs) {
        nrow_complete.data <- nrow(na.omit(file_bind[file_bind$ID == i,]))  
        new_row <- data.frame( id = i, nobs = nrow_complete.data)
        df.complete.obs <- rbind(df.complete.obs, new_row)
    } 
    return(df.complete.obs)
}
complete("specdata", 30:25)


df <- complete("specdata", 30:25)
View(df)

vecnum <- numeric(length(1:55))
vecnum


# Step 1: Create an empty data frame with column names
df <- data.frame(ID = numeric(2), Name = character(2), Age = numeric(2))

# Step 2: Add rows to the data frame using rbind()
new_row1 <- data.frame(ID = 1, Name = "Alice", Age = 25)
new_row2 <- data.frame(ID = 2, Name = "Bob", Age = 30)

df <- rbind(df, new_row1)
df <- rbind(df, new_row2)

# Print the updated data frame
print(df)



corr <- function (directory, threshold = 0) {
    file_bind <- na.omit(unite.files(directory))
    View(file_bind)
    file.thresholded <- file_bind[seq(threshold),]
    View(file.thresholded)
    cor.res <- cor( x = file.thresholded$sulfate, y = file.thresholded$nitrate )
    return(cor.res)
}
cr <- corr("specdata", 150)
summary(cr)
head(cr)
?cor

