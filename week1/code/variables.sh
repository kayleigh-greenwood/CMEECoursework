#!/bin/bash

# Shows the use of variables
MyVar='some string' #Creates the variable(MyVar) and assigns it a value (some string)
echo 'the current value of the variable is' MyVar #Prints the value of the variable in the console
echo 'Please enter a new string' #Asks user to re-assign a value to the variable
read MyVar #Tells the programme that the value the user enters on this line is the new value of the 'MyVar' variable
echo 'the current value of the variable is' $MyVar #prints the variable's new value in the console

## Reading multiple values
echo 'Enter two numbers separated by a space(s)' #prints instructions for user in console
read a b #Tells the programme that the two numbers entered by the user are the values for the new variables a and b, respectively
echo 'you entered' $a 'and' $b '. Their sum is:' #repeats the user's entries to them and states the sum will be calculated
mysum=`expr $a + $b` #stores the sum of variables a and b into a new variable 'mysum' using expr command. Expr command requires either $() or `` (single quote, NOT APOSTROPHE)
echo $mysum #prints the value of the mysum variable to the console