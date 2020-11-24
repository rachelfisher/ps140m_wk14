##  PS140M SECTION WORKSHOP WEEK 14
# A VERY SHORT INTRO TO R

#The hashtag (#) symbol turns what proceeds into a comment as opposed to code

rm(list=ls()) #clears your workspace

#Determine which directory your R session is using as its current working directory using getwd()
getwd()
#Set your working directory to where you want to get and save files
setwd("~/PS140M/Week14")

################################################################
## SOME BASICS

#We can use R as a calculator: 
#Arithmetic operators can include: `+`, `-`, `*`, `/`, and `^` (where e.g., x^2 means 'x squared')
#square root is sqrt() 
#absolute value is abs()

5+7
#Order of operations applies, so need to use parentheses appropriately
5+7/24
(5+7)/24

4^2 
sqrt(16)
abs(-3)

#sqrt() and abs() are canned functions already programmed into (Base) R
#There are also packages we can install to get other funtions that programmers have written
#We can also write our own functions (won't cover)

#########################################################

##Variables
#A variable is a symbolic name for (or reference to) information.
#We can create a variable called x and give it the value 5
x <- 5
x

y <- 7
xplusy <- x + y
xplusy

##Data Types
#Variables can contain values of specific types within R. 
#In R, there are six data types. For now, we'll focus on the two most common:
  
# "numeric" for any numerical value (e.g., 0.25, -6, 100000)
# "character" for text values, denoted by using quotes ("") around value (e.g., "conservative", "5", etc.)

#x was a numeric variable but we can check with the function class()
class(x)

#now a character variable
z <- "PR system"
class(z)

##Data Structures 
#Variables can store more than just a single value, they can store a multitude of different data structures. 
#These include, but are not limited to, vectors (c), factors (factor), matrices (matrix), data frames (data.frame) and lists (list).

#A vector is the most common and basic data structure in R
#It's a collection of values of either numbers or characters (vectors must be same data type)

prop <- c(.1, .2, .3)
prop
quota <- c("reserved", "candidate quota", "voluntary pol party")
quota

#Factors
#A factor is a special type of vector that is used to store categorical data. 
#Each unique category is referred to as a factor level (i.e. category = level). 
#Factors are built on top of integer vectors such that each factor level is assigned an integer value, creating value-label pairs.

religiosity <- c("low", "high", "medium", "high", "low", "medium", "high")
religiosity <- factor(religiosity)
religiosity
?factor

# By default, the factor() function assigns integers to the categories alphabetically, with high=1, low=2, medium=3
religiosity <- factor(religiosity, levels=c("low", "medium", "high"))
religiosity


#Data Frame
#A data.frame is the de facto data structure for most tabular data and what we use for statistics and plotting.
#Often we import a dataset and it is stored as a data frame

df <- data.frame(prop, quota)
df
View(df)
#the function data.frame()’s default turns character vectors into factors




#Reading data into R
#See Google Doc with list of data types and corresponding functions and packages

install.packages("pacman")
library("pacman")
p_load(dplyr, haven, tidyverse)

#Here we are going to import a sample of Indonesia's DPR RI 2014 candidates and election results
#Thanks to Tom Pepinsky for collecting the data
df <- read.csv("ps140m_wk14.git/indo_example.csv")



#Logical operators
#We can use indices with logical operators to select certain elements in a vector or data frame.
#We can also use logical expressions to determine whether a particular condition is true or false.

#Operator 	Description
#   >	      greater than
#   >=    	greater than or equal to
#   <	      less than
#   <=	    less than or equal to
#   ==	    equal to
#   !=	    not equal to
#   &     	and
#   |	      or


df$elected==1 #to call a specific variable from a data frame, the code is [name of df]$[name of variable]
df$position<=3
df$position[df$female==1]<=3
df$position[df$female==1]<3


#We can obtain summary statistics of variables
mean(df$elected)
mean(df$elected[df$female==1]) #we can add a condition to subset only to women
mean(df$elected[df$female==0])

sum(df$elected[df$female==0]) #sums the values
length(df$female[df$female==0]) #gives the length of the vector, or here the subset (in other words, the number of observations)
10/62 #same as the mean

mean(df$total_exp_mil)
mean(df$total_exp_mil, na.rm = TRUE)

#Simple plot
plot(df$total_exp_mil, df$vote_share) #for those with more advanced experience with stats, should we take the log of expenditure?


###########################################
## GRAPHING WITH GGPLOT2
# This is a big jump but just wanted to show you what ggplot can do

ggplot(data=df, aes(x = total_exp_mil, y=vote_share, color=factor(female))) + 
  geom_point(na.rm = TRUE) +
  xlab("Expenditure (in millions)") +
  ylab("Vote Share (in percent)")+
  scale_color_manual(values=c("purple", "orange"), name = "Candidate",
                      labels = c("Men", "Women")) +
  theme_bw()



#Now we're going to import the Asian Barometer Wave 4 subset of variables
w4 <- read_dta("ps140m_wk14.git/w4_subset.dta")

#Code to replace values with NAs in order to exclude from analyses
#Important to look at the codebook to know which values indicate, e.g., decline to answer or don't know
#se6 is religion and 99=none in the codebook, Stata's label says decline to answer, what to code as?
w4_recode <- w4 %>%
  mutate_at(vars(q33, q35, q36, q37, q44, q61, q139, se4, se7a), ~replace(., . >= 8, NA)) %>%
  mutate_at(vars(se3_1, se3_2, se5a), ~replace(., . == -1, NA)) %>%
  mutate_at(vars(se5, se6, se7), ~replace(., . == 99, NA)) 

mean(w4_recode$se5a, na.rm = TRUE)

ggplot(data=subset(w4_recode, se5a<6), aes(x=factor(se2), y = q139)) + 
  geom_bar(position = "dodge", stat="summary", na.rm=TRUE) +
  xlab("Q: Women should not be involved in politics") +
  theme_bw()





#If you'd like to learn more and practice in R, I recommend using SWIRL which has a bunch of tutorials
#install.packages("swirl")
library(swirl)
swirl()

#https://github.com/hbctraining/Intro-to-R/blob/master/lessons/02_introR-syntax-and-data-structures.md
