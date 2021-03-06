## Import Statements

## Import Libraries 
library(readr)
library(class)
library(pROC)
library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.3/Resources/library")
library("ROCR", lib.loc="/Library/Frameworks/R.framework/Versions/3.3/Resources/library")

## Import Dataset
income <- read_csv("./income_tr.csv") # Change to location of "income_tr.csv"
income.test <- read_csv("./income_te.csv") # Change to location of "income_te.csv"
income.df <- data.frame(income)
income.test.df <- data.frame(income.test)


## Data Frame Manipulation
## Create new data frame
newincome.df <- data.frame(income.df$ID)
newincome.df[,2:43] <- 0
newincome.test.df <- data.frame(income.test.df$ID)
newincome.test.df[,2:43] <- 0


## Rename columns for training and test
colnames(newincome.df) <- c("ID", "isAge10-19", "isAge20-29", "isAge30-39", "isAge40-49", "isAge50-59", "isAge60-69", "isAge70-79", "isAge80-89", "isWorkPriv", "isWorkOther", "isWgt20-99k", "isWgt100-199k", "isWgt200-299k", "isWgt300-399k", "isWgt400-499k", "isWgt500k+", "isEduHighGradOrLess", "isEduSCol-Bach", "isEduMastOrMore", "isMarried", "isNeverMarried", "isDivOrSep", "isWidowed", "isOccBus", "isOccTech", "isOccOther", "isRelHusbOrWife", "isRelUnmarried", "isRelOther", "isRaceWhite", "isRaceOther", "isMale", "isFemale", "isCapGain0", "isCapGainOther", "isCapLoss0", "isCapLossOther", "isHPW40OrLess", "isHPW41OrMore", "isCountryUS", "isCountryOther", "isClass>50K")

colnames(newincome.test.df) <- c("ID", "isAge10-19", "isAge20-29", "isAge30-39", "isAge40-49", "isAge50-59", "isAge60-69", "isAge70-79", "isAge80-89", "isWorkPriv", "isWorkOther", "isWgt20-99k", "isWgt100-199k", "isWgt200-299k", "isWgt300-399k", "isWgt400-499k", "isWgt500k+", "isEduHighGradOrLess", "isEduSCol-Bach", "isEduMastOrMore", "isMarried", "isNeverMarried", "isDivOrSep", "isWidowed", "isOccBus", "isOccTech", "isOccOther", "isRelHusbOrWife", "isRelUnmarried", "isRelOther", "isRaceWhite", "isRaceOther", "isMale", "isFemale", "isCapGain0", "isCapGainOther", "isCapLoss0", "isCapLossOther", "isHPW40OrLess", "isHPW41OrMore", "isCountryUS", "isCountryOther", "isClass>50K")

## Data Pre-Processing
## Get indices of corresponding entries for "class"
classInd <- which(income.df$class == ">50K")
classInd.test <- which(income.test.df$class == ">50K")

## Assign correct values to newincome.df according to "class"
newincome.df$`isClass>50K`[classInd] = 1
newincome.test.df$`isClass>50K`[classInd.test] = 1

## Get indices of corresponding entries for "age"
tenInd <- which(income.df$age >= 10 & income.df$age <= 19)
twentyInd <- which(income.df$age >= 20 & income.df$age <= 29)
thirtyInd <- which(income.df$age >= 30 & income.df$age <= 39)
fortyInd <- which(income.df$age >= 40 & income.df$age <= 49)
fiftyInd <- which(income.df$age >= 50 & income.df$age <= 59)
sixtyInd <- which(income.df$age >= 60 & income.df$age <= 69)
seventyInd <- which(income.df$age >= 70 & income.df$age <= 79)
eightyInd <- which(income.df$age >= 80 & income.df$age <= 89)

