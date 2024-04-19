library(tidyverse)
#search()
specdata_dir <- file.path(getwd(),"specdata")

file_names <- list.files(specdata_dir)

file1 <- read.csv(file.path(specdata_dir,file_names[1]))
file1 <- na.omit(file1)
file1[seq(14),]
seq(14)
file1[file1$sulfate > 1 & file1$nitrate> 1, ]


file2 <- read.csv(file.path(specdata_dir,file_names[2]))
exists("file2")
file1_2 <- rbind(file1,file2)
?exists
file1_2
pollutant <- "sulfate"
file1_2[,pollutant]


mean(file1_2[,pollutant], na.rm = TRUE)
source("Functions_Quiz_2week.R")
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)
cc <- complete("specdata", 54)
print(cc$nobs)

RNGversion("3.5.1")  
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

cr <- corr("specdata")                
cr <- sort(cr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                

cr <- sort(cr)                
n <- length(cr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

pollutantmean("specdata", "sulfate", 1:10)


exists("gg")




na.omit(file2)


file1 <- read.csv(file.path(specdata_dir,file_names[30]))
nrow(na.omit(file1))






library(datasets)
data(iris)
?iris
df_iris
iris
?data
mean(iris[iris$Species == "virginica",]$Sepal.Length)
data(mtcars)
?mtcars
mtcars
tapply(mtcars$mpg, mtcars$cyl, mean)

sapply(split(mtcars$mpg, mtcars$cyl), mean)

apply(mtcars, 2, mean)

split(mtcars, mtcars$cyl)

lapply(mtcars, mean)

tapply(mtcars$cyl, mtcars$mpg, mean)

with(mtcars, tapply(mpg, cyl, mean))

mean(mtcars$mpg, mtcars$cyl)

sapply(mtcars, cyl, mean)

mean(mtcars[mtcars$cyl == 4,]$hp) - mean(mtcars[mtcars$cyl == 8,]$hp)
mean(mtcars[mtcars$cyl == 8,]$hp)
debug(ls)
ls
