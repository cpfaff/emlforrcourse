# install prerequisites
install.packages("devtools")
library("devtools")
install_github("ropensci/EML", build=FALSE, dependencies=c("DEPENDS", "IMPORTS"))
library("EML")

# read the csv without metadata you recieved from Karl
undescribed_data = read.csv("http://bit.ly/11Q4GOt")
undescribed_data$dates = as.Date(undescribed_data$dates)

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
                 unit = "number",
                 format = "YYYY-MM-DD")

# assemble with the data.set command
described_dataset = data.set(undescribed_data,
                             col.defs = col_defs,
                             unit.defs = unit_defs)


# add a contact person
claas_contact = eml_person("Claas-Thido Pfaff <test@fake.com>")

address_of_claas_contact = new("address",
                   deliveryPoint = "Universität Leipzig, Johannisallee 21",
                   city = "Leipzig",
                   postalCode = "04103",
                   country = "GER")

claas_contact@address = address_of_claas_contact


# add a license and a title
title = "Count of life fish in traps at the sampling sites of the Sacramento and the American River"
license = "CC0, http://creativecommons.org/publicdomain/zero/1.0"


# assemble and write out
data = eml(dat = described_dataset,
           title = "Count of life fish in traps",
           contact = claas_contact,
           license = "CC0, Creative commons zero"
)

eml_write(data, file="mymetadata.xml")