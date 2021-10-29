for (i in 1:10) {
  if ((i %% 2) == 0) # check if the number is even
    next # pass to next iteration of loop. 
  print(i) # only prints odd numbers
}