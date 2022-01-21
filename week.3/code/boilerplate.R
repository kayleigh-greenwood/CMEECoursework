# A boilerplate R script, no shebang needed for scripts for data analysis and visualisation

MyFunction <- function(Arg1, Arg2){
  # creates function 'MyFunction' which takes two arguments, and begins to define it
  # definition of function lies within {}
  
  # Statements involving Arg1, Arg2:
  print(paste("Argument", as.character(Arg1), "is a", class(Arg1))) 
  # print Arg1's type
  print(paste("Argument", as.character(Arg2), "is a", class(Arg2))) 
  # print Arg2's type
    
  return (c(Arg1, Arg2)) 
  # this is optional, but very useful
  # ensures any changes made to the inputted arguments are applicable outside of the function(globally)
  # if using Rscript, output will print this return function
}

MyFunction(1,2) 
# test the function with numbers
MyFunction("Riki","Tiki") 
# A different test using strings