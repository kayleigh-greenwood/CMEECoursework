#!/bin/bash

NumLines=`wc -l < $1` #creates a variable and assigns a value to it
#wc alone summongs lines, words and characters but coding -l afterwards specifies line count only
# < inputs the value to its right into the command on its left. Without it, the line count would still print, but so would other information about the file that comes out in a regular wc function. Here we want the line count only.
# $1 is the variable passed to the function

echo "The file $1 has $NumLines lines" #Prints line count of the variable to the console
echo # prints an empty line