tenInd.test <- which(income.test.df$age >= 10 & income.test.df$age <= 19)
twentyInd.test <- which(income.test.df$age >= 20 & income.test.df$age <= 29)
thirtyInd.test <- which(income.test.df$age >= 30 & income.test.df$age <= 39)
fortyInd.test <- which(income.test.df$age >= 40 & income.test.df$age <= 49)
fiftyInd.test <- which(income.test.df$age >= 50 & income.test.df$age <= 59)
sixtyInd.test <- which(income.test.df$age >= 60 & income.test.df$age <= 69)
seventyInd.test <- which(income.test.df$age >= 70 & income.test.df$age <= 79)
eightyInd.test <- which(income.test.df$age >= 80 & income.test.df$age <= 89)

## Assign correct values to newincome.df according to "age"
newincome.df$`isAge10-19`[tenInd] = 1
newincome.df$`isAge20-29`[twentyInd] = 1
newincome.df$`isAge30-39`[thirtyInd] = 1
newincome.df$`isAge40-49`[fortyInd] = 1
newincome.df$`isAge50-59`[fiftyInd] = 1
newincome.df$`isAge60-69`[sixtyInd] = 1
newincome.df$`isAge70-79`[seventyInd] = 1
newincome.df$`isAge80-89`[eightyInd] = 1

newincome.test.df$`isAge10-19`[tenInd.test] = 1
newincome.test.df$`isAge20-29`[twentyInd.test] = 1
newincome.test.df$`isAge30-39`[thirtyInd.test] = 1
newincome.test.df$`isAge40-49`[fortyInd.test] = 1
newincome.test.df$`isAge50-59`[fiftyInd.test] = 1
newincome.test.df$`isAge60-69`[sixtyInd.test] = 1
newincome.test.df$`isAge70-79`[seventyInd.test] = 1
newincome.test.df$`isAge80-89`[eightyInd.test] = 1

## Get indices of corresponding entries for "workclass"
privInd <- which(income.df$workclass %in% c("Private"))
othInd <- which(!income.df$workclass %in% c("Private"))

privInd.test <- which(income.test.df$workclass %in% c("Private"))
othInd.test <- which(!income.test.df$workclass %in% c("Private"))

## Assign correct values to newincome.df according to "workclass"
newincome.df$isWorkPriv[privInd] = 1
newincome.df$isWorkOther[othInd] = 1

newincome.test.df$isWorkPriv[privInd.test] = 1
newincome.test.df$isWorkOther[othInd.test] = 1

## Get indices of corresponding entries for "fnlwgt"
twentyInd <- which(income.df$fnlwgt >= 20000 & income.df$fnlwgt < 100000)
onehundInd <- which(income.df$fnlwgt >= 100000 & income.df$fnlwgt < 200000)
twohundInd <- which(income.df$fnlwgt >= 200000 & income.df$fnlwgt < 300000)
threehundInd <- which(income.df$fnlwgt >= 300000 & income.df$fnlwgt < 400000)
fourhundInd <- which(income.df$fnlwgt >= 400000 & income.df$fnlwgt < 500000)
fivehundInd <- which(income.df$fnlwgt >= 500000 & income.df$fnlwgt < 1000000)

twentyInd.test <- which(income.test.df$fnlwgt >= 20000 & income.test.df$fnlwgt < 100000)
onehundInd.test <- which(income.test.df$fnlwgt >= 100000 & income.test.df$fnlwgt < 200000)
twohundInd.test <- which(income.test.df$fnlwgt >= 200000 & income.test.df$fnlwgt < 300000)
threehundInd.test <- which(income.test.df$fnlwgt >= 300000 & income.test.df$fnlwgt < 400000)
fourhundInd.test <- which(income.test.df$fnlwgt >= 400000 & income.test.df$fnlwgt < 500000)
fivehundInd.test <- which(income.test.df$fnlwgt >= 500000 & income.test.df$fnlwgt < 1000000)

