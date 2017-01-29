#0: Load the data in RStudio
#Save the data set as a CSV file called titanic_original.csv and load it in RStudio into a data frame.

titanic_original <- read.csv(file = "titanic_original.csv", stringsAsFactors = FALSE)
is.data.frame(titanic_original)
head(titanic_original)

#1: Port of embarkation
#The embarked column has some missing values, which are known to correspond to passengers who actually 
#embarked at Southampton. Find the missing values and replace them with S. (Caution: Sometimes a missing
#value might be read into R as a blank or empty string.)

#First look at the rows where "embarked" is missing: 
titanic_original[titanic_original$embarked=="",]
#Rows 169 and 285 are the only ones where "embarked" is missing

#Fill in the blank values of "embarked" with "S"
titanic_original[titanic_original$embarked=="","embarked"]<-"S"

#Check work: 

titanic_original[c(169,285),"embarked"]

#2: Age
#You'll notice that a lot of the values in the Age column are missing. While there are many ways to fill 
#these missing values, using the mean or median of the rest of the values is quite common in such cases.
#Calculate the mean of the Age column and use that value to populate the missing values
#Think about other ways you could have populated the missing values in the age column. Why would you pick 
#any of those over the mean (or not)?

(mean_age<-mean(titanic_original$age[!is.na(titanic_original$age)]))

titanic_original[is.na(titanic_original$age),"age"]<-mean_age

#Check to see if blank ages were all filled in

(titanic_original[is.na(titanic_original$age),])

#I would not impute the missing ages with mean age. The reason is that there is no relationship between 
#an individual passenger's age and the mean age of all passengers. It would be better to impute the 
#missing ages with a passenger's most likely age, aka the mode of the ages.  We could also take the 
#passenger's gender into account when finding the mode. That is, if the passenger is 
#male and his age is missing, fill in the missing age with the mode of all the male passengers' ages; 
#Do the corresponding computation for females. Going even further, we could use all of the passenger
#fields available to build a model to predict individual passenger's ages. 


#3: Lifeboat
#You're interested in looking at the distribution of passengers in different lifeboats, but as we know, 
#many passengers did not make it to a boat :-( This means that there are a lot of missing values in the boat 
#column. Fill these empty slots with a dummy value e.g. the string 'None' or 'NA'

titanic_original[titanic_original$boat=="","boat"]<-"NA"
titanic_original$boat

#4: Cabin
#You notice that many passengers don't have a cabin number associated with them.
#Does it make sense to fill missing cabin numbers with a value?
#What does a missing value here mean?
#You have a hunch that the fact that the cabin number is missing might be a useful indicator of survival. 
#Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
titanic_original[titanic_original$cabin=="","has_cabin_number"]<-0
titanic_original[titanic_original$cabin!="","has_cabin_number"]<-1

#Check work: 

titanic_original[1:50,c("cabin","has_cabin_number")]
#5: Submit the project on Github
#Include your code, the original data as a CSV file titanic_original.csv, and the cleaned up data as a CSV 
#file called titanic_clean.csv

write.csv(titanic_original, file = "titanic_clean.csv")
