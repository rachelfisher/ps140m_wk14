library(foreign)
library("swirl")
swirl()


x <- 5+7
y <- x - 3
z <- c(1.1, 9, 3.14)
?c
c(z, 555, z)
z * 2 + 100

#Arithmetic operators: `+`, `-`, `/`, and `^` (where x^2 means 'x squared')
#square root is sqrt() 
#absolute value is

my_sqrt <- sqrt(z-1)
my_div <- z/my_sqrt
# z * 2 + 100, what it really computes is this: z * c(2, 2, 2) + c(100, 100, 100).
c(1, 2, 3, 4) + c(0, 10)

#Determine which directory your R session is using as its current working directory using getwd()
getwd()
#List all the objects in your local workspace using ls().
ls()

dir.create("testdir")
setwd("testdir")
file.create("mytest.R")
file.exists("mytest.R")
[1] TRUE
file.remove()
file.rename()
file.copy()
file.info("mytest.R")$mode
file.path()
file.path("folder1", "folder2")
dir.create(file.path('testdir2', 'testdir3'), recursive = TRUE)
install.packages("swirl")