## Assign correct values to newincome.df according to "fnlwgt"
newincome.df$`isWgt20-99k`[twentyInd] = 1
newincome.df$`isWgt100-199k`[onehundInd] = 1
newincome.df$`isWgt200-299k`[twohundInd] = 1
newincome.df$`isWgt300-399k`[threehundInd] = 1
newincome.df$`isWgt400-499k`[fourhundInd] = 1
newincome.df$`isWgt500k+`[fivehundInd] = 1

newincome.test.df$`isWgt20-99k`[twentyInd.test] = 1
newincome.test.df$`isWgt100-199k`[onehundInd.test] = 1
newincome.test.df$`isWgt200-299k`[twohundInd.test] = 1
newincome.test.df$`isWgt300-399k`[threehundInd.test] = 1
newincome.test.df$`isWgt400-499k`[fourhundInd.test] = 1
newincome.test.df$`isWgt500k+`[fivehundInd.test] = 1

## Get indices of corresponding entries for "education"
highInd <- which(income.df$education %in% c("Preschool", "1st-4th", "5th-6th", "7th-8th", 
                                            "9th", "10th", "11th", "12th", "HS-grad"))
bachInd <- which(income.df$education %in% c("Some-college", "Assoc-acdm", "Assoc-voc",
                                            "Bachelors"))
mastInd <- which(income.df$education %in% c("Masters", "Doctorate", "Prof-school"))

highInd.test <- which(income.test.df$education %in% c("Preschool", "1st-4th", "5th-6th", "7th-8th", 
                                                      "9th", "10th", "11th", "12th", "HS-grad"))
bachInd.test <- which(income.test.df$education %in% c("Some-college", "Assoc-acdm", "Assoc-voc",
                                                      "Bachelors"))
mastInd.test <- which(income.test.df$education %in% c("Masters", "Doctorate", "Prof-school"))

## Assign correct values to newincome.df according to "education"
newincome.df$isEduHighGradOrLess[highInd] = 1
newincome.df$`isEduSCol-Bach`[bachInd] = 1
newincome.df$isEduMastOrMore[mastInd] = 1

newincome.test.df$isEduHighGradOrLess[highInd.test] = 1
newincome.test.df$`isEduSCol-Bach`[bachInd.test] = 1
newincome.test.df$isEduMastOrMore[mastInd.test] = 1

## Get indices of corresponding entries for "marital_status"
marriedInd <- which(income.df$marital_status %in% c("Married-AF-spouse", 
                                                    "Married-civ-spouse", 
                                                    "Married-spouse-absent"))
nMarriedInd <- which(income.df$marital_status %in% c("Never-married"))
divInd <- which(income.df$marital_status %in% c("Divorced", "Separated"))
widInd <- which(income.df$marital_status %in% c("Widowed"))

marriedInd.test <- which(income.test.df$marital_status %in% c("Married-AF-spouse", 
                                                              "Married-civ-spouse", 
                                                              "Married-spouse-absent"))
nMarriedInd.test <- which(income.test.df$marital_status %in% c("Never-married"))
divInd.test <- which(income.test.df$marital_status %in% c("Divorced", "Separated"))
widInd.test <- which(income.test.df$marital_status %in% c("Widowed"))

## Assign correct values to newincome.df according to "marital_status"
newincome.df$isMarried[marriedInd] = 1
newincome.df$isNeverMarried[nMarriedInd] = 1
newincome.df$isDivOrSep[divInd] = 1
newincome.df$isWidowed[widInd] = 1

newincome.test.df$isMarried[marriedInd.test] = 1
newincome.test.df$isNeverMarried[nMarriedInd.test] = 1
newincome.test.df$isDivOrSep[divInd.test] = 1
newincome.test.df$isWidowed[widInd.test] = 1

## Get indices of corresponding entries for "occupation"
occBusInd <- which(income.df$occupation %in% c("Adm-clerical", 
                                               "Exec-managerial", 
                                               "Sales"))
