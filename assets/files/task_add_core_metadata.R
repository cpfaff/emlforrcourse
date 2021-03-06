# install prerequisites
#install.packages("devtools")
#library("devtools")
#install_github("ropensci/EML", build=FALSE, dependencies=c("DEPENDS", "IMPORTS"))
library("EML")

# read the csv without metadata you recieved from Karl
undescribed_data = read.csv("http://bit.ly/11Q4GOt")

# create column definitions
col_defs = c("River site used for collection",
             "Species common name",
             "Life Stage",
             "Count of live fish in traps", 
             "Date of collection")

# create unit definitions
unit_defs = list(c(SAC = "The Sacramento River", AM = "The American River"),
                 c(king = "King Salmon", ccho = "Coho Salmon"),
                 c(parr = "third life stage", smolt = "fourth life stage"),
                 c(unit = "number"),
                 c(format = "YYYY-MM-DD")
                 )
                

# assemble with the data.set command
described_dataset = data.set(undescribed_data,
                             col.defs = col_defs,
                             unit.defs = unit_defs)

