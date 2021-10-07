#!/bin/bash

#user passes three arguments to the function: the two files to concatenate($1 and $2), and the variable they want the combination to be stored in ($3)
cat $1 > $3 #assigns the value of the first inputted variable ($1) to the third inputted variable ($3) which replaces any prior content/value.
cat $2 >> $3 #appends the value of the second inputted variable ($2) to the $3 variable
# the contents of the two inputted variables have been added to $3

echo "Merged File is" #Prints statement to console
cat $3 #prints the value of the variable $3 to the console, which contains the contents of the first inputted variable ($1) followed by the second ($2).