occTechInd <- which(income.df$occupation %in% c("Machine-op-inspct", "Tech-support"))
occOthInd <- which(income.df$occupation %in% c("?", "Craft-repair", "Farming-fishing",
                                               "Handlers-cleaners", "Other-service", 
                                               "Priv-house-serv", "Prof-specialty", 
                                               "Protective-serv", "Transport-moving"))

occBusInd.test <- which(income.test.df$occupation %in% c("Adm-clerical", 
                                                         "Exec-managerial", 
                                                         "Sales"))
occTechInd.test <- which(income.test.df$occupation %in% c("Machine-op-inspct", "Tech-support"))
occOthInd.test <- which(income.test.df$occupation %in% c("?", "Craft-repair", "Farming-fishing",
                                                         "Handlers-cleaners", "Other-service", 
                                                         "Priv-house-serv", "Prof-specialty", 
                                                         "Protective-serv", "Transport-moving"))

## Assign correct values to newincome.df according to "occupation"
newincome.df$isOccBus[occBusInd] = 1
newincome.df$isOccTech[occTechInd] = 1
newincome.df$isOccOther[occOthInd] = 1

newincome.test.df$isOccBus[occBusInd.test] = 1
newincome.test.df$isOccTech[occTechInd.test] = 1
newincome.test.df$isOccOther[occOthInd.test] = 1

## Get indices of corresponding entries for "relationship"
relHW <- which(income.df$relationship %in% c("Husband", 
                                             "Wife"))
relUnmarr <- which(income.df$relationship %in% c("Unmarried"))
relOther <- which(income.df$relationship %in% c("Not-in-family", "Other-relative",
                                                "Own-child"))

relHW.test <- which(income.test.df$relationship %in% c("Husband", 
                                                       "Wife"))
relUnmarr.test <- which(income.test.df$relationship %in% c("Unmarried"))
relOther.test <- which(income.test.df$relationship %in% c("Not-in-family", "Other-relative",
                                                          "Own-child"))

## Assign correct values to newincome.df according to "relationship"
newincome.df$isRelHusbOrWife[relHW] = 1
newincome.df$isRelUnmarried[relUnmarr] = 1
newincome.df$isRelOther[relOther] = 1

newincome.test.df$isRelHusbOrWife[relHW.test] = 1
newincome.test.df$isRelUnmarried[relUnmarr.test] = 1
newincome.test.df$isRelOther[relOther.test] = 1

## Get indices of corresponding entries for "race"
raceWhite <- which(income.df$race %in% c("White"))
raceOther <- which(!income.df$race %in% c("White"))

raceWhite.test <- which(income.test.df$race %in% c("White"))
raceOther.test <- which(!income.test.df$race %in% c("White"))

## Assign correct values to newincome.df according to "race"
newincome.df$isRaceWhite[raceWhite] = 1
newincome.df$isRaceOther[raceOther] = 1

newincome.test.df$isRaceWhite[raceWhite.test] = 1
newincome.test.df$isRaceOther[raceOther.test] = 1

## Get indices of corresponding entries for "gender"
genMale <- which(income.df$gender %in% c("Male"))
genFemale <- which(income.df$gender %in% c("Female"))

genMale.test <- which(income.test.df$gender %in% c("Male"))
genFemale.test <- which(income.test.df$gender %in% c("Female"))

## Assign correct values to newincome.df according to "gender"
newincome.df$isMale[genMale] = 1
newincome.df$isFemale[genFemale] = 1

newincome.test.df$isMale[genMale.test] = 1
newincome.test.df$isFemale[genFemale.test] = 1

## Get indices of corresponding entries for "capital_gain"
gainZero <- which(income.df$capital_gain == 0)
gainOther <- which(income.df$capital_gain != 0)

gainZero.test <- which(income.test.df$capital_gain == 0)
gainOther.test <- which(income.test.df$capital_gain != 0)

