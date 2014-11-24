---
title       : The EML R package
subtitle    : Ecological Metadata Language Integration into R
author      : Claas-Thido Pfaff, Carl Boettiger, Karthik Ram, Matt Jones
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax, bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained
knit        : slidify::knit2slides
github:
  author: cpfaff
  repo: emlforrcourse
---



## Why metadata matters?


* Imagine you are interested in salmon species
  + Their distribution across N.A. (~ past 30 years)
  + But you only find publications (no datasets)
  + You start asking the authors and your network

> He Claas
> 
> A former colleague of mine was working intensly with salmon  
> species in North America over years. He is retired now but we  
> still have his data laying around in our archive. I hope this     
> is useful to you!  
> -- *All the best Karl*

<a href="assets/files/csv_file_from_email.csv" class="btn"><i class="icon-envelope"></i> Attachment.csv</a>

* Download and open the dataset now!

---

## Why metadata matters? 




|river |spp  |stg   |  ct|dates      |
|:-----|:----|:-----|---:|:----------|
|SAC   |king |smolt | 293|10.10.1991 |
|SAC   |king |parr  | 410|11.10.1992 |
|AM    |ccho |smolt | 210|10.10.1993 |
</br>

* Some you might guess!
  - river: Abbr. of collection sites
  - spp: May be species names
  - stg: Seems to be the life stage

* But what about the rest?
  - ct: Is numeric (direct or statistic?)
  - dates: Which date format?

---

## Why metadata matters?

</br>

Thus you ask:

> He Claas
> 
> I just checked the data again and fortunately I was involved  
> in that particular data collection! The information you need is:  
>
> river: sac = The sacramento river, am = The american river  
> spp: king = King Salmon, ccho = Coho Salmon  
> stg: par = Third life stage, smolt = Fourth life stage  
> ct: It is the count of life fish caught in traps  
> dates: The date format is YMD
>  
> -- *All the best Karl*

* With that information you can start use the data!

---

## Why metadata matters?

* Without metadata
  - Valuable data becomes unusable
  - Even if preserved!

* With good metadata
  - Supports the reuse (larger context)
  - Helps preserve and exchange

* We have good tools and standards
  - Morpho (DataOne), Data-Up (California Libraries), BEF-Data (BEF-China)
  - ABCD (Access to Biological Collection Data)
  - Ecological Metadata Language (customizable)

<div class = "flushfooter">
  <a href="https://knb.ecoinformatics.org/#tools" class="btn"><i class="icon-home"></i> Morpho</a>
  <a href="http://dataup.cdlib.org/" class="btn"><i class="icon-home"></i> Data-Up</a>
  <a href="http://bit.ly/1vuYJTt" class="btn"><i class="icon-book"></i> Fegraus et al. 2005</a>
  <a href="https://github.com/befdata/befdata" class="btn"><i class="icon-download"></i> BEF-Data</a>
</div>

---

## The package (About)

* Ecological Metadata Language (XML)
  * Allows to capture aspects of data:
    * Units and categories
    * Temporal and spatial coverage ...
    * Contact information ... and much more
  * In a structured machine readable way
  * Better data exchange, use and preservation
  
* Motivation (R package for EML)
  * Many data undescribed; Biologists in R
  * Introduces a wide spread standard to R
  * Read + Write metadata, Publish (Data + Metadata)

<div class = "flushfooter">
  <a href="https://knb.ecoinformatics.org/#tools" class="btn"><i class="icon-home"></i> EML</a>
</div>

---

## The package (About)

* Part of the rOpenSci community
  * Data-Acess, Vizualisation, Reproducibility... 30+)
  * rgbif (Global Biodiversity Information Facility)
  * taxize (20+ Taxonomic Databases for e.g. species name resolving) 
  * rBEFdata (Access to BEFdata data management platforms)
  
* The EML package is developed by:

<img src="assets/img/ropensci_all_developers.png" style="width: 800px;"s/>

