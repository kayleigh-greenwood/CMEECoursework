# Intro to using 'next' to skip to next iteration of for loop. Only prints odd numbers

for (i in 1:10) {
  # for each number in an inclusive sequence
  if ((i %% 2) == 0) 
  # check if the number is even
    next # pass to next iteration of loop. 
  print(i) # only prints odd numbers
}