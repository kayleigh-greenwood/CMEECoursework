# CMEE 2021 HPC excercises R code challenge G pro forma

rm(list=ls()) # nothing written elsewhere should be needed to make this work

# please edit these data to show your information.
name <- "Kayleigh Greenwood"
preferred_name <- "Kayleigh"
email <- "kg21@imperial.ac.uk"
username <- "kg21"

# don't worry about comments for this challenge - the number of characters used will be counted starting from here

######### in development 400 characters##########

f <- function(s=c(0,0), a=1.5708, l=7, m=FALSE, d=1)  {
  d <- d*-1
  
  if (m==FALSE){
    m <- l*0.005
  }
  
  e <- c(s[1] + l*cos(a), s[2] + l*sin(a))
  lines(x=c(s[1], e[1]), y=c(s[2], e[2]))
  s <- e
  
  if (l >= m){
    f(s, a, l*0.87, m, d)
    
    if (d>0){
      x <- (pi/4)
    } else {
      x <- -(pi/4)
    }
  
    f(s, a+x, l*0.38, m, d)
  }
}
plot(-25:25, 5:55, type="n", xlab="", ylab="", axes=FALSE)

f()