<a href="http://ropensci.org/" class="btn flushfooter"><i class="icon-home"></i> rOpenSci</a>

--- bg:#EEE

## The package (Install)

* Not yet available via CRAN
* Source code via GitHub
  * https://github.com/ropensci/EML
  
* Devtools (Hadley Wickham)
  
```
install.packages("devtools")
library("devtools")
```

* Install from github

```
install_github("ropensci/EML", build=FALSE, dependencies=c("DEPENDS", "IMPORTS"))
library("EML")
```

<a href="assets/files/install_script.R" class="btn flushfooter"><i class="icon-download"></i> Install Script.R</a>

---

## Typical metadata (add core)

```
- eml
  - dataset
    - creator
    - contact
    - publisher
    - title
    - pubDate
    - keywords
    - abstract
    - intellectualRights
    - methods
    - coverage
    - dataTable (description, categories, units)
      - physical
      - attributeList
  - additionalMetadata
```

---  

## Typical metadata (add more "x")

```
- eml
  - dataset
    - creator (x)
    - contact (x)
    - publisher
    - title
    - pubDate
    - keywords
    - abstract (x)
    - intellectualRights (x)
    - methods
    - coverage
    - dataTable (description, categories, units)
      - physical
      - attributeList
  - additionalMetadata
```

---

## Create metadata

</br>

* River site used for collection
  - river: sac = The sacramento river, am = The american river  
* Scientific species names  
  - spp: king = King Salmon, ccho = Coho Salmon
* Life stage of fish
  - stg: par = Third life stage, smolt = Fourth life stage  
* Count of life fish in traps
  - ct: numeric  
* The date of data collection: 
  - dates: Format is Day, Month, Year

---

## Create metadata

* EML package adds `data.set(data.frame, col.defs =, unit.defs =)`

* `col.defs` (plain text definition)


```r
col_defs = c("River site used for collection",
             "Species common name",
             "Life Stage",
             "Count of live fish in traps", 
             "Date of collection")
```