## Assign correct values to newincome.df according to "capital_gain"
newincome.df$isCapGain0[gainZero] = 1
newincome.df$isCapGainOther[gainOther] = 1

newincome.test.df$isCapGain0[gainZero.test] = 1
newincome.test.df$isCapGainOther[gainOther.test] = 1

## Get indices of corresponding entries for "capital_loss"
lossZero <- which(income.df$capital_loss == 0)
lossOther <- which(income.df$capital_loss != 0)

lossZero.test <- which(income.test.df$capital_loss == 0)
lossOther.test <- which(income.test.df$capital_loss != 0)

## Assign correct values to newincome.df according to "capital_loss"
newincome.df$isCapLoss0[lossZero] = 1
newincome.df$isCapLossOther[lossOther] = 1

newincome.test.df$isCapLoss0[lossZero.test] = 1
newincome.test.df$isCapLossOther[lossOther.test] = 1

## Get indices of corresponding entries for "hours_per_week"
hrsForty <- which(income.df$hour_per_week > 0 & income.df$hour_per_week <= 40)
hrsGreater <- which(income.df$hour_per_week > 40 & income.df$hour_per_week <= 100)

hrsForty.test <- which(income.test.df$hour_per_week > 0 & income.test.df$hour_per_week <= 40)
hrsGreater.test <- which(income.test.df$hour_per_week > 40 & income.test.df$hour_per_week <= 100)

## Assign correct values to newincome.df according to "hours_per_week"
newincome.df$isHPW40OrLess[hrsForty] = 1
newincome.df$isHPW41OrMore[hrsGreater] = 1

newincome.test.df$isHPW40OrLess[hrsForty.test] = 1
newincome.test.df$isHPW41OrMore[hrsGreater.test] = 1

## Get indices of corresponding entries for "native_country"
countryUS <- which(income.df$native_country %in% c("United-States"))
countryOther <- which(!income.df$native_country %in% c("United-States"))

countryUS.test <- which(income.test.df$native_country %in% c("United-States"))
countryOther.test <- which(!income.test.df$native_country %in% c("United-States"))

## Assign correct values to newincome.df according to "native_country"
newincome.df$isCountryUS[countryUS] = 1
newincome.df$isCountryOther[countryOther] = 1

newincome.test.df$isCountryUS[countryUS.test] = 1
newincome.test.df$isCountryOther[countryOther.test] = 1


### Jaccard and Cosine Similarity 
## Convert data frame to matrix
newincome.m <- data.matrix(newincome.df)
newincome.test.m <- data.matrix(newincome.test.df)

## Create adjustable k
k <- 10 # Adjust k here

## Create a new data frame containing jaccard similarities and output values
jaccard.m <- matrix(nrow=(nrow(newincome.df)+1), ncol=(nrow(newincome.df)+1))
jaccard.m[2:nrow(jaccard.m),1] <- newincome.df$ID
jaccard.m[1,2:nrow(jaccard.m)] <- newincome.df$ID
jaccard.df <- data.frame(income.df$ID)
jaccard.df[,2:((k*2)+1)] <- 0

jaccard.test.m <- matrix(nrow=(nrow(newincome.df)+1), ncol=(nrow(newincome.test.df)+1))
jaccard.test.m[2:nrow(jaccard.test.m),1] <- newincome.df$ID
jaccard.test.m[1,2:ncol(jaccard.test.m)] <- newincome.test.df$ID
jaccard.test.df <- data.frame(income.test.df$ID)
jaccard.test.df[,2:((k*2)+1)] <- 0

## Rename columns
names(jaccard.df)[seq(2,ncol(jaccard.df),2)] <- "Index"
names(jaccard.df)[seq(1,ncol(jaccard.df),2)] <- "Proximity"
names(jaccard.df)[1] <- "ID"

names(jaccard.test.df)[seq(2,ncol(jaccard.test.df),2)] <- "Index"
names(jaccard.test.df)[seq(1,ncol(jaccard.test.df),2)] <- "Proximity"
names(jaccard.test.df)[1] <- "ID"

