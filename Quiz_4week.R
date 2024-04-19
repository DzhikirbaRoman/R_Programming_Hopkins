library(tidyverse)
library(dplyr)

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome
head(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])

TX <- outcome[outcome$State == "TX",]

View(df)
df$State
df11 <- df[,c(11,17,23)]

df23 <- df[order(df[df$State == "TX", 11]),]
df[df$State == "TX", 11]

head(df23)

# df <- read.csv("outcome-of-care-measures.csv")
# # View(df)
# df[,11] <- as.numeric(df[,11])
# hospitals <- df[df$State == "MD", c(2,11)]
# 
# hospitals
# ordered <- order(hospitals[,2])
# ordered
# ordered[1]
# lowest_val <- hospitals[ordered[1],2]
# lowest_val
# 
# hospitals[hospitals[,2] == lowest_val,]
# hospitals[,2] == lowest_val
# best_hosp <- na.omit(hospitals[hospitals[,2] == lowest_val,])
# best_hosp
# best_hosp[,1]
# 
# hospitals
# is.numeric(lowest_val)


best <- function(state, outcome) {
    df <- read.csv("outcome-of-care-measures.csv")
    ## Read outcome data
    states <- unique(df$State)
    if (!state %in% states) { ## Check that state is valid
        stop("invalid state")
    } 
    if (outcome == "heart attack") { ## Check that outcome is valid
        i <- 11
    } else if(outcome == 'heart failure') {
        i <- 17
    } else if(outcome == 'pneumonia') {
        i <- 23
    } else {
        stop('invalid outcome')
    }   
    df[,i] <- as.numeric(df[,i])
    hospitals <- df[df$State == state, c(2,i)]
    ordered_hosps <- order(hospitals[,2])
    
    lowest_val <- hospitals[ordered_hosps[1],2]
    
    best_hosps <- na.omit(hospitals[hospitals[,2] == lowest_val,])
    best_hosps <- sort(best_hosps[,1])
    best_hosps[1]     ## Return hospital name in that state with lowest 30-day death
}
best("TX", "heart attack")
best("MD", "heart attack")

best("MD", "pneumonia")

best("BB", "heart attack")

best("NY", "hert attack")

best("SC", "heart attack")
best("NY", "pneumonia")
best("AK", "pneumonia")

rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    
    df <- read.csv("outcome-of-care-measures.csv")
    ## Read outcome data
    states <- unique(df$State)
    if (!state %in% states) { ## Check that state is valid
        stop("invalid state")
    } 
    if (outcome == "heart attack") { ## Check that outcome is valid
        i <- 11
    } else if(outcome == 'heart failure') {
        i <- 17
    } else if(outcome == 'pneumonia') {
        i <- 23
    } else {
        stop('invalid outcome')
    }   
    
    
    df[,i] <- as.numeric(df[,i])
    hospitals <- df[df$State == state, c(2,i)]
    ordered_hosps <- order(hospitals[,2])
    
    if (num == "best") {
        num = 1
    }
    if (num == "worst") {
        num = nrow(na.omit(hospitals))
        print(num)
    }
    lowest_num_val <- hospitals[ordered_hosps[1:num],2]

    best_hosps <- na.omit(hospitals[hospitals[,2] %in% lowest_num_val,])

    colnames_inDF <- colnames(best_hosps)
    
    best_hosps <- rename(best_hosps, "rate" = colnames_inDF[2])
    
    best_hosps <- arrange(best_hosps, rate, Hospital.Name)

    best_hosps$rank <- rank(best_hosps[,2], ties.method = "first")
    print(best_hosps)

    best_hosps[best_hosps$rank == num, 1]
    
}
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)
rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)