- `unit.defs` (factor => levels, dates => YYYY or MM-DD-YY, numeric => unit list [KNB](http://bit.ly/1vEmFnE))


```r
unit_defs = list(c(SAC = "The Sacramento River", AM = "The American River"),
                 c(king = "King Salmon", ccho = "Coho Salmon"),
                 c(parr = "third life stage", smolt = "fourth life stage"),
                 unit = "number",
                 format = "YYYY-MM-DD")
```

---

## Put dataset together

* Put together with `data.set()`


```r
described_dataset = data.set(undescribed_data,
                             col.defs = col_defs,
                             unit.defs = unit_defs)
```

* However there is still general information missing:
  - title (add now)
  - absract
  - temporal and spatial coverage
  - contact person (add now)
  - creator
  - and other things ...

--- bg:#EEE

## Your turn (core metadata)

```
read.csv("http://cpfaff.github.io/emlforrcourse/assets/files/csv_file_from_email.csv")
```

* Create the colum definitions
  - Write them into an own variable first!
  - Hint: A vector with plain text definitions

* Create unit definitions
  - Write them into an own variable first!
  - Hint: A list with vectors of key/value pairs
  - Use: unit = "number" (for the count)
  - Use: format = "YYYY-MM-DD" (for thed date)
  - Ensure that the date column is a date! (as.Date(...))

---

## Add contact

* Create person object using


```r
claas = eml_person("Claas-Thido Pfaff <fake@test.com>")
```

* Coerce to a contact object


```r
claas_contact = as(claas, "contact")
```

* Add an address


```r
address <- new("address",
               deliveryPoint = "Universität Leipzig, Johannisallee 21",
               city = "Leipzig",
               postalCode = "04103",
               country = "GER")
claas_contact@address = address
```

---

## Put together and save

* The `eml()` command assembles everything


```r
data <- eml(dat = described_dataset,
            title = "This is an example title",
            contact = claas_contact
            )
```

* Write out the EML to a file


```r
eml_write(data, file="mymetadata.eml")
```

* Publish to figshare (requires `rfigshare` package)


```r
eml_publish("mymetadata.eml", 
            description="Example EML file from EML",
            categories = "Ecology", 
            tags = "EML", 
            destination="figshare")
```

---

## Uploaded to FigShare

<img src="assets/img/uploaded_csv_and_metadata_two_figshare.png" style="width: 800px;"/>

---

## Uploaded to FigShare

* Metadata

<img src="assets/img/uploaded_csv_and_metadata_two_xml_shown.png" style="width: 800px;"/>

* Data

<img src="assets/img/uploaded_csv_and_metadata_two_figshare_csv_shown.png" style="width: 800px;"/>













## Idea collection practice

Read data and metadata:
  + Import a dataset
  + Extract contact person
  + Extract a column description

Write data and metadata:
  + Download an example dataset
  + Add the core metadata (units: dictionary, dates, descriptions, classes)
  + Show the most common metadata fields 
  + Let them create and add (creator, contact, title, intellectual rights)















---

## Read metadata
  
* Read metadata from any EML formated source (File, URL, KNB-ID)


```r
metadata <- eml_read("http://china.befdata.biow.uni-leipzig.de/datasets/334.eml")
```

* Then use `eml_get(metadata, "xy")`
  - csv_filepaths
  - coverage
  - contact
  - unit.defs
  - col.defs
  - creator
  - data.set ...

---

## Read metadata
  

```r
eml_get(metadata, "creator")
```

```
## [1] "Anne Lang <anne_christina.lang@uni-leipzig.de> [cre]"
## [2] "Werner HÃ¤rdtle <haerdtle@uni-lueneburg.de> [cre]"   
## [3] "Goddert von Oheimb <vonoheimb@uni.leuphana.de> [cre]"
```
  

```r
eml_get(metadata, "coverage")
```

```
## geographicCoverage:
##   geographicDescription: "The experiment was set up in the northeast part of Jiangxi
##     Province, P.R. China (N 29Â° 06.29 E 117Â° 55.28). \n"
##   boundingCoordinates:
##     westBoundingCoordinate: '117.89978'
##     eastBoundingCoordinate: '118.148346'
##     northBoundingCoordinate: '29.285201'
##     southBoundingCoordinate: '29.101777'
## temporalCoverage:
##   rangeOfDates:
##     beginDate:
##       calendarDate: |2
## 
##         2009-08-26
##     endDate:
##       calendarDate: |2
## 
##         2010-09-26
## taxonomicCoverage:
##   taxonomicClassification:
##     commonName: |2+
## 
##       tree species (Schima superba, Elaeoarpus decipiens, Castanea henryi, Quercus serrata)
```

---

## Import data

* Access the data based on metadata information
  



```
example_dataset = eml_get(metadata, "data.set")
```

* Just display a subset of it here


```r
example_dataset[1:4, 1:3]
```

```
##     plot_id             Spp Leaf_15N_recovery_g_T5
## 1 pilot1C09 Castanea henryi              1.504e-05
## 2 pilot1D10 Castanea henryi              8.604e-05
## 3 pilot2C11 Castanea henryi              2.905e-05
## 4 pilot2D01 Castanea henryi              8.923e-06
```

---

## Wrap-up

* The `EML` package
  - Access to metadata 
  - Access to data
  - From any EML formatted source!
  - Describe your own data with metadata
  - Allows publication of citable data products

* This was very brief intro:
  - Just visit GitHub for more!
  - https://github.com/ropensci/EML

---

<div class = "flushcenter">
  <h1>Thanks for your attention!</h1>
  <h1>Any questions?</h1>
</div>
  
<br>
 * Find this slides: 
<br>
  http://cpfaff.github.io/remlgfoe2014
<br>
 * Find EML package: 
<br>
  https://github.com/ropensci/EML

<img src="assets/img/affiliations_gfoe_2014.png" style="width: 400px;", class="flushfooter flushcenter"/>