## Create a function for calculating euclidean similarity of two distinct data entries
jaccard <- function(indi, indj) {
  bmask <- rep(1, 41)
  xVec <- as.numeric(newincome.df[indi,2:42])
  yVec <- as.numeric(newincome.df[indj,2:42])
  M01 <- sum((!xVec&bmask)&(yVec&bmask))
  M10 <- sum((xVec&bmask)&(!yVec&bmask))
  M00 <- sum(!xVec & !yVec)
  M11 <- sum(xVec & yVec)
  simJ <- (M11)/(M01+M10+M11)
  return(simJ)
}

## Create a function for calculating cosine similarity of two distinct data entries
cosine <- function(indi, indj) {
  xVec <- as.numeric(newincome.df[indi,2:42])
  yVec <- as.numeric(newincome.df[indj,2:42])
  xlen <- sqrt(sum(xVec^2))
  ylen <- sqrt(sum(yVec^2))
  simC <- sum(t(xVec)*yVec)/(xlen*ylen)
  return(simC)
}

jaccard.test <- function(indi, indj) {
  bmask <- rep(1, 41)
  xVec <- as.numeric(newincome.df[indi,2:42])
  yVec <- as.numeric(newincome.test.df[indj,2:42])
  M01 <- sum((!xVec&bmask)&(yVec&bmask))
  M10 <- sum((xVec&bmask)&(!yVec&bmask))
  M00 <- sum(!xVec & !yVec)
  M11 <- sum(xVec & yVec) 
  simJ <- (M11)/(M01+M10+M11)
  return(simJ)
}

## Perform function for each entry
for (rowi in 1:nrow(newincome.df)) {
  for (rowj in 1:nrow(newincome.df)) {
    jaccard.m[rowi+1, rowj+1] <- jaccard(rowi, rowj) # Adjust function by changing from jaccard function to cosine
  }
}

for (rowi in 1:nrow(newincome.test.df)) {
  for (rowj in 1:nrow(newincome.test.df)) {
    jaccard.test.m[rowi+1, rowj+1] <- jaccard.test(rowi, rowj)
  }
}

## Convert matrix to dataframe
jacsim.df <- data.frame(jaccard.m)
jacsim.df[1,1] = 0
colnames(jacsim.df) <- jacsim.df[1,]
jacsim.df <- jacsim.df[-1,]
colnames(jacsim.df)[1] <- "ID"

jacsim.test.df <- data.frame(jaccard.test.m)
jacsim.test.df[1,1] = 0
colnames(jacsim.test.df) <- jacsim.test.df[1,]
jacsim.test.df <- jacsim.test.df[-1,]
colnames(jacsim.test.df)[1] <- "ID"

## Remove high similarities of entries similar to itself
for(i in 1:nrow(jacsim.df)) {
  jacsim.df[i, i+1] = 0
}

## Find k most similar entries and add values from matrix to output df
for(col in 2:ncol(jacsim.df)) {
  i = 0
  kmost <- sort(jacsim.df[,col], index.return=TRUE, decreasing = TRUE)
  kmost <- lapply(kmost, `[`, kmost$x %in% head(kmost$x,k))
  for(coscol in 1:k) {
    jaccard.df[col-1,coscol+i+1] <- kmost$ix[coscol]
    jaccard.df[col-1,coscol+i+2] <- kmost$x[coscol]
    i = i + 1
  }
}

for(col in 2:ncol(jacsim.test.df)) {
  i = 0
  kmost <- sort(jacsim.test.df[,col], index.return=TRUE, decreasing = TRUE)
  kmost <- lapply(kmost, `[`, kmost$x %in% head(kmost$x,k))
  for(coscol in 1:k) {
    jaccard.test.df[col-1,coscol+i+1] <- kmost$ix[coscol]
    jaccard.test.df[col-1,coscol+i+2] <- kmost$x[coscol]
    i = i + 1
  }
}