rankall <- function(outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    df <- read.csv("outcome-of-care-measures.csv")
    ## Read outcome data
    states <- unique(df$State)
    if (outcome == "heart attack") { ## Check that outcome is valid
        i <- 11
    } else if(outcome == 'heart failure') {
        i <- 17
    } else if(outcome == 'pneumonia') {
        i <- 23
    } else {
        stop('invalid outcome')
    }
    df[,i] <- as.numeric(df[,i])

    df_res <- data.frame(Hospital.Name = character(), State = character())
    for (state in states) {
        hospitals <- df[df$State == state, c(2,i,7)]
        if (num == "best") {
            num = 1
        }
        if (num == "worst") {
            num = nrow(na.omit(hospitals))
            print(num)
        }

        ordered_hosps <- order(hospitals[,2])
        lowest_num_val <- hospitals[ordered_hosps[1:num],2]

        best_hosps <- na.omit(hospitals[hospitals[,2] %in% lowest_num_val,])

        colnames_inDF <- colnames(best_hosps)

        best_hosps <- rename(best_hosps, "rate" = colnames_inDF[2])

        best_hosps <- arrange(best_hosps, rate, Hospital.Name)

        best_hosps$rank <- rank(best_hosps[,2], ties.method = "first")
        #print(best_hosps)

        df_res <- rbind(df_res,best_hosps[num,c(1,3)])
    }
    print(df_res)
}

# rankall <- function(outcome, num = "best") {
#     data <- read.csv(file="outcome-of-care-measures.csv", colClasses = 'character')
#     
#     if(outcome == 'heart attack') {
#         i <- 11
#     }
#     else if(outcome == 'heart failure') {
#         i <- 17
#     }
#     else if(outcome == 'pneumonia') {
#         i <- 23
#     }
#     else {
#         stop('invalid outcome')
#     }
#     
#     unique.states <- sort(unique(data$State))
#     # print(unique.states)
#     
#     result.df <- list()
#     
#     for(state in unique.states) {
#         data.state <- data[data$State == state, ]
#         data.state[, i] <- as.numeric(x=data.state[, i])
#         data.state <- data.state[complete.cases(data.state), ]
#         
#         # print(num)
#         
#         if(num == "best") {
#             numrank = 1
#         }
#         else if(num == "worst") {
#             numrank = nrow(data.state)
#             # if(state == 'WI') {
#             #   print(num)
#             #   print('WI num')
#             # }
#         }
#         else if(is.numeric(x=num)) {
#             # print(num)
#             if(num < 1 || num > nrow(data.state)) {
#                 result.df <- rbind(result.df, list(NA, state))
#                 print(state)
#                 next
#             }
#             else numrank <- num
#             # print(num)
#         }
#         else {
#             stop('invalid num')
#         }
#         
#         # print(num)
#         data.state <- data.state[order(data.state[,i], data.state$Hospital.Name), ]
#         
#         # if(state == 'WI') {
#         #  print(data.state[, c(2,i)])
#         #  print(numrank)
#         #  print(nrow(data.state))
#         # }
#         
#         return.names <- data.state[numrank, ]$Hospital.Name
#         
#         # print(return.names[1])
#         
#         result.df <- rbind(result.df, list(return.names[1], state))
#         # print(result.df)
#     }
#     
#     result.df <- as.data.frame(x=result.df)
#     colnames(x=result.df) <- c('hospital', 'state')
#     
#     result.df
# }


rankall("heart attack", 20)
tail(rankall("pneumonia", "worst"), 3)
rankall("heart failure")
tail(rankall("heart failure"), 10)

r <- rankall("heart attack", 4)
r
as.character(subset(r, state == "HI")$Hospital.Name)
r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)


df <- read.csv("outcome-of-care-measures.csv")
View(df)
state <- "TX"
i <- 17
## Read outcome data
df[,i] <- as.numeric(df[,i])
hospitals <- df[df$State == state, c(2,i)]
hospitals
ordered_hosps <- order(hospitals[,2])
ordered_hosps
#print(ordered_hosps)
num <- 4
top_num_hosps <- ordered_hosps[1:num]
print(top_num_hosps)
#lowest_val <- hospitals[ordered_hosps[1],2]
hospitals[top_num_hosps,]
best_hosps <- na.omit(hospitals[hospitals[,2] %in% top_num_hosps,])
#best_hosps <- sort(best_hosps[,1])
best_hosps     ## Return hosp




df <- data.frame(names = c("Charlie", "Alice", "Bob", "David","Bonny"),
                 values = c(30, 20, 40, 10,30))
# Sort the data frame by 'names' column in alphabetical order
# and simultaneously sort 'values' column in ascending order
sorted_df <- arrange(df, values,names)

# Print the sorted data frame
print(sorted_df)


df <- data.frame(old_name = c(1, 2, 3),
                 other_column = c("A", "B", "C"))

# Rename the 'old_name' column to 'new_name'
df <- rename(df, "new_name" = "old_name")
df
