
install.packages("reshape2")
library(reshape2)
# Sample data in wide format
data_wide <- data.frame(
    Country = c("USA", "Canada", "Mexico"),
    Year2000 = c(1000, 900, 500),
    Year2001 = c(1100, 950, 600)
)

# Print the wide format data
print(data_wide)
# Reshape the data to long format
data_long <- melt(data_wide, id.vars = "Country", variable.name = "Year", value.name = "GDP")

# Print the long format data
print(data_long)





string_1 <- "-mean\\(\\)|-std\\(\\)"
string_2 <- "-mean\""
string_2 <- "-mean\""

writeLines(string_2)
writeLines(string_1)
grep("\\\"", string_2)
print(string_1)

# 
# The dcast() function in R is part of the reshape2 and data.table packages and is used to transform data from long format 
# to wide format. This is the opposite of what the melt() function does. The dcast() function is particularly useful for 
#  pivoting data tables by reshaping and aggregating data.
# Basic Syntax
# 
# The basic syntax of dcast() from the reshape2 package is:
#     
# dcast(data, formula, fun.aggregate = NULL, ...)
# 
# data: The data frame or data table to be cast.
# formula: A formula specifying the variable(s) to be cast and the variable(s) to be kept.
# fun.aggregate: An optional aggregation function. If specified, this function is applied to aggregate values when there are multiple observations for a combination of the variables specified in the formula.
# ...: Additional arguments passed to the aggregation function.
# 
# Example Usage

# Load the reshape2 package
library(reshape2)

# Create a sample long format data frame
data <- data.frame(
    subject = c(1, 1, 2, 2),
    variable = c("A", "B", "A", "B"),
    value = c(10, 20, 30, 40)
)

# View the sample data
print(data)

# This prints:
# subject variable value
# 1       1        A    10
# 2       1        B    20
# 3       2        A    30
# 4       2        B    40
# 
# Using dcast()

# The goal is to transform this long format data into a wide format where each variable becomes a column.

# Use dcast to transform data from long to wide format
wide_data <- dcast(data, subject ~ variable, value.var = "value")

# View the wide format data
print(wide_data)

# This prints:
# subject  A  B
# 1       1 10 20
# 2       2 30 40

# Aggregating Data
# 
# If you have multiple observations for a combination of variables, you can use an aggregation function. For example, let’s extend the data

# Extended sample data with multiple observations
extended_data <- data.frame(
    subject = c(1, 1, 1, 2, 2, 2),
    variable = c("A", "A", "B", "A", "A", "B"),
    value = c(10, 15, 20, 30, 35, 40)
)

# View the extended data
print(extended_data)
# 
# This prints:
#     
# subject variable value
# 1       1        A    10
# 2       1        A    15
# 3       1        B    20
# 4       2        A    30
# 5       2        A    35
# 6       2        B    40
# 
# Now, let’s use dcast() with an aggregation function:
#     
# Use dcast with an aggregation function (mean in this case)
aggregated_data <- dcast(extended_data, subject ~ variable, value.var = "value", fun.aggregate = mean)

# View the aggregated wide format data
print(aggregated_data)

# This prints:
# 
# subject    A  B
# 1       1 12.5 20
# 2       2 32.5 40
# 
# Here, the mean value for each combination of subject and variable is calculated and cast into the wide format.
# Summary
# 
# dcast() is used to transform data from long format to wide format.
# formula: Specifies the casting formula, determining which variables should be cast and which should be kept.
# fun.aggregate: An optional parameter that specifies an aggregation function to be applied when there are multiple observations for a combination of variables.
# Packages: It is part of the reshape2 and data.table packages.


# The melt() function in R, part of the reshape2 package, is used to transform data from wide format to long format. 
# It is similar to pivot_longer() from the tidyverse but has different syntax and parameters. 
# Here’s the syntax and an explanation of how it works:
#   Syntax
# melt(data, id.vars, measure.vars, variable.name = "variable", value.name = "value", ...)
# 
# Parameters
# 
# data: The data frame to be transformed.
# id.vars: Columns to keep as identifiers (i.e., the columns that should remain unchanged).
# measure.vars: Columns to melt into long format (i.e., the columns that contain the values to be transformed into rows).
# variable.name: The name of the new column that will contain the names of the measure variables. Default is "variable".
# value.name: The name of the new column that will contain the values of the measure variables. Default is "value".
# ...: Additional arguments passed to or from other methods.
# 
# Example Usage
# 
# Let's go through an example to demonstrate how melt() works.
# Sample Data

# Load the reshape2 package
library(reshape2)

# Create a sample wide format data frame
wide_data <- data.frame(
    id = 1:3,
    Jan = c(10, 20, 30),
    Feb = c(15, 25, 35),
    Mar = c(20, 30, 40)
)

# View the sample data
print(wide_data)

# This prints:
#   id Jan Feb Mar
# 1  1  10  15  20
# 2  2  20  25  30
# 3  3  30  35  40
# 
# Using melt()
# To transform this data from wide format to long format:

# Use melt to transform data from wide to long format
long_data <- melt(
    data = wide_data,
    id.vars = "id",
    measure.vars = c("Jan", "Feb", "Mar"),
    variable.name = "Month",
    value.name = "Value"
)

# View the long format data
print(long_data)

# This prints:
#   id Month Value
# 1  1   Jan    10
# 2  2   Jan    20
# 3  3   Jan    30
# 4  1   Feb    15
# 5  2   Feb    25
# 6  3   Feb    35
# 7  1   Mar    20
# 8  2   Mar    30
# 9  3   Mar    40
# 
# Detailed Explanation
#     data: The data frame wide_data is provided as input.
#     id.vars = "id": The column id is kept as an identifier.
#     measure.vars = c("Jan", "Feb", "Mar"): Specifies the columns to melt into the long format. This selects the columns Jan, Feb, and Mar.
#     variable.name = "Month": The new column Month will contain the names of the original columns (Jan, Feb, Mar).
#     value.name = "Value": The new column Value will contain the values from the original columns.

# Advanced Usage
# You can also use melt() to handle more complex data structures.
# Example with Multiple ID Variables

# Create a sample data frame with multiple id variables
wide_data_multi_id <- data.frame(
    id = 1:3,
    group = c("A", "B", "A"),
    Jan = c(10, 20, 30),
    Feb = c(15, 25, 35),
    Mar = c(20, 30, 40)
)

# Use melt with multiple id variables
long_data_multi_id <- melt(
    data = wide_data_multi_id,
    id.vars = c("id", "group"),
    measure.vars = c("Jan", "Feb", "Mar"),
    variable.name = "Month",
    value.name = "Value"
)

# View the transformed data
print(long_data_multi_id)

# This prints:
# 
#   id group Month Value
# 1  1     A   Jan    10
# 2  2     B   Jan    20
# 3  3     A   Jan    30
# 4  1     A   Feb    15
# 5  2     B   Feb    25
# 6  3     A   Feb    35
# 7  1     A   Mar    20
# 8  2     B   Mar    30
# 9  3     A   Mar    40
# 
# Summary
#     melt() is used to convert data from wide format to long format.
#     It is part of the reshape2 package.
#     The function provides options for specifying identifier columns (id.vars), measure columns (measure.vars), and naming the resulting columns (variable.name, value.name).
#     It is particularly useful for data tidying, allowing you to transform your data into a more analysis-friendly format.