### Output Data Frame: Predicted vs. Actual
## Create output matrix
output.df <- data.frame(newincome.test.df$ID)
output.df[,2:4] <- 0

## Rename columns
colnames(output.df) <- c("ID", "Actual Class", "Predicted Class", "Posterior Probability")

## Post the Actual Class
output.df$`Actual Class` <- sapply(output.df$ID, function(x) newincome.test.df$`isClass>50K`[newincome.test.df$ID == x])

## Calculate the Posterior Probability
i <- 0
totalsum <- 0
prob <- 0
greaterfif <- 0
lessfif <- 0
for(row in 1:nrow(jaccard.test.df)) {
  for(col in 1:k) {
    if(newincome.test.df$`isClass>50K`[jaccard.test.df[row, col+i+1]] == 1) {
      greaterfif <- greaterfif + jaccard.test.df[row, col+i+2]
    } else {
      lessfif <- lessfif + jaccard.test.df[row, col+i+2]
    }
    totalsum <- totalsum + jaccard.test.df[row, col+i+2]
    i <- i + 1
  }
  prob <- greaterfif/totalsum
  if(prob > 0.5) {
    output.df$`Posterior Probability`[row] <- prob
    output.df$`Predicted Class`[row] <- 1
  } else {
    prob <- lessfif/totalsum
    output.df$`Posterior Probability`[row] <- prob
    output.df$`Predicted Class`[row] <- 0
  }
  i <- 0
  totalsum <- 0
  prob <- 0
  greaterfif <- 0
  lessfif <- 0
}

## Calculate the Error Rate
err.output <- 100 * (sum(output.df$`Actual Class` == output.df$`Predicted Class`)/nrow(output.df))
err.output

## Create a confusion matrix
table(output.df$`Actual Class`, output.df$`Predicted Class`)


### Compare Ouput with R Package
## Initialize function input variables
train.gc <- newincome.df
test.gc <- newincome.test.df
train.def <- factor(newincome.df$`isClass>50K`)
test.def <- factor(newincome.test.df$`isClass>50K`)

## Use the knn from the Class package
knn.5 <- knn(train=train.gc, test=test.gc, cl=train.def, k=20, prob = TRUE)

## Calculate the Error Rate
err.knn <- 100 * (sum(test.def == knn.5)/nrow(test.gc))
err.knn

## Compare the error rates
err.output # using my knn function
err.knn # premade r package

### Construct Precision, Recall, F-Score, and ROC Curve
## Construct the ROC Curve Data Frame
output.df$`Posterior Probability` <- round(output.df$`Posterior Probability`, 2)
output.roc.df <- data.frame(sort(unique(output.df$`Posterior Probability`)))
output.roc.df[,2:7] <- 0
colnames(output.roc.df) <- c("Threshold", "TP", "FP", "TN", "FN", "TPR", "FPR")

## Calculate True Positive
for(thresh.ind in 1:nrow(output.roc.df)) {
  c.n <- 0
  for(post.ind in 1:nrow(output.df)) {
    if((output.roc.df$Threshold[thresh.ind]==output.df$`Posterior Probability`[post.ind]) & 
       (output.df$`Actual Class`[post.ind] == output.df$`Predicted Class`[post.ind]) &
       (output.df$`Actual Class`[post.ind] == 1)) {
      c.n <- c.n + 1
    }
  }
  output.roc.df$TP[thresh.ind] <- c.n
}

## Calculate False Positive
for(thresh.ind in 1:nrow(output.roc.df)) {
  c.n <- 0
  for(post.ind in 1:nrow(output.df)) {
    if((output.roc.df$Threshold[thresh.ind]==output.df$`Posterior Probability`[post.ind]) & 
       (output.df$`Predicted Class`[post.ind] == 1) &
       (output.df$`Actual Class`[post.ind] == 0)) {
      c.n <- c.n + 1
    }
  }
  output.roc.df$FP[thresh.ind] <- c.n
}

