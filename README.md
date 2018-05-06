# Jtransit

## Inroduction
Traffic influence not only economic activity, but also human bahavior. In our daily life, we use car, rail way, bus and other vehicles, we go somewhere by walk and railway from your home.  
It is very important to understand traffic system, especially service area. Service areas created by Network Analyst also help evaluate accessibility. Concentric service areas show how accessibility varies with impedance.  
To create service area, we have to gather transit dara. Except Japan, it is possible to get the transit data(duration, fare...) from google API. Also ArcGIS(ESRI) provide some function to create service area. However, it is very expensive for student to use such charged software. So this package provide some function to get transit data from [yahoo transit service](https://transit.yahoo.co.jp/ "yahoo transit service").
The aim of this package is creating service area.

![](https://github.com/kmbsweb/Jtransit/blob/master/pic/fare%20vs%20duration.PNG?raw=true)


* [Install](#install)
* [Documentation](#documentation)
* [Features](#features)
* [Examples](#examples)

**Updated the package to better suit `rvest`**

## Install

```R
# dev version only
devtools::install_github("kmbsweb/Jtransit") 
```

## Documentation 

* [Examples](https://kmbsweb.wordpress.com/)

## Features

*`function`*

- `transit` - get duration and fare from origin to destianation.
- `covert_m` - converting unit(from hour to minute).
- `dest.loc` - facility geocoding.
- `transit.map.fare` - create map of fare.
- `transit.map.dura` - create map of duration.

*`data`*

- `all_sta` - station geometry data all over Japan.
- `hyo_sta` - station geometry data all over Hyogo prefecture.


See `NEWS.md` for changes.


## Examples

```R
library(Jtransit)

# one origin, one destination
# origin:神戸大学, destination:夙川駅
# departure:14:15
transit("神戸大学","夙川駅",14,1,5)

# result
# origin destination time_h time_m1 time_m2 duration  fare   transit
# 神戸大学      夙川駅     14       1       5     29分 220円 乗換：0回
# alternative
#      6
```

```R
# more than 2 origins, more than 2 destinations
# make the example data.frame
# remove the blank

df <- read.csv(textConnection(
"origin,destination,origin2
神戸大学,夙川駅,
神戸大学,阪急六甲駅,
神戸大学,王子公園駅,
神戸大学,阪急岡本駅,
神戸大学,阪急花隈駅,
神戸大学,阪急御影駅,
神戸大学,神戸三宮駅,
神戸大学,西宮北口駅,"
))

or <- as.character(df$origin)
des <- as.character(df$destination)

# prepare for the blank data.frame
# ErrorPage <- NULL
Data <- data.frame()

# repetition processing
for (i in seq(or)){
  print(paste0("...", i, "行目を処理しています。"))
  exdata <- transit(or[i],des[i],14,1,5)
    #row bind
  Data <- rbind(Data, exdata)
  }

```