## Calculate False Negative
for(thresh.ind in 1:nrow(output.roc.df)) {
  c.n <- 0
  for(post.ind in 1:nrow(output.df)) {
    if((output.roc.df$Threshold[thresh.ind]==output.df$`Posterior Probability`[post.ind]) & 
       (output.df$`Predicted Class`[post.ind] == 0) &
       (output.df$`Actual Class`[post.ind] == 1)) {
      c.n <- c.n + 1
    }
  }
  output.roc.df$FN[thresh.ind] <- c.n
}

## Calculate True Negative
for(thresh.ind in 1:nrow(output.roc.df)) {
  c.n <- 0
  for(post.ind in 1:nrow(output.df)) {
    if((output.roc.df$Threshold[thresh.ind]==output.df$`Posterior Probability`[post.ind]) & 
       (output.df$`Actual Class`[post.ind] == output.df$`Predicted Class`[post.ind]) &
       (output.df$`Actual Class`[post.ind] == 0)) {
      c.n <- c.n + 1
    }
  }
  output.roc.df$TN[thresh.ind] <- c.n
}

## Calculate True Positive Rate
for(row in 1:nrow(output.roc.df)) {
  output.roc.df$TPR[row] <- output.roc.df$TP[row]/(output.roc.df$TP[row]+output.roc.df$FN[row])
}

## Calculate False Positive Rate
for(row in 1:nrow(output.roc.df)) {
  output.roc.df$FPR[row] <- output.roc.df$FP[row]/(output.roc.df$FP[row]+output.roc.df$TN[row])
}

## Plot the ROC Curve
plot(output.roc.df$FPR, output.roc.df$TPR, ylim = c(0,1))
# abline(0, 1)

## Assign appropriate variables
cm <- table(output.df$`Actual Class`, output.df$`Predicted Class`)
a <- cm[2,2]
b <- cm[1,2]
c <- cm[2,1]
d <- cm[1,1]

## Calculate Precision
p <- a/(a+c)
p

## Calculate Recall
r <- a/(a+b)
r

## Calculate F-Score
f <- ((2*r*p)/(r+p))
f

## Calculate True Positive Rate of total data
tp <- cm[2,2]
fn <- cm[1,2]
fp <- cm[2,1]
tn <- cm[1,1]
tpr <- tp/(tp+fn)
tpr

## Calculate True Negative Rate of total data
tnr <- tn/(fp+tn)
tnr

## Calculate False Positive Rate of total data
fpr <- fp/(fp+tn)
fpr

## Calculate False Negative Rate of total data
fnr <- fn/(tp+fn)
fnr


## Additional Analysis
## Education and Class
ggplot(income.test.df, aes(x = education_cat, y = ID, color = class)) + geom_point(aes(size=class))

## Marital Status and Class
lessfif <- subset(income.test.df, income.test.df$class == "<=50K")
grefif <- subset(income.test.df, income.test.df$class == ">50K")
table(lessfif$marital_status)/nrow(lessfif) * 100
table(grefif$marital_status)/nrow(grefif) * 100

## Gender and Class
lessfif <- subset(income.test.df, income.test.df$class == "<=50K")
grefif <- subset(income.test.df, income.test.df$class == ">50K")
table(lessfif$gender)/nrow(lessfif) * 100
table(grefif$gender)/nrow(grefif) * 100


## Write Files
## Export jaccard similarity output - training data
write.csv(jaccard.df, file = "JaccardSimilarityOutputTrain.csv")

## Export jaccard similarity output - testing data
write.csv(jaccard.test.df, file = "JaccardSimilarityOutputTest.csv")

## Export General Output
write.csv(output.df, file = "OutputDataFrame.csv")

## Export Roc Output
write.csv(output.roc.df, file = "OutputROCDataFrame.csv